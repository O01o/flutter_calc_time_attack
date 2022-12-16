// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'issue_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

IssueData _$IssueDataFromJson(Map<String, dynamic> json) {
  return _IssueData.fromJson(json);
}

/// @nodoc
mixin _$IssueData {
  String get issue => throw _privateConstructorUsedError;
  String get formula => throw _privateConstructorUsedError;
  String get a => throw _privateConstructorUsedError;
  String get b => throw _privateConstructorUsedError;
  String get c => throw _privateConstructorUsedError;
  String get d => throw _privateConstructorUsedError;
  String get answer => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IssueDataCopyWith<IssueData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IssueDataCopyWith<$Res> {
  factory $IssueDataCopyWith(IssueData value, $Res Function(IssueData) then) =
      _$IssueDataCopyWithImpl<$Res, IssueData>;
  @useResult
  $Res call(
      {String issue,
      String formula,
      String a,
      String b,
      String c,
      String d,
      String answer});
}

/// @nodoc
class _$IssueDataCopyWithImpl<$Res, $Val extends IssueData>
    implements $IssueDataCopyWith<$Res> {
  _$IssueDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? issue = null,
    Object? formula = null,
    Object? a = null,
    Object? b = null,
    Object? c = null,
    Object? d = null,
    Object? answer = null,
  }) {
    return _then(_value.copyWith(
      issue: null == issue
          ? _value.issue
          : issue // ignore: cast_nullable_to_non_nullable
              as String,
      formula: null == formula
          ? _value.formula
          : formula // ignore: cast_nullable_to_non_nullable
              as String,
      a: null == a
          ? _value.a
          : a // ignore: cast_nullable_to_non_nullable
              as String,
      b: null == b
          ? _value.b
          : b // ignore: cast_nullable_to_non_nullable
              as String,
      c: null == c
          ? _value.c
          : c // ignore: cast_nullable_to_non_nullable
              as String,
      d: null == d
          ? _value.d
          : d // ignore: cast_nullable_to_non_nullable
              as String,
      answer: null == answer
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_IssueDataCopyWith<$Res> implements $IssueDataCopyWith<$Res> {
  factory _$$_IssueDataCopyWith(
          _$_IssueData value, $Res Function(_$_IssueData) then) =
      __$$_IssueDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String issue,
      String formula,
      String a,
      String b,
      String c,
      String d,
      String answer});
}

/// @nodoc
class __$$_IssueDataCopyWithImpl<$Res>
    extends _$IssueDataCopyWithImpl<$Res, _$_IssueData>
    implements _$$_IssueDataCopyWith<$Res> {
  __$$_IssueDataCopyWithImpl(
      _$_IssueData _value, $Res Function(_$_IssueData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? issue = null,
    Object? formula = null,
    Object? a = null,
    Object? b = null,
    Object? c = null,
    Object? d = null,
    Object? answer = null,
  }) {
    return _then(_$_IssueData(
      issue: null == issue
          ? _value.issue
          : issue // ignore: cast_nullable_to_non_nullable
              as String,
      formula: null == formula
          ? _value.formula
          : formula // ignore: cast_nullable_to_non_nullable
              as String,
      a: null == a
          ? _value.a
          : a // ignore: cast_nullable_to_non_nullable
              as String,
      b: null == b
          ? _value.b
          : b // ignore: cast_nullable_to_non_nullable
              as String,
      c: null == c
          ? _value.c
          : c // ignore: cast_nullable_to_non_nullable
              as String,
      d: null == d
          ? _value.d
          : d // ignore: cast_nullable_to_non_nullable
              as String,
      answer: null == answer
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_IssueData with DiagnosticableTreeMixin implements _IssueData {
  const _$_IssueData(
      {required this.issue,
      required this.formula,
      required this.a,
      required this.b,
      required this.c,
      required this.d,
      required this.answer});

  factory _$_IssueData.fromJson(Map<String, dynamic> json) =>
      _$$_IssueDataFromJson(json);

  @override
  final String issue;
  @override
  final String formula;
  @override
  final String a;
  @override
  final String b;
  @override
  final String c;
  @override
  final String d;
  @override
  final String answer;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'IssueData(issue: $issue, formula: $formula, a: $a, b: $b, c: $c, d: $d, answer: $answer)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'IssueData'))
      ..add(DiagnosticsProperty('issue', issue))
      ..add(DiagnosticsProperty('formula', formula))
      ..add(DiagnosticsProperty('a', a))
      ..add(DiagnosticsProperty('b', b))
      ..add(DiagnosticsProperty('c', c))
      ..add(DiagnosticsProperty('d', d))
      ..add(DiagnosticsProperty('answer', answer));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_IssueData &&
            (identical(other.issue, issue) || other.issue == issue) &&
            (identical(other.formula, formula) || other.formula == formula) &&
            (identical(other.a, a) || other.a == a) &&
            (identical(other.b, b) || other.b == b) &&
            (identical(other.c, c) || other.c == c) &&
            (identical(other.d, d) || other.d == d) &&
            (identical(other.answer, answer) || other.answer == answer));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, issue, formula, a, b, c, d, answer);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_IssueDataCopyWith<_$_IssueData> get copyWith =>
      __$$_IssueDataCopyWithImpl<_$_IssueData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_IssueDataToJson(
      this,
    );
  }
}

abstract class _IssueData implements IssueData {
  const factory _IssueData(
      {required final String issue,
      required final String formula,
      required final String a,
      required final String b,
      required final String c,
      required final String d,
      required final String answer}) = _$_IssueData;

  factory _IssueData.fromJson(Map<String, dynamic> json) =
      _$_IssueData.fromJson;

  @override
  String get issue;
  @override
  String get formula;
  @override
  String get a;
  @override
  String get b;
  @override
  String get c;
  @override
  String get d;
  @override
  String get answer;
  @override
  @JsonKey(ignore: true)
  _$$_IssueDataCopyWith<_$_IssueData> get copyWith =>
      throw _privateConstructorUsedError;
}
