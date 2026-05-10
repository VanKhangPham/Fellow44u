import { Router } from 'express';

import { requireAuth } from '../../common/middleware/auth.middleware';
import { addWishlistItem, deleteWishlistItem, listWishlist } from './wishlist.controller';

const wishlistRouter = Router();

wishlistRouter.use(requireAuth);
wishlistRouter.get('/', listWishlist);
wishlistRouter.post('/', addWishlistItem);
wishlistRouter.delete('/:tourId', deleteWishlistItem);

export default wishlistRouter;
