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
import '../categories/category.dart' as _i2;
import '../tags/article_tag.dart' as _i3;
import '../comments/comment.dart' as _i4;
import 'package:my_app_client/src/protocol/protocol.dart' as _i5;

abstract class Article implements _i1.SerializableModel {
  Article._({
    this.id,
    required this.title,
    required this.slug,
    this.summary,
    required this.content,
    this.coverImageUrl,
    required this.authorName,
    this.authorAvatarUrl,
    required this.status,
    required this.viewsCount,
    required this.likesCount,
    required this.readingTimeMinutes,
    required this.isFeatured,
    this.publishedAt,
    required this.createdAt,
    this.updatedAt,
    this.categoryId,
    this.category,
    this.articleTags,
    this.comments,
  });

  factory Article({
    int? id,
    required String title,
    required String slug,
    String? summary,
    required String content,
    String? coverImageUrl,
    required String authorName,
    String? authorAvatarUrl,
    required String status,
    required int viewsCount,
    required int likesCount,
    required int readingTimeMinutes,
    required bool isFeatured,
    DateTime? publishedAt,
    required DateTime createdAt,
    DateTime? updatedAt,
    int? categoryId,
    _i2.Category? category,
    List<_i3.ArticleTag>? articleTags,
    List<_i4.Comment>? comments,
  }) = _ArticleImpl;

  factory Article.fromJson(Map<String, dynamic> jsonSerialization) {
    return Article(
      id: jsonSerialization['id'] as int?,
      title: jsonSerialization['title'] as String,
      slug: jsonSerialization['slug'] as String,
      summary: jsonSerialization['summary'] as String?,
      content: jsonSerialization['content'] as String,
      coverImageUrl: jsonSerialization['coverImageUrl'] as String?,
      authorName: jsonSerialization['authorName'] as String,
      authorAvatarUrl: jsonSerialization['authorAvatarUrl'] as String?,
      status: jsonSerialization['status'] as String,
      viewsCount: jsonSerialization['viewsCount'] as int,
      likesCount: jsonSerialization['likesCount'] as int,
      readingTimeMinutes: jsonSerialization['readingTimeMinutes'] as int,
      isFeatured: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['isFeatured'],
      ),
      publishedAt: jsonSerialization['publishedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['publishedAt'],
            ),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      categoryId: jsonSerialization['categoryId'] as int?,
      category: jsonSerialization['category'] == null
          ? null
          : _i5.Protocol().deserialize<_i2.Category>(
              jsonSerialization['category'],
            ),
      articleTags: jsonSerialization['articleTags'] == null
          ? null
          : _i5.Protocol().deserialize<List<_i3.ArticleTag>>(
              jsonSerialization['articleTags'],
            ),
      comments: jsonSerialization['comments'] == null
          ? null
          : _i5.Protocol().deserialize<List<_i4.Comment>>(
              jsonSerialization['comments'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String title;

  String slug;

  String? summary;

  String content;

  String? coverImageUrl;

  String authorName;

  String? authorAvatarUrl;

  String status;

  int viewsCount;

  int likesCount;

  int readingTimeMinutes;

  bool isFeatured;

  DateTime? publishedAt;

  DateTime createdAt;

  DateTime? updatedAt;

  int? categoryId;

  _i2.Category? category;

  List<_i3.ArticleTag>? articleTags;

  List<_i4.Comment>? comments;

  /// Returns a shallow copy of this [Article]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Article copyWith({
    int? id,
    String? title,
    String? slug,
    String? summary,
    String? content,
    String? coverImageUrl,
    String? authorName,
    String? authorAvatarUrl,
    String? status,
    int? viewsCount,
    int? likesCount,
    int? readingTimeMinutes,
    bool? isFeatured,
    DateTime? publishedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? categoryId,
    _i2.Category? category,
    List<_i3.ArticleTag>? articleTags,
    List<_i4.Comment>? comments,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Article',
      if (id != null) 'id': id,
      'title': title,
      'slug': slug,
      if (summary != null) 'summary': summary,
      'content': content,
      if (coverImageUrl != null) 'coverImageUrl': coverImageUrl,
      'authorName': authorName,
      if (authorAvatarUrl != null) 'authorAvatarUrl': authorAvatarUrl,
      'status': status,
      'viewsCount': viewsCount,
      'likesCount': likesCount,
      'readingTimeMinutes': readingTimeMinutes,
      'isFeatured': isFeatured,
      if (publishedAt != null) 'publishedAt': publishedAt?.toJson(),
      'createdAt': createdAt.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (categoryId != null) 'categoryId': categoryId,
      if (category != null) 'category': category?.toJson(),
      if (articleTags != null)
        'articleTags': articleTags?.toJson(valueToJson: (v) => v.toJson()),
      if (comments != null)
        'comments': comments?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ArticleImpl extends Article {
  _ArticleImpl({
    int? id,
    required String title,
    required String slug,
    String? summary,
    required String content,
    String? coverImageUrl,
    required String authorName,
    String? authorAvatarUrl,
    required String status,
    required int viewsCount,
    required int likesCount,
    required int readingTimeMinutes,
    required bool isFeatured,
    DateTime? publishedAt,
    required DateTime createdAt,
    DateTime? updatedAt,
    int? categoryId,
    _i2.Category? category,
    List<_i3.ArticleTag>? articleTags,
    List<_i4.Comment>? comments,
  }) : super._(
         id: id,
         title: title,
         slug: slug,
         summary: summary,
         content: content,
         coverImageUrl: coverImageUrl,
         authorName: authorName,
         authorAvatarUrl: authorAvatarUrl,
         status: status,
         viewsCount: viewsCount,
         likesCount: likesCount,
         readingTimeMinutes: readingTimeMinutes,
         isFeatured: isFeatured,
         publishedAt: publishedAt,
         createdAt: createdAt,
         updatedAt: updatedAt,
         categoryId: categoryId,
         category: category,
         articleTags: articleTags,
         comments: comments,
       );

  /// Returns a shallow copy of this [Article]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Article copyWith({
    Object? id = _Undefined,
    String? title,
    String? slug,
    Object? summary = _Undefined,
    String? content,
    Object? coverImageUrl = _Undefined,
    String? authorName,
    Object? authorAvatarUrl = _Undefined,
    String? status,
    int? viewsCount,
    int? likesCount,
    int? readingTimeMinutes,
    bool? isFeatured,
    Object? publishedAt = _Undefined,
    DateTime? createdAt,
    Object? updatedAt = _Undefined,
    Object? categoryId = _Undefined,
    Object? category = _Undefined,
    Object? articleTags = _Undefined,
    Object? comments = _Undefined,
  }) {
    return Article(
      id: id is int? ? id : this.id,
      title: title ?? this.title,
      slug: slug ?? this.slug,
      summary: summary is String? ? summary : this.summary,
      content: content ?? this.content,
      coverImageUrl: coverImageUrl is String?
          ? coverImageUrl
          : this.coverImageUrl,
      authorName: authorName ?? this.authorName,
      authorAvatarUrl: authorAvatarUrl is String?
          ? authorAvatarUrl
          : this.authorAvatarUrl,
      status: status ?? this.status,
      viewsCount: viewsCount ?? this.viewsCount,
      likesCount: likesCount ?? this.likesCount,
      readingTimeMinutes: readingTimeMinutes ?? this.readingTimeMinutes,
      isFeatured: isFeatured ?? this.isFeatured,
      publishedAt: publishedAt is DateTime? ? publishedAt : this.publishedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      categoryId: categoryId is int? ? categoryId : this.categoryId,
      category: category is _i2.Category?
          ? category
          : this.category?.copyWith(),
      articleTags: articleTags is List<_i3.ArticleTag>?
          ? articleTags
          : this.articleTags?.map((e0) => e0.copyWith()).toList(),
      comments: comments is List<_i4.Comment>?
          ? comments
          : this.comments?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
