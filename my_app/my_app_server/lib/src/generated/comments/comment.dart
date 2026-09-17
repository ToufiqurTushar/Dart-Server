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
import 'package:my_app_server/src/generated/protocol.dart' as _i3;

abstract class Comment
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = CommentTable();

  static const db = CommentRepository._();

  @override
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

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Comment',
      if (id != null) 'id': id,
      'articleId': articleId,
      if (article != null) 'article': article?.toJsonForProtocol(),
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

  static CommentInclude include({_i2.ArticleInclude? article}) {
    return CommentInclude._(article: article);
  }

  static CommentIncludeList includeList({
    _i1.WhereExpressionBuilder<CommentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CommentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CommentTable>? orderByList,
    CommentInclude? include,
  }) {
    return CommentIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Comment.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Comment.t),
      include: include,
    );
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

class CommentUpdateTable extends _i1.UpdateTable<CommentTable> {
  CommentUpdateTable(super.table);

  _i1.ColumnValue<int, int> articleId(int value) => _i1.ColumnValue(
    table.articleId,
    value,
  );

  _i1.ColumnValue<String, String> authorName(String value) => _i1.ColumnValue(
    table.authorName,
    value,
  );

  _i1.ColumnValue<String, String> authorEmail(String value) => _i1.ColumnValue(
    table.authorEmail,
    value,
  );

  _i1.ColumnValue<String, String> authorAvatarUrl(String? value) =>
      _i1.ColumnValue(
        table.authorAvatarUrl,
        value,
      );

  _i1.ColumnValue<String, String> content(String value) => _i1.ColumnValue(
    table.content,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<bool, bool> isApproved(bool value) => _i1.ColumnValue(
    table.isApproved,
    value,
  );

  _i1.ColumnValue<int, int> parentCommentId(int? value) => _i1.ColumnValue(
    table.parentCommentId,
    value,
  );

  _i1.ColumnValue<int, int> userId(int? value) => _i1.ColumnValue(
    table.userId,
    value,
  );
}

class CommentTable extends _i1.Table<int?> {
  CommentTable({super.tableRelation}) : super(tableName: 'comment') {
    updateTable = CommentUpdateTable(this);
    articleId = _i1.ColumnInt(
      'articleId',
      this,
    );
    authorName = _i1.ColumnString(
      'authorName',
      this,
    );
    authorEmail = _i1.ColumnString(
      'authorEmail',
      this,
    );
    authorAvatarUrl = _i1.ColumnString(
      'authorAvatarUrl',
      this,
    );
    content = _i1.ColumnString(
      'content',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    isApproved = _i1.ColumnBool(
      'isApproved',
      this,
    );
    parentCommentId = _i1.ColumnInt(
      'parentCommentId',
      this,
    );
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
  }

  late final CommentUpdateTable updateTable;

  late final _i1.ColumnInt articleId;

  _i2.ArticleTable? _article;

  late final _i1.ColumnString authorName;

  late final _i1.ColumnString authorEmail;

  late final _i1.ColumnString authorAvatarUrl;

  late final _i1.ColumnString content;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnBool isApproved;

  late final _i1.ColumnInt parentCommentId;

  late final _i1.ColumnInt userId;

  _i2.ArticleTable get article {
    if (_article != null) return _article!;
    _article = _i1.createRelationTable(
      relationFieldName: 'article',
      field: Comment.t.articleId,
      foreignField: _i2.Article.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.ArticleTable(tableRelation: foreignTableRelation),
    );
    return _article!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    articleId,
    authorName,
    authorEmail,
    authorAvatarUrl,
    content,
    createdAt,
    isApproved,
    parentCommentId,
    userId,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'article') {
      return article;
    }
    return null;
  }
}

class CommentInclude extends _i1.IncludeObject {
  CommentInclude._({_i2.ArticleInclude? article}) {
    _article = article;
  }

  _i2.ArticleInclude? _article;

  @override
  Map<String, _i1.Include?> get includes => {'article': _article};

  @override
  _i1.Table<int?> get table => Comment.t;
}

class CommentIncludeList extends _i1.IncludeList {
  CommentIncludeList._({
    _i1.WhereExpressionBuilder<CommentTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Comment.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Comment.t;
}

class CommentRepository {
  const CommentRepository._();

  final attachRow = const CommentAttachRowRepository._();

  /// Returns a list of [Comment]s matching the given query parameters.
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
  Future<List<Comment>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CommentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CommentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CommentTable>? orderByList,
    _i1.Transaction? transaction,
    CommentInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Comment>(
      where: where?.call(Comment.t),
      orderBy: orderBy?.call(Comment.t),
      orderByList: orderByList?.call(Comment.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Comment] matching the given query parameters.
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
  Future<Comment?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CommentTable>? where,
    int? offset,
    _i1.OrderByBuilder<CommentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CommentTable>? orderByList,
    _i1.Transaction? transaction,
    CommentInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Comment>(
      where: where?.call(Comment.t),
      orderBy: orderBy?.call(Comment.t),
      orderByList: orderByList?.call(Comment.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Comment] by its [id] or null if no such row exists.
  Future<Comment?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    CommentInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Comment>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Comment]s in the list and returns the inserted rows.
  ///
  /// The returned [Comment]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Comment>> insert(
    _i1.DatabaseSession session,
    List<Comment> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Comment>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Comment] and returns the inserted row.
  ///
  /// The returned [Comment] will have its `id` field set.
  Future<Comment> insertRow(
    _i1.DatabaseSession session,
    Comment row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Comment>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Comment]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Comment>> update(
    _i1.DatabaseSession session,
    List<Comment> rows, {
    _i1.ColumnSelections<CommentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Comment>(
      rows,
      columns: columns?.call(Comment.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Comment]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Comment> updateRow(
    _i1.DatabaseSession session,
    Comment row, {
    _i1.ColumnSelections<CommentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Comment>(
      row,
      columns: columns?.call(Comment.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Comment] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Comment?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<CommentUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Comment>(
      id,
      columnValues: columnValues(Comment.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Comment]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Comment>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<CommentUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<CommentTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CommentTable>? orderBy,
    _i1.OrderByListBuilder<CommentTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Comment>(
      columnValues: columnValues(Comment.t.updateTable),
      where: where(Comment.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Comment.t),
      orderByList: orderByList?.call(Comment.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Comment]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Comment>> delete(
    _i1.DatabaseSession session,
    List<Comment> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Comment>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Comment].
  Future<Comment> deleteRow(
    _i1.DatabaseSession session,
    Comment row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Comment>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Comment>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<CommentTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Comment>(
      where: where(Comment.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CommentTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Comment>(
      where: where?.call(Comment.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Comment] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<CommentTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Comment>(
      where: where(Comment.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class CommentAttachRowRepository {
  const CommentAttachRowRepository._();

  /// Creates a relation between the given [Comment] and [Article]
  /// by setting the [Comment]'s foreign key `articleId` to refer to the [Article].
  Future<void> article(
    _i1.DatabaseSession session,
    Comment comment,
    _i2.Article article, {
    _i1.Transaction? transaction,
  }) async {
    if (comment.id == null) {
      throw ArgumentError.notNull('comment.id');
    }
    if (article.id == null) {
      throw ArgumentError.notNull('article.id');
    }

    var $comment = comment.copyWith(articleId: article.id);
    await session.db.updateRow<Comment>(
      $comment,
      columns: [Comment.t.articleId],
      transaction: transaction,
    );
  }
}
