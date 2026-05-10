import { AppError } from '../../common/utils/app-error';
import { tourRepository, TourListFilters } from './tour.repository';

function serializeTour(tour: {
  id: string;
  title: string;
  coverImagePath: string;
  dateLabel: string;
  durationLabel: string;
  priceLabel: string;
  oldPriceLabel: string | null;
  likesLabel: string;
  provider: string;
  itinerary: string;
  durationDetail: string;
  departureDateLabel: string;
  departurePlace: string;
  description: string | null;
  rating: number;
  reviewsCount: number;
  isLiked: boolean;
  isBookmarked: boolean;
}) {
  return {
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
  };
}

export const tourService = {
  async list(filters: TourListFilters) {
    const tours = await tourRepository.list(filters);
    return tours.map(serializeTour);
  },

  async getDetail(tourId: string) {
    const detail = await tourRepository.findById(tourId);

    if (!detail) {
      throw new AppError(404, 'Tour not found');
    }

    return {
      tour: serializeTour(detail),
      headerImagePath: detail.headerImagePath,
      reviewsCount: detail.reviewsCount,
      scheduleDays: detail.scheduleDays.map((day) => ({
        id: day.id,
        label: day.label,
        entries: day.entries.map((entry) => ({
          id: entry.id,
          timeLabel: entry.timeLabel,
          description: entry.description,
        })),
      })),
    };
  },
};
