import { asyncHandler } from '../../common/utils/async-handler';
import { sendSuccess } from '../../common/utils/response';
import { destinationService } from './destination.service';

export const listDestinations = asyncHandler(async (_req, res) => {
  const result = await destinationService.list();
  return sendSuccess(res, result);
});
