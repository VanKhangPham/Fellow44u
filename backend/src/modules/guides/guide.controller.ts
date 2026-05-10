import { asyncHandler } from '../../common/utils/async-handler';
import { sendSuccess } from '../../common/utils/response';
import { guideService } from './guide.service';

function parseBoolean(value: unknown): boolean | undefined {
  if (value === 'true') {
    return true;
  }

  if (value === 'false') {
    return false;
  }

  return undefined;
}

function parseLimit(value: unknown): number | undefined {
  if (typeof value !== 'string') {
    return undefined;
  }

  const limit = Number(value);
  return Number.isFinite(limit) && limit > 0 ? limit : undefined;
}

export const listGuides = asyncHandler(async (req, res) => {
  const result = await guideService.list({
    featured: parseBoolean(req.query.featured),
    limit: parseLimit(req.query.limit),
    search: typeof req.query.search === 'string' ? req.query.search.trim() : undefined,
    city: typeof req.query.city === 'string' ? req.query.city.trim() : undefined,
    language:
      typeof req.query.language === 'string'
        ? req.query.language.trim()
        : undefined,
  });

  return sendSuccess(res, result);
});

export const getGuideDetail = asyncHandler(async (req, res) => {
  const result = await guideService.getDetail(req.params.id);
  return sendSuccess(res, result);
});
