import { NextFunction, Request, Response } from 'express';

import { AppError } from '../utils/app-error';
import { sendError } from '../utils/response';

export function notFoundMiddleware(
  _req: Request,
  _res: Response,
  next: NextFunction,
) {
  next(new AppError(404, 'Route not found'));
}

export function errorMiddleware(
  error: Error,
  _req: Request,
  res: Response,
  _next: NextFunction,
) {
  if (error instanceof AppError) {
    return sendError(res, error.message, error.statusCode, error.errors);
  }

  return sendError(res, 'Internal server error', 500);
}
