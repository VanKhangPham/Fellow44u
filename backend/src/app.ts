import cors from 'cors';
import express from 'express';

import { errorMiddleware, notFoundMiddleware } from './common/middleware/error.middleware';
import attractionRouter from './modules/attractions/attraction.routes';
import authRouter from './modules/auth/auth.routes';
import destinationRouter from './modules/destinations/destination.routes';
import guideRouter from './modules/guides/guide.routes';
import searchRouter from './modules/search/search.routes';
import tourRouter from './modules/tours/tour.routes';
import tripRouter from './modules/trips/trip.routes';
import wishlistRouter from './modules/wishlist/wishlist.routes';
import exploreRouter from './modules/explore/explore.routes';

const app = express();

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.get('/health', (_req, res) => {
  res.json({
    success: true,
    message: 'OK',
    data: {
      status: 'up',
    },
  });
});

app.use('/api/v1/auth', authRouter);
app.use('/api/v1/destinations', destinationRouter);
app.use('/api/v1/guides', guideRouter);
app.use('/api/v1/tours', tourRouter);
app.use('/api/v1/search', searchRouter);
app.use('/api/v1/attractions', attractionRouter);
app.use('/api/v1/trips', tripRouter);
app.use('/api/v1/wishlist', wishlistRouter);
app.use('/api/v1/explore', exploreRouter);

app.use(notFoundMiddleware);
app.use(errorMiddleware);

export default app;
