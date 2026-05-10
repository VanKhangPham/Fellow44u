import { destinationRepository } from './destination.repository';

export const destinationService = {
  async list() {
    const destinations = await destinationRepository.list();

    return destinations.map((destination) => ({
      id: destination.id,
      name: destination.name,
      city: destination.city,
      country: destination.country,
      imageUrl: destination.imageUrl,
    }));
  },
};
