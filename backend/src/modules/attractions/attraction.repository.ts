import { Prisma } from '@prisma/client';

import { prisma } from '../../config/db';

export interface AttractionListFilters {
  search?: string;
  city?: string;
}

export const attractionRepository = {
  async list(filters: AttractionListFilters) {
    const attractions = await prisma.attraction.findMany({
      orderBy: [
        { isSuggested: 'desc' },
        { name: 'asc' },
      ],
    });

    return attractions.filter((attraction) => {
      const matchesSearch = !filters.search
        || attraction.name.toLowerCase().includes(filters.search.toLowerCase());
      const matchesCity = !filters.city
        || attraction.city.toLowerCase().includes(filters.city.toLowerCase());

      return matchesSearch && matchesCity;
    });
  },

  findManyByIds(ids: string[]) {
    return prisma.attraction.findMany({
      where: {
        id: {
          in: ids,
        },
      },
    });
  },
};
