import { attractionRepository, AttractionListFilters } from './attraction.repository';

export const attractionService = {
  async list(filters: AttractionListFilters) {
    const attractions = await attractionRepository.list(filters);

    return attractions.map((attraction) => ({
      id: attraction.id,
      name: attraction.name,
      city: attraction.city,
      imagePath: attraction.imagePath,
      description: attraction.description,
      isSuggested: attraction.isSuggested,
    }));
  },
};
