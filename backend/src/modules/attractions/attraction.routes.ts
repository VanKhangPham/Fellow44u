import { Router } from 'express';

import { listAttractions } from './attraction.controller';

const attractionRouter = Router();

attractionRouter.get('/', listAttractions);

export default attractionRouter;
