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
};
