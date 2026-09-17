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
import '../tags/article_tag.dart' as _i2;
import 'package:my_app_client/src/protocol/protocol.dart' as _i3;

abstract class Tag implements _i1.SerializableModel {
  Tag._({
    this.id,
    required this.name,
    required this.slug,
    this.articleTags,
  });

  factory Tag({
    int? id,
    required String name,
    required String slug,
    List<_i2.ArticleTag>? articleTags,
  }) = _TagImpl;

  factory Tag.fromJson(Map<String, dynamic> jsonSerialization) {
    return Tag(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      slug: jsonSerialization['slug'] as String,
      articleTags: jsonSerialization['articleTags'] == null
          ? null
          : _i3.Protocol().deserialize<List<_i2.ArticleTag>>(
              jsonSerialization['articleTags'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  String slug;

  List<_i2.ArticleTag>? articleTags;

  /// Returns a shallow copy of this [Tag]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Tag copyWith({
    int? id,
    String? name,
    String? slug,
    List<_i2.ArticleTag>? articleTags,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Tag',
      if (id != null) 'id': id,
      'name': name,
      'slug': slug,
      if (articleTags != null)
        'articleTags': articleTags?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TagImpl extends Tag {
  _TagImpl({
    int? id,
    required String name,
    required String slug,
    List<_i2.ArticleTag>? articleTags,
  }) : super._(
         id: id,
         name: name,
         slug: slug,
         articleTags: articleTags,
       );

  /// Returns a shallow copy of this [Tag]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Tag copyWith({
    Object? id = _Undefined,
    String? name,
    String? slug,
    Object? articleTags = _Undefined,
  }) {
    return Tag(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      articleTags: articleTags is List<_i2.ArticleTag>?
          ? articleTags
          : this.articleTags?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
