// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issue_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_IssueData _$$_IssueDataFromJson(Map<String, dynamic> json) => _$_IssueData(
      issue: json['issue'] as String,
      formula: json['formula'] as String,
      a: json['a'] as String,
      b: json['b'] as String,
      c: json['c'] as String,
      d: json['d'] as String,
      answerIndex: json['answerIndex'] as int,
      yourAnswerIndex: json['yourAnswerIndex'] as int?,
    );

Map<String, dynamic> _$$_IssueDataToJson(_$_IssueData instance) =>
    <String, dynamic>{
      'issue': instance.issue,
      'formula': instance.formula,
      'a': instance.a,
      'b': instance.b,
      'c': instance.c,
      'd': instance.d,
      'answerIndex': instance.answerIndex,
      'yourAnswerIndex': instance.yourAnswerIndex,
    };
