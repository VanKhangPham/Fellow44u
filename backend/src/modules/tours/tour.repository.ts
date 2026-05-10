import { Prisma } from '@prisma/client';

import { prisma } from '../../config/db';

export interface TourListFilters {
  featured?: boolean;
  limit?: number;
  search?: string;
  city?: string;
  minPrice?: number;
  maxPrice?: number;
}

function parsePriceNumber(label: string): number {
  return Number(label.replace(/[^0-9.]/g, '')) || 0;
}

export const tourRepository = {
  async list(filters: TourListFilters) {
    const where: Prisma.TourWhereInput = {};

    if (typeof filters.featured === 'boolean') {
      where.featured = filters.featured;
    }

    const tours = await prisma.tour.findMany({
      where,
      orderBy: [
        { featured: 'desc' },
        { title: 'asc' },
      ],
    });

    const normalizedSearch = filters.search?.toLowerCase();
    const normalizedCity = filters.city?.toLowerCase();

    const filtered = tours.filter((tour) => {
      const matchesSearch = !normalizedSearch || [
        tour.title,
        tour.itinerary,
        tour.departurePlace,
      ].some((value) => value.toLowerCase().includes(normalizedSearch));

      const matchesCity = !normalizedCity || [
        tour.city ?? '',
        tour.departurePlace,
      ].some((value) => value.toLowerCase().includes(normalizedCity));

      const price = parsePriceNumber(tour.priceLabel);

      if (typeof filters.minPrice === 'number' && price < filters.minPrice) {
        return false;
      }

      if (typeof filters.maxPrice === 'number' && price > filters.maxPrice) {
        return false;
      }

      return matchesSearch && matchesCity;
    });

    return typeof filters.limit === 'number'
      ? filtered.slice(0, filters.limit)
      : filtered;
  },

  findById(tourId: string) {
    return prisma.tour.findUnique({
      where: { id: tourId },
      include: {
        scheduleDays: {
          orderBy: { sortOrder: 'asc' },
          include: {
            entries: {
              orderBy: { sortOrder: 'asc' },
            },
          },
        },
      },
    });
  },
};
