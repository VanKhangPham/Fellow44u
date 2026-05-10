import { AppError } from '../../common/utils/app-error';
import { guideRepository, GuideListFilters } from './guide.repository';

function parseLanguages(languagesText: string) {
  return languagesText
    .split('|')
    .map((language) => language.trim())
    .filter(Boolean);
}

function serializeGuide(guide: {
  id: string;
  name: string;
  avatarPath: string;
  location: string;
  city: string;
  country: string;
  languagesText: string;
  rating: number;
  reviewsCount: number;
  bio: string;
  coverImagePath: string | null;
  isAvailable: boolean;
}) {
  return {
    id: guide.id,
    name: guide.name,
    avatarPath: guide.avatarPath,
    location: guide.location,
    city: guide.city,
    country: guide.country,
    languages: parseLanguages(guide.languagesText),
    rating: guide.rating,
    reviewsCount: guide.reviewsCount,
    bio: guide.bio,
    coverImagePath: guide.coverImagePath,
    isAvailable: guide.isAvailable,
  };
}

export const guideService = {
  async list(filters: GuideListFilters) {
    const guides = await guideRepository.list(filters);
    return guides.map(serializeGuide);
  },

  async getDetail(guideId: string) {
    const detail = await guideRepository.findById(guideId);

    if (!detail) {
      throw new AppError(404, 'Guide not found');
    }

    return {
      guide: serializeGuide(detail),
      headerImagePath: detail.headerImagePath,
      mediaPreviewPath: detail.mediaPreviewPath,
      languages: parseLanguages(detail.languagesText),
      shortIntroduction: detail.shortIntroduction,
      experiences: detail.experiences.map((experience) => ({
        id: experience.id,
        leftImagePath: experience.leftImagePath,
        rightTopImagePath: experience.rightTopImagePath,
        rightBottomImagePath: experience.rightBottomImagePath,
        title: experience.title,
        location: experience.location,
        dateLabel: experience.dateLabel,
        likesLabel: experience.likesLabel,
      })),
      reviews: detail.reviews.map((review) => ({
        id: review.id,
        avatarPath: review.avatarPath,
        name: review.name,
        dateLabel: review.dateLabel,
        review: review.review,
        rating: review.rating,
      })),
    };
  },
};
