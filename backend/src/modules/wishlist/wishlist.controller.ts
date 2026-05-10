import { AuthenticatedRequest } from '../../common/types/authenticated-request';
import { asyncHandler } from '../../common/utils/async-handler';
import { AppError } from '../../common/utils/app-error';
import { sendSuccess } from '../../common/utils/response';
import { wishlistService } from './wishlist.service';

function validateWishlistBody(body: unknown): { tourId: string } {
  const payload = (body ?? {}) as Record<string, unknown>;
  const tourId = typeof payload.tourId === 'string' ? payload.tourId.trim() : '';

  if (!tourId) {
    throw new AppError(422, 'Validation failed', {
      tourId: ['Tour id is required'],
    });
  }

  return { tourId };
}

export const listWishlist = asyncHandler(async (req: AuthenticatedRequest, res) => {
  const result = await wishlistService.list(req.user!.userId);
  return sendSuccess(res, result);
});

export const addWishlistItem = asyncHandler(async (req: AuthenticatedRequest, res) => {
  const input = validateWishlistBody(req.body);
  const result = await wishlistService.create(req.user!.userId, input.tourId);

  return sendSuccess(res, result, 'Added to wishlist', 201);
});

export const deleteWishlistItem = asyncHandler(async (req: AuthenticatedRequest, res) => {
  const result = await wishlistService.remove(req.user!.userId, req.params.tourId);
  return sendSuccess(res, result, 'Removed from wishlist');
});
