import { Prisma } from '@prisma/client';

import { prisma } from '../../config/db';

export interface GuideListFilters {
  featured?: boolean;
  limit?: number;
  search?: string;
  city?: string;
  language?: string;
}

export const guideRepository = {
  async list(filters: GuideListFilters) {
    const where: Prisma.GuideWhereInput = {};

    if (typeof filters.featured === 'boolean') {
      where.featured = filters.featured;
    }

    const guides = await prisma.guide.findMany({
      where,
      orderBy: [
        { featured: 'desc' },
        { rating: 'desc' },
        { name: 'asc' },
      ],
    });

    const normalizedSearch = filters.search?.toLowerCase();
    const normalizedCity = filters.city?.toLowerCase();
    const normalizedLanguage = filters.language?.toLowerCase();

    const filtered = guides.filter((guide) => {
      const matchesSearch = !normalizedSearch || [
        guide.name,
        guide.location,
        guide.city,
        guide.country,
      ].some((value) => value.toLowerCase().includes(normalizedSearch));

      const matchesCity = !normalizedCity
        || guide.city.toLowerCase().includes(normalizedCity);

      const matchesLanguage = !normalizedLanguage || guide.languagesText
        .split('|')
        .map((language) => language.trim().toLowerCase())
        .includes(normalizedLanguage);

      return matchesSearch && matchesCity && matchesLanguage;
    });

    return typeof filters.limit === 'number'
      ? filtered.slice(0, filters.limit)
      : filtered;
  },

  findById(guideId: string) {
    return prisma.guide.findUnique({
      where: { id: guideId },
      include: {
        experiences: {
          orderBy: { sortOrder: 'asc' },
        },
        reviews: {
          orderBy: { createdAt: 'asc' },
        },
      },
    });
  },
};
