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
        articleTags: ArticleTag.includeList(
          include: ArticleTag.include(
            tag: Tag.include(),
          ),
        ),
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
        articleTags: ArticleTag.includeList(
          include: ArticleTag.include(
            tag: Tag.include(),
          ),
        ),
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
  Future<Article> addArticle(
    Session session,
    Article article, {
    List<int>? tagIds,
  }) async {
    final now = DateTime.now();
    final newArticle = article.copyWith(
      publishedAt: article.status == 'published' ? (article.publishedAt ?? now) : null,
    );
    final saved = await Article.db.insertRow(session, newArticle);

    if (tagIds != null && tagIds.isNotEmpty && saved.id != null) {
      for (final tagId in tagIds) {
        await ArticleTag.db.insertRow(
          session,
          ArticleTag(articleId: saved.id!, tagId: tagId),
        );
      }
    }

    final reloaded = await getArticleById(session, saved.id!);
    return reloaded ?? saved;
  }

  /// Update an existing article
  Future<Article> updateArticle(
    Session session,
    Article article, {
    List<int>? tagIds,
  }) async {
    final updated = article.copyWith(
      updatedAt: DateTime.now(),
    );
    final saved = await Article.db.updateRow(session, updated);

    if (tagIds != null && saved.id != null) {
      await ArticleTag.db.deleteWhere(
        session,
        where: (t) => t.articleId.equals(saved.id!),
      );

      for (final tagId in tagIds) {
        await ArticleTag.db.insertRow(
          session,
          ArticleTag(articleId: saved.id!, tagId: tagId),
        );
      }
    }

    final reloaded = await getArticleById(session, saved.id!);
    return reloaded ?? saved;
  }

  /// Delete an article by ID
  Future<bool> deleteArticle(Session session, int id) async {
    final article = await Article.db.findById(session, id);
    if (article != null) {
      await ArticleTag.db.deleteWhere(
        session,
        where: (t) => t.articleId.equals(id),
      );
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
