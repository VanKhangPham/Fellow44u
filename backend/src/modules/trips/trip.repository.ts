import { Prisma, TripStatus } from '@prisma/client';

import { prisma } from '../../config/db';

export interface TripMutationInput {
  title?: string;
  city: string;
  dateLabel: string;
  fromTimeLabel: string;
  toTimeLabel: string;
  travelerCount: number;
  note?: string;
  guideId?: string;
  guideName?: string;
  priceLabel?: string;
  guideLanguagePreferences: string[];
  attractionIds: string[];
  status: TripStatus;
}

export const tripRepository = {
  create(userId: string, input: TripMutationInput) {
    return prisma.trip.create({
      data: {
        userId,
        title: input.title,
        city: input.city,
        dateLabel: input.dateLabel,
        fromTimeLabel: input.fromTimeLabel,
        toTimeLabel: input.toTimeLabel,
        travelerCount: input.travelerCount,
        note: input.note,
        guideId: input.guideId,
        guideName: input.guideName,
        priceLabel: input.priceLabel,
        guideLanguagePreferencesText: input.guideLanguagePreferences.join('|'),
        status: input.status,
        attractionLinks: input.attractionIds.length
          ? {
              create: input.attractionIds.map((attractionId) => ({
                attractionId,
              })),
            }
          : undefined,
      },
      include: {
        attractionLinks: {
          include: {
            attraction: true,
          },
        },
      },
    });
  },

  listByUser(userId: string, status?: TripStatus) {
    const where: Prisma.TripWhereInput = {
      userId,
    };

    if (status) {
      where.status = status;
    }

    return prisma.trip.findMany({
      where,
      orderBy: [
        { createdAt: 'desc' },
      ],
    });
  },

  findByIdForUser(tripId: string, userId: string) {
    return prisma.trip.findFirst({
      where: {
        id: tripId,
        userId,
      },
      include: {
        attractionLinks: {
          include: {
            attraction: true,
          },
        },
      },
    });
  },

  async updateForUser(tripId: string, userId: string, input: TripMutationInput) {
    return prisma.$transaction(async (tx) => {
      const existingTrip = await tx.trip.findFirst({
        where: {
          id: tripId,
          userId,
        },
      });

      if (!existingTrip) {
        return null;
      }

      await tx.trip.update({
        where: { id: tripId },
        data: {
          title: input.title,
          city: input.city,
          dateLabel: input.dateLabel,
          fromTimeLabel: input.fromTimeLabel,
          toTimeLabel: input.toTimeLabel,
          travelerCount: input.travelerCount,
          note: input.note,
          guideId: input.guideId,
          guideName: input.guideName,
          priceLabel: input.priceLabel,
          guideLanguagePreferencesText: input.guideLanguagePreferences.join('|'),
          status: input.status,
        },
      });

      await tx.tripAttraction.deleteMany({
        where: {
          tripId,
        },
      });

      if (input.attractionIds.length > 0) {
        await tx.tripAttraction.createMany({
          data: input.attractionIds.map((attractionId) => ({
            tripId,
            attractionId,
          })),
        });
      }

      return tx.trip.findFirst({
        where: {
          id: tripId,
          userId,
        },
        include: {
          attractionLinks: {
            include: {
              attraction: true,
            },
          },
        },
      });
    });
  },
};
