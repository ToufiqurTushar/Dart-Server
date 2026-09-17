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
// ignore_for_file: unnecessary_null_comparison

import 'package:serverpod/serverpod.dart' as _i1;
import '../categories/category.dart' as _i2;
import '../tags/article_tag.dart' as _i3;
import '../comments/comment.dart' as _i4;
import 'package:my_app_server/src/generated/protocol.dart' as _i5;

abstract class Article
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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
  }) : _categoryArticlesCategoryId = null;

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
    return ArticleImplicit._(
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
      $_categoryArticlesCategoryId:
          jsonSerialization['_categoryArticlesCategoryId'] as int?,
    );
  }

  static final t = ArticleTable();

  static const db = ArticleRepository._();

  @override
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

  final int? _categoryArticlesCategoryId;

  @override
  _i1.Table<int?> get table => t;

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
      if (_categoryArticlesCategoryId != null)
        '_categoryArticlesCategoryId': _categoryArticlesCategoryId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
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
      if (category != null) 'category': category?.toJsonForProtocol(),
      if (articleTags != null)
        'articleTags': articleTags?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (comments != null)
        'comments': comments?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static ArticleInclude include({
    _i2.CategoryInclude? category,
    _i3.ArticleTagIncludeList? articleTags,
    _i4.CommentIncludeList? comments,
  }) {
    return ArticleInclude._(
      category: category,
      articleTags: articleTags,
      comments: comments,
    );
  }

  static ArticleIncludeList includeList({
    _i1.WhereExpressionBuilder<ArticleTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ArticleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ArticleTable>? orderByList,
    ArticleInclude? include,
  }) {
    return ArticleIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Article.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Article.t),
      include: include,
    );
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
    return ArticleImplicit._(
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
      $_categoryArticlesCategoryId: this._categoryArticlesCategoryId,
    );
  }
}

class ArticleImplicit extends _ArticleImpl {
  ArticleImplicit._({
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
    int? $_categoryArticlesCategoryId,
  }) : _categoryArticlesCategoryId = $_categoryArticlesCategoryId,
       super(
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

  factory ArticleImplicit(
    Article article, {
    int? $_categoryArticlesCategoryId,
  }) {
    return ArticleImplicit._(
      id: article.id,
      title: article.title,
      slug: article.slug,
      summary: article.summary,
      content: article.content,
      coverImageUrl: article.coverImageUrl,
      authorName: article.authorName,
      authorAvatarUrl: article.authorAvatarUrl,
      status: article.status,
      viewsCount: article.viewsCount,
      likesCount: article.likesCount,
      readingTimeMinutes: article.readingTimeMinutes,
      isFeatured: article.isFeatured,
      publishedAt: article.publishedAt,
      createdAt: article.createdAt,
      updatedAt: article.updatedAt,
      categoryId: article.categoryId,
      category: article.category,
      articleTags: article.articleTags,
      comments: article.comments,
      $_categoryArticlesCategoryId: $_categoryArticlesCategoryId,
    );
  }

  @override
  final int? _categoryArticlesCategoryId;
}

class ArticleUpdateTable extends _i1.UpdateTable<ArticleTable> {
  ArticleUpdateTable(super.table);

  _i1.ColumnValue<String, String> title(String value) => _i1.ColumnValue(
    table.title,
    value,
  );

  _i1.ColumnValue<String, String> slug(String value) => _i1.ColumnValue(
    table.slug,
    value,
  );

  _i1.ColumnValue<String, String> summary(String? value) => _i1.ColumnValue(
    table.summary,
    value,
  );

  _i1.ColumnValue<String, String> content(String value) => _i1.ColumnValue(
    table.content,
    value,
  );

  _i1.ColumnValue<String, String> coverImageUrl(String? value) =>
      _i1.ColumnValue(
        table.coverImageUrl,
        value,
      );

  _i1.ColumnValue<String, String> authorName(String value) => _i1.ColumnValue(
    table.authorName,
    value,
  );

  _i1.ColumnValue<String, String> authorAvatarUrl(String? value) =>
      _i1.ColumnValue(
        table.authorAvatarUrl,
        value,
      );

  _i1.ColumnValue<String, String> status(String value) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<int, int> viewsCount(int value) => _i1.ColumnValue(
    table.viewsCount,
    value,
  );

  _i1.ColumnValue<int, int> likesCount(int value) => _i1.ColumnValue(
    table.likesCount,
    value,
  );

  _i1.ColumnValue<int, int> readingTimeMinutes(int value) => _i1.ColumnValue(
    table.readingTimeMinutes,
    value,
  );

  _i1.ColumnValue<bool, bool> isFeatured(bool value) => _i1.ColumnValue(
    table.isFeatured,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> publishedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.publishedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );

  _i1.ColumnValue<int, int> categoryId(int? value) => _i1.ColumnValue(
    table.categoryId,
    value,
  );

  _i1.ColumnValue<int, int> $_categoryArticlesCategoryId(int? value) =>
      _i1.ColumnValue(
        table.$_categoryArticlesCategoryId,
        value,
      );
}

class ArticleTable extends _i1.Table<int?> {
  ArticleTable({super.tableRelation}) : super(tableName: 'article') {
    updateTable = ArticleUpdateTable(this);
    title = _i1.ColumnString(
      'title',
      this,
    );
    slug = _i1.ColumnString(
      'slug',
      this,
    );
    summary = _i1.ColumnString(
      'summary',
      this,
    );
    content = _i1.ColumnString(
      'content',
      this,
    );
    coverImageUrl = _i1.ColumnString(
      'coverImageUrl',
      this,
    );
    authorName = _i1.ColumnString(
      'authorName',
      this,
    );
    authorAvatarUrl = _i1.ColumnString(
      'authorAvatarUrl',
      this,
    );
    status = _i1.ColumnString(
      'status',
      this,
    );
    viewsCount = _i1.ColumnInt(
      'viewsCount',
      this,
    );
    likesCount = _i1.ColumnInt(
      'likesCount',
      this,
    );
    readingTimeMinutes = _i1.ColumnInt(
      'readingTimeMinutes',
      this,
    );
    isFeatured = _i1.ColumnBool(
      'isFeatured',
      this,
    );
    publishedAt = _i1.ColumnDateTime(
      'publishedAt',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
    categoryId = _i1.ColumnInt(
      'categoryId',
      this,
    );
    $_categoryArticlesCategoryId = _i1.ColumnInt(
      '_categoryArticlesCategoryId',
      this,
    );
  }

  late final ArticleUpdateTable updateTable;

  late final _i1.ColumnString title;

  late final _i1.ColumnString slug;

  late final _i1.ColumnString summary;

  late final _i1.ColumnString content;

  late final _i1.ColumnString coverImageUrl;

  late final _i1.ColumnString authorName;

  late final _i1.ColumnString authorAvatarUrl;

  late final _i1.ColumnString status;

  late final _i1.ColumnInt viewsCount;

  late final _i1.ColumnInt likesCount;

  late final _i1.ColumnInt readingTimeMinutes;

  late final _i1.ColumnBool isFeatured;

  late final _i1.ColumnDateTime publishedAt;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  late final _i1.ColumnInt categoryId;

  _i2.CategoryTable? _category;

  _i3.ArticleTagTable? ___articleTags;

  _i1.ManyRelation<_i3.ArticleTagTable>? _articleTags;

  _i4.CommentTable? ___comments;

  _i1.ManyRelation<_i4.CommentTable>? _comments;

  late final _i1.ColumnInt $_categoryArticlesCategoryId;

  _i2.CategoryTable get category {
    if (_category != null) return _category!;
    _category = _i1.createRelationTable(
      relationFieldName: 'category',
      field: Article.t.categoryId,
      foreignField: _i2.Category.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.CategoryTable(tableRelation: foreignTableRelation),
    );
    return _category!;
  }

  _i3.ArticleTagTable get __articleTags {
    if (___articleTags != null) return ___articleTags!;
    ___articleTags = _i1.createRelationTable(
      relationFieldName: '__articleTags',
      field: Article.t.id,
      foreignField: _i3.ArticleTag.t.articleId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.ArticleTagTable(tableRelation: foreignTableRelation),
    );
    return ___articleTags!;
  }

  _i4.CommentTable get __comments {
    if (___comments != null) return ___comments!;
    ___comments = _i1.createRelationTable(
      relationFieldName: '__comments',
      field: Article.t.id,
      foreignField: _i4.Comment.t.articleId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.CommentTable(tableRelation: foreignTableRelation),
    );
    return ___comments!;
  }

  _i1.ManyRelation<_i3.ArticleTagTable> get articleTags {
    if (_articleTags != null) return _articleTags!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'articleTags',
      field: Article.t.id,
      foreignField: _i3.ArticleTag.t.articleId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.ArticleTagTable(tableRelation: foreignTableRelation),
    );
    _articleTags = _i1.ManyRelation<_i3.ArticleTagTable>(
      tableWithRelations: relationTable,
      table: _i3.ArticleTagTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _articleTags!;
  }

  _i1.ManyRelation<_i4.CommentTable> get comments {
    if (_comments != null) return _comments!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'comments',
      field: Article.t.id,
      foreignField: _i4.Comment.t.articleId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.CommentTable(tableRelation: foreignTableRelation),
    );
    _comments = _i1.ManyRelation<_i4.CommentTable>(
      tableWithRelations: relationTable,
      table: _i4.CommentTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _comments!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    title,
    slug,
    summary,
    content,
    coverImageUrl,
    authorName,
    authorAvatarUrl,
    status,
    viewsCount,
    likesCount,
    readingTimeMinutes,
    isFeatured,
    publishedAt,
    createdAt,
    updatedAt,
    categoryId,
    $_categoryArticlesCategoryId,
  ];

  @override
  List<_i1.Column> get managedColumns => [
    id,
    title,
    slug,
    summary,
    content,
    coverImageUrl,
    authorName,
    authorAvatarUrl,
    status,
    viewsCount,
    likesCount,
    readingTimeMinutes,
    isFeatured,
    publishedAt,
    createdAt,
    updatedAt,
    categoryId,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'category') {
      return category;
    }
    if (relationField == 'articleTags') {
      return __articleTags;
    }
    if (relationField == 'comments') {
      return __comments;
    }
    return null;
  }
}

class ArticleInclude extends _i1.IncludeObject {
  ArticleInclude._({
    _i2.CategoryInclude? category,
    _i3.ArticleTagIncludeList? articleTags,
    _i4.CommentIncludeList? comments,
  }) {
    _category = category;
    _articleTags = articleTags;
    _comments = comments;
  }

  _i2.CategoryInclude? _category;

  _i3.ArticleTagIncludeList? _articleTags;

  _i4.CommentIncludeList? _comments;

  @override
  Map<String, _i1.Include?> get includes => {
    'category': _category,
    'articleTags': _articleTags,
    'comments': _comments,
  };

  @override
  _i1.Table<int?> get table => Article.t;
}

class ArticleIncludeList extends _i1.IncludeList {
  ArticleIncludeList._({
    _i1.WhereExpressionBuilder<ArticleTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Article.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Article.t;
}

class ArticleRepository {
  const ArticleRepository._();

  final attach = const ArticleAttachRepository._();

  final attachRow = const ArticleAttachRowRepository._();

  final detach = const ArticleDetachRepository._();

  final detachRow = const ArticleDetachRowRepository._();

  /// Returns a list of [Article]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<Article>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ArticleTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ArticleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ArticleTable>? orderByList,
    _i1.Transaction? transaction,
    ArticleInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Article>(
      where: where?.call(Article.t),
      orderBy: orderBy?.call(Article.t),
      orderByList: orderByList?.call(Article.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Article] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<Article?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ArticleTable>? where,
    int? offset,
    _i1.OrderByBuilder<ArticleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ArticleTable>? orderByList,
    _i1.Transaction? transaction,
    ArticleInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Article>(
      where: where?.call(Article.t),
      orderBy: orderBy?.call(Article.t),
      orderByList: orderByList?.call(Article.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Article] by its [id] or null if no such row exists.
  Future<Article?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    ArticleInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Article>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Article]s in the list and returns the inserted rows.
  ///
  /// The returned [Article]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Article>> insert(
    _i1.DatabaseSession session,
    List<Article> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Article>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Article] and returns the inserted row.
  ///
  /// The returned [Article] will have its `id` field set.
  Future<Article> insertRow(
    _i1.DatabaseSession session,
    Article row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Article>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Article]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Article>> update(
    _i1.DatabaseSession session,
    List<Article> rows, {
    _i1.ColumnSelections<ArticleTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Article>(
      rows,
      columns: columns?.call(Article.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Article]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Article> updateRow(
    _i1.DatabaseSession session,
    Article row, {
    _i1.ColumnSelections<ArticleTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Article>(
      row,
      columns: columns?.call(Article.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Article] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Article?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<ArticleUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Article>(
      id,
      columnValues: columnValues(Article.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Article]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Article>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<ArticleUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<ArticleTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ArticleTable>? orderBy,
    _i1.OrderByListBuilder<ArticleTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Article>(
      columnValues: columnValues(Article.t.updateTable),
      where: where(Article.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Article.t),
      orderByList: orderByList?.call(Article.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Article]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Article>> delete(
    _i1.DatabaseSession session,
    List<Article> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Article>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Article].
  Future<Article> deleteRow(
    _i1.DatabaseSession session,
    Article row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Article>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Article>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ArticleTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Article>(
      where: where(Article.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ArticleTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Article>(
      where: where?.call(Article.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Article] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ArticleTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Article>(
      where: where(Article.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class ArticleAttachRepository {
  const ArticleAttachRepository._();

  /// Creates a relation between this [Article] and the given [ArticleTag]s
  /// by setting each [ArticleTag]'s foreign key `articleId` to refer to this [Article].
  Future<void> articleTags(
    _i1.DatabaseSession session,
    Article article,
    List<_i3.ArticleTag> articleTag, {
    _i1.Transaction? transaction,
  }) async {
    if (articleTag.any((e) => e.id == null)) {
      throw ArgumentError.notNull('articleTag.id');
    }
    if (article.id == null) {
      throw ArgumentError.notNull('article.id');
    }

    var $articleTag = articleTag
        .map((e) => e.copyWith(articleId: article.id))
        .toList();
    await session.db.update<_i3.ArticleTag>(
      $articleTag,
      columns: [_i3.ArticleTag.t.articleId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Article] and the given [Comment]s
  /// by setting each [Comment]'s foreign key `articleId` to refer to this [Article].
  Future<void> comments(
    _i1.DatabaseSession session,
    Article article,
    List<_i4.Comment> comment, {
    _i1.Transaction? transaction,
  }) async {
    if (comment.any((e) => e.id == null)) {
      throw ArgumentError.notNull('comment.id');
    }
    if (article.id == null) {
      throw ArgumentError.notNull('article.id');
    }

    var $comment = comment
        .map((e) => e.copyWith(articleId: article.id))
        .toList();
    await session.db.update<_i4.Comment>(
      $comment,
      columns: [_i4.Comment.t.articleId],
      transaction: transaction,
    );
  }
}

class ArticleAttachRowRepository {
  const ArticleAttachRowRepository._();

  /// Creates a relation between the given [Article] and [Category]
  /// by setting the [Article]'s foreign key `categoryId` to refer to the [Category].
  Future<void> category(
    _i1.DatabaseSession session,
    Article article,
    _i2.Category category, {
    _i1.Transaction? transaction,
  }) async {
    if (article.id == null) {
      throw ArgumentError.notNull('article.id');
    }
    if (category.id == null) {
      throw ArgumentError.notNull('category.id');
    }

    var $article = article.copyWith(categoryId: category.id);
    await session.db.updateRow<Article>(
      $article,
      columns: [Article.t.categoryId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Article] and the given [ArticleTag]
  /// by setting the [ArticleTag]'s foreign key `articleId` to refer to this [Article].
  Future<void> articleTags(
    _i1.DatabaseSession session,
    Article article,
    _i3.ArticleTag articleTag, {
    _i1.Transaction? transaction,
  }) async {
    if (articleTag.id == null) {
      throw ArgumentError.notNull('articleTag.id');
    }
    if (article.id == null) {
      throw ArgumentError.notNull('article.id');
    }

    var $articleTag = articleTag.copyWith(articleId: article.id);
    await session.db.updateRow<_i3.ArticleTag>(
      $articleTag,
      columns: [_i3.ArticleTag.t.articleId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Article] and the given [Comment]
  /// by setting the [Comment]'s foreign key `articleId` to refer to this [Article].
  Future<void> comments(
    _i1.DatabaseSession session,
    Article article,
    _i4.Comment comment, {
    _i1.Transaction? transaction,
  }) async {
    if (comment.id == null) {
      throw ArgumentError.notNull('comment.id');
    }
    if (article.id == null) {
      throw ArgumentError.notNull('article.id');
    }

    var $comment = comment.copyWith(articleId: article.id);
    await session.db.updateRow<_i4.Comment>(
      $comment,
      columns: [_i4.Comment.t.articleId],
      transaction: transaction,
    );
  }
}

class ArticleDetachRepository {
  const ArticleDetachRepository._();

  /// Detaches the relation between this [Article] and the given [ArticleTag]
  /// by setting the [ArticleTag]'s foreign key `articleId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> articleTags(
    _i1.DatabaseSession session,
    List<_i3.ArticleTag> articleTag, {
    _i1.Transaction? transaction,
  }) async {
    if (articleTag.any((e) => e.id == null)) {
      throw ArgumentError.notNull('articleTag.id');
    }

    var $articleTag = articleTag
        .map((e) => e.copyWith(articleId: null))
        .toList();
    await session.db.update<_i3.ArticleTag>(
      $articleTag,
      columns: [_i3.ArticleTag.t.articleId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [Article] and the given [Comment]
  /// by setting the [Comment]'s foreign key `articleId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> comments(
    _i1.DatabaseSession session,
    List<_i4.Comment> comment, {
    _i1.Transaction? transaction,
  }) async {
    if (comment.any((e) => e.id == null)) {
      throw ArgumentError.notNull('comment.id');
    }

    var $comment = comment.map((e) => e.copyWith(articleId: null)).toList();
    await session.db.update<_i4.Comment>(
      $comment,
      columns: [_i4.Comment.t.articleId],
      transaction: transaction,
    );
  }
}

class ArticleDetachRowRepository {
  const ArticleDetachRowRepository._();

  /// Detaches the relation between this [Article] and the [Category] set in `category`
  /// by setting the [Article]'s foreign key `categoryId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> category(
    _i1.DatabaseSession session,
    Article article, {
    _i1.Transaction? transaction,
  }) async {
    if (article.id == null) {
      throw ArgumentError.notNull('article.id');
    }

    var $article = article.copyWith(categoryId: null);
    await session.db.updateRow<Article>(
      $article,
      columns: [Article.t.categoryId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [Article] and the given [ArticleTag]
  /// by setting the [ArticleTag]'s foreign key `articleId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> articleTags(
    _i1.DatabaseSession session,
    _i3.ArticleTag articleTag, {
    _i1.Transaction? transaction,
  }) async {
    if (articleTag.id == null) {
      throw ArgumentError.notNull('articleTag.id');
    }

    var $articleTag = articleTag.copyWith(articleId: null);
    await session.db.updateRow<_i3.ArticleTag>(
      $articleTag,
      columns: [_i3.ArticleTag.t.articleId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [Article] and the given [Comment]
  /// by setting the [Comment]'s foreign key `articleId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> comments(
    _i1.DatabaseSession session,
    _i4.Comment comment, {
    _i1.Transaction? transaction,
  }) async {
    if (comment.id == null) {
      throw ArgumentError.notNull('comment.id');
    }

    var $comment = comment.copyWith(articleId: null);
    await session.db.updateRow<_i4.Comment>(
      $comment,
      columns: [_i4.Comment.t.articleId],
      transaction: transaction,
    );
  }
}
