import '../models/destination_model.dart';
import '../models/experience_model.dart';
import '../models/guide_detail_model.dart';
import '../models/guide_experience_detail_model.dart';
import '../models/guide_model.dart';
import '../models/guide_review_model.dart';
import '../models/journey_model.dart';
import '../models/tour_detail_model.dart';
import '../models/tour_model.dart';
import '../models/tour_schedule_day_model.dart';
import '../models/tour_schedule_entry_model.dart';
import '../models/travel_news_model.dart';

const _fallbackGuideAvatar =
    'assets/images/explore/4293a86720d50b28e6ad1b224c2db9f92d54d9d5.jpg';
const _fallbackTourCover =
    'assets/images/explore/69c85a3ef2934da77239256b0a2f5429818850a5.jpg';
const _fallbackHeaderImage = 'assets/images/tour_detail/670301139 1.png';
const _fallbackGuideHeader =
    'assets/images/guide_page/a3d236cc36adec97a0448232035165d4adb9a4ae.png';
const _fallbackNewsImage =
    'assets/images/explore/42751d9e220fe7ee14bf95a97b59825a368e47d5.jpg';
const _fallbackExperienceImage =
    'assets/images/explore/21c7c394eebe1f5ab9fb03014d50d398e03633a0.jpg';
const _fallbackJourneyImage =
    'assets/images/explore/de3ae8b56251d0766aa04a8cbe98e842db2ac2fb.png';
const _fallbackReviewAvatar =
    'assets/images/guide_page/1019aa9fca01d6bce807cf74fe90b3b71c995634.png';

List<dynamic> asList(dynamic value) => value is List ? value : const [];

Map<String, dynamic> asMap(dynamic value) =>
    value is Map<String, dynamic> ? value : <String, dynamic>{};

String asString(dynamic value, {String fallback = ''}) {
  if (value is String && value.trim().isNotEmpty) {
    return value.trim();
  }
  return fallback;
}

int asInt(dynamic value, {int fallback = 0}) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value) ?? fallback;
  return fallback;
}

double asDouble(dynamic value, {double fallback = 0}) {
  if (value is double) return value;
  if (value is num) return value.toDouble();
  if (value is String) return double.tryParse(value) ?? fallback;
  return fallback;
}

bool asBool(dynamic value, {bool fallback = false}) {
  if (value is bool) return value;
  if (value is String) return value.toLowerCase() == 'true';
  return fallback;
}

String asAssetPath(dynamic value, String fallbackAsset) {
  final path = asString(value);
  if (path.startsWith('assets/')) {
    return path;
  }
  return fallbackAsset;
}

List<String> asStringList(dynamic value) {
  if (value is! List) return const [];
  return value
      .map((item) => asString(item))
      .where((item) => item.isNotEmpty)
      .toList();
}

GuideModel mapGuide(dynamic json) {
  final item = asMap(json);
  final city = asString(item['city']);
  final country = asString(item['country']);
  final fallbackLocation = [
    city,
    country,
  ].where((e) => e.isNotEmpty).join(', ');
  return GuideModel(
    id: asString(
      item['id'],
      fallback: asString(item['_id'], fallback: 'guide-unknown'),
    ),
    name: asString(item['name'], fallback: 'Unknown guide'),
    avatarPath: asAssetPath(
      item['avatarPath'] ?? item['avatar'],
      _fallbackGuideAvatar,
    ),
    location: asString(
      item['location'],
      fallback: fallbackLocation.isEmpty ? 'Unknown' : fallbackLocation,
    ),
    city: city,
    country: country,
    languages: asStringList(item['languages']),
    rating: asDouble(item['rating'], fallback: 5),
    reviewsCount: asInt(item['reviewsCount'], fallback: 0),
    bio: asString(item['bio'], fallback: ''),
    coverImagePath: asAssetPath(item['coverImagePath'], _fallbackGuideHeader),
    isAvailable: asBool(item['isAvailable'], fallback: true),
  );
}

TourModel mapTour(dynamic json) {
  final item = asMap(json);
  return TourModel(
    id: asString(
      item['id'],
      fallback: asString(item['_id'], fallback: 'tour-unknown'),
    ),
    title: asString(item['title'], fallback: 'Untitled tour'),
    coverImagePath: asAssetPath(
      item['coverImagePath'] ?? item['coverImage'],
      _fallbackTourCover,
    ),
    dateLabel: asString(
      item['dateLabel'],
      fallback: asString(item['date'], fallback: 'N/A'),
    ),
    durationLabel: asString(
      item['durationLabel'],
      fallback: asString(item['duration'], fallback: 'N/A'),
    ),
    priceLabel: asString(
      item['priceLabel'],
      fallback: asString(item['price'], fallback: '\$0.00'),
    ),
    likesLabel: asString(
      item['likesLabel'],
      fallback: '${asInt(item['likesCount'])} likes',
    ),
    provider: asString(item['provider'], fallback: 'Unknown'),
    itinerary: asString(item['itinerary'], fallback: 'N/A'),
    durationDetail: asString(
      item['durationDetail'],
      fallback: asString(item['duration'], fallback: 'N/A'),
    ),
    departureDateLabel: asString(
      item['departureDateLabel'],
      fallback: asString(item['departureDate'], fallback: 'N/A'),
    ),
    departurePlace: asString(item['departurePlace'], fallback: 'N/A'),
    oldPriceLabel: asString(item['oldPriceLabel']),
    description: asString(item['description']),
    rating: asDouble(item['rating'], fallback: 5),
    reviewsCount: asInt(item['reviewsCount'], fallback: 0),
    isLiked: asBool(item['isLiked'], fallback: false),
    isBookmarked: asBool(item['isBookmarked'], fallback: false),
  );
}

GuideDetailModel mapGuideDetail(dynamic json) {
  final item = asMap(json);
  final guide = mapGuide(item['guide'] ?? item);
  final experiences = asList(
    item['experiences'],
  ).map(mapGuideExperience).toList();
  final reviews = asList(item['reviews']).map(mapGuideReview).toList();
  return GuideDetailModel(
    guide: guide,
    headerImagePath: asAssetPath(item['headerImagePath'], _fallbackGuideHeader),
    mediaPreviewPath: asAssetPath(item['mediaPreviewPath'], guide.avatarPath),
    languages: asStringList(item['languages']).isEmpty
        ? guide.languages
        : asStringList(item['languages']),
    shortIntroduction: asString(item['shortIntroduction'], fallback: guide.bio),
    experiences: experiences,
    reviews: reviews,
  );
}

GuideExperienceDetailModel mapGuideExperience(dynamic json) {
  final item = asMap(json);
  return GuideExperienceDetailModel(
    leftImagePath: asAssetPath(item['leftImagePath'], _fallbackExperienceImage),
    rightTopImagePath: asAssetPath(
      item['rightTopImagePath'],
      _fallbackExperienceImage,
    ),
    rightBottomImagePath: asAssetPath(
      item['rightBottomImagePath'],
      _fallbackExperienceImage,
    ),
    title: asString(item['title'], fallback: 'Experience'),
    location: asString(item['location'], fallback: 'Unknown'),
    dateLabel: asString(item['dateLabel'], fallback: 'N/A'),
    likesLabel: asString(item['likesLabel'], fallback: '0 likes'),
  );
}

GuideReviewModel mapGuideReview(dynamic json) {
  final item = asMap(json);
  return GuideReviewModel(
    avatarPath: asAssetPath(
      item['avatarPath'] ?? item['avatar'],
      _fallbackReviewAvatar,
    ),
    name: asString(item['name'], fallback: 'Anonymous'),
    dateLabel: asString(item['dateLabel'], fallback: 'N/A'),
    review: asString(item['review'], fallback: ''),
    rating: asInt(item['rating'], fallback: 5),
  );
}

TourDetailModel mapTourDetail(dynamic json) {
  final item = asMap(json);
  return TourDetailModel(
    tour: mapTour(item['tour'] ?? item),
    headerImagePath: asAssetPath(item['headerImagePath'], _fallbackHeaderImage),
    reviewsCount: asInt(item['reviewsCount'], fallback: 0),
    scheduleDays: asList(item['scheduleDays']).map(mapScheduleDay).toList(),
  );
}

TourScheduleDayModel mapScheduleDay(dynamic json) {
  final item = asMap(json);
  return TourScheduleDayModel(
    label: asString(item['label'], fallback: 'Day'),
    entries: asList(item['entries']).map(mapScheduleEntry).toList(),
  );
}

TourScheduleEntryModel mapScheduleEntry(dynamic json) {
  final item = asMap(json);
  return TourScheduleEntryModel(
    timeLabel: asString(item['timeLabel'], fallback: '--:--'),
    description: asString(item['description'], fallback: ''),
  );
}

DestinationModel mapDestination(dynamic json) {
  final item = asMap(json);
  final city = asString(item['city']);
  final country = asString(item['country']);
  final name = asString(
    item['name'],
    fallback: [city, country].where((e) => e.isNotEmpty).join(', '),
  );
  return DestinationModel(
    id: asString(
      item['id'],
      fallback: asString(
        item['_id'],
        fallback: name.toLowerCase().replaceAll(' ', '-'),
      ),
    ),
    name: name,
    city: city,
    country: country,
  );
}

JourneyModel mapJourney(dynamic json) {
  final item = asMap(json);
  return JourneyModel(
    id: asString(
      item['id'],
      fallback: asString(item['_id'], fallback: 'journey-unknown'),
    ),
    imagePath: asAssetPath(item['imagePath'], _fallbackJourneyImage),
    title: asString(item['title'], fallback: 'Journey'),
    dateLabel: asString(item['dateLabel'], fallback: 'N/A'),
    durationLabel: asString(item['durationLabel'], fallback: 'N/A'),
    priceLabel: asString(item['priceLabel'], fallback: '\$0.00'),
    likesLabel: asString(item['likesLabel'], fallback: '0 likes'),
    isBookmarked: asBool(item['isBookmarked']),
  );
}

ExperienceModel mapExperience(dynamic json) {
  final item = asMap(json);
  return ExperienceModel(
    id: asString(
      item['id'],
      fallback: asString(item['_id'], fallback: 'experience-unknown'),
    ),
    imagePath: asAssetPath(item['imagePath'], _fallbackExperienceImage),
    guideAvatarPath: asAssetPath(item['guideAvatarPath'], _fallbackGuideAvatar),
    title: asString(item['title'], fallback: 'Experience'),
    location: asString(item['location'], fallback: 'Unknown'),
    guideName: asString(item['guideName'], fallback: 'Guide'),
  );
}

TravelNewsModel mapNews(dynamic json) {
  final item = asMap(json);
  return TravelNewsModel(
    id: asString(
      item['id'],
      fallback: asString(item['_id'], fallback: 'news-unknown'),
    ),
    title: asString(item['title'], fallback: 'Travel news'),
    dateLabel: asString(item['dateLabel'], fallback: 'N/A'),
    imagePath: asAssetPath(item['imagePath'], _fallbackNewsImage),
  );
}
