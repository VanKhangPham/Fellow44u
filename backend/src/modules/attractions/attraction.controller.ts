import { asyncHandler } from '../../common/utils/async-handler';
import { sendSuccess } from '../../common/utils/response';
import { attractionService } from './attraction.service';

export const listAttractions = asyncHandler(async (req, res) => {
  const result = await attractionService.list({
    search: typeof req.query.search === 'string' ? req.query.search.trim() : undefined,
    city: typeof req.query.city === 'string' ? req.query.city.trim() : undefined,
  });

  return sendSuccess(res, result);
});
