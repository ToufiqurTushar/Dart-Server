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
import '../articles/article.dart' as _i2;
import '../tags/tag.dart' as _i3;
import 'package:my_app_server/src/generated/protocol.dart' as _i4;

abstract class ArticleTag
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = ArticleTagTable();

  static const db = ArticleTagRepository._();

  @override
  int? id;

  int articleId;

  _i2.Article? article;

  int tagId;

  _i3.Tag? tag;

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ArticleTag',
      if (id != null) 'id': id,
      'articleId': articleId,
      if (article != null) 'article': article?.toJsonForProtocol(),
      'tagId': tagId,
      if (tag != null) 'tag': tag?.toJsonForProtocol(),
    };
  }

  static ArticleTagInclude include({
    _i2.ArticleInclude? article,
    _i3.TagInclude? tag,
  }) {
    return ArticleTagInclude._(
      article: article,
      tag: tag,
    );
  }

  static ArticleTagIncludeList includeList({
    _i1.WhereExpressionBuilder<ArticleTagTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ArticleTagTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ArticleTagTable>? orderByList,
    ArticleTagInclude? include,
  }) {
    return ArticleTagIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ArticleTag.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ArticleTag.t),
      include: include,
    );
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

class ArticleTagUpdateTable extends _i1.UpdateTable<ArticleTagTable> {
  ArticleTagUpdateTable(super.table);

  _i1.ColumnValue<int, int> articleId(int value) => _i1.ColumnValue(
    table.articleId,
    value,
  );

  _i1.ColumnValue<int, int> tagId(int value) => _i1.ColumnValue(
    table.tagId,
    value,
  );
}

class ArticleTagTable extends _i1.Table<int?> {
  ArticleTagTable({super.tableRelation}) : super(tableName: 'article_tag') {
    updateTable = ArticleTagUpdateTable(this);
    articleId = _i1.ColumnInt(
      'articleId',
      this,
    );
    tagId = _i1.ColumnInt(
      'tagId',
      this,
    );
  }

  late final ArticleTagUpdateTable updateTable;

  late final _i1.ColumnInt articleId;

  _i2.ArticleTable? _article;

  late final _i1.ColumnInt tagId;

  _i3.TagTable? _tag;

  _i2.ArticleTable get article {
    if (_article != null) return _article!;
    _article = _i1.createRelationTable(
      relationFieldName: 'article',
      field: ArticleTag.t.articleId,
      foreignField: _i2.Article.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.ArticleTable(tableRelation: foreignTableRelation),
    );
    return _article!;
  }

  _i3.TagTable get tag {
    if (_tag != null) return _tag!;
    _tag = _i1.createRelationTable(
      relationFieldName: 'tag',
      field: ArticleTag.t.tagId,
      foreignField: _i3.Tag.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.TagTable(tableRelation: foreignTableRelation),
    );
    return _tag!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    articleId,
    tagId,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'article') {
      return article;
    }
    if (relationField == 'tag') {
      return tag;
    }
    return null;
  }
}

class ArticleTagInclude extends _i1.IncludeObject {
  ArticleTagInclude._({
    _i2.ArticleInclude? article,
    _i3.TagInclude? tag,
  }) {
    _article = article;
    _tag = tag;
  }

  _i2.ArticleInclude? _article;

  _i3.TagInclude? _tag;

  @override
  Map<String, _i1.Include?> get includes => {
    'article': _article,
    'tag': _tag,
  };

  @override
  _i1.Table<int?> get table => ArticleTag.t;
}

class ArticleTagIncludeList extends _i1.IncludeList {
  ArticleTagIncludeList._({
    _i1.WhereExpressionBuilder<ArticleTagTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ArticleTag.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ArticleTag.t;
}

class ArticleTagRepository {
  const ArticleTagRepository._();

  final attachRow = const ArticleTagAttachRowRepository._();

  /// Returns a list of [ArticleTag]s matching the given query parameters.
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
  Future<List<ArticleTag>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ArticleTagTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ArticleTagTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ArticleTagTable>? orderByList,
    _i1.Transaction? transaction,
    ArticleTagInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ArticleTag>(
      where: where?.call(ArticleTag.t),
      orderBy: orderBy?.call(ArticleTag.t),
      orderByList: orderByList?.call(ArticleTag.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ArticleTag] matching the given query parameters.
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
  Future<ArticleTag?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ArticleTagTable>? where,
    int? offset,
    _i1.OrderByBuilder<ArticleTagTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ArticleTagTable>? orderByList,
    _i1.Transaction? transaction,
    ArticleTagInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ArticleTag>(
      where: where?.call(ArticleTag.t),
      orderBy: orderBy?.call(ArticleTag.t),
      orderByList: orderByList?.call(ArticleTag.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ArticleTag] by its [id] or null if no such row exists.
  Future<ArticleTag?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    ArticleTagInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ArticleTag>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ArticleTag]s in the list and returns the inserted rows.
  ///
  /// The returned [ArticleTag]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<ArticleTag>> insert(
    _i1.DatabaseSession session,
    List<ArticleTag> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<ArticleTag>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [ArticleTag] and returns the inserted row.
  ///
  /// The returned [ArticleTag] will have its `id` field set.
  Future<ArticleTag> insertRow(
    _i1.DatabaseSession session,
    ArticleTag row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ArticleTag>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ArticleTag]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ArticleTag>> update(
    _i1.DatabaseSession session,
    List<ArticleTag> rows, {
    _i1.ColumnSelections<ArticleTagTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ArticleTag>(
      rows,
      columns: columns?.call(ArticleTag.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ArticleTag]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ArticleTag> updateRow(
    _i1.DatabaseSession session,
    ArticleTag row, {
    _i1.ColumnSelections<ArticleTagTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ArticleTag>(
      row,
      columns: columns?.call(ArticleTag.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ArticleTag] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ArticleTag?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<ArticleTagUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ArticleTag>(
      id,
      columnValues: columnValues(ArticleTag.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ArticleTag]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ArticleTag>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<ArticleTagUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<ArticleTagTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ArticleTagTable>? orderBy,
    _i1.OrderByListBuilder<ArticleTagTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ArticleTag>(
      columnValues: columnValues(ArticleTag.t.updateTable),
      where: where(ArticleTag.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ArticleTag.t),
      orderByList: orderByList?.call(ArticleTag.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ArticleTag]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ArticleTag>> delete(
    _i1.DatabaseSession session,
    List<ArticleTag> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ArticleTag>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ArticleTag].
  Future<ArticleTag> deleteRow(
    _i1.DatabaseSession session,
    ArticleTag row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ArticleTag>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ArticleTag>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ArticleTagTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ArticleTag>(
      where: where(ArticleTag.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ArticleTagTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ArticleTag>(
      where: where?.call(ArticleTag.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ArticleTag] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ArticleTagTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ArticleTag>(
      where: where(ArticleTag.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class ArticleTagAttachRowRepository {
  const ArticleTagAttachRowRepository._();

  /// Creates a relation between the given [ArticleTag] and [Article]
  /// by setting the [ArticleTag]'s foreign key `articleId` to refer to the [Article].
  Future<void> article(
    _i1.DatabaseSession session,
    ArticleTag articleTag,
    _i2.Article article, {
    _i1.Transaction? transaction,
  }) async {
    if (articleTag.id == null) {
      throw ArgumentError.notNull('articleTag.id');
    }
    if (article.id == null) {
      throw ArgumentError.notNull('article.id');
    }

    var $articleTag = articleTag.copyWith(articleId: article.id);
    await session.db.updateRow<ArticleTag>(
      $articleTag,
      columns: [ArticleTag.t.articleId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [ArticleTag] and [Tag]
  /// by setting the [ArticleTag]'s foreign key `tagId` to refer to the [Tag].
  Future<void> tag(
    _i1.DatabaseSession session,
    ArticleTag articleTag,
    _i3.Tag tag, {
    _i1.Transaction? transaction,
  }) async {
    if (articleTag.id == null) {
      throw ArgumentError.notNull('articleTag.id');
    }
    if (tag.id == null) {
      throw ArgumentError.notNull('tag.id');
    }

    var $articleTag = articleTag.copyWith(tagId: tag.id);
    await session.db.updateRow<ArticleTag>(
      $articleTag,
      columns: [ArticleTag.t.tagId],
      transaction: transaction,
    );
  }
}
