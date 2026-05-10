import { Router } from 'express';

import { getGuideDetail, listGuides } from './guide.controller';

const guideRouter = Router();

guideRouter.get('/', listGuides);
guideRouter.get('/:id', getGuideDetail);

export default guideRouter;
