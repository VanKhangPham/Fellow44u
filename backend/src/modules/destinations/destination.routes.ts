import { Router } from 'express';

import { listDestinations, getPopularDestinations, searchDestinations } from './destination.controller';

const destinationRouter = Router();

destinationRouter.get('/', listDestinations);
destinationRouter.get('/popular', getPopularDestinations);
destinationRouter.get('/search', searchDestinations);

export default destinationRouter;
