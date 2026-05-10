import { Router } from 'express';

import { getTourDetail, listTours } from './tour.controller';

const tourRouter = Router();

tourRouter.get('/', listTours);
tourRouter.get('/:id', getTourDetail);

export default tourRouter;
