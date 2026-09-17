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
import '../tags/tag.dart' as _i3;
import 'package:my_app_client/src/protocol/protocol.dart' as _i4;

abstract class ArticleTag implements _i1.SerializableModel {
  ArticleTag._({
    this.id,
    required this.articleId,
    this.article,
    required this.tagId,
    this.tag,
  });

  factory ArticleTag({
    int? id,
    required int articleId,
    _i2.Article? article,
    required int tagId,
    _i3.Tag? tag,
  }) = _ArticleTagImpl;

  factory ArticleTag.fromJson(Map<String, dynamic> jsonSerialization) {
    return ArticleTag(
      id: jsonSerialization['id'] as int?,
      articleId: jsonSerialization['articleId'] as int,
      article: jsonSerialization['article'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.Article>(
              jsonSerialization['article'],
            ),
      tagId: jsonSerialization['tagId'] as int,
      tag: jsonSerialization['tag'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.Tag>(jsonSerialization['tag']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int articleId;

  _i2.Article? article;

  int tagId;

  _i3.Tag? tag;

  /// Returns a shallow copy of this [ArticleTag]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ArticleTag copyWith({
    int? id,
    int? articleId,
    _i2.Article? article,
    int? tagId,
    _i3.Tag? tag,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ArticleTag',
      if (id != null) 'id': id,
      'articleId': articleId,
      if (article != null) 'article': article?.toJson(),
      'tagId': tagId,
      if (tag != null) 'tag': tag?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ArticleTagImpl extends ArticleTag {
  _ArticleTagImpl({
    int? id,
    required int articleId,
    _i2.Article? article,
    required int tagId,
    _i3.Tag? tag,
  }) : super._(
         id: id,
         articleId: articleId,
         article: article,
         tagId: tagId,
         tag: tag,
       );

  /// Returns a shallow copy of this [ArticleTag]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ArticleTag copyWith({
    Object? id = _Undefined,
    int? articleId,
    Object? article = _Undefined,
    int? tagId,
    Object? tag = _Undefined,
  }) {
    return ArticleTag(
      id: id is int? ? id : this.id,
      articleId: articleId ?? this.articleId,
      article: article is _i2.Article? ? article : this.article?.copyWith(),
      tagId: tagId ?? this.tagId,
      tag: tag is _i3.Tag? ? tag : this.tag?.copyWith(),
    );
  }
}
