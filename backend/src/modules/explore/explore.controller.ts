import { asyncHandler } from '../../common/utils/async-handler';
import { sendSuccess } from '../../common/utils/response';
import { prisma } from '../../config/db';

export const getExploreHome = asyncHandler(async (req, res) => {
  // Fetch guides
  const guides = await prisma.guide.findMany({ take: 5 });

  // Fetch featured tours
  const featuredTours = await prisma.tour.findMany({ where: { featured: true }, take: 5 });

  // Fetch experiences
  const guideExperiences = await prisma.guideExperience.findMany({
    include: { guide: true },
    take: 5
  });

  const experiences = guideExperiences.map((e) => ({
    id: e.id,
    imagePath: e.leftImagePath,
    guideAvatarPath: e.guide.avatarPath,
    title: e.title,
    location: e.location,
    guideName: e.guide.name
  }));

  // Mock journeys
  const journeys = [
    {
      id: "j1",
      imagePath: "assets/images/explore/de3ae8b56251d0766aa04a8cbe98e842db2ac2fb.png",
      title: "Da Nang - Ba Na - Hoi An",
      dateLabel: "Jan 30, 2024",
      durationLabel: "3 Days",
      priceLabel: "$400",
      likesLabel: "1.2k likes",
      isBookmarked: false
    },
    {
      id: "j2",
      imagePath: "assets/images/explore/de3ae8b56251d0766aa04a8cbe98e842db2ac2fb.png",
      title: "Thai Lan - Bangkok",
      dateLabel: "Feb 15, 2024",
      durationLabel: "4 Days",
      priceLabel: "$200",
      likesLabel: "800 likes",
      isBookmarked: true
    }
  ];

  // Mock news
  const news = [
    {
      id: "n1",
      title: "Discover the new world",
      dateLabel: "Jan 12, 2024",
      imagePath: "assets/images/explore/42751d9e220fe7ee14bf95a97b59825a368e47d5.jpg"
    },
    {
      id: "n2",
      title: "Symphony of light",
      dateLabel: "Jan 10, 2024",
      imagePath: "assets/images/explore/42751d9e220fe7ee14bf95a97b59825a368e47d5.jpg"
    }
  ];

  return sendSuccess(res, {
    journeys,
    guides,
    experiences,
    featuredTours,
    news
  });
});
