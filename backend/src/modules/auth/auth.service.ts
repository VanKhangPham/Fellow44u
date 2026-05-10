import { comparePassword, hashPassword } from '../../common/utils/hash';
import { AppError } from '../../common/utils/app-error';
import { signAccessToken } from '../../common/utils/jwt';
import { authRepository } from './auth.repository';
import {
  ForgotPasswordInput,
  SignInInput,
  SignUpInput,
} from './auth.validation';

function serializeUser(user: {
  id: string;
  fullName: string;
  email: string;
}) {
  return {
    id: user.id,
    fullName: user.fullName,
    email: user.email,
  };
}

export const authService = {
  async signUp(input: SignUpInput) {
    const existingUser = await authRepository.findByEmail(input.email);

    if (existingUser) {
      throw new AppError(409, 'Email already exists');
    }

    const passwordHash = await hashPassword(input.password);
    const user = await authRepository.create({
      fullName: input.fullName,
      email: input.email,
      passwordHash,
    });

    const accessToken = signAccessToken({
      userId: user.id,
      email: user.email,
    });

    return {
      accessToken,
      user: serializeUser(user),
    };
  },

  async signIn(input: SignInInput) {
    const user = await authRepository.findByEmail(input.email);

    if (!user) {
      throw new AppError(401, 'Invalid credentials');
    }

    const isPasswordValid = await comparePassword(
      input.password,
      user.passwordHash,
    );

    if (!isPasswordValid) {
      throw new AppError(401, 'Invalid credentials');
    }

    const accessToken = signAccessToken({
      userId: user.id,
      email: user.email,
    });

    return {
      accessToken,
      user: serializeUser(user),
    };
  },

  async getCurrentUser(userId: string) {
    const user = await authRepository.findById(userId);

    if (!user) {
      throw new AppError(404, 'User not found');
    }

    return serializeUser(user);
  },

  async forgotPassword(_input: ForgotPasswordInput) {
    return null;
  },
};
