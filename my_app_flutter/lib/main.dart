import 'package:my_app_client/my_app_client.dart';
import 'package:flutter/material.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import 'theme/blog_theme.dart';
import 'widgets/auth_dialog.dart';
import 'widgets/blog_header.dart';
import 'screens/articles_screen.dart';
import 'screens/article_detail_screen.dart';
import 'screens/admin_dashboard_screen.dart' deferred as admin_panel;

late final Client client;
late String serverUrl;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final serverUrl = await getServerUrl();

  client = Client(serverUrl)
    ..connectivityMonitor = FlutterConnectivityMonitor()
    ..authSessionManager = FlutterAuthSessionManager();

  client.auth.initialize();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.dark;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Apex Blog System',
      debugShowCheckedModeBanner: false,
      theme: BlogTheme.lightTheme(),
      darkTheme: BlogTheme.darkTheme(),
      themeMode: _themeMode,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        final uri = Uri.parse(settings.name ?? '/');
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => BlogShell(
            onToggleTheme: _toggleTheme,
            initialRouteUri: uri,
          ),
        );
      },
    );
  }
}

class BlogShell extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final Uri initialRouteUri;

  const BlogShell({
    super.key,
    required this.onToggleTheme,
    required this.initialRouteUri,
  });

  @override
  State<BlogShell> createState() => _BlogShellState();
}

class _BlogShellState extends State<BlogShell> {
  bool _isAdminMode = false;
  UserSession? _currentSession;
  String _searchQuery = '';

  Article? _selectedArticle;
  int? _selectedCategoryId;
  List<Article> _articles = [];
  List<Category> _categories = [];
  List<Tag> _tags = [];
  List<Comment> _articleComments = [];
  List<Comment> _allComments = [];
  DashboardStats? _dashboardStats;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    setState(() => _isLoading = true);
    try {
      var categories = await client.article.getCategories();
      var tags = await client.article.getTags();
      var articles = await client.article.getArticles();

      if (categories.isEmpty) {
        categories = await _seedCategories();
      }
      if (tags.isEmpty) {
        tags = await _seedTags();
      }
      if (articles.isEmpty) {
        articles = await _seedArticles(categories);
      }

      var stats = await client.dashboard.getStats();
      var allComments = await client.comment.getAllCommentsForAdmin();

      setState(() {
        _categories = categories;
        _tags = tags;
        _articles = articles;
        _dashboardStats = stats;
        _allComments = allComments;
        _isLoading = false;
      });

      _parseRouteFromUri(widget.initialRouteUri);
    } catch (e) {
      debugPrint('Error loading server data: $e');
      _populateInMemoryFallback();
      setState(() => _isLoading = false);
      _parseRouteFromUri(widget.initialRouteUri);
    }
  }

  void _parseRouteFromUri(Uri uri) {
    final path = uri.path;
    final segments = uri.pathSegments;

    if (path == '/admin' || (segments.isNotEmpty && segments.first == 'admin')) {
      setState(() {
        _isAdminMode = true;
        _selectedArticle = null;
      });
    } else if (segments.length >= 2 && segments[0] == 'article') {
      final articleId = int.tryParse(segments[1]);
      if (articleId != null) {
        final found = _articles.firstWhere(
          (a) => a.id == articleId,
          orElse: () => _articles.first,
        );
        _selectArticle(found);
      }
    } else if (segments.length >= 2 && segments[0] == 'category') {
      final catId = int.tryParse(segments[1]);
      setState(() {
        _selectedCategoryId = catId;
        _isAdminMode = false;
        _selectedArticle = null;
      });
    }
  }

  Future<List<Category>> _seedCategories() async {
    final seedCat1 = Category(name: 'Technology & AI', slug: 'tech-ai', description: 'Next-gen computing, artificial intelligence, software design.');
    final seedCat2 = Category(name: 'Mobile Development', slug: 'mobile-dev', description: 'Flutter, Serverpod, cross-platform app engineering.');
    final seedCat3 = Category(name: 'Design Systems', slug: 'design-systems', description: 'UI/UX aesthetic frameworks, glassmorphism, typography.');
    
    try {
      final c1 = await client.article.createCategory(seedCat1);
      final c2 = await client.article.createCategory(seedCat2);
      final c3 = await client.article.createCategory(seedCat3);
      return [c1, c2, c3];
    } catch (_) {
      return [seedCat1, seedCat2, seedCat3];
    }
  }

  Future<List<Tag>> _seedTags() async {
    final t1 = Tag(name: 'Flutter', slug: 'flutter');
    final t2 = Tag(name: 'Serverpod', slug: 'serverpod');
    final t3 = Tag(name: 'Dart', slug: 'dart');
    try {
      final res1 = await client.article.createTag(t1);
      final res2 = await client.article.createTag(t2);
      final res3 = await client.article.createTag(t3);
      return [res1, res2, res3];
    } catch (_) {
      return [t1, t2, t3];
    }
  }

  Future<List<Article>> _seedArticles(List<Category> cats) async {
    final now = DateTime.now();
    final catId = cats.isNotEmpty ? cats.first.id : null;

    final a1 = Article(
      title: 'Building Fullstack Apps with Flutter & Serverpod in 2026',
      slug: 'building-fullstack-apps-flutter-serverpod',
      summary: 'Explore how Serverpod 4.0 and Flutter enable seamless type-safe server-side Dart backends with real-time database reactivity.',
      content: '''
# The Dawn of Serverpod 4.0

Developing fullstack web and mobile applications in pure Dart has evolved into a powerhouse ecosystem. With Serverpod handling database migrations, ORM modeling, identity authentication, and RPC client codegen automatically, developers can build scalable platforms at record speed.

### Key Highlights:
1. **Strongly Typed Protocol Models**: Define `.spy.yaml` schemas once and get instantly generated Dart code for both server and Flutter client.
2. **PostgreSQL & Redis Cache**: Enterprise performance out of the box with zero boilerplate SQL queries required.
3. **Flutter Web & Desktop Optimization**: High performance rendering with responsive modern web layouts.

```dart
void main() async {
  client = Client('http://localhost:8080/')
    ..connectivityMonitor = FlutterConnectivityMonitor();
}
```

The future of cross-platform Dart development is brighter than ever.
''',
      coverImageUrl: 'https://images.unsplash.com/photo-1555066931-4365d14bab8c?w=1200',
      authorName: 'Alex Rivers',
      authorAvatarUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150',
      status: 'published',
      viewsCount: 342,
      likesCount: 89,
      readingTimeMinutes: 5,
      isFeatured: true,
      publishedAt: now,
      createdAt: now,
      categoryId: catId,
    );

    final a2 = Article(
      title: 'Designing Rich Modern Aesthetics with Glassmorphism',
      slug: 'designing-rich-modern-aesthetics-glassmorphism',
      summary: 'Master vibrant HSL gradients, frosted glass visual depth, and micro-animations for high-impact web design.',
      content: '''
# Modern Web & Mobile UI Trends

Visual impression is key to user retention. Modern design leverages subtle translucency, vibrant contrast colors, precise letter-spacing, and tactile micro-animations to deliver a state-of-the-art software experience.

### Core Principles:
- **Layered Elevation**: Use soft ambient shadows combined with semi-transparent borders.
- **Micro-Interactions**: Hover transitions and scale effects invite user curiosity and engagement.
- **Accessible Typography**: High-legibility font hierarchies ensure comfortable long-form reading.
''',
      coverImageUrl: 'https://images.unsplash.com/photo-1507238691740-187a5b1d37b8?w=1200',
      authorName: 'Elena Vance',
      authorAvatarUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150',
      status: 'published',
      viewsCount: 215,
      likesCount: 54,
      readingTimeMinutes: 4,
      isFeatured: false,
      publishedAt: now,
      createdAt: now,
      categoryId: cats.length > 2 ? cats[2].id : catId,
    );

    final tagIds = _tags.map((t) => t.id).where((id) => id != null).cast<int>().toList();
    try {
      final res1 = await client.article.addArticle(a1, tagIds: tagIds.isNotEmpty ? [tagIds.first] : null);
      final res2 = await client.article.addArticle(a2, tagIds: tagIds);
      return [res1, res2];
    } catch (_) {
      return [a1, a2];
    }
  }

  void _populateInMemoryFallback() {
    _categories = [
      Category(id: 1, name: 'Technology & AI', slug: 'tech-ai'),
      Category(id: 2, name: 'Mobile Dev', slug: 'mobile-dev'),
    ];
    _tags = [Tag(id: 1, name: 'Flutter', slug: 'flutter')];
    _articles = [
      Article(
        id: 1,
        title: 'Apex Blog System is Live',
        slug: 'apex-blog-live',
        summary: 'Welcome to your complete blog platform powered by Flutter and Serverpod.',
        content: 'This is the complete blog system with reader experience, admin dashboard, comments, and authentication.',
        coverImageUrl: 'https://images.unsplash.com/photo-1499750310107-5fef28a66643?w=1200',
        authorName: 'Admin',
        status: 'published',
        viewsCount: 100,
        likesCount: 42,
        readingTimeMinutes: 3,
        isFeatured: true,
        createdAt: DateTime.now(),
        categoryId: 1,
        articleTags: [ArticleTag(articleId: 1, tagId: 1, tag: Tag(id: 1, name: 'Flutter', slug: 'flutter'))],
      ),
    ];
  }

  void _selectArticle(Article article) async {
    setState(() {
      _selectedArticle = article;
      _isAdminMode = false;
    });
    try {
      final updated = await client.article.getArticleById(article.id!);
      if (updated != null) {
        setState(() {
          _selectedArticle = updated;
          final index = _articles.indexWhere((a) => a.id == updated.id);
          if (index != -1) _articles[index] = updated;
        });
      }
      final comments = await client.comment.getCommentsForArticle(article.id!);
      setState(() => _articleComments = comments);
    } catch (e) {
      debugPrint('Error fetching article detail: $e');
    }
  }

  Future<int> _handleLikeArticle(int articleId) async {
    try {
      final newLikes = await client.article.incrementLikes(articleId);
      setState(() {
        final index = _articles.indexWhere((a) => a.id == articleId);
        if (index != -1) {
          _articles[index] = _articles[index].copyWith(likesCount: newLikes);
        }
        if (_selectedArticle?.id == articleId) {
          _selectedArticle = _selectedArticle!.copyWith(likesCount: newLikes);
        }
      });
      return newLikes;
    } catch (e) {
      return 0;
    }
  }

  Future<void> _handleSubmitComment(String name, String email, String content) async {
    if (_selectedArticle == null) return;
    final comment = Comment(
      articleId: _selectedArticle!.id!,
      authorName: name,
      authorEmail: email,
      authorAvatarUrl: _currentSession?.avatarUrl,
      content: content,
      createdAt: DateTime.now(),
      isApproved: true,
    );

    try {
      final created = await client.comment.addComment(comment);
      setState(() {
        _articleComments.insert(0, created);
        _allComments.insert(0, created);
      });
    } catch (e) {
      setState(() {
        _articleComments.insert(0, comment);
        _allComments.insert(0, comment);
      });
    }
  }

  void _showToast(String message, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isError ? Icons.warning_amber_rounded : Icons.check_circle_outline,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ),
          ],
        ),
        backgroundColor: isError ? Colors.orange.shade900 : Colors.green.shade700,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 4),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _handleSaveArticle(Article article, List<int> tagIds) async {
    try {
      if (article.id == null) {
        final created = await client.article.addArticle(article, tagIds: tagIds);
        setState(() => _articles.insert(0, created));
      } else {
        final updated = await client.article.updateArticle(article, tagIds: tagIds);
        setState(() {
          final idx = _articles.indexWhere((a) => a.id == updated.id);
          if (idx != -1) _articles[idx] = updated;
        });
      }
      _showToast(article.id == null ? 'Article created successfully!' : 'Article updated successfully!');
      _refreshStats();
    } catch (e) {
      debugPrint('Error saving article on server, applying local fallback: $e');
      final selectedTags = _tags.where((t) => t.id != null && tagIds.contains(t.id!)).toList();
      final targetId = article.id ?? DateTime.now().millisecondsSinceEpoch;
      final articleTagList = selectedTags
          .map((t) => ArticleTag(articleId: targetId, tagId: t.id!, tag: t))
          .toList();
      if (article.id == null) {
        final localCreated = article.copyWith(
          id: targetId,
          articleTags: articleTagList,
        );
        setState(() => _articles.insert(0, localCreated));
      } else {
        final localUpdated = article.copyWith(articleTags: articleTagList);
        setState(() {
          final idx = _articles.indexWhere((a) => a.id == article.id);
          if (idx != -1) _articles[idx] = localUpdated;
        });
      }
      _showToast('Server offline: Article saved locally in offline mode', isError: true);
    }
  }

  void _handleDeleteArticle(int id) async {
    try {
      await client.article.deleteArticle(id);
      _showToast('Article deleted successfully.');
    } catch (e) {
      debugPrint('Error deleting article on server, applying local fallback: $e');
      _showToast('Server offline: Article removed locally', isError: true);
    }
    setState(() => _articles.removeWhere((a) => a.id == id));
    _refreshStats();
  }

  void _handleCreateCategory(Category category) async {
    try {
      final created = await client.article.createCategory(category);
      setState(() => _categories.add(created));
      _showToast('Category created successfully!');
    } catch (e) {
      debugPrint('Error creating category on server, applying local fallback: $e');
      final localCat = category.copyWith(id: DateTime.now().millisecondsSinceEpoch);
      setState(() => _categories.add(localCat));
      _showToast('Server offline: Category added locally', isError: true);
    }
  }

  void _handleDeleteCategory(int id) async {
    try {
      await client.article.deleteCategory(id);
      _showToast('Category deleted.');
    } catch (e) {
      debugPrint('Error deleting category on server, applying local fallback: $e');
      _showToast('Server offline: Category removed locally', isError: true);
    }
    setState(() => _categories.removeWhere((c) => c.id == id));
  }

  Future<Tag> _handleCreateTag(Tag tag) async {
    try {
      final created = await client.article.createTag(tag);
      setState(() => _tags.add(created));
      _showToast('Tag created successfully!');
      return created;
    } catch (e) {
      debugPrint('Error creating tag on server, applying local fallback: $e');
      final localTag = tag.copyWith(id: DateTime.now().millisecondsSinceEpoch);
      setState(() => _tags.add(localTag));
      _showToast('Server offline: Tag added locally', isError: true);
      return localTag;
    }
  }

  void _handleDeleteTag(int id) async {
    try {
      await client.article.deleteTag(id);
      _showToast('Tag deleted.');
    } catch (e) {
      debugPrint('Error deleting tag on server, applying local fallback: $e');
      _showToast('Server offline: Tag removed locally', isError: true);
    }
    setState(() => _tags.removeWhere((t) => t.id == id));
  }

  void _handleToggleCommentApproval(int id) async {
    try {
      final updated = await client.comment.toggleApproval(id);
      if (updated != null) {
        setState(() {
          final idx = _allComments.indexWhere((c) => c.id == id);
          if (idx != -1) _allComments[idx] = updated;
        });
      }
    } catch (e) {
      debugPrint('Error toggling comment approval: $e');
    }
  }

  void _handleDeleteComment(int id) async {
    try {
      await client.comment.deleteComment(id);
      setState(() {
        _allComments.removeWhere((c) => c.id == id);
        _articleComments.removeWhere((c) => c.id == id);
      });
    } catch (e) {
      debugPrint('Error deleting comment: $e');
    }
  }

  void _refreshStats() async {
    try {
      final stats = await client.dashboard.getStats();
      setState(() => _dashboardStats = stats);
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: BlogTheme.primaryViolet),
              SizedBox(height: 16),
              Text('Connecting to Apex Blog Server...', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      );
    }

    Widget currentBody;

    if (_isAdminMode) {
      currentBody = FutureBuilder(
        future: admin_panel.loadLibrary(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return admin_panel.AdminDashboardScreen(
              stats: _dashboardStats,
              articles: _articles,
              categories: _categories,
              tags: _tags,
              allComments: _allComments,
              onRefresh: _loadInitialData,
              onSaveArticle: _handleSaveArticle,
              onDeleteArticle: _handleDeleteArticle,
              onCreateCategory: _handleCreateCategory,
              onDeleteCategory: _handleDeleteCategory,
              onCreateTag: _handleCreateTag,
              onDeleteTag: _handleDeleteTag,
              onToggleCommentApproval: _handleToggleCommentApproval,
              onDeleteComment: _handleDeleteComment,
            );
          }
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: BlogTheme.primaryViolet),
                SizedBox(height: 12),
                Text('Loading Admin Panel Studio...', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          );
        },
      );
    } else if (_selectedArticle != null) {
      currentBody = ArticleDetailScreen(
        article: _selectedArticle!,
        comments: _articleComments,
        currentSession: _currentSession,
        onBack: () => setState(() => _selectedArticle = null),
        onLike: _handleLikeArticle,
        onSubmitComment: _handleSubmitComment,
      );
    } else {
      currentBody = ArticlesFeedScreen(
        articles: _articles,
        categories: _categories,
        initialCategoryId: _selectedCategoryId,
        searchQuery: _searchQuery,
        onSelectArticle: _selectArticle,
        onLikeArticle: _handleLikeArticle,
      );
    }

    return Scaffold(
      appBar: BlogHeader(
        isAdminMode: _isAdminMode,
        onModeChanged: (admin) {
          setState(() {
            _isAdminMode = admin;
            _selectedArticle = null;
          });
        },
        currentSession: _currentSession,
        onSessionChanged: (session) => setState(() => _currentSession = session),
        onThemeToggle: widget.onToggleTheme,
        onSearchChanged: (query) => setState(() => _searchQuery = query),
      ),
      body: currentBody,
    );
  }
}
