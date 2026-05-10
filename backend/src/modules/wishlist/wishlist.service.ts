import { prisma } from '../../config/db';
import { AppError } from '../../common/utils/app-error';
import { wishlistRepository } from './wishlist.repository';

export const wishlistService = {
  async list(userId: string) {
    const items = await wishlistRepository.listByUser(userId);

    return items.map((item) => ({
      id: item.id,
      tourId: item.tourId,
      title: item.tour.title,
      coverImagePath: item.tour.coverImagePath,
      dateLabel: item.tour.dateLabel,
      daysLabel: item.tour.durationLabel,
      priceLabel: item.tour.priceLabel,
      likesLabel: item.tour.likesLabel,
      isLiked: item.tour.isLiked,
      isBookmarked: true,
    }));
  },

  async create(userId: string, tourId: string) {
    const tour = await prisma.tour.findUnique({
      where: { id: tourId },
    });

    if (!tour) {
      throw new AppError(404, 'Tour not found');
    }

    const existingItem = await wishlistRepository.findByUserAndTour(userId, tourId);

    if (existingItem) {
      throw new AppError(409, 'Tour already exists in wishlist');
    }

    const item = await wishlistRepository.create(userId, tourId);

    return {
      id: item.id,
      tourId: item.tourId,
    };
  },

  async remove(userId: string, tourId: string) {
    await wishlistRepository.deleteByUserAndTour(userId, tourId);
    return null;
  },
};
