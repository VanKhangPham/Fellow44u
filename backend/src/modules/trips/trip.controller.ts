import { AuthenticatedRequest } from '../../common/types/authenticated-request';
import { asyncHandler } from '../../common/utils/async-handler';
import { sendSuccess } from '../../common/utils/response';
import { tripService } from './trip.service';
import {
  validateCreateTripInput,
  validateTripStatusQuery,
  validateUpdateTripInput,
} from './trip.validation';

export const createTrip = asyncHandler(async (req: AuthenticatedRequest, res) => {
  const input = validateCreateTripInput(req.body);
  const result = await tripService.create(req.user!.userId, input);

  return sendSuccess(res, result, 'Trip created successfully', 201);
});

export const listTrips = asyncHandler(async (req: AuthenticatedRequest, res) => {
  const status = validateTripStatusQuery(req.query.status);
  const result = await tripService.list(req.user!.userId, status);

  return sendSuccess(res, result);
});

export const getTripDetail = asyncHandler(async (req: AuthenticatedRequest, res) => {
  const result = await tripService.getDetail(req.user!.userId, req.params.id);
  return sendSuccess(res, result);
});

export const updateTrip = asyncHandler(async (req: AuthenticatedRequest, res) => {
  const input = validateUpdateTripInput(req.body);
  const result = await tripService.update(req.user!.userId, req.params.id, input);

  return sendSuccess(res, result, 'Trip updated successfully');
});
