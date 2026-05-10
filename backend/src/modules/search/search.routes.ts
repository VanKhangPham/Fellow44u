import { Router } from 'express';

import { search } from './search.controller';

const searchRouter = Router();

searchRouter.get('/', search);

export default searchRouter;
