import { TripStatus } from '@prisma/client';

import { AppError } from '../../common/utils/app-error';
import { tripRepository } from './trip.repository';
import { TripPayload } from './trip.validation';

function parseGuideLanguagePreferences(value: string) {
  return value
    .split('|')
    .map((item) => item.trim())
    .filter(Boolean);
}

function serializeStatus(status: TripStatus) {
  return status.toLowerCase();
}

function serializeTripSummary(trip: {
  id: string;
  city: string;
  dateLabel: string;
  fromTimeLabel: string;
  toTimeLabel: string;
  travelerCount: number;
  status: TripStatus;
  title: string | null;
  guideId: string | null;
  guideName: string | null;
  priceLabel: string | null;
  guideLanguagePreferencesText: string;
}) {
  return {
    id: trip.id,
    city: trip.city,
    dateLabel: trip.dateLabel,
    fromTimeLabel: trip.fromTimeLabel,
    toTimeLabel: trip.toTimeLabel,
    travelerCount: trip.travelerCount,
    status: serializeStatus(trip.status),
    title: trip.title,
    guideId: trip.guideId,
    guideName: trip.guideName,
    priceLabel: trip.priceLabel,
    guideLanguagePreferences: parseGuideLanguagePreferences(
      trip.guideLanguagePreferencesText,
    ),
  };
}

export const tripService = {
  async create(userId: string, input: TripPayload) {
    const trip = await tripRepository.create(userId, {
      ...input,
      status: input.status ?? TripStatus.NEXT,
    });

    return {
      ...serializeTripSummary(trip),
      note: trip.note,
      attractionIds: trip.attractionLinks.map((item) => item.attractionId),
    };
  },

  async list(userId: string, status?: TripStatus) {
    const trips = await tripRepository.listByUser(userId, status);
    return trips.map(serializeTripSummary);
  },

  async getDetail(userId: string, tripId: string) {
    const trip = await tripRepository.findByIdForUser(tripId, userId);

    if (!trip) {
      throw new AppError(404, 'Trip not found');
    }

    return {
      ...serializeTripSummary(trip),
      note: trip.note,
      attractions: trip.attractionLinks.map((item) => item.attraction),
    };
  },

  async update(userId: string, tripId: string, input: TripPayload) {
    const trip = await tripRepository.updateForUser(tripId, userId, {
      ...input,
      status: input.status ?? TripStatus.NEXT,
    });

    if (!trip) {
      throw new AppError(404, 'Trip not found');
    }

    return {
      id: trip.id,
    };
  },
};
