import { asyncHandler } from '../../common/utils/async-handler';
import { sendSuccess } from '../../common/utils/response';
import { destinationService } from './destination.service';

export const listDestinations = asyncHandler(async (_req, res) => {
  const result = await destinationService.list();
  return sendSuccess(res, result);
});

export const getPopularDestinations = asyncHandler(async (_req, res) => {
  const result = await destinationService.getPopular();
  return sendSuccess(res, result);
});

export const searchDestinations = asyncHandler(async (req, res) => {
  const query = (req.query.q as string) || '';
  const result = await destinationService.search(query);
  return sendSuccess(res, result);
});
