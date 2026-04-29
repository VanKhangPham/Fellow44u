import 'package:flutter/material.dart';

class MainBottomNav extends StatelessWidget {
  const MainBottomNav({
    super.key,
    required this.currentIndex,
    this.onExploreTap,
    this.onTripsTap,
    this.onMessagesTap,
    this.onNotificationsTap,
    this.onProfileTap,
  });

  final int currentIndex;
  final VoidCallback? onExploreTap;
  final VoidCallback? onTripsTap;
  final VoidCallback? onMessagesTap;
  final VoidCallback? onNotificationsTap;
  final VoidCallback? onProfileTap;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;
    return Container(
      padding: EdgeInsets.fromLTRB(6, 8, 6, bottomInset > 0 ? bottomInset : 8),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.08),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _BottomNavItem(
            icon: Icons.explore_outlined,
            label: 'Explore',
            selected: currentIndex == 0,
            onTap: onExploreTap,
          ),
          _BottomNavItem(
            icon: Icons.location_on_outlined,
            label: 'My Trips',
            selected: currentIndex == 1,
            onTap: onTripsTap,
          ),
          _BottomNavItem(
            icon: Icons.chat_bubble_outline,
            label: 'Messages',
            selected: currentIndex == 2,
            onTap: onMessagesTap,
          ),
          _BottomNavItem(
            icon: Icons.notifications_none,
            label: 'Alerts',
            selected: currentIndex == 3,
            onTap: onNotificationsTap,
          ),
          _BottomNavItem(
            icon: Icons.person_outline,
            label: 'Profile',
            selected: currentIndex == 4,
            onTap: onProfileTap,
          ),
        ],
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem({
    required this.icon,
    required this.label,
    required this.selected,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? const Color(0xFF00C7A7) : const Color(0xFF9E9E9E);
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 24, color: color),
            if (selected)
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
      ),
    );
  }
}
