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

abstract class Category implements _i1.SerializableModel {
  Category._({
    this.id,
    required this.name,
    required this.slug,
    this.description,
    this.colorHex,
    this.iconName,
    this.articles,
  });

  factory Category({
    int? id,
    required String name,
    required String slug,
    String? description,
    String? colorHex,
    String? iconName,
    List<_i2.Article>? articles,
  }) = _CategoryImpl;

  factory Category.fromJson(Map<String, dynamic> jsonSerialization) {
    return Category(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      slug: jsonSerialization['slug'] as String,
      description: jsonSerialization['description'] as String?,
      colorHex: jsonSerialization['colorHex'] as String?,
      iconName: jsonSerialization['iconName'] as String?,
      articles: jsonSerialization['articles'] == null
          ? null
          : _i3.Protocol().deserialize<List<_i2.Article>>(
              jsonSerialization['articles'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  String slug;

  String? description;

  String? colorHex;

  String? iconName;

  List<_i2.Article>? articles;

  /// Returns a shallow copy of this [Category]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Category copyWith({
    int? id,
    String? name,
    String? slug,
    String? description,
    String? colorHex,
    String? iconName,
    List<_i2.Article>? articles,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Category',
      if (id != null) 'id': id,
      'name': name,
      'slug': slug,
      if (description != null) 'description': description,
      if (colorHex != null) 'colorHex': colorHex,
      if (iconName != null) 'iconName': iconName,
      if (articles != null)
        'articles': articles?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CategoryImpl extends Category {
  _CategoryImpl({
    int? id,
    required String name,
    required String slug,
    String? description,
    String? colorHex,
    String? iconName,
    List<_i2.Article>? articles,
  }) : super._(
         id: id,
         name: name,
         slug: slug,
         description: description,
         colorHex: colorHex,
         iconName: iconName,
         articles: articles,
       );

  /// Returns a shallow copy of this [Category]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Category copyWith({
    Object? id = _Undefined,
    String? name,
    String? slug,
    Object? description = _Undefined,
    Object? colorHex = _Undefined,
    Object? iconName = _Undefined,
    Object? articles = _Undefined,
  }) {
    return Category(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      description: description is String? ? description : this.description,
      colorHex: colorHex is String? ? colorHex : this.colorHex,
      iconName: iconName is String? ? iconName : this.iconName,
      articles: articles is List<_i2.Article>?
          ? articles
          : this.articles?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
