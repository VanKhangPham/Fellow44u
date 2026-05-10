import { NextFunction, Response } from 'express';

import { AuthenticatedRequest } from '../types/authenticated-request';
import { AppError } from '../utils/app-error';
import { verifyAccessToken } from '../utils/jwt';

export function requireAuth(
  req: AuthenticatedRequest,
  _res: Response,
  next: NextFunction,
) {
  const authorization = req.headers.authorization;

  if (!authorization || !authorization.startsWith('Bearer ')) {
    return next(new AppError(401, 'Unauthorized'));
  }

  const token = authorization.replace('Bearer ', '').trim();

  try {
    req.user = verifyAccessToken(token);
    return next();
  } catch (_error) {
    return next(new AppError(401, 'Invalid or expired token'));
  }
}
