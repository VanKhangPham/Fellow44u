import { asyncHandler } from '../../common/utils/async-handler';
import { sendSuccess } from '../../common/utils/response';
import { searchService } from './search.service';

export const search = asyncHandler(async (req, res) => {
  const result = await searchService.search({
    query: typeof req.query.destination === 'string' ? req.query.destination.trim() : typeof req.query.query === 'string' ? req.query.query.trim() : undefined,
    city: typeof req.query.city === 'string' ? req.query.city.trim() : undefined,
    category:
      typeof req.query.tab === 'string'
        ? (req.query.tab === 'guides' ? 'guide' : 'tour')
        : typeof req.query.category === 'string'
        ? req.query.category.trim()
        : undefined,
    language:
      typeof req.query.languages === 'string'
        ? req.query.languages.trim()
        : typeof req.query.language === 'string'
        ? req.query.language.trim()
        : undefined,
  });

  return sendSuccess(res, result);
});
