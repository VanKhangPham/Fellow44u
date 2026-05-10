import { prisma } from '../../config/db';

export const wishlistRepository = {
  listByUser(userId: string) {
    return prisma.wishlist.findMany({
      where: { userId },
      include: {
        tour: true,
      },
      orderBy: { createdAt: 'desc' },
    });
  },

  findByUserAndTour(userId: string, tourId: string) {
    return prisma.wishlist.findUnique({
      where: {
        userId_tourId: {
          userId,
          tourId,
        },
      },
    });
  },

  create(userId: string, tourId: string) {
    return prisma.wishlist.create({
      data: {
        userId,
        tourId,
      },
    });
  },

  deleteByUserAndTour(userId: string, tourId: string) {
    return prisma.wishlist.deleteMany({
      where: {
        userId,
        tourId,
      },
    });
  },
};
