import 'package:flutter/material.dart';
import 'package:my_app_client/my_app_client.dart';
import '../theme/blog_theme.dart';

class ArticleCard extends StatefulWidget {
  final Article article;
  final VoidCallback onTap;
  final VoidCallback? onLike;

  const ArticleCard({
    super.key,
    required this.article,
    required this.onTap,
    this.onLike,
  });

  @override
  State<ArticleCard> createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final a = widget.article;

    final coverUrl = a.coverImageUrl != null && a.coverImageUrl!.isNotEmpty
        ? a.coverImageUrl!
        : 'https://images.unsplash.com/photo-1499750310107-5fef28a66643?w=800';

    return RepaintBoundary(
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: _isHovered ? (Matrix4.identity()..scale(1.02, 1.02)) : Matrix4.identity(),
          child: Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: _isHovered ? 8 : 2,
            color: isDark ? BlogTheme.darkCardBg : Colors.white,
            child: InkWell(
              onTap: widget.onTap,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cover Image with overlays
                  Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Image.network(
                          coverUrl,
                          cacheWidth: 600,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [BlogTheme.primaryViolet, BlogTheme.secondaryCyan],
                            ),
                          ),
                          child: const Center(
                            child: Icon(Icons.article, size: 48, color: Colors.white54),
                          ),
                        ),
                      ),
                    ),
                    // Gradient overlay
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.6),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Category badge top left
                    if (a.category != null)
                      Positioned(
                        top: 12,
                        left: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: BlogTheme.primaryViolet,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            a.category!.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    // Read time badge top right
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.65),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.timer_outlined, size: 12, color: Colors.white),
                            const SizedBox(width: 4),
                            Text(
                              '${a.readingTimeMinutes} min',
                              style: const TextStyle(color: Colors.white, fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Featured ribbon
                    if (a.isFeatured)
                      Positioned(
                        bottom: 12,
                        left: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: BlogTheme.goldYellow,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.star, size: 12, color: Colors.black87),
                              SizedBox(width: 4),
                              Text(
                                'FEATURED',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),

                // Post Content Info
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        a.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        a.summary ?? a.content,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: isDark ? Colors.grey[400] : Colors.grey[700],
                          fontSize: 13,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Divider(height: 1),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 14,
                            backgroundImage: NetworkImage(
                              a.authorAvatarUrl != null && a.authorAvatarUrl!.isNotEmpty
                                  ? a.authorAvatarUrl!
                                  : 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100',
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              a.authorName.isNotEmpty ? a.authorName : 'Editorial',
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          // View count
                          Row(
                            children: [
                              const Icon(Icons.remove_red_eye_outlined, size: 14, color: Colors.grey),
                              const SizedBox(width: 3),
                              Text('${a.viewsCount}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                            ],
                          ),
                          const SizedBox(width: 12),
                          // Like count
                          InkWell(
                            onTap: widget.onLike,
                            borderRadius: BorderRadius.circular(12),
                            child: Row(
                              children: [
                                const Icon(Icons.favorite, size: 14, color: BlogTheme.accentPink),
                                const SizedBox(width: 3),
                                Text('${a.likesCount}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: BlogTheme.accentPink)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ),
          ),
        ),
      ),
    );
  }
}
