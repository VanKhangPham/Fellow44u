import { Router } from 'express';
import { getExploreHome } from './explore.controller';

const exploreRouter = Router();

exploreRouter.get('/home', getExploreHome);

export default exploreRouter;
