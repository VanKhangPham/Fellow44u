import 'package:flutter/material.dart';

import '../search/search.dart';
import '../widgets/main_bottom_nav.dart';

class MyTripsCurrentScreen extends StatefulWidget {
  const MyTripsCurrentScreen({super.key});

  static const Color _primary = Color(0xFF00C7A7);
  static const Color _textPrimary = Color(0xFF212121);
  static const Color _textSecondary = Color(0xFF6F6F6F);
  static const Color _background = Color(0xFFFBFBFB);

  static const String _headerAsset =
      'assets/images/my_trips_current/2a4028cfda3cda6d2d71eef70a4cdc292c82b02c.png';
  static const String _tripAsset =
      'assets/images/my_trips_current/51414a035e8038967a7f919ee4da7a5fcf080c96.jpg';
  static const String _avatarAsset =
      'assets/images/my_trips_current/4293a86720d50b28e6ad1b224c2db9f92d54d9d5.jpg';
  static const String _calendarAsset =
      'assets/images/my_trips_current/Frame 26.png';
  static const String _clockAsset =
      'assets/images/my_trips_current/Frame 37.png';
  static const String _personAsset = 'assets/images/my_trips_current/Group.png';
  static const String _checkAsset =
      'assets/images/my_trips_current/Vector.png';

  static const String _nextHoGuomAsset =
      'assets/images/my_trips_next/960a939280f3f36fc0c105ffe4ad31d968ac6451.png';
  static const String _nextMausoleumAsset =
      'assets/images/my_trips_next/accb51ccbb0a22aae14c9e1af900ffe62bc5f983.png';
  static const String _nextChurchAsset =
      'assets/images/my_trips_next/a4ac4c80eecaa270b09aca98f13878ecf0eaca85.jpg';
  static const String _nextEmmyAsset =
      'assets/images/my_trips_next/d8d1d509c67d429aab24f69d4b7219554c1c69b7.png';
  static const String _nextKhaiHoAsset =
      'assets/images/my_trips_next/67f8ecec96e4799757e73bf4c011c059135b7527.jpg';
  static const String _nextExtraGuideAsset =
      'assets/images/my_trips_next/f70235434dd80443d892bdaed7f8c67bdf755753.jpg';
  static const String _pastTempleAsset =
      'assets/images/my_trips_past/0270b73aa10450750a134687fa6ecfa0700ef0ef.jpg';
  static const String _pastPalaceAsset =
      'assets/images/my_trips_past/b529f8c33726fe420d25c7305deae6b5c3852207.jpg';
  static const String _pastEmmyAsset =
      'assets/images/my_trips_past/d8d1d509c67d429aab24f69d4b7219554c1c69b7.png';
  static const String _pastKhaiHoAsset =
      'assets/images/my_trips_past/67f8ecec96e4799757e73bf4c011c059135b7527.jpg';

  @override
  State<MyTripsCurrentScreen> createState() => _MyTripsCurrentScreenState();
}

enum _MyTripsTab { current, next, past, wishList }

class _MyTripsCurrentScreenState extends State<MyTripsCurrentScreen> {
  late final List<_NextTripItem> _nextTrips = [
    const _NextTripItem(
      coverAsset: MyTripsCurrentScreen._nextHoGuomAsset,
      title: 'Ho Guom Trip',
      location: 'Hanoi, Vietnam',
      date: 'Feb 2, 2020',
      time: '8:00 - 10:00',
      guideLabel: 'Emmy',
      avatars: [MyTripsCurrentScreen._nextEmmyAsset],
      showChat: true,
      showPay: true,
    ),
    const _NextTripItem(
      coverAsset: MyTripsCurrentScreen._nextMausoleumAsset,
      title: 'Ho Chi Minh Mausoleum',
      location: 'Hanoi, Vietnam',
      date: 'Feb 2, 2020',
      time: '8:00 - 10:00',
      guideLabel: 'Emmy',
      statusLabel: 'Waiting',
      avatars: [MyTripsCurrentScreen._nextEmmyAsset],
    ),
    const _NextTripItem(
      coverAsset: MyTripsCurrentScreen._nextChurchAsset,
      title: 'Duc Ba Church',
      location: 'Ho Chi Minh, Vietnam',
      date: 'Feb 2, 2020',
      time: '8:00 - 10:00',
      guideLabel: 'Waiting for offers',
      statusLabel: 'Bidding',
      avatars: [
        MyTripsCurrentScreen._nextKhaiHoAsset,
        MyTripsCurrentScreen._nextExtraGuideAsset,
      ],
      extraCount: 3,
      showChat: true,
    ),
  ];
  late final List<_PastTripItem> _pastTrips = [
    const _PastTripItem(
      coverAsset: MyTripsCurrentScreen._pastTempleAsset,
      title: 'Quoc Tu Giam Temple',
      location: 'Hanoi, Vietnam',
      date: 'Feb 2, 2020',
      time: '8:00 - 10:00',
      guideLabel: 'Emmy',
      avatarAsset: MyTripsCurrentScreen._pastEmmyAsset,
    ),
    const _PastTripItem(
      coverAsset: MyTripsCurrentScreen._pastPalaceAsset,
      title: 'Dinh Doc Lap',
      location: 'Ho Chi Minh, Vietnam',
      date: 'Feb 2, 2020',
      time: '8:00 - 10:00',
      guideLabel: 'Khai Ho',
      avatarAsset: MyTripsCurrentScreen._pastKhaiHoAsset,
    ),
  ];

  _MyTripsTab _selectedTab = _MyTripsTab.current;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTripsCurrentScreen._background,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: MyTripsCurrentScreen._primary,
        elevation: 2,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, size: 38, color: Colors.white),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildHeader(context),
                  const SizedBox(height: 10),
                  _buildTabs(),
                  const SizedBox(height: 26),
                  _buildSelectedTabBody(),
                  const SizedBox(height: 110),
                ],
              ),
            ),
            MainBottomNav(
              currentIndex: 1,
              onExploreTap: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SizedBox(
      height: 140,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(MyTripsCurrentScreen._headerAsset, fit: BoxFit.cover),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(0, 0, 0, 0.08),
                  Color.fromRGBO(0, 0, 0, 0.16),
                ],
              ),
            ),
          ),
          Positioned(
            left: 18,
            bottom: 18,
            child: Text(
              'My Trips',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Positioned(
            right: 16,
            top: 18,
            child: GestureDetector(
              onTap: () => _openSearch(context),
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 255, 255, 0.18),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(Icons.search, color: Colors.white, size: 22),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _TripTabButton(
            label: 'Current Trips',
            selected: _selectedTab == _MyTripsTab.current,
            onTap: () => setState(() => _selectedTab = _MyTripsTab.current),
          ),
          const SizedBox(width: 12),
          _TripTabButton(
            label: 'Next Trips',
            selected: _selectedTab == _MyTripsTab.next,
            onTap: () => setState(() => _selectedTab = _MyTripsTab.next),
          ),
          const SizedBox(width: 12),
          _TripTabButton(
            label: 'Past Trips',
            selected: _selectedTab == _MyTripsTab.past,
            onTap: () => setState(() => _selectedTab = _MyTripsTab.past),
          ),
          const SizedBox(width: 12),
          _TripTabButton(
            label: 'Wish List',
            selected: _selectedTab == _MyTripsTab.wishList,
            onTap: () => setState(() => _selectedTab = _MyTripsTab.wishList),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedTabBody() {
    switch (_selectedTab) {
      case _MyTripsTab.current:
        return _buildCurrentTripCard();
      case _MyTripsTab.next:
        return _buildNextTripsList();
      case _MyTripsTab.past:
        return _buildPastTripsList();
      case _MyTripsTab.wishList:
        return _buildPlaceholder(
          title: 'No saved trips yet',
          subtitle: 'Trips you bookmark can live here later.',
        );
    }
  }

  Widget _buildCurrentTripCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.08),
              blurRadius: 18,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
              child: SizedBox(
                height: 136,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      MyTripsCurrentScreen._tripAsset,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      left: 16,
                      top: 18,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 9,
                        ),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(223, 236, 245, 0.65),
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(
                            color: const Color.fromRGBO(93, 93, 93, 0.45),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              MyTripsCurrentScreen._checkAsset,
                              width: 14,
                              height: 11,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Mark Finished',
                              style: TextStyle(
                                color: MyTripsCurrentScreen._textPrimary,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 14,
                      bottom: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(0, 0, 0, 0.36),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Da Nang, Vietnam',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Dragon Bridge Trip',
                          style: TextStyle(
                            color: MyTripsCurrentScreen._textPrimary,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const _InfoRow(
                          assetPath: MyTripsCurrentScreen._calendarAsset,
                          label: 'Jan 30, 2020',
                        ),
                        const SizedBox(height: 8),
                        const _InfoRow(
                          assetPath: MyTripsCurrentScreen._clockAsset,
                          label: '13:00 - 15:00',
                        ),
                        const SizedBox(height: 8),
                        const _InfoRow(
                          assetPath: MyTripsCurrentScreen._personAsset,
                          label: 'Tuan Tran',
                        ),
                        const SizedBox(height: 16),
                        OutlinedButton.icon(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            foregroundColor: MyTripsCurrentScreen._primary,
                            side: const BorderSide(
                              color: MyTripsCurrentScreen._primary,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 9,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          icon: const Icon(Icons.info_outline, size: 16),
                          label: const Text(
                            'Detail',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    margin: const EdgeInsets.only(top: 2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: MyTripsCurrentScreen._primary,
                        width: 4,
                      ),
                    ),
                    child: const CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          AssetImage(MyTripsCurrentScreen._avatarAsset),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNextTripsList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: List.generate(_nextTrips.length, (index) {
          final item = _nextTrips[index];
          return Padding(
            padding: EdgeInsets.only(
              bottom: index == _nextTrips.length - 1 ? 0 : 18,
            ),
            child: _buildNextTripCard(item),
          );
        }),
      ),
    );
  }

  Widget _buildPastTripsList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: List.generate(_pastTrips.length, (index) {
          final item = _pastTrips[index];
          return Padding(
            padding: EdgeInsets.only(
              bottom: index == _pastTrips.length - 1 ? 0 : 18,
            ),
            child: _buildPastTripCard(item),
          );
        }),
      ),
    );
  }

  Widget _buildNextTripCard(_NextTripItem item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.08),
            blurRadius: 18,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
            child: SizedBox(
              height: 136,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(item.coverAsset, fit: BoxFit.cover),
                  if (item.statusLabel != null)
                    Positioned(
                      left: 12,
                      top: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(157, 166, 177, 0.82),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          item.statusLabel!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(0, 0, 0, 0.35),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.more_horiz,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 14,
                    bottom: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(0, 0, 0, 0.36),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Colors.white,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            item.location,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(
                          color: MyTripsCurrentScreen._textPrimary,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _InfoRow(
                        assetPath: MyTripsCurrentScreen._calendarAsset,
                        label: item.date,
                      ),
                      const SizedBox(height: 8),
                      _InfoRow(
                        assetPath: MyTripsCurrentScreen._clockAsset,
                        label: item.time,
                      ),
                      const SizedBox(height: 8),
                      _InfoRow(
                        assetPath: MyTripsCurrentScreen._personAsset,
                        label: item.guideLabel,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                _AvatarCluster(
                  avatars: item.avatars,
                  extraCount: item.extraCount,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Wrap(
              spacing: 12,
              runSpacing: 10,
              children: [
                const _TripActionButton(
                  icon: Icons.info_outline,
                  label: 'Detail',
                ),
                if (item.showChat)
                  const _TripActionButton(
                    icon: Icons.chat_bubble_outline,
                    label: 'Chat',
                  ),
                if (item.showPay)
                  const _TripActionButton(
                    icon: Icons.payment_outlined,
                    label: 'Pay',
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPastTripCard(_PastTripItem item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.08),
            blurRadius: 18,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
            child: SizedBox(
              height: 136,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(item.coverAsset, fit: BoxFit.cover),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(0, 0, 0, 0.35),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.more_horiz,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 14,
                    bottom: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(0, 0, 0, 0.36),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Colors.white,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            item.location,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(
                          color: MyTripsCurrentScreen._textPrimary,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _InfoRow(
                        assetPath: MyTripsCurrentScreen._calendarAsset,
                        label: item.date,
                      ),
                      const SizedBox(height: 8),
                      _InfoRow(
                        assetPath: MyTripsCurrentScreen._clockAsset,
                        label: item.time,
                      ),
                      const SizedBox(height: 8),
                      _InfoRow(
                        assetPath: MyTripsCurrentScreen._personAsset,
                        label: item.guideLabel,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                _TripAvatar(assetPath: item.avatarAsset),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder({
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.06),
              blurRadius: 14,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            const Icon(
              Icons.explore_outlined,
              size: 42,
              color: MyTripsCurrentScreen._primary,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: MyTripsCurrentScreen._textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: MyTripsCurrentScreen._textSecondary,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openSearch(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const ExploreSearchModal(),
    );
  }
}

class _TripTabButton extends StatelessWidget {
  const _TripTabButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
        decoration: BoxDecoration(
          color:
              selected ? MyTripsCurrentScreen._primary : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: TextStyle(
            color:
                selected
                    ? Colors.white
                    : MyTripsCurrentScreen._textSecondary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.assetPath,
    required this.label,
  });

  final String assetPath;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          assetPath,
          width: 15,
          height: 15,
          color: const Color(0xFF8F8F8F),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            color: MyTripsCurrentScreen._textSecondary,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

class _TripActionButton extends StatelessWidget {
  const _TripActionButton({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        foregroundColor: MyTripsCurrentScreen._primary,
        side: const BorderSide(color: MyTripsCurrentScreen._primary),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      icon: Icon(icon, size: 16),
      label: Text(
        label,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class _AvatarCluster extends StatelessWidget {
  const _AvatarCluster({
    required this.avatars,
    this.extraCount,
  });

  final List<String> avatars;
  final int? extraCount;

  @override
  Widget build(BuildContext context) {
    if (avatars.length == 1 && extraCount == null) {
      return _TripAvatar(assetPath: avatars.first);
    }

    return SizedBox(
      width: 88,
      height: 64,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: _TripAvatar(assetPath: avatars.first),
          ),
          if (avatars.length > 1)
            Positioned(
              right: 0,
              top: 0,
              child: _TripAvatar(
                assetPath: avatars[1],
                darkOverlay: extraCount != null,
                overlayLabel: extraCount != null ? '+$extraCount' : null,
              ),
            ),
        ],
      ),
    );
  }
}

class _TripAvatar extends StatelessWidget {
  const _TripAvatar({
    required this.assetPath,
    this.darkOverlay = false,
    this.overlayLabel,
  });

  final String assetPath;
  final bool darkOverlay;
  final String? overlayLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: MyTripsCurrentScreen._primary, width: 4),
      ),
      child: SizedBox(
        width: 60,
        height: 60,
        child: ClipOval(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(assetPath, fit: BoxFit.cover),
              if (darkOverlay)
                Container(color: const Color.fromRGBO(0, 0, 0, 0.45)),
              if (overlayLabel != null)
                Center(
                  child: Text(
                    overlayLabel!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NextTripItem {
  const _NextTripItem({
    required this.coverAsset,
    required this.title,
    required this.location,
    required this.date,
    required this.time,
    required this.guideLabel,
    required this.avatars,
    this.statusLabel,
    this.extraCount,
    this.showChat = false,
    this.showPay = false,
  });

  final String coverAsset;
  final String title;
  final String location;
  final String date;
  final String time;
  final String guideLabel;
  final List<String> avatars;
  final String? statusLabel;
  final int? extraCount;
  final bool showChat;
  final bool showPay;
}

class _PastTripItem {
  const _PastTripItem({
    required this.coverAsset,
    required this.title,
    required this.location,
    required this.date,
    required this.time,
    required this.guideLabel,
    required this.avatarAsset,
  });

  final String coverAsset;
  final String title;
  final String location;
  final String date;
  final String time;
  final String guideLabel;
  final String avatarAsset;
}
