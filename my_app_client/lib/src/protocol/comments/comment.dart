/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:serverpod_client/serverpod_client.dart' as _i1;
import '../articles/article.dart' as _i2;
import 'package:my_app_client/src/protocol/protocol.dart' as _i3;

abstract class Comment implements _i1.SerializableModel {
  Comment._({
    this.id,
    required this.articleId,
    this.article,
    required this.authorName,
    required this.authorEmail,
    this.authorAvatarUrl,
    required this.content,
    required this.createdAt,
    required this.isApproved,
    this.parentCommentId,
    this.userId,
  });

  factory Comment({
    int? id,
    required int articleId,
    _i2.Article? article,
    required String authorName,
    required String authorEmail,
    String? authorAvatarUrl,
    required String content,
    required DateTime createdAt,
    required bool isApproved,
    int? parentCommentId,
    int? userId,
  }) = _CommentImpl;

  factory Comment.fromJson(Map<String, dynamic> jsonSerialization) {
    return Comment(
      id: jsonSerialization['id'] as int?,
      articleId: jsonSerialization['articleId'] as int,
      article: jsonSerialization['article'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Article>(
              jsonSerialization['article'],
            ),
      authorName: jsonSerialization['authorName'] as String,
      authorEmail: jsonSerialization['authorEmail'] as String,
      authorAvatarUrl: jsonSerialization['authorAvatarUrl'] as String?,
      content: jsonSerialization['content'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      isApproved: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['isApproved'],
      ),
      parentCommentId: jsonSerialization['parentCommentId'] as int?,
      userId: jsonSerialization['userId'] as int?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int articleId;

  _i2.Article? article;

  String authorName;

  String authorEmail;

  String? authorAvatarUrl;

  String content;

  DateTime createdAt;

  bool isApproved;

  int? parentCommentId;

  int? userId;

  /// Returns a shallow copy of this [Comment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Comment copyWith({
    int? id,
    int? articleId,
    _i2.Article? article,
    String? authorName,
    String? authorEmail,
    String? authorAvatarUrl,
    String? content,
    DateTime? createdAt,
    bool? isApproved,
    int? parentCommentId,
    int? userId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Comment',
      if (id != null) 'id': id,
      'articleId': articleId,
      if (article != null) 'article': article?.toJson(),
      'authorName': authorName,
      'authorEmail': authorEmail,
      if (authorAvatarUrl != null) 'authorAvatarUrl': authorAvatarUrl,
      'content': content,
      'createdAt': createdAt.toJson(),
      'isApproved': isApproved,
      if (parentCommentId != null) 'parentCommentId': parentCommentId,
      if (userId != null) 'userId': userId,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CommentImpl extends Comment {
  _CommentImpl({
    int? id,
    required int articleId,
    _i2.Article? article,
    required String authorName,
    required String authorEmail,
    String? authorAvatarUrl,
    required String content,
    required DateTime createdAt,
    required bool isApproved,
    int? parentCommentId,
    int? userId,
  }) : super._(
         id: id,
         articleId: articleId,
         article: article,
         authorName: authorName,
         authorEmail: authorEmail,
         authorAvatarUrl: authorAvatarUrl,
         content: content,
         createdAt: createdAt,
         isApproved: isApproved,
         parentCommentId: parentCommentId,
         userId: userId,
       );

  /// Returns a shallow copy of this [Comment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Comment copyWith({
    Object? id = _Undefined,
    int? articleId,
    Object? article = _Undefined,
    String? authorName,
    String? authorEmail,
    Object? authorAvatarUrl = _Undefined,
    String? content,
    DateTime? createdAt,
    bool? isApproved,
    Object? parentCommentId = _Undefined,
    Object? userId = _Undefined,
  }) {
    return Comment(
      id: id is int? ? id : this.id,
      articleId: articleId ?? this.articleId,
      article: article is _i2.Article? ? article : this.article?.copyWith(),
      authorName: authorName ?? this.authorName,
      authorEmail: authorEmail ?? this.authorEmail,
      authorAvatarUrl: authorAvatarUrl is String?
          ? authorAvatarUrl
          : this.authorAvatarUrl,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      isApproved: isApproved ?? this.isApproved,
      parentCommentId: parentCommentId is int?
          ? parentCommentId
          : this.parentCommentId,
      userId: userId is int? ? userId : this.userId,
    );
  }
}
