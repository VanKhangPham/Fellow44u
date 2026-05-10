import { Request } from 'express';

import { AccessTokenPayload } from '../utils/jwt';

export interface AuthenticatedRequest extends Request {
  user?: AccessTokenPayload;
}
