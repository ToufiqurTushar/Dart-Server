import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class ArticleEndpoint extends Endpoint {
  /// Get articles with optional filtering by status, search, categoryId
  Future<List<Article>> getArticles(
    Session session, {
    String? statusFilter,
    String? searchQuery,
    int? categoryId,
  }) async {
    return await Article.db.find(
      session,
      where: (t) {
        Expression expr = Constant.bool(true);

        if (statusFilter != null && statusFilter.isNotEmpty && statusFilter != 'all') {
          expr = expr & t.status.equals(statusFilter);
        }

        if (categoryId != null) {
          expr = expr & t.categoryId.equals(categoryId);
        }

        if (searchQuery != null && searchQuery.trim().isNotEmpty) {
          final query = '%${searchQuery.trim()}%';
          expr = expr & (t.title.like(query) | t.content.like(query));
        }

        return expr;
      },
      orderBy: (t) => t.createdAt,
      orderDescending: true,
      include: Article.include(
        category: Category.include(),
      ),
    );
  }

  /// Get single article by ID and increment its view counter
  Future<Article?> getArticleById(Session session, int id) async {
    final article = await Article.db.findById(
      session,
      id,
      include: Article.include(
        category: Category.include(),
      ),
    );

    if (article != null) {
      final updated = article.copyWith(
        viewsCount: article.viewsCount + 1,
      );
      await Article.db.updateRow(session, updated);
      return updated;
    }
    return null;
  }

  /// Increment article like count
  Future<int> incrementLikes(Session session, int articleId) async {
    final article = await Article.db.findById(session, articleId);
    if (article != null) {
      final updated = article.copyWith(
        likesCount: article.likesCount + 1,
      );
      await Article.db.updateRow(session, updated);
      return updated.likesCount;
    }
    return 0;
  }

  /// Create a new article
  Future<Article> addArticle(Session session, Article article) async {
    final now = DateTime.now();
    final newArticle = article.copyWith(
      createdAt: article.createdAt ?? now,
      publishedAt: article.status == 'published' ? (article.publishedAt ?? now) : null,
      viewsCount: article.viewsCount ?? 0,
      likesCount: article.likesCount ?? 0,
    );
    return await Article.db.insertRow(session, newArticle);
  }

  /// Update an existing article
  Future<Article> updateArticle(Session session, Article article) async {
    final updated = article.copyWith(
      updatedAt: DateTime.now(),
    );
    return await Article.db.updateRow(session, updated);
  }

  /// Delete an article by ID
  Future<bool> deleteArticle(Session session, int id) async {
    final article = await Article.db.findById(session, id);
    if (article != null) {
      await Article.db.deleteRow(session, article);
      return true;
    }
    return false;
  }

  /// Categories CRUD
  Future<Category> createCategory(Session session, Category category) async {
    return await Category.db.insertRow(session, category);
  }

  Future<List<Category>> getCategories(Session session) async {
    return await Category.db.find(session, orderBy: (c) => c.name);
  }

  Future<bool> deleteCategory(Session session, int id) async {
    final cat = await Category.db.findById(session, id);
    if (cat != null) {
      await Category.db.deleteRow(session, cat);
      return true;
    }
    return false;
  }

  /// Tags CRUD
  Future<Tag> createTag(Session session, Tag tag) async {
    return await Tag.db.insertRow(session, tag);
  }

  Future<List<Tag>> getTags(Session session) async {
    return await Tag.db.find(session, orderBy: (t) => t.name);
  }

  Future<bool> deleteTag(Session session, int id) async {
    final tag = await Tag.db.findById(session, id);
    if (tag != null) {
      await Tag.db.deleteRow(session, tag);
      return true;
    }
    return false;
  }
}
