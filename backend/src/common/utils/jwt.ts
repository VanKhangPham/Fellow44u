import jwt, { SignOptions } from 'jsonwebtoken';

import { env } from '../../config/env';

export interface AccessTokenPayload {
  userId: string;
  email: string;
}

export function signAccessToken(payload: AccessTokenPayload): string {
  const options: SignOptions = {
    expiresIn: env.jwtExpiresIn as SignOptions['expiresIn'],
  };

  return jwt.sign(payload, env.jwtSecret, options);
}

export function verifyAccessToken(token: string): AccessTokenPayload {
  return jwt.verify(token, env.jwtSecret) as AccessTokenPayload;
}
