import 'package:e_commarcae/core/theme/appColors/app_color_light.dart';
import 'package:e_commarcae/feature/user/model/userModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Persistent header that shows:
///  • User avatar (network image or fallback initials)
///  • Greeting  "Hi, {name}! 👋"
///  • Subtitle  "Good morning / afternoon / evening"
///  • Notification bell with badge
class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.userName,
    this.user,
    this.onNotificationTap,
    this.notificationCount = 0,
  });

  final String userName;
  final User? user;
  final VoidCallback? onNotificationTap;
  final int notificationCount;

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning ☀️';
    if (hour < 17) return 'Good Afternoon 🌤';
    return 'Good Evening 🌙';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          // ── Avatar ──────────────────────────────────────────────────
          _buildAvatar(isDark),
          const SizedBox(width: 14),

          // ── Greeting text ────────────────────────────────────────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _greeting(),
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Hi, $userName! 👋',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.onSurface,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // ── Notification bell ────────────────────────────────────────
          _buildNotificationBell(theme),
        ],
      ),
    );
  }

  Widget _buildAvatar(bool isDark) {
    final imageUrl = user?.image;
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [AppColorLight.primaryColor, Color(0xFF7B61FF)],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColorLight.primaryColor.withValues(alpha: 0.35),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: CircleAvatar(
        radius: 24,
        backgroundColor: Colors.transparent,
        backgroundImage:
            (imageUrl != null && imageUrl.isNotEmpty) ? NetworkImage(imageUrl) : null,
        child: (imageUrl == null || imageUrl.isEmpty)
            ? Text(
                _initials(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              )
            : null,
      ),
    );
  }

  Widget _buildNotificationBell(ThemeData theme) {
    return GestureDetector(
      onTap: onNotificationTap,
      child: Container(
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          color: theme.cardTheme.color ?? Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Icon(
              Icons.notifications_outlined,
              color: AppColorLight.primaryColor,
              size: 24,
            ),
            if (notificationCount > 0)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _initials() {
    if (userName.isEmpty) return '?';
    final parts = userName.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return userName[0].toUpperCase();
  }
}
