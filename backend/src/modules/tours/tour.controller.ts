import { asyncHandler } from '../../common/utils/async-handler';
import { sendSuccess } from '../../common/utils/response';
import { tourService } from './tour.service';

function parseBoolean(value: unknown): boolean | undefined {
  if (value === 'true') {
    return true;
  }

  if (value === 'false') {
    return false;
  }

  return undefined;
}

function parseNumberValue(value: unknown): number | undefined {
  if (typeof value !== 'string') {
    return undefined;
  }

  const parsed = Number(value);
  return Number.isFinite(parsed) ? parsed : undefined;
}

export const listTours = asyncHandler(async (req, res) => {
  const result = await tourService.list({
    featured: parseBoolean(req.query.featured),
    limit: parseNumberValue(req.query.limit),
    search: typeof req.query.search === 'string' ? req.query.search.trim() : undefined,
    city: typeof req.query.city === 'string' ? req.query.city.trim() : undefined,
    minPrice: parseNumberValue(req.query.minPrice),
    maxPrice: parseNumberValue(req.query.maxPrice),
  });

  return sendSuccess(res, result);
});

export const getTourDetail = asyncHandler(async (req, res) => {
  const result = await tourService.getDetail(req.params.id);
  return sendSuccess(res, result);
});
