import 'package:flutter/material.dart';
import 'package:my_app_client/my_app_client.dart';
import '../theme/blog_theme.dart';
import '../widgets/article_editor_dialog.dart';

class AdminDashboardScreen extends StatefulWidget {
  final DashboardStats? stats;
  final List<Article> articles;
  final List<Category> categories;
  final List<Tag> tags;
  final List<Comment> allComments;

  final VoidCallback onRefresh;
  final Function(Article article) onSaveArticle;
  final Function(int id) onDeleteArticle;
  final Function(Category category) onCreateCategory;
  final Function(int id) onDeleteCategory;
  final Function(Tag tag) onCreateTag;
  final Function(int id) onDeleteTag;
  final Function(int id) onToggleCommentApproval;
  final Function(int id) onDeleteComment;

  const AdminDashboardScreen({
    super.key,
    required this.stats,
    required this.articles,
    required this.categories,
    required this.tags,
    required this.allComments,
    required this.onRefresh,
    required this.onSaveArticle,
    required this.onDeleteArticle,
    required this.onCreateCategory,
    required this.onDeleteCategory,
    required this.onCreateTag,
    required this.onDeleteTag,
    required this.onToggleCommentApproval,
    required this.onDeleteComment,
  });

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _articleSearchQuery = '';
  String _articleStatusFilter = 'all';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showCreateCategoryDialog() {
    final nameController = TextEditingController();
    final slugController = TextEditingController();
    final descController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Category'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Category Name', border: OutlineInputBorder()),
              onChanged: (val) {
                slugController.text = val.toLowerCase().replaceAll(RegExp(r'\s+'), '-');
              },
            ),
            const SizedBox(height: 10),
            TextField(
              controller: slugController,
              decoration: const InputDecoration(labelText: 'Slug', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: 'Description', border: OutlineInputBorder()),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                final cat = Category(
                  name: nameController.text.trim(),
                  slug: slugController.text.trim(),
                  description: descController.text.trim(),
                );
                widget.onCreateCategory(cat);
                Navigator.pop(context);
              }
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _showCreateTagDialog() {
    final nameController = TextEditingController();
    final slugController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Tag'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Tag Name', border: OutlineInputBorder()),
              onChanged: (val) {
                slugController.text = val.toLowerCase().replaceAll(RegExp(r'\s+'), '-');
              },
            ),
            const SizedBox(height: 10),
            TextField(
              controller: slugController,
              decoration: const InputDecoration(labelText: 'Slug', border: OutlineInputBorder()),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                final tag = Tag(
                  name: nameController.text.trim(),
                  slug: slugController.text.trim(),
                );
                widget.onCreateTag(tag);
                Navigator.pop(context);
              }
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dashboard Title Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Admin Panel Dashboard',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Manage your blog posts, comments, categories, and platform analytics.',
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: widget.onRefresh,
                      tooltip: 'Refresh Stats',
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () {
                        ArticleEditorDialog.show(
                          context,
                          categories: widget.categories,
                          tags: widget.tags,
                          onSave: widget.onSaveArticle,
                        );
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('New Article'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: BlogTheme.primaryViolet,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Overview Metric Cards Grid
            GridView.count(
              crossAxisCount: MediaQuery.of(context).size.width > 900 ? 4 : 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              shrinkWrap: true,
              childAspectRatio: 2.2,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildMetricCard(
                  context,
                  title: 'Total Articles',
                  value: '${widget.stats?.totalArticles ?? widget.articles.length}',
                  subText: '${widget.stats?.publishedArticles ?? 0} Published / ${widget.stats?.draftArticles ?? 0} Drafts',
                  icon: Icons.article_outlined,
                  color: BlogTheme.primaryViolet,
                ),
                _buildMetricCard(
                  context,
                  title: 'Total Views',
                  value: '${widget.stats?.totalViews ?? 0}',
                  subText: 'Across all published posts',
                  icon: Icons.visibility_outlined,
                  color: BlogTheme.secondaryCyan,
                ),
                _buildMetricCard(
                  context,
                  title: 'Total Comments',
                  value: '${widget.stats?.totalComments ?? widget.allComments.length}',
                  subText: '${widget.stats?.pendingComments ?? 0} Pending Moderation',
                  icon: Icons.comment_outlined,
                  color: BlogTheme.accentPink,
                ),
                _buildMetricCard(
                  context,
                  title: 'Categories & Tags',
                  value: '${widget.categories.length} / ${widget.tags.length}',
                  subText: 'Active taxonomy filters',
                  icon: Icons.category_outlined,
                  color: BlogTheme.goldYellow,
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Tab Bar Navigation
            TabBar(
              controller: _tabController,
              labelColor: BlogTheme.primaryViolet,
              unselectedLabelColor: Colors.grey,
              indicatorColor: BlogTheme.primaryViolet,
              tabs: const [
                Tab(icon: Icon(Icons.article), text: 'Articles Studio'),
                Tab(icon: Icon(Icons.comment), text: 'Comments Queue'),
                Tab(icon: Icon(Icons.category), text: 'Categories'),
                Tab(icon: Icon(Icons.tag), text: 'Tags'),
              ],
            ),
            const SizedBox(height: 20),

            SizedBox(
              height: 600,
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Tab 1: Articles Studio Table
                  _buildArticlesStudioTab(isDark),

                  // Tab 2: Comments Moderation Queue
                  _buildCommentsQueueTab(isDark),

                  // Tab 3: Categories Manager
                  _buildCategoriesTab(isDark),

                  // Tab 4: Tags Manager
                  _buildTagsTab(isDark),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(
    BuildContext context, {
    required String title,
    required String value,
    required String subText,
    required IconData icon,
    required Color color,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? BlogTheme.darkCardBg : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? Colors.white10 : Colors.black12),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: const TextStyle(fontSize: 13, color: Colors.grey)),
                Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Text(subText, style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArticlesStudioTab(bool isDark) {
    final filtered = widget.articles.where((a) {
      final matchesSearch = a.title.toLowerCase().contains(_articleSearchQuery.toLowerCase());
      final matchesStatus = _articleStatusFilter == 'all' || a.status == _articleStatusFilter;
      return matchesSearch && matchesStatus;
    }).toList();

    return Column(
      children: [
        // Controls bar
        Row(
          children: [
            Expanded(
              child: TextField(
                onChanged: (val) => setState(() => _articleSearchQuery = val),
                decoration: const InputDecoration(
                  hintText: 'Filter posts by title...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                ),
              ),
            ),
            const SizedBox(width: 16),
            DropdownButton<String>(
              value: _articleStatusFilter,
              items: const [
                DropdownMenuItem(value: 'all', child: Text('All Statuses')),
                DropdownMenuItem(value: 'published', child: Text('Published Only')),
                DropdownMenuItem(value: 'draft', child: Text('Drafts Only')),
              ],
              onChanged: (val) => setState(() => _articleStatusFilter = val!),
            ),
          ],
        ),
        const SizedBox(height: 16),

        Expanded(
          child: Card(
            color: isDark ? BlogTheme.darkCardBg : Colors.white,
            child: ListView.separated(
              itemCount: filtered.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final a = filtered[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      a.coverImageUrl != null && a.coverImageUrl!.isNotEmpty
                          ? a.coverImageUrl!
                          : 'https://images.unsplash.com/photo-1499750310107-5fef28a66643?w=100',
                    ),
                  ),
                  title: Text(a.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('Author: ${a.authorName} • Views: ${a.viewsCount} • Likes: ${a.likesCount}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: a.status == 'published' ? Colors.green.withOpacity(0.15) : Colors.orange.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          a.status.toUpperCase(),
                          style: TextStyle(
                            color: a.status == 'published' ? Colors.green : Colors.orange,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      IconButton(
                        icon: const Icon(Icons.edit_outlined, color: BlogTheme.primaryViolet),
                        onPressed: () {
                          ArticleEditorDialog.show(
                            context,
                            article: a,
                            categories: widget.categories,
                            tags: widget.tags,
                            onSave: widget.onSaveArticle,
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () => widget.onDeleteArticle(a.id!),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCommentsQueueTab(bool isDark) {
    return Card(
      color: isDark ? BlogTheme.darkCardBg : Colors.white,
      child: widget.allComments.isEmpty
          ? const Center(child: Text('No comments submitted yet.'))
          : ListView.separated(
              itemCount: widget.allComments.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final c = widget.allComments[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: BlogTheme.primaryViolet,
                    child: Text(c.authorName.isNotEmpty ? c.authorName[0].toUpperCase() : 'C', style: const TextStyle(color: Colors.white)),
                  ),
                  title: Text('${c.authorName} (${c.authorEmail})'),
                  subtitle: Text(c.content),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () => widget.onToggleCommentApproval(c.id!),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: c.isApproved ? Colors.green : Colors.grey,
                          foregroundColor: Colors.white,
                        ),
                        child: Text(c.isApproved ? 'Approved' : 'Approve'),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () => widget.onDeleteComment(c.id!),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  Widget _buildCategoriesTab(bool isDark) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton.icon(
            onPressed: _showCreateCategoryDialog,
            icon: const Icon(Icons.add),
            label: const Text('Add Category'),
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: Card(
            color: isDark ? BlogTheme.darkCardBg : Colors.white,
            child: ListView.separated(
              itemCount: widget.categories.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final cat = widget.categories[index];
                return ListTile(
                  title: Text(cat.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('Slug: ${cat.slug} • ${cat.description ?? "No description"}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: () => widget.onDeleteCategory(cat.id!),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTagsTab(bool isDark) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton.icon(
            onPressed: _showCreateTagDialog,
            icon: const Icon(Icons.add),
            label: const Text('Add Tag'),
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: Card(
            color: isDark ? BlogTheme.darkCardBg : Colors.white,
            child: ListView.separated(
              itemCount: widget.tags.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final tag = widget.tags[index];
                return ListTile(
                  title: Text('#${tag.name}', style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('Slug: ${tag.slug}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: () => widget.onDeleteTag(tag.id!),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
