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

  async getPopular() {
    const destinations = await destinationRepository.getPopular();

    return destinations.map((destination) => ({
      id: destination.id,
      name: destination.name,
      city: destination.city,
      country: destination.country,
      imageUrl: destination.imageUrl,
    }));
  },

  async search(query: string) {
    const destinations = await destinationRepository.search(query);

    return destinations.map((destination) => ({
      id: destination.id,
      name: destination.name,
      city: destination.city,
      country: destination.country,
      imageUrl: destination.imageUrl,
    }));
  },
};
