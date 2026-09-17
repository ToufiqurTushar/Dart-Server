import 'package:flutter/material.dart';
import 'package:my_app_client/my_app_client.dart';
import '../theme/blog_theme.dart';
import '../widgets/auth_dialog.dart';
import '../widgets/comment_section.dart';
import '../widgets/markdown_renderer.dart';

class ArticleDetailScreen extends StatefulWidget {
  final Article article;
  final List<Comment> comments;
  final UserSession? currentSession;
  final VoidCallback onBack;
  final Future<int> Function(int articleId) onLike;
  final Future<void> Function(String name, String email, String content) onSubmitComment;

  const ArticleDetailScreen({
    super.key,
    required this.article,
    required this.comments,
    required this.currentSession,
    required this.onBack,
    required this.onLike,
    required this.onSubmitComment,
  });

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  late int _likesCount;
  bool _hasLiked = false;

  @override
  void initState() {
    super.initState();
    _likesCount = widget.article.likesCount;
  }

  void _handleLike() async {
    if (_hasLiked) return;
    setState(() {
      _likesCount++;
      _hasLiked = true;
    });
    final newCount = await widget.onLike(widget.article.id!);
    setState(() {
      _likesCount = newCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    final a = widget.article;

    final coverUrl = a.coverImageUrl != null && a.coverImageUrl!.isNotEmpty
        ? a.coverImageUrl!
        : 'https://images.unsplash.com/photo-1499750310107-5fef28a66643?w=1200';

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Header Cover Container
            Stack(
              children: [
                Container(
                  height: 420,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(coverUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.4),
                          Colors.black.withOpacity(0.85),
                        ],
                      ),
                    ),
                  ),
                ),
                // Navigation back button
                Positioned(
                  top: 20,
                  left: 24,
                  child: FloatingActionButton.small(
                    onPressed: widget.onBack,
                    backgroundColor: Colors.white,
                    child: const Icon(Icons.arrow_back, color: Colors.black),
                  ),
                ),
                // Main Header Metadata
                Positioned(
                  bottom: 32,
                  left: 24,
                  right: 24,
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 900),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            if (a.category != null)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                                decoration: BoxDecoration(
                                  color: BlogTheme.primaryViolet,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  a.category!.name.toUpperCase(),
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                                ),
                              ),
                            if (a.articleTags != null && a.articleTags!.isNotEmpty) ...[
                              const SizedBox(width: 10),
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: a.articleTags!.map((at) {
                                      final tagName = at.tag?.name ?? 'Tag#${at.tagId}';
                                      return Padding(
                                        padding: const EdgeInsets.only(right: 6),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.2),
                                            borderRadius: BorderRadius.circular(16),
                                            border: Border.all(color: Colors.white30),
                                          ),
                                          child: Text(
                                            '#$tagName',
                                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 11),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          a.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                            height: 1.25,
                          ),
                        ),
                        if (a.summary != null && a.summary!.isNotEmpty) ...[
                          const SizedBox(height: 12),
                          Text(
                            a.summary!,
                            style: TextStyle(
                              color: Colors.grey[300],
                              fontSize: 16,
                              height: 1.4,
                            ),
                          ),
                        ],
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 18,
                              backgroundImage: NetworkImage(
                                a.authorAvatarUrl != null && a.authorAvatarUrl!.isNotEmpty
                                    ? a.authorAvatarUrl!
                                    : 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100',
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  a.authorName.isNotEmpty ? a.authorName : 'Editorial',
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                                ),
                                Text(
                                  'Published on ${a.createdAt.day}/${a.createdAt.month}/${a.createdAt.year} • ${a.readingTimeMinutes} min read',
                                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Main Article Body Content
            Container(
              constraints: const BoxConstraints(maxWidth: 850),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Article Content Body with Markdown Rendering
                  MarkdownRenderer(rawContent: a.content),
                  const SizedBox(height: 40),
                  const Divider(),
                  const SizedBox(height: 20),

                  // Like & Share Actions Bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ElevatedButton.icon(
                            onPressed: _handleLike,
                            icon: Icon(
                              _hasLiked ? Icons.favorite : Icons.favorite_border,
                              color: Colors.white,
                            ),
                            label: Text('$_likesCount Likes'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: BlogTheme.accentPink,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                          const SizedBox(width: 16),
                          OutlinedButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Article link copied to clipboard!')),
                              );
                            },
                            icon: const Icon(Icons.share_outlined),
                            label: const Text('Share'),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.remove_red_eye_outlined, color: Colors.grey, size: 18),
                          const SizedBox(width: 6),
                          Text('${a.viewsCount} Readers', style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 48),

                  // Comment Section
                  CommentSection(
                    articleId: a.id!,
                    comments: widget.comments,
                    currentSession: widget.currentSession,
                    onSubmitComment: widget.onSubmitComment,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
