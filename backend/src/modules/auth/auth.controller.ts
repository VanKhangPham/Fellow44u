import { Response } from 'express';

import { AuthenticatedRequest } from '../../common/types/authenticated-request';
import { asyncHandler } from '../../common/utils/async-handler';
import { sendSuccess } from '../../common/utils/response';
import { authService } from './auth.service';
import {
  validateForgotPasswordInput,
  validateSignInInput,
  validateSignUpInput,
} from './auth.validation';

export const signUp = asyncHandler(async (req, res: Response) => {
  const input = validateSignUpInput(req.body);
  const result = await authService.signUp(input);

  return sendSuccess(res, result, 'Sign up successful', 201);
});

export const signIn = asyncHandler(async (req, res: Response) => {
  const input = validateSignInInput(req.body);
  const result = await authService.signIn(input);

  return sendSuccess(res, result, 'Login successful');
});

export const me = asyncHandler(async (req: AuthenticatedRequest, res: Response) => {
  const result = await authService.getCurrentUser(req.user!.userId);

  return sendSuccess(res, result);
});

export const forgotPassword = asyncHandler(async (req, res: Response) => {
  const input = validateForgotPasswordInput(req.body);
  await authService.forgotPassword(input);

  return sendSuccess(res, null, 'Reset password request received');
});
