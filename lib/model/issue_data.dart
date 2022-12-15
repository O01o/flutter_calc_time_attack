// This file is "main.dart"
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'issue_data.freezed.dart';
part 'issue_data.g.dart';

@freezed
class IssueData with _$IssueData {
  const factory IssueData({
    required String formula,
  }) = _IssueData;

  factory IssueData.fromJson(Map<String, Object?> json)
      => _$IssueDataFromJson(json);
}