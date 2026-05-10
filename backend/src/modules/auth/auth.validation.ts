import { AppError } from '../../common/utils/app-error';

export interface SignUpInput {
  fullName: string;
  email: string;
  password: string;
}

export interface SignInInput {
  email: string;
  password: string;
}

export interface ForgotPasswordInput {
  email: string;
}

function ensureString(value: unknown): string {
  return typeof value === 'string' ? value.trim() : '';
}

export function validateSignUpInput(body: unknown): SignUpInput {
  const payload = (body ?? {}) as Record<string, unknown>;
  const fullName = ensureString(payload.fullName);
  const email = ensureString(payload.email).toLowerCase();
  const password = ensureString(payload.password);
  const errors: Record<string, string[]> = {};

  if (!fullName) {
    errors.fullName = ['Full name is required'];
  }

  if (!email) {
    errors.email = ['Email is required'];
  }

  if (!password) {
    errors.password = ['Password is required'];
  } else if (password.length < 8) {
    errors.password = ['Password must be at least 8 characters'];
  }

  if (Object.keys(errors).length > 0) {
    throw new AppError(422, 'Validation failed', errors);
  }

  return {
    fullName,
    email,
    password,
  };
}

export function validateSignInInput(body: unknown): SignInInput {
  const payload = (body ?? {}) as Record<string, unknown>;
  const email = ensureString(payload.email).toLowerCase();
  const password = ensureString(payload.password);
  const errors: Record<string, string[]> = {};

  if (!email) {
    errors.email = ['Email is required'];
  }

  if (!password) {
    errors.password = ['Password is required'];
  }

  if (Object.keys(errors).length > 0) {
    throw new AppError(422, 'Validation failed', errors);
  }

  return {
    email,
    password,
  };
}

export function validateForgotPasswordInput(body: unknown): ForgotPasswordInput {
  const payload = (body ?? {}) as Record<string, unknown>;
  const email = ensureString(payload.email).toLowerCase();

  if (!email) {
    throw new AppError(422, 'Validation failed', {
      email: ['Email is required'],
    });
  }

  return { email };
}
