import { PrismaClient, TripStatus } from '@prisma/client';
import bcrypt from 'bcryptjs';

const prisma = new PrismaClient();

async function main() {
  const passwordHash = await bcrypt.hash('12345678', 10);

  await prisma.tripAttraction.deleteMany();
  await prisma.wishlist.deleteMany();
  await prisma.trip.deleteMany();
  await prisma.tourScheduleEntry.deleteMany();
  await prisma.tourScheduleDay.deleteMany();
  await prisma.tour.deleteMany();
  await prisma.guideExperience.deleteMany();
  await prisma.guideReview.deleteMany();
  await prisma.guide.deleteMany();
  await prisma.attraction.deleteMany();
  await prisma.destination.deleteMany();

  await prisma.user.upsert({
    where: { email: 'a@gmail.com' },
    update: {},
    create: {
      fullName: 'Nguyen Van A',
      email: 'a@gmail.com',
      passwordHash,
    },
  });

  await prisma.destination.createMany({
    data: [
      {
        id: 'danang-vietnam',
        name: 'Danang, Vietnam',
        city: 'Danang',
        country: 'Vietnam',
      },
      {
        id: 'hcm-vietnam',
        name: 'Ho Chi Minh, Vietnam',
        city: 'Ho Chi Minh',
        country: 'Vietnam',
      },
      {
        id: 'venice-italy',
        name: 'Venice, Italy',
        city: 'Venice',
        country: 'Italy',
      },
      {
        id: 'hanoi-vietnam',
        name: 'Hanoi, Vietnam',
        city: 'Hanoi',
        country: 'Vietnam',
      },
    ],
  });

  await prisma.guide.createMany({
    data: [
      {
        id: 'guide-tuan-tran',
        name: 'Tuan Tran',
        avatarPath:
          'assets/images/explore/4293a86720d50b28e6ad1b224c2db9f92d54d9d5.jpg',
        location: 'Danang, Vietnam',
        city: 'Danang',
        country: 'Vietnam',
        languagesText: 'Vietnamese|English|Korean',
        rating: 5,
        reviewsCount: 127,
        bio: 'Local guide in Danang.',
        featured: true,
        headerImagePath:
          'assets/images/guide_page/a3d236cc36adec97a0448232035165d4adb9a4ae.png',
        mediaPreviewPath:
          'assets/images/explore/4293a86720d50b28e6ad1b224c2db9f92d54d9d5.jpg',
        shortIntroduction:
          'Short introduction: Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      },
      {
        id: 'guide-emmy',
        name: 'Emmy',
        avatarPath:
          'assets/images/explore/d8d1d509c67d429aab24f69d4b7219554c1c69b7.png',
        location: 'Hanoi, Vietnam',
        city: 'Hanoi',
        country: 'Vietnam',
        languagesText: 'Vietnamese|English',
        rating: 5,
        reviewsCount: 129,
        bio: 'Local guide in Hanoi.',
        featured: true,
        headerImagePath:
          'assets/images/guide_page/a3d236cc36adec97a0448232035165d4adb9a4ae.png',
        mediaPreviewPath:
          'assets/images/explore/d8d1d509c67d429aab24f69d4b7219554c1c69b7.png',
        shortIntroduction:
          'Friendly local guide with experience leading city walks in Hanoi.',
      },
      {
        id: 'guide-linh-hana',
        name: 'Linh Hana',
        avatarPath:
          'assets/images/explore/fc207b73626f5125383e54e4f9bd8e50563101a4.jpg',
        location: 'Danang, Vietnam',
        city: 'Danang',
        country: 'Vietnam',
        languagesText: 'Vietnamese|English',
        rating: 5,
        reviewsCount: 127,
        bio: 'Local guide in Danang.',
        featured: true,
        headerImagePath:
          'assets/images/guide_page/a3d236cc36adec97a0448232035165d4adb9a4ae.png',
        mediaPreviewPath:
          'assets/images/explore/fc207b73626f5125383e54e4f9bd8e50563101a4.jpg',
        shortIntroduction:
          'Experienced guide focused on mountain and nature experiences.',
      },
      {
        id: 'guide-khai-ho',
        name: 'Khai Ho',
        avatarPath:
          'assets/images/explore/67f8ecec96e4799757e73bf4c011c059135b7527.jpg',
        location: 'Ho Chi Minh, Vietnam',
        city: 'Ho Chi Minh',
        country: 'Vietnam',
        languagesText: 'Vietnamese|English',
        rating: 5,
        reviewsCount: 127,
        bio: 'Local guide in Ho Chi Minh City.',
        featured: true,
        headerImagePath:
          'assets/images/guide_page/a3d236cc36adec97a0448232035165d4adb9a4ae.png',
        mediaPreviewPath:
          'assets/images/explore/67f8ecec96e4799757e73bf4c011c059135b7527.jpg',
        shortIntroduction:
          'Ho Chi Minh local guide with a focus on food and historical places.',
      },
    ],
  });

  await prisma.guideExperience.createMany({
    data: [
      {
        guideId: 'guide-tuan-tran',
        leftImagePath:
          'assets/images/guide_page/21c7c394eebe1f5ab9fb03014d50d398e03633a0.jpg',
        rightTopImagePath:
          'assets/images/guide_page/c7a25670e7ba19408b7e776b363d6705858a5598.jpg',
        rightBottomImagePath:
          'assets/images/guide_page/8e041ef05fef946a59bcf7b4931c2de56d77b715.jpg',
        title: '2 Hour Bicycle Tour exploring Hoian',
        location: 'Hoian, Vietnam',
        dateLabel: 'Jan 30, 2020',
        likesLabel: '1247 likes',
        sortOrder: 1,
      },
      {
        guideId: 'guide-tuan-tran',
        leftImagePath:
          'assets/images/guide_page/a01abee1a6fc8132b8dc0bc149ba93954fd78b33.jpg',
        rightTopImagePath:
          'assets/images/guide_page/3a15600dffa5a81824d2f9def8b87e1ba384e8e4.jpg',
        rightBottomImagePath:
          'assets/images/guide_page/90ae1c9a1f3e492bb8800b488b4397104799941f.jpg',
        title: 'Street food and city walk',
        location: 'Danang, Vietnam',
        dateLabel: 'Feb 2, 2020',
        likesLabel: '890 likes',
        sortOrder: 2,
      },
      {
        guideId: 'guide-emmy',
        leftImagePath:
          'assets/images/guide_page/21c7c394eebe1f5ab9fb03014d50d398e03633a0.jpg',
        rightTopImagePath:
          'assets/images/guide_page/c7a25670e7ba19408b7e776b363d6705858a5598.jpg',
        rightBottomImagePath:
          'assets/images/guide_page/8e041ef05fef946a59bcf7b4931c2de56d77b715.jpg',
        title: 'Old Quarter discovery',
        location: 'Hanoi, Vietnam',
        dateLabel: 'Feb 5, 2020',
        likesLabel: '760 likes',
        sortOrder: 1,
      },
      {
        guideId: 'guide-linh-hana',
        leftImagePath:
          'assets/images/guide_page/a01abee1a6fc8132b8dc0bc149ba93954fd78b33.jpg',
        rightTopImagePath:
          'assets/images/guide_page/3a15600dffa5a81824d2f9def8b87e1ba384e8e4.jpg',
        rightBottomImagePath:
          'assets/images/guide_page/90ae1c9a1f3e492bb8800b488b4397104799941f.jpg',
        title: 'Ba Na Hills full day',
        location: 'Danang, Vietnam',
        dateLabel: 'Mar 3, 2020',
        likesLabel: '930 likes',
        sortOrder: 1,
      },
      {
        guideId: 'guide-khai-ho',
        leftImagePath:
          'assets/images/guide_page/a01abee1a6fc8132b8dc0bc149ba93954fd78b33.jpg',
        rightTopImagePath:
          'assets/images/guide_page/3a15600dffa5a81824d2f9def8b87e1ba384e8e4.jpg',
        rightBottomImagePath:
          'assets/images/guide_page/90ae1c9a1f3e492bb8800b488b4397104799941f.jpg',
        title: 'History and food combo',
        location: 'Ho Chi Minh, Vietnam',
        dateLabel: 'Mar 14, 2020',
        likesLabel: '680 likes',
        sortOrder: 1,
      },
    ],
  });

  await prisma.guideReview.createMany({
    data: [
      {
        guideId: 'guide-tuan-tran',
        avatarPath:
          'assets/images/guide_page/1019aa9fca01d6bce807cf74fe90b3b71c995634.png',
        name: 'Jenny Wilson',
        dateLabel: 'Jan 30, 2020',
        review: 'Amazing guide and very friendly.',
        rating: 5,
      },
      {
        guideId: 'guide-tuan-tran',
        avatarPath:
          'assets/images/guide_page/959746cd629042b29a8f93f90bd29f83e5401423.png',
        name: 'Esther Howard',
        dateLabel: 'Feb 3, 2020',
        review: 'The trip was well organized and fun.',
        rating: 5,
      },
      {
        guideId: 'guide-emmy',
        avatarPath:
          'assets/images/guide_page/1019aa9fca01d6bce807cf74fe90b3b71c995634.png',
        name: 'Leslie Alexander',
        dateLabel: 'Feb 1, 2020',
        review: 'Helpful and punctual guide.',
        rating: 5,
      },
      {
        guideId: 'guide-linh-hana',
        avatarPath:
          'assets/images/guide_page/959746cd629042b29a8f93f90bd29f83e5401423.png',
        name: 'Courtney Henry',
        dateLabel: 'Feb 10, 2020',
        review: 'Clear communication and very professional.',
        rating: 5,
      },
      {
        guideId: 'guide-khai-ho',
        avatarPath:
          'assets/images/guide_page/c7b8b5b6cc0c7f882d307811b73f983fdd7235b8.png',
        name: 'Ralph Edwards',
        dateLabel: 'Feb 14, 2020',
        review: 'A nice balance of local culture and sightseeing.',
        rating: 5,
      },
    ],
  });

  await prisma.tour.createMany({
    data: [
      {
        id: 'tour-danang-bana-hoian',
        title: 'Da Nang - Ba Na - Hoi An',
        coverImagePath:
          'assets/images/explore/69c85a3ef2934da77239256b0a2f5429818850a5.jpg',
        dateLabel: 'Jan 30, 2020',
        durationLabel: '3 days',
        priceLabel: '$400.00',
        oldPriceLabel: '$450.00',
        likesLabel: '1247 likes',
        provider: 'dulichviet',
        itinerary: 'Da Nang - Ba Na - Hoi An',
        durationDetail: '2 days, 2 nights',
        departureDateLabel: 'Feb 12',
        departurePlace: 'Ho Chi Minh',
        city: 'Danang',
        country: 'Vietnam',
        featured: true,
        headerImagePath: 'assets/images/tour_detail/670301139 1.png',
        reviewsCount: 145,
      },
      {
        id: 'tour-melbourne-sydney',
        title: 'Melbourne - Sydney',
        coverImagePath:
          'assets/images/explore/e8bbf8e4a3407d7d2ac4e0c6107ed68738f49e92.png',
        dateLabel: 'Jan 30, 2020',
        durationLabel: '3 days',
        priceLabel: '$600.00',
        oldPriceLabel: '$680.00',
        likesLabel: '1247 likes',
        provider: 'southerntour',
        itinerary: 'Melbourne - Sydney',
        durationDetail: '4 days, 3 nights',
        departureDateLabel: 'Mar 05',
        departurePlace: 'Melbourne',
        city: 'Melbourne',
        country: 'Australia',
        featured: true,
        headerImagePath: 'assets/images/tour_detail/670301139 1.png',
        reviewsCount: 145,
        isLiked: true,
        isBookmarked: true,
      },
      {
        id: 'tour-hanoi-halong',
        title: 'Hanoi - Ha Long Bay',
        coverImagePath:
          'assets/images/explore/6236a6fc45bbe62cddf36784fcd2767ec32f1972.jpg',
        dateLabel: 'Jan 30, 2020',
        durationLabel: '3 days',
        priceLabel: '$300.00',
        oldPriceLabel: '$350.00',
        likesLabel: '1247 likes',
        provider: 'vietravel',
        itinerary: 'Hanoi - Ha Long Bay',
        durationDetail: '2 days, 1 night',
        departureDateLabel: 'Apr 20',
        departurePlace: 'Hanoi',
        city: 'Hanoi',
        country: 'Vietnam',
        featured: true,
        headerImagePath: 'assets/images/tour_detail/670301139 1.png',
        reviewsCount: 145,
      },
    ],
  });

  const tours = [
    {
      tourId: 'tour-danang-bana-hoian',
      days: [
        {
          label: 'Day 1',
          entries: [
            {
              timeLabel: '08:00',
              description: 'Meet at departure point and transfer to Da Nang.',
            },
            {
              timeLabel: '12:00',
              description: 'Lunch and check-in.',
            },
          ],
        },
        {
          label: 'Day 2',
          entries: [
            {
              timeLabel: '09:00',
              description: 'Explore Ba Na Hills and Golden Bridge.',
            },
            {
              timeLabel: '15:00',
              description: 'Travel to Hoi An for evening walk.',
            },
          ],
        },
      ],
    },
    {
      tourId: 'tour-melbourne-sydney',
      days: [
        {
          label: 'Day 1',
          entries: [
            {
              timeLabel: '09:00',
              description: 'Arrive in Melbourne and city orientation.',
            },
          ],
        },
        {
          label: 'Day 2',
          entries: [
            {
              timeLabel: '10:00',
              description: 'Transfer to Sydney with afternoon free time.',
            },
          ],
        },
      ],
    },
    {
      tourId: 'tour-hanoi-halong',
      days: [
        {
          label: 'Day 1',
          entries: [
            {
              timeLabel: '08:30',
              description: 'Depart from Hanoi to Ha Long Bay.',
            },
          ],
        },
        {
          label: 'Day 2',
          entries: [
            {
              timeLabel: '11:00',
              description: 'Cruise activities and return to Hanoi.',
            },
          ],
        },
      ],
    },
  ];

  for (const tour of tours) {
    for (const [dayIndex, day] of tour.days.entries()) {
      const createdDay = await prisma.tourScheduleDay.create({
        data: {
          tourId: tour.tourId,
          label: day.label,
          sortOrder: dayIndex + 1,
        },
      });

      await prisma.tourScheduleEntry.createMany({
        data: day.entries.map((entry, entryIndex) => ({
          dayId: createdDay.id,
          timeLabel: entry.timeLabel,
          description: entry.description,
          sortOrder: entryIndex + 1,
        })),
      });
    }
  }

  await prisma.attraction.createMany({
    data: [
      {
        id: 'dragon-bridge',
        name: 'Dragon Bridge',
        city: 'Danang',
        isSuggested: true,
      },
      {
        id: 'cham-museum',
        name: 'Cham Museum',
        city: 'Danang',
        isSuggested: true,
      },
      {
        id: 'my-khe-beach',
        name: 'My Khe Beach',
        city: 'Danang',
        isSuggested: true,
      },
      {
        id: 'cong-coffee',
        name: 'Cong Coffee',
        city: 'Danang',
        imagePath:
          'assets/images/new_attractions/d0e12956c710254dcc64c0c50ab0ac6ed6d861b3.png',
        isSuggested: true,
      },
      {
        id: 'cong-hoa-market',
        name: 'Cong Hoa Market',
        city: 'Danang',
      },
      {
        id: 'cong-cho',
        name: 'Cong Cho',
        city: 'Danang',
      },
      {
        id: 'cong-church',
        name: 'Cong Church',
        city: 'Danang',
      },
    ],
  });

  const user = await prisma.user.findUniqueOrThrow({
    where: { email: 'a@gmail.com' },
  });

  const currentTrip = await prisma.trip.create({
    data: {
      userId: user.id,
      title: 'Dragon Bridge Trip',
      city: 'Da Nang',
      dateLabel: 'Jan 30, 2020',
      fromTimeLabel: '13:00',
      toTimeLabel: '15:00',
      travelerCount: 2,
      status: TripStatus.CURRENT,
      guideName: 'Tuan Tran',
      guideLanguagePreferencesText: '',
    },
  });

  await prisma.tripAttraction.create({
    data: {
      tripId: currentTrip.id,
      attractionId: 'dragon-bridge',
    },
  });

  await prisma.wishlist.createMany({
    data: [
      {
        userId: user.id,
        tourId: 'tour-melbourne-sydney',
      },
      {
        userId: user.id,
        tourId: 'tour-hanoi-halong',
      },
    ],
  });
}

main()
  .then(async () => {
    await prisma.$disconnect();
  })
  .catch(async (error) => {
    console.error(error);
    await prisma.$disconnect();
    process.exit(1);
  });
