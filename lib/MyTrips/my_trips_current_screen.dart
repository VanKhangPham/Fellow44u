import 'package:flutter/material.dart';

import '../Trip/create_new_trip_screen.dart';
import '../data/mock/mock_my_trips_data.dart';
import '../models/my_current_trip_model.dart';
import '../models/my_next_trip_model.dart';
import '../models/my_past_trip_model.dart';
import '../models/my_trips_data.dart';
import '../models/wishlist_trip_model.dart';
import '../repositories/mock_my_trips_repository.dart';
import '../repositories/my_trips_repository.dart';
import '../search/search.dart';
import '../widgets/main_bottom_nav.dart';

class MyTripsCurrentScreen extends StatefulWidget {
  const MyTripsCurrentScreen({
    super.key,
    this.repository = const MockMyTripsRepository(),
  });

  static const Color primary = Color(0xFF00C7A7);
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF6F6F6F);
  static const Color background = Color(0xFFFBFBFB);

  final MyTripsRepository repository;

  @override
  State<MyTripsCurrentScreen> createState() => _MyTripsCurrentScreenState();
}

enum _MyTripsTab { current, next, past, wishList }

class _MyTripsCurrentScreenState extends State<MyTripsCurrentScreen> {
  _MyTripsTab _selectedTab = _MyTripsTab.current;
  late Future<MyTripsData> _tripsFuture;
  final Set<String> _likedWishlistIds = <String>{};
  final Set<String> _bookmarkedWishlistIds = <String>{};
  final Set<String> _needAnotherGuideIds = <String>{};

  @override
  void initState() {
    super.initState();
    _tripsFuture = widget.repository.fetchMyTrips();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTripsCurrentScreen.background,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 220),
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const CreateNewTripScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    final curved = CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOut,
                    );
                    return FadeTransition(opacity: curved, child: child);
                  },
            ),
          );
        },
        backgroundColor: MyTripsCurrentScreen.primary,
        elevation: 2,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, size: 38, color: Colors.white),
      ),
      body: SafeArea(
        bottom: false,
        child: FutureBuilder<MyTripsData>(
          future: _tripsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                child: CircularProgressIndicator(
                  color: MyTripsCurrentScreen.primary,
                ),
              );
            }

            final data = snapshot.data;
            if (data == null) {
              return const Center(
                child: Text(
                  'Trips unavailable',
                  style: TextStyle(color: MyTripsCurrentScreen.textPrimary),
                ),
              );
            }

            return Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      _buildHeader(context),
                      const SizedBox(height: 10),
                      _buildTabs(),
                      const SizedBox(height: 26),
                      _buildSelectedTabBody(data),
                      const SizedBox(height: 110),
                    ],
                  ),
                ),
                MainBottomNav(
                  currentIndex: 1,
                  onExploreTap: () => Navigator.of(context).pop(),
                ),
              ],
            );
          },
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
          Image.asset(myTripsCurrentHeaderAsset, fit: BoxFit.cover),
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
          const Positioned(
            left: 18,
            bottom: 18,
            child: Text(
              'My Trips',
              style: TextStyle(
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

  void _openSearch(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const ExploreSearchModal(),
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

  Widget _buildSelectedTabBody(MyTripsData data) {
    switch (_selectedTab) {
      case _MyTripsTab.current:
        return _buildCurrentTripCard(data.currentTrip);
      case _MyTripsTab.next:
        return _buildNextTripsList(data.nextTrips);
      case _MyTripsTab.past:
        return _buildPastTripsList(data.pastTrips);
      case _MyTripsTab.wishList:
        return _buildWishList(data.wishlistTrips);
    }
  }

  Widget _buildCurrentTripCard(MyCurrentTripModel trip) {
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
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(14),
              ),
              child: SizedBox(
                height: 136,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(trip.coverAsset, fit: BoxFit.cover),
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
                              myTripsCurrentCheckAsset,
                              width: 14,
                              height: 11,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Mark Finished',
                              style: TextStyle(
                                color: MyTripsCurrentScreen.textPrimary,
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
                              trip.location,
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
                          trip.title,
                          style: const TextStyle(
                            color: MyTripsCurrentScreen.textPrimary,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _InfoRow(
                          assetPath: myTripsCurrentCalendarAsset,
                          label: trip.dateLabel,
                        ),
                        const SizedBox(height: 8),
                        _InfoRow(
                          assetPath: myTripsCurrentClockAsset,
                          label: trip.timeLabel,
                        ),
                        const SizedBox(height: 8),
                        _InfoRow(
                          assetPath: myTripsCurrentPersonAsset,
                          label: trip.guideName,
                        ),
                        const SizedBox(height: 16),
                        OutlinedButton.icon(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            foregroundColor: MyTripsCurrentScreen.primary,
                            side: const BorderSide(
                              color: MyTripsCurrentScreen.primary,
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
                        color: MyTripsCurrentScreen.primary,
                        width: 4,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(trip.guideAvatarAsset),
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

  Widget _buildNextTripsList(List<MyNextTripModel> trips) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: trips
            .map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 18),
                child: _buildNextTripCard(item),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildNextTripCard(MyNextTripModel item) {
    final needsAnotherGuide = _needAnotherGuideIds.contains(item.id);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.08),
            blurRadius: 16,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
            child: Stack(
              children: [
                Image.asset(
                  item.coverAsset,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 150,
                ),
                if (item.statusLabel != null && !needsAnotherGuide)
                  Positioned(
                    left: 16,
                    top: 14,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(255, 255, 255, 0.85),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(
                        item.statusLabel!,
                        style: const TextStyle(
                          color: MyTripsCurrentScreen.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: MyTripsCurrentScreen.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item.location,
                  style: const TextStyle(
                    color: MyTripsCurrentScreen.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                _InfoRow(
                  assetPath: myTripsCurrentCalendarAsset,
                  label: item.dateLabel,
                ),
                const SizedBox(height: 8),
                _InfoRow(
                  assetPath: myTripsCurrentClockAsset,
                  label: item.timeLabel,
                ),
                const SizedBox(height: 8),
                _InfoRow(
                  assetPath: myTripsCurrentPersonAsset,
                  label: needsAnotherGuide
                      ? 'Choose another guide'
                      : item.guideLabel,
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    _AvatarCluster(
                      avatars: item.avatars,
                      extraCount: item.extraCount,
                      needsAnotherGuide: needsAnotherGuide,
                    ),
                    const Spacer(),
                    if (item.canChooseAnotherGuide)
                      TextButton(
                        onPressed: () {
                          setState(() {
                            if (needsAnotherGuide) {
                              _needAnotherGuideIds.remove(item.id);
                            } else {
                              _needAnotherGuideIds.add(item.id);
                            }
                          });
                        },
                        child: const Text('Choose another guide'),
                      ),
                  ],
                ),
                Row(
                  children: [
                    if (item.showChat)
                      _TripActionButton(
                        label: 'Chat',
                        outlined: true,
                        onPressed: () {},
                      ),
                    if (item.showChat) const SizedBox(width: 10),
                    if (item.showPay)
                      _TripActionButton(label: 'Pay', onPressed: () {}),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPastTripsList(List<MyPastTripModel> trips) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: trips
            .map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 18),
                child: _buildPastTripCard(item),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildPastTripCard(MyPastTripModel item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.08),
            blurRadius: 16,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
            child: Image.asset(
              item.coverAsset,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 150,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
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
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: MyTripsCurrentScreen.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item.location,
                        style: const TextStyle(
                          color: MyTripsCurrentScreen.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _InfoRow(
                        assetPath: myTripsCurrentCalendarAsset,
                        label: item.dateLabel,
                      ),
                      const SizedBox(height: 8),
                      _InfoRow(
                        assetPath: myTripsCurrentClockAsset,
                        label: item.timeLabel,
                      ),
                      const SizedBox(height: 8),
                      _InfoRow(
                        assetPath: myTripsCurrentPersonAsset,
                        label: item.guideLabel,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(item.avatarAsset),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWishList(List<WishlistTripModel> items) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: items
            .map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 18),
                child: _buildWishlistCard(item),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildWishlistCard(WishlistTripModel item) {
    final isLiked = _likedWishlistIds.contains(item.id) || item.isLiked;
    final isBookmarked =
        _bookmarkedWishlistIds.contains(item.id) || item.isBookmarked;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.08),
            blurRadius: 16,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
            child: Stack(
              children: [
                Image.asset(
                  item.coverAsset,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 150,
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isBookmarked) {
                          _bookmarkedWishlistIds.remove(item.id);
                        } else {
                          _bookmarkedWishlistIds.add(item.id);
                        }
                      });
                    },
                    child: Icon(
                      isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  left: 12,
                  bottom: 12,
                  child: Text(
                    item.likesLabel,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.title,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: MyTripsCurrentScreen.textPrimary,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isLiked) {
                            _likedWishlistIds.remove(item.id);
                          } else {
                            _likedWishlistIds.add(item.id);
                          }
                        });
                      },
                      child: Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color: MyTripsCurrentScreen.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _InfoRow(
                  assetPath: myTripsCurrentCalendarAsset,
                  label: item.dateLabel,
                ),
                const SizedBox(height: 8),
                _InfoRow(
                  assetPath: myTripsCurrentClockAsset,
                  label: item.daysLabel,
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    item.priceLabel,
                    style: const TextStyle(
                      color: MyTripsCurrentScreen.primary,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? MyTripsCurrentScreen.primary : Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: selected
                ? MyTripsCurrentScreen.primary
                : const Color(0xFFE2E2E2),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : MyTripsCurrentScreen.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.assetPath, required this.label});

  final String assetPath;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(assetPath, width: 16, height: 16),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(color: MyTripsCurrentScreen.textSecondary),
        ),
      ],
    );
  }
}

class _TripActionButton extends StatelessWidget {
  const _TripActionButton({
    required this.label,
    required this.onPressed,
    this.outlined = false,
  });

  final String label;
  final VoidCallback onPressed;
  final bool outlined;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: outlined
              ? Colors.white
              : MyTripsCurrentScreen.primary,
          foregroundColor: outlined
              ? MyTripsCurrentScreen.primary
              : Colors.white,
          side: outlined
              ? const BorderSide(color: MyTripsCurrentScreen.primary)
              : BorderSide.none,
        ),
        child: Text(label),
      ),
    );
  }
}

class _AvatarCluster extends StatelessWidget {
  const _AvatarCluster({
    required this.avatars,
    this.extraCount,
    this.needsAnotherGuide = false,
  });

  final List<String> avatars;
  final int? extraCount;
  final bool needsAnotherGuide;

  @override
  Widget build(BuildContext context) {
    if (needsAnotherGuide) {
      return Container(
        width: 68,
        height: 68,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: MyTripsCurrentScreen.primary, width: 4),
        ),
        child: const Center(
          child: Icon(
            Icons.person,
            color: MyTripsCurrentScreen.primary,
            size: 34,
          ),
        ),
      );
    }

    return SizedBox(
      width: 82,
      height: 68,
      child: Stack(
        children: [
          _TripAvatar(assetPath: avatars.first),
          if (avatars.length > 1)
            Positioned(
              right: 0,
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
      width: 68,
      height: 68,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: MyTripsCurrentScreen.primary, width: 4),
      ),
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
    );
  }
}
