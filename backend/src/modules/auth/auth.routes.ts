import { Router } from 'express';

import { requireAuth } from '../../common/middleware/auth.middleware';
import { forgotPassword, me, signIn, signUp } from './auth.controller';

const authRouter = Router();

authRouter.post('/sign-up', signUp);
authRouter.post('/sign-in', signIn);
authRouter.get('/me', requireAuth, me);
authRouter.post('/forgot-password', forgotPassword);

export default authRouter;
