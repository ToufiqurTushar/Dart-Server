import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class CommentEndpoint extends Endpoint {
  /// Add a new comment to an article
  Future<Comment> addComment(Session session, Comment comment) async {
    final newComment = comment.copyWith(
      createdAt: DateTime.now(),
      // Auto approve for smooth demo experience, or configurable
      isApproved: true,
    );
    return await Comment.db.insertRow(session, newComment);
  }

  /// Get approved comments for an article
  Future<List<Comment>> getCommentsForArticle(Session session, int articleId) async {
    return await Comment.db.find(
      session,
      where: (t) => t.articleId.equals(articleId) & t.isApproved.equals(true),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
    );
  }

  /// Get all comments for Admin moderation
  Future<List<Comment>> getAllCommentsForAdmin(Session session) async {
    return await Comment.db.find(
      session,
      orderBy: (t) => t.createdAt,
      orderDescending: true,
    );
  }

  /// Toggle approval status of a comment
  Future<Comment?> toggleApproval(Session session, int commentId) async {
    final comment = await Comment.db.findById(session, commentId);
    if (comment != null) {
      final updated = comment.copyWith(
        isApproved: !comment.isApproved,
      );
      return await Comment.db.updateRow(session, updated);
    }
    return null;
  }

  /// Delete a comment
  Future<bool> deleteComment(Session session, int commentId) async {
    final comment = await Comment.db.findById(session, commentId);
    if (comment != null) {
      await Comment.db.deleteRow(session, comment);
      return true;
    }
    return false;
  }
}
