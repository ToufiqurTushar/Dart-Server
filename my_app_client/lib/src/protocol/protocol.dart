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
import 'articles/article.dart' as _i2;
import 'categories/category.dart' as _i3;
import 'comments/comment.dart' as _i4;
import 'dashboard/dashboard_stats.dart' as _i5;
import 'greetings/greeting.dart' as _i6;
import 'tags/article_tag.dart' as _i7;
import 'tags/tag.dart' as _i8;
import 'package:my_app_client/src/protocol/articles/article.dart' as _i9;
import 'package:my_app_client/src/protocol/categories/category.dart' as _i10;
import 'package:my_app_client/src/protocol/tags/tag.dart' as _i11;
import 'package:my_app_client/src/protocol/comments/comment.dart' as _i12;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i13;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i14;
export 'articles/article.dart';
export 'categories/category.dart';
export 'comments/comment.dart';
export 'dashboard/dashboard_stats.dart';
export 'greetings/greeting.dart';
export 'tags/article_tag.dart';
export 'tags/tag.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i2.Article) {
      return _i2.Article.fromJson(data) as T;
    }
    if (t == _i3.Category) {
      return _i3.Category.fromJson(data) as T;
    }
    if (t == _i4.Comment) {
      return _i4.Comment.fromJson(data) as T;
    }
    if (t == _i5.DashboardStats) {
      return _i5.DashboardStats.fromJson(data) as T;
    }
    if (t == _i6.Greeting) {
      return _i6.Greeting.fromJson(data) as T;
    }
    if (t == _i7.ArticleTag) {
      return _i7.ArticleTag.fromJson(data) as T;
    }
    if (t == _i8.Tag) {
      return _i8.Tag.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.Article?>()) {
      return (data != null ? _i2.Article.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.Category?>()) {
      return (data != null ? _i3.Category.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.Comment?>()) {
      return (data != null ? _i4.Comment.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.DashboardStats?>()) {
      return (data != null ? _i5.DashboardStats.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.Greeting?>()) {
      return (data != null ? _i6.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.ArticleTag?>()) {
      return (data != null ? _i7.ArticleTag.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.Tag?>()) {
      return (data != null ? _i8.Tag.fromJson(data) : null) as T;
    }
    if (t == List<_i7.ArticleTag>) {
      return (data as List).map((e) => deserialize<_i7.ArticleTag>(e)).toList()
          as T;
    }
    if (t == _i1.getType<List<_i7.ArticleTag>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i7.ArticleTag>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i4.Comment>) {
      return (data as List).map((e) => deserialize<_i4.Comment>(e)).toList()
          as T;
    }
    if (t == _i1.getType<List<_i4.Comment>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<_i4.Comment>(e)).toList()
              : null)
          as T;
    }
    if (t == List<_i2.Article>) {
      return (data as List).map((e) => deserialize<_i2.Article>(e)).toList()
          as T;
    }
    if (t == _i1.getType<List<_i2.Article>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<_i2.Article>(e)).toList()
              : null)
          as T;
    }
    if (t == List<_i9.Article>) {
      return (data as List).map((e) => deserialize<_i9.Article>(e)).toList()
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == _i1.getType<List<int>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<int>(e)).toList()
              : null)
          as T;
    }
    if (t == List<_i10.Category>) {
      return (data as List).map((e) => deserialize<_i10.Category>(e)).toList()
          as T;
    }
    if (t == List<_i11.Tag>) {
      return (data as List).map((e) => deserialize<_i11.Tag>(e)).toList() as T;
    }
    if (t == List<_i12.Comment>) {
      return (data as List).map((e) => deserialize<_i12.Comment>(e)).toList()
          as T;
    }
    try {
      return _i13.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i14.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.Article => 'Article',
      _i3.Category => 'Category',
      _i4.Comment => 'Comment',
      _i5.DashboardStats => 'DashboardStats',
      _i6.Greeting => 'Greeting',
      _i7.ArticleTag => 'ArticleTag',
      _i8.Tag => 'Tag',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('my_app.', '');
    }

    switch (data) {
      case _i2.Article():
        return 'Article';
      case _i3.Category():
        return 'Category';
      case _i4.Comment():
        return 'Comment';
      case _i5.DashboardStats():
        return 'DashboardStats';
      case _i6.Greeting():
        return 'Greeting';
      case _i7.ArticleTag():
        return 'ArticleTag';
      case _i8.Tag():
        return 'Tag';
    }
    className = _i13.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i14.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'Article') {
      return deserialize<_i2.Article>(data['data']);
    }
    if (dataClassName == 'Category') {
      return deserialize<_i3.Category>(data['data']);
    }
    if (dataClassName == 'Comment') {
      return deserialize<_i4.Comment>(data['data']);
    }
    if (dataClassName == 'DashboardStats') {
      return deserialize<_i5.DashboardStats>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i6.Greeting>(data['data']);
    }
    if (dataClassName == 'ArticleTag') {
      return deserialize<_i7.ArticleTag>(data['data']);
    }
    if (dataClassName == 'Tag') {
      return deserialize<_i8.Tag>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i13.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i14.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _i13.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i14.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
