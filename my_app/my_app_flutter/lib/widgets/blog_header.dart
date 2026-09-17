import 'package:flutter/material.dart';
import '../theme/blog_theme.dart';
import 'auth_dialog.dart';

class BlogHeader extends StatelessWidget implements PreferredSizeWidget {
  final bool isAdminMode;
  final ValueChanged<bool> onModeChanged;
  final UserSession? currentSession;
  final Function(UserSession?) onSessionChanged;
  final VoidCallback onThemeToggle;
  final ValueChanged<String> onSearchChanged;

  const BlogHeader({
    super.key,
    required this.isAdminMode,
    required this.onModeChanged,
    required this.currentSession,
    required this.onSessionChanged,
    required this.onThemeToggle,
    required this.onSearchChanged,
  });

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: preferredSize.height,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: isDark ? BlogTheme.darkCardBg : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Logo & Title
          InkWell(
            onTap: () => onModeChanged(false),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [BlogTheme.primaryViolet, BlogTheme.secondaryCyan],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.bolt, color: Colors.white, size: 24),
                ),
                const SizedBox(width: 12),
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [BlogTheme.primaryViolet, BlogTheme.secondaryCyan],
                  ).createShader(bounds),
                  child: const Text(
                    'Apex Blog',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 24),

          // Search Field
          Expanded(
            child: Container(
              height: 42,
              constraints: const BoxConstraints(maxWidth: 450),
              decoration: BoxDecoration(
                color: isDark ? BlogTheme.darkBg : BlogTheme.lightBg,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isDark ? Colors.white10 : Colors.black12,
                ),
              ),
              child: TextField(
                onChanged: onSearchChanged,
                decoration: const InputDecoration(
                  hintText: 'Search articles, topics, authors...',
                  prefixIcon: Icon(Icons.search, size: 20, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),
          ),

          const SizedBox(width: 16),

          // Mode Switcher (Reader View / Admin Dashboard)
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: isDark ? BlogTheme.darkBg : BlogTheme.lightBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                _buildModeButton(
                  context,
                  title: 'Reader Feed',
                  icon: Icons.article_outlined,
                  isSelected: !isAdminMode,
                  onTap: () => onModeChanged(false),
                ),
                const SizedBox(width: 4),
                _buildModeButton(
                  context,
                  title: 'Admin Dashboard',
                  icon: Icons.dashboard_outlined,
                  isSelected: isAdminMode,
                  badge: currentSession?.isAdmin == true ? 'ADMIN' : null,
                  onTap: () {
                    if (currentSession?.isAdmin == true) {
                      onModeChanged(true);
                    } else {
                      AuthDialog.show(context, onAuthenticated: (session) {
                        onSessionChanged(session);
                        if (session.isAdmin) {
                          onModeChanged(true);
                        }
                      });
                    }
                  },
                ),
              ],
            ),
          ),

          const SizedBox(width: 16),

          // Theme Toggle
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode_outlined),
            onPressed: onThemeToggle,
            tooltip: 'Toggle Theme',
          ),

          const SizedBox(width: 12),

          // Auth / Profile Button
          if (currentSession == null)
            ElevatedButton.icon(
              onPressed: () => AuthDialog.show(context, onAuthenticated: onSessionChanged),
              icon: const Icon(Icons.login, size: 18),
              label: const Text('Sign In'),
              style: ElevatedButton.styleFrom(
                backgroundColor: BlogTheme.primaryViolet,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            )
          else
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'logout') {
                  onSessionChanged(null);
                  onModeChanged(false);
                } else if (value == 'admin') {
                  onModeChanged(true);
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  enabled: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(currentSession!.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(currentSession!.email, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: currentSession!.isAdmin ? BlogTheme.accentPink : BlogTheme.secondaryCyan,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          currentSession!.isAdmin ? 'ADMINISTRATOR' : 'READER USER',
                          style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                const PopupMenuDivider(),
                if (currentSession!.isAdmin)
                  const PopupMenuItem(
                    value: 'admin',
                    child: Row(
                      children: [
                        Icon(Icons.dashboard, size: 18),
                        SizedBox(width: 8),
                        Text('Admin Panel'),
                      ],
                    ),
                  ),
                const PopupMenuItem(
                  value: 'logout',
                  child: Row(
                    children: [
                      Icon(Icons.logout, size: 18, color: Colors.red),
                      SizedBox(width: 8),
                      Text('Sign Out', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ],
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundImage: NetworkImage(currentSession!.avatarUrl),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    currentSession!.name,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildModeButton(
    BuildContext context, {
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
    String? badge,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? BlogTheme.primaryViolet : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: isSelected ? Colors.white : Colors.grey),
            const SizedBox(width: 6),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[700],
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 13,
              ),
            ),
            if (badge != null) ...[
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                decoration: BoxDecoration(
                  color: BlogTheme.accentPink,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  badge,
                  style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w900),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
