import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class DashboardEndpoint extends Endpoint {
  /// Fetch aggregate stats for the Admin Dashboard
  Future<DashboardStats> getStats(Session session) async {
    final allArticles = await Article.db.find(session);
    final allComments = await Comment.db.find(session);
    final categories = await Category.db.find(session);
    final tags = await Tag.db.find(session);

    int publishedCount = 0;
    int draftCount = 0;
    int totalViewsCount = 0;

    for (final a in allArticles) {
      if (a.status == 'published') {
        publishedCount++;
      } else {
        draftCount++;
      }
      totalViewsCount += a.viewsCount;
    }

    int pendingCommentsCount = 0;
    for (final c in allComments) {
      if (!c.isApproved) {
        pendingCommentsCount++;
      }
    }

    return DashboardStats(
      totalArticles: allArticles.length,
      publishedArticles: publishedCount,
      draftArticles: draftCount,
      totalViews: totalViewsCount,
      totalComments: allComments.length,
      pendingComments: pendingCommentsCount,
      totalCategories: categories.length,
      totalTags: tags.length,
    );
  }
}
