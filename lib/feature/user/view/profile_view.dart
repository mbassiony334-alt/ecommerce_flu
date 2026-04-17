import 'package:e_commarcae/core/services/cache/cache_helper.dart';
import 'package:e_commarcae/core/theme/appColors/app_color_light.dart';
import 'package:e_commarcae/feature/user/model/userModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';










class ProfileView extends StatelessWidget {
  const ProfileView({super.key, this.user, this.isEmbedded = false});

  final User? user;
  final bool isEmbedded;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    
    final name = user?.name ?? (CacheHelper.getData(key: 'userName') as String?) ?? 'User';
    final email = user?.email ?? '';
    final phone = user?.phone ?? '';
    final role = user?.role ?? 'Customer';
    final image = user?.image ?? '';

    final content = CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          
          SliverAppBar(
            expandedHeight: 260,
            pinned: true,
            backgroundColor: theme.scaffoldBackgroundColor,
            elevation: 0,
            automaticallyImplyLeading: false,
            leading: isEmbedded
                ? const SizedBox.shrink()
                : IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xFF2A2A2A)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 18,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
            actions: [
              
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: IconButton(
                  icon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF2A2A2A)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.edit_outlined,
                      size: 18,
                      color: AppColorLight.primaryColor,
                    ),
                  ),
                  onPressed: () => _showEditDialog(context, name, email, phone),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: _buildProfileHero(isDark, name, email, role, image),
            ),
          ),

          
          SliverToBoxAdapter(
            child: _buildStatsRow(context, isDark),
          ),

          
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
              child: Text(
                'Personal Information',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),

          SliverList(
            delegate: SliverChildListDelegate([
              _InfoTile(
                icon: Icons.person_outline_rounded,
                label: 'Full Name',
                value: name.isEmpty ? '—' : name,
              ),
              _InfoTile(
                icon: Icons.email_outlined,
                label: 'Email',
                value: email.isEmpty ? '—' : email,
              ),
              _InfoTile(
                icon: Icons.phone_outlined,
                label: 'Phone',
                value: phone.isEmpty ? '—' : phone,
              ),
              _InfoTile(
                icon: Icons.cake_outlined,
                label: 'Date of Birth',
                value: '—', 
              ),
              _InfoTile(
                icon: Icons.shield_outlined,
                label: 'Role',
                value: role.isEmpty ? 'Customer' : role,
              ),
            ]),
          ),

          
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
              child: Column(
                children: [
                  
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: () =>
                          _showEditDialog(context, name, email, phone),
                      icon: const SizedBox.shrink(),
                      label: Ink(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              AppColorLight.primaryColor,
                              Color(0xFF6B9FF8),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.edit_rounded,
                                  color: Colors.white, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                'Edit Profile',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),

                  
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                            color: Colors.redAccent, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      icon: const Icon(Icons.logout_rounded,
                          color: Colors.redAccent),
                      label: Text(
                        'Logout',
                        style: GoogleFonts.poppins(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      onPressed: () => _confirmLogout(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      );
    if (isEmbedded) {
      return content;
    }
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: content,
    );
  }

  
  Widget _buildProfileHero(
    bool isDark,
    String name,
    String email,
    String role,
    String image,
  ) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [const Color(0xFF121212), const Color(0xFF1E1E2E)]
              : [const Color(0xFFF0F4FF), const Color(0xFFFFFFFF)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 60),
          
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [AppColorLight.primaryColor, Color(0xFF7B61FF)],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColorLight.primaryColor.withValues(alpha: 0.4),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 50,
              backgroundColor:
                  isDark ? const Color(0xFF1E1E1E) : Colors.white,
              backgroundImage:
                  image.isNotEmpty ? NetworkImage(image) : null,
              child: image.isEmpty
                  ? Text(
                      _initials(name),
                      style: const TextStyle(
                        color: AppColorLight.primaryColor,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : null,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            name.isEmpty ? 'User' : name,
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: isDark ? Colors.white : const Color(0xFF001640),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            email,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: isDark
                  ? Colors.white60
                  : const Color(0xFF51526C),
            ),
          ),
          const SizedBox(height: 6),
          
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
            decoration: BoxDecoration(
              color: AppColorLight.primaryColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              role.toUpperCase(),
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppColorLight.primaryColor,
                letterSpacing: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  
  Widget _buildStatsRow(BuildContext context, bool isDark) {
    final items = [
      {'label': 'Orders', 'value': '12', 'icon': Icons.shopping_bag_outlined},
      {'label': 'Favourites', 'value': '8', 'icon': Icons.favorite_outline},
      {'label': 'Reviews', 'value': '3', 'icon': Icons.star_outline_rounded},
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: items.map((item) {
          return Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 6),
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF1E1E1E)
                    : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.07),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(
                    item['icon'] as IconData,
                    color: AppColorLight.primaryColor,
                    size: 22,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item['value'] as String,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    item['label'] as String,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.55),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  
  String _initials(String name) {
    if (name.isEmpty) return '?';
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name[0].toUpperCase();
  }

  void _showEditDialog(
      BuildContext context, String name, String email, String phone) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _EditProfileSheet(
        initialName: name,
        initialEmail: email,
        initialPhone: phone,
      ),
    );
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text('Logout'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
            ),
            onPressed: () {
              CacheHelper.clear();
              Navigator.pop(context);
              
              Navigator.of(context)
                  .popUntil((route) => route.isFirst);
            },
            child: const Text('Logout',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}


class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.06),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AppColorLight.primaryColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColorLight.primaryColor, size: 20),
            ),
            const SizedBox(width: 14),
            
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded,
                color: AppColorLight.primaryColor, size: 20),
          ],
        ),
      ),
    );
  }
}


class _EditProfileSheet extends StatefulWidget {
  const _EditProfileSheet({
    required this.initialName,
    required this.initialEmail,
    required this.initialPhone,
  });

  final String initialName;
  final String initialEmail;
  final String initialPhone;

  @override
  State<_EditProfileSheet> createState() => _EditProfileSheetState();
}

class _EditProfileSheetState extends State<_EditProfileSheet> {
  late TextEditingController _nameCtrl;
  late TextEditingController _emailCtrl;
  late TextEditingController _phoneCtrl;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.initialName);
    _emailCtrl = TextEditingController(text: widget.initialEmail);
    _phoneCtrl = TextEditingController(text: widget.initialPhone);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Edit Profile',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 20),
            _buildField(Icons.person_outline_rounded, 'Full Name', _nameCtrl),
            const SizedBox(height: 14),
            _buildField(Icons.email_outlined, 'Email', _emailCtrl),
            const SizedBox(height: 14),
            _buildField(Icons.phone_outlined, 'Phone', _phoneCtrl),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColorLight.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  
                  CacheHelper.saveData(
                    key: 'userName',
                    value: _nameCtrl.text.trim(),
                  );
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Profile updated successfully'),
                      backgroundColor: AppColorLight.primaryColor,
                    ),
                  );
                },
                child: Text(
                  'Save Changes',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildField(
    IconData icon,
    String hint,
    TextEditingController ctrl,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF5F7FA),
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextField(
        controller: ctrl,
        style: GoogleFonts.poppins(fontSize: 14),
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon, color: AppColorLight.primaryColor),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }
}
