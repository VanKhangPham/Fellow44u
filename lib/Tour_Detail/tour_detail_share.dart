import 'package:flutter/material.dart';

class ShareBottomSheet extends StatelessWidget {
  const ShareBottomSheet({super.key});

  static const Color _primary = Color(0xFF00C7A7);

  // Các đường dẫn hình ảnh
  static const String _facebookIcon = 'assets/images/tour_share/Group 9.png';
  static const String _googleIcon = 'assets/images/tour_share/Group 171.png';
  static const String _kakaoIcon = 'assets/images/tour_share/Group 8.png';
  static const String _whatsappIcon = 'assets/images/tour_share/Group 172.png';
  static const String _twitterIcon = 'assets/images/tour_share/Mask Group.png';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Thanh trượt ở trên
          Container(
            margin: const EdgeInsets.only(top: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFFE0E0E0),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          // Tiêu đề
          const Text(
            'Share on',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF212121),
            ),
          ),
          const SizedBox(height: 28),
          // Các nút mạng xã hội
          SizedBox(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ShareButton(
                  icon: _facebookIcon,
                  label: 'Facebook',
                  onTap: () => _handleShare(context, 'Facebook'),
                ),
                _ShareButton(
                  icon: _googleIcon,
                  label: 'Google',
                  onTap: () => _handleShare(context, 'Google'),
                ),
                _ShareButton(
                  icon: _kakaoIcon,
                  label: 'Kakao Talk',
                  onTap: () => _handleShare(context, 'Kakao Talk'),
                ),
                _ShareButton(
                  icon: _whatsappIcon,
                  label: 'Whatsapp',
                  onTap: () => _handleShare(context, 'Whatsapp'),
                ),
                _ShareButton(
                  icon: _twitterIcon,
                  label: 'Twitter',
                  onTap: () => _handleShare(context, 'Twitter'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Nút Cancel
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  void _handleShare(BuildContext context, String platform) {
    // TODO: Thêm logic chia sẻ thực tế ở đây
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Chia sẻ qua $platform')),
    );
    Navigator.pop(context);
  }
}

class _ShareButton extends StatelessWidget {
  final String icon;
  final String label;
  final VoidCallback onTap;

  const _ShareButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                icon,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xFFF0F0F0),
                    child: const Icon(Icons.image_not_supported),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF757575),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}