import { Destination } from '@prisma/client';

import { prisma } from '../../config/db';

export const destinationRepository = {
  list(): Promise<Destination[]> {
    return prisma.destination.findMany({
      orderBy: [
        { country: 'asc' },
        { city: 'asc' },
      ],
    });
  },

  getPopular(): Promise<Destination[]> {
    return prisma.destination.findMany({
      take: 10,
      orderBy: {
        id: 'asc',
      },
    });
  },

  search(query: string): Promise<Destination[]> {
    return prisma.destination.findMany({
      where: {
        OR: [
          { name: { contains: query } },
          { city: { contains: query } },
          { country: { contains: query } },
        ],
      },
      orderBy: [
        { country: 'asc' },
        { city: 'asc' },
      ],
    });
  },
};
