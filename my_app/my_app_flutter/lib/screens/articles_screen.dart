import 'package:flutter/material.dart';
import 'package:my_app_client/my_app_client.dart';
import '../theme/blog_theme.dart';
import '../widgets/article_card.dart';

class ArticlesFeedScreen extends StatefulWidget {
  final List<Article> articles;
  final List<Category> categories;
  final int? initialCategoryId;
  final String searchQuery;
  final Function(Article article) onSelectArticle;
  final Function(int articleId) onLikeArticle;

  const ArticlesFeedScreen({
    super.key,
    required this.articles,
    required this.categories,
    this.initialCategoryId,
    required this.searchQuery,
    required this.onSelectArticle,
    required this.onLikeArticle,
  });

  @override
  State<ArticlesFeedScreen> createState() => _ArticlesFeedScreenState();
}

class _ArticlesFeedScreenState extends State<ArticlesFeedScreen> {
  int? _selectedCategoryId;

  @override
  void initState() {
    super.initState();
    _selectedCategoryId = widget.initialCategoryId;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Filter articles by category & search query
    final filteredArticles = widget.articles.where((a) {
      final matchesCategory = _selectedCategoryId == null || a.categoryId == _selectedCategoryId;
      final query = widget.searchQuery.trim().toLowerCase();
      final matchesQuery = query.isEmpty ||
          a.title.toLowerCase().contains(query) ||
          (a.summary != null && a.summary!.toLowerCase().contains(query)) ||
          a.content.toLowerCase().contains(query);
      return matchesCategory && matchesQuery && a.status == 'published';
    }).toList();

    // Featured articles for Hero Banner
    final featuredList = widget.articles.where((a) => a.isFeatured && a.status == 'published').toList();
    final heroArticle = featuredList.isNotEmpty ? featuredList.first : (widget.articles.isNotEmpty ? widget.articles.first : null);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Featured Hero Banner Card
          if (heroArticle != null && widget.searchQuery.isEmpty && _selectedCategoryId == null) ...[
            InkWell(
              onTap: () => widget.onSelectArticle(heroArticle),
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 360,
                width: double.infinity,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(
                      heroArticle.coverImageUrl != null && heroArticle.coverImageUrl!.isNotEmpty
                          ? heroArticle.coverImageUrl!
                          : 'https://images.unsplash.com/photo-1519389950473-47ba0277781c?w=1200',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.85),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 28,
                      left: 28,
                      right: 28,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: BlogTheme.goldYellow,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'FEATURED STORY',
                              style: TextStyle(color: Colors.black87, fontSize: 11, fontWeight: FontWeight.w900),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            heroArticle.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            heroArticle.summary ?? heroArticle.content,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.grey[300], fontSize: 14),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 14,
                                backgroundImage: NetworkImage(
                                  heroArticle.authorAvatarUrl != null && heroArticle.authorAvatarUrl!.isNotEmpty
                                      ? heroArticle.authorAvatarUrl!
                                      : 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100',
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                heroArticle.authorName,
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                              const SizedBox(width: 16),
                              const Icon(Icons.timer_outlined, size: 14, color: Colors.grey),
                              const SizedBox(width: 4),
                              Text(
                                '${heroArticle.readingTimeMinutes} min read',
                                style: const TextStyle(color: Colors.grey, fontSize: 12),
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
            const SizedBox(height: 32),
          ],

          // Category Pills Filter Bar
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                FilterChip(
                  label: const Text('All Topics'),
                  selected: _selectedCategoryId == null,
                  onSelected: (_) => setState(() => _selectedCategoryId = null),
                  selectedColor: BlogTheme.primaryViolet,
                  labelStyle: TextStyle(
                    color: _selectedCategoryId == null ? Colors.white : (isDark ? Colors.white70 : Colors.black87),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                ...widget.categories.map((c) {
                  final isSelected = _selectedCategoryId == c.id;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(c.name),
                      selected: isSelected,
                      selectedColor: BlogTheme.primaryViolet,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : (isDark ? Colors.white70 : Colors.black87),
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                      onSelected: (_) => setState(() => _selectedCategoryId = isSelected ? null : c.id),
                    ),
                  );
                }),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Section Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _selectedCategoryId != null
                    ? 'Articles in Category'
                    : (widget.searchQuery.isNotEmpty ? 'Search Results' : 'Latest Articles'),
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Text(
                '${filteredArticles.length} Articles',
                style: TextStyle(color: Colors.grey[600], fontSize: 13),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Articles Grid
          if (filteredArticles.isEmpty)
            Padding(
              padding: const EdgeInsets.all(48),
              child: Center(
                child: Column(
                  children: [
                    const Icon(Icons.search_off, size: 64, color: Colors.grey),
                    const SizedBox(height: 16),
                    Text(
                      'No articles found',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Try clearing your search or switching categories.',
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),
            )
          else
            LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = 1;
                if (constraints.maxWidth > 1100) {
                  crossAxisCount = 3;
                } else if (constraints.maxWidth > 700) {
                  crossAxisCount = 2;
                }

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 0.82,
                  ),
                  itemCount: filteredArticles.length,
                  itemBuilder: (context, index) {
                    final article = filteredArticles[index];
                    return ArticleCard(
                      article: article,
                      onTap: () => widget.onSelectArticle(article),
                      onLike: () => widget.onLikeArticle(article.id!),
                    );
                  },
                );
              },
            ),
        ],
      ),
    );
  }
}
