import { Router } from 'express';

import { listDestinations } from './destination.controller';

const destinationRouter = Router();

destinationRouter.get('/', listDestinations);

export default destinationRouter;
