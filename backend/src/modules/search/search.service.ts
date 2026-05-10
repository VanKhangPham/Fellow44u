import { guideRepository } from '../guides/guide.repository';
import { tourRepository } from '../tours/tour.repository';

export interface SearchFilters {
  query?: string;
  city?: string;
  category?: string;
  language?: string;
}

export const searchService = {
  async search(filters: SearchFilters) {
    const category = filters.category?.toLowerCase();
    const shouldLoadGuides = !category || category === 'guide';
    const shouldLoadTours = !category || category === 'tour';

    const [guides, tours] = await Promise.all([
      shouldLoadGuides
        ? guideRepository.list({
            search: filters.query,
            city: filters.city,
            language: filters.language,
          })
        : Promise.resolve([]),
      shouldLoadTours
        ? tourRepository.list({
            search: filters.query,
            city: filters.city,
          })
        : Promise.resolve([]),
    ]);

    return {
      guides: guides.map((guide) => ({
        id: guide.id,
        name: guide.name,
        avatarPath: guide.avatarPath,
        location: guide.location,
        city: guide.city,
        country: guide.country,
        languages: guide.languagesText
          .split('|')
          .map((language) => language.trim())
          .filter(Boolean),
        rating: guide.rating,
        reviewsCount: guide.reviewsCount,
        bio: guide.bio,
        coverImagePath: guide.coverImagePath,
        isAvailable: guide.isAvailable,
      })),
      tours: tours.map((tour) => ({
        id: tour.id,
        title: tour.title,
        coverImagePath: tour.coverImagePath,
        dateLabel: tour.dateLabel,
        durationLabel: tour.durationLabel,
        priceLabel: tour.priceLabel,
        oldPriceLabel: tour.oldPriceLabel,
        likesLabel: tour.likesLabel,
        provider: tour.provider,
        itinerary: tour.itinerary,
        durationDetail: tour.durationDetail,
        departureDateLabel: tour.departureDateLabel,
        departurePlace: tour.departurePlace,
        description: tour.description,
        rating: tour.rating,
        reviewsCount: tour.reviewsCount,
        isLiked: tour.isLiked,
        isBookmarked: tour.isBookmarked,
      })),
    };
  },
};
