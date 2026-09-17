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

import 'package:serverpod/serverpod.dart' as _i1;

abstract class DashboardStats
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  DashboardStats._({
    required this.totalArticles,
    required this.publishedArticles,
    required this.draftArticles,
    required this.totalViews,
    required this.totalComments,
    required this.pendingComments,
    required this.totalCategories,
    required this.totalTags,
  });

  factory DashboardStats({
    required int totalArticles,
    required int publishedArticles,
    required int draftArticles,
    required int totalViews,
    required int totalComments,
    required int pendingComments,
    required int totalCategories,
    required int totalTags,
  }) = _DashboardStatsImpl;

  factory DashboardStats.fromJson(Map<String, dynamic> jsonSerialization) {
    return DashboardStats(
      totalArticles: jsonSerialization['totalArticles'] as int,
      publishedArticles: jsonSerialization['publishedArticles'] as int,
      draftArticles: jsonSerialization['draftArticles'] as int,
      totalViews: jsonSerialization['totalViews'] as int,
      totalComments: jsonSerialization['totalComments'] as int,
      pendingComments: jsonSerialization['pendingComments'] as int,
      totalCategories: jsonSerialization['totalCategories'] as int,
      totalTags: jsonSerialization['totalTags'] as int,
    );
  }

  int totalArticles;

  int publishedArticles;

  int draftArticles;

  int totalViews;

  int totalComments;

  int pendingComments;

  int totalCategories;

  int totalTags;

  /// Returns a shallow copy of this [DashboardStats]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DashboardStats copyWith({
    int? totalArticles,
    int? publishedArticles,
    int? draftArticles,
    int? totalViews,
    int? totalComments,
    int? pendingComments,
    int? totalCategories,
    int? totalTags,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DashboardStats',
      'totalArticles': totalArticles,
      'publishedArticles': publishedArticles,
      'draftArticles': draftArticles,
      'totalViews': totalViews,
      'totalComments': totalComments,
      'pendingComments': pendingComments,
      'totalCategories': totalCategories,
      'totalTags': totalTags,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DashboardStats',
      'totalArticles': totalArticles,
      'publishedArticles': publishedArticles,
      'draftArticles': draftArticles,
      'totalViews': totalViews,
      'totalComments': totalComments,
      'pendingComments': pendingComments,
      'totalCategories': totalCategories,
      'totalTags': totalTags,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _DashboardStatsImpl extends DashboardStats {
  _DashboardStatsImpl({
    required int totalArticles,
    required int publishedArticles,
    required int draftArticles,
    required int totalViews,
    required int totalComments,
    required int pendingComments,
    required int totalCategories,
    required int totalTags,
  }) : super._(
         totalArticles: totalArticles,
         publishedArticles: publishedArticles,
         draftArticles: draftArticles,
         totalViews: totalViews,
         totalComments: totalComments,
         pendingComments: pendingComments,
         totalCategories: totalCategories,
         totalTags: totalTags,
       );

  /// Returns a shallow copy of this [DashboardStats]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DashboardStats copyWith({
    int? totalArticles,
    int? publishedArticles,
    int? draftArticles,
    int? totalViews,
    int? totalComments,
    int? pendingComments,
    int? totalCategories,
    int? totalTags,
  }) {
    return DashboardStats(
      totalArticles: totalArticles ?? this.totalArticles,
      publishedArticles: publishedArticles ?? this.publishedArticles,
      draftArticles: draftArticles ?? this.draftArticles,
      totalViews: totalViews ?? this.totalViews,
      totalComments: totalComments ?? this.totalComments,
      pendingComments: pendingComments ?? this.pendingComments,
      totalCategories: totalCategories ?? this.totalCategories,
      totalTags: totalTags ?? this.totalTags,
    );
  }
}
