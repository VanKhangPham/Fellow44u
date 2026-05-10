import { TripStatus } from '@prisma/client';

import { AppError } from '../../common/utils/app-error';

export interface TripPayload {
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
  status?: TripStatus;
}

function ensureString(value: unknown): string {
  return typeof value === 'string' ? value.trim() : '';
}

function ensureStringArray(value: unknown): string[] {
  return Array.isArray(value)
    ? value.filter((item): item is string => typeof item === 'string').map((item) => item.trim()).filter(Boolean)
    : [];
}

function validateTripBody(body: unknown): TripPayload {
  const payload = (body ?? {}) as Record<string, unknown>;
  const city = ensureString(payload.city);
  const dateLabel = ensureString(payload.date ?? payload.dateLabel);
  const fromTimeLabel = ensureString(payload.fromTime ?? payload.fromTimeLabel);
  const toTimeLabel = ensureString(payload.toTime ?? payload.toTimeLabel);
  const travelerCount = Number(payload.travelerCount);
  const errors: Record<string, string[]> = {};

  if (!city) {
    errors.city = ['City is required'];
  }

  if (!dateLabel) {
    errors.date = ['Date is required'];
  }

  if (!fromTimeLabel) {
    errors.fromTime = ['From time is required'];
  }

  if (!toTimeLabel) {
    errors.toTime = ['To time is required'];
  }

  if (!Number.isFinite(travelerCount) || travelerCount <= 0) {
    errors.travelerCount = ['Traveler count must be greater than 0'];
  }

  if (Object.keys(errors).length > 0) {
    throw new AppError(422, 'Validation failed', errors);
  }

  const statusInput = ensureString(payload.status).toUpperCase();
  const status = statusInput && statusInput in TripStatus ? (statusInput as TripStatus) : undefined;

  return {
    title: ensureString(payload.title) || undefined,
    city,
    dateLabel,
    fromTimeLabel,
    toTimeLabel,
    travelerCount,
    note: ensureString(payload.note) || undefined,
    guideId: ensureString(payload.guideId) || undefined,
    guideName: ensureString(payload.guideName) || undefined,
    priceLabel: ensureString(payload.priceLabel) || undefined,
    guideLanguagePreferences: ensureStringArray(payload.guideLanguagePreferences),
    attractionIds: ensureStringArray(payload.attractionIds),
    status,
  };
}

export function validateCreateTripInput(body: unknown) {
  return validateTripBody(body);
}

export function validateUpdateTripInput(body: unknown) {
  return validateTripBody(body);
}

export function validateTripStatusQuery(value: unknown): TripStatus | undefined {
  if (typeof value !== 'string' || !value.trim()) {
    return undefined;
  }

  const normalized = value.trim().toUpperCase();

  if (!(normalized in TripStatus)) {
    throw new AppError(422, 'Validation failed', {
      status: ['Status must be current, next, or past'],
    });
  }

  return normalized as TripStatus;
}
