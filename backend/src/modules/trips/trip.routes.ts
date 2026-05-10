import { Router } from 'express';

import { requireAuth } from '../../common/middleware/auth.middleware';
import { createTrip, getTripDetail, listTrips, updateTrip } from './trip.controller';

const tripRouter = Router();

tripRouter.use(requireAuth);
tripRouter.post('/', createTrip);
tripRouter.get('/', listTrips);
tripRouter.get('/:id', getTripDetail);
tripRouter.put('/:id', updateTrip);

export default tripRouter;
