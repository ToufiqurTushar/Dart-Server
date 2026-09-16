import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class ArticleEndpoint extends Endpoint {
  /// Create a new article in the database
  Future<Article> addArticle(Session session, Article article) async {
    return await Article.db.insertRow(session, article);
  }

  /// Get all articles from the database
  Future<List<Article>> getArticles(Session session) async {
    return await Article.db.find(session);
  }
}
