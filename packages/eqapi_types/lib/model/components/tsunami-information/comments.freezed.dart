// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comments.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TsunamiComments _$TsunamiCommentsFromJson(Map<String, dynamic> json) {
  return _TsunamiComments.fromJson(json);
}

/// @nodoc
mixin _$TsunamiComments {
  String? get free => throw _privateConstructorUsedError;
  TsunamiForecastCommentWarning? get warning =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TsunamiCommentsCopyWith<TsunamiComments> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TsunamiCommentsCopyWith<$Res> {
  factory $TsunamiCommentsCopyWith(
          TsunamiComments value, $Res Function(TsunamiComments) then) =
      _$TsunamiCommentsCopyWithImpl<$Res, TsunamiComments>;
  @useResult
  $Res call({String? free, TsunamiForecastCommentWarning? warning});

  $TsunamiForecastCommentWarningCopyWith<$Res>? get warning;
}

/// @nodoc
class _$TsunamiCommentsCopyWithImpl<$Res, $Val extends TsunamiComments>
    implements $TsunamiCommentsCopyWith<$Res> {
  _$TsunamiCommentsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? free = freezed,
    Object? warning = freezed,
  }) {
    return _then(_value.copyWith(
      free: freezed == free
          ? _value.free
          : free // ignore: cast_nullable_to_non_nullable
              as String?,
      warning: freezed == warning
          ? _value.warning
          : warning // ignore: cast_nullable_to_non_nullable
              as TsunamiForecastCommentWarning?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TsunamiForecastCommentWarningCopyWith<$Res>? get warning {
    if (_value.warning == null) {
      return null;
    }

    return $TsunamiForecastCommentWarningCopyWith<$Res>(_value.warning!,
        (value) {
      return _then(_value.copyWith(warning: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TsunamiCommentsImplCopyWith<$Res>
    implements $TsunamiCommentsCopyWith<$Res> {
  factory _$$TsunamiCommentsImplCopyWith(_$TsunamiCommentsImpl value,
          $Res Function(_$TsunamiCommentsImpl) then) =
      __$$TsunamiCommentsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? free, TsunamiForecastCommentWarning? warning});

  @override
  $TsunamiForecastCommentWarningCopyWith<$Res>? get warning;
}

/// @nodoc
class __$$TsunamiCommentsImplCopyWithImpl<$Res>
    extends _$TsunamiCommentsCopyWithImpl<$Res, _$TsunamiCommentsImpl>
    implements _$$TsunamiCommentsImplCopyWith<$Res> {
  __$$TsunamiCommentsImplCopyWithImpl(
      _$TsunamiCommentsImpl _value, $Res Function(_$TsunamiCommentsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? free = freezed,
    Object? warning = freezed,
  }) {
    return _then(_$TsunamiCommentsImpl(
      free: freezed == free
          ? _value.free
          : free // ignore: cast_nullable_to_non_nullable
              as String?,
      warning: freezed == warning
          ? _value.warning
          : warning // ignore: cast_nullable_to_non_nullable
              as TsunamiForecastCommentWarning?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TsunamiCommentsImpl implements _TsunamiComments {
  const _$TsunamiCommentsImpl({required this.free, required this.warning});

  factory _$TsunamiCommentsImpl.fromJson(Map<String, dynamic> json) =>
      _$$TsunamiCommentsImplFromJson(json);

  @override
  final String? free;
  @override
  final TsunamiForecastCommentWarning? warning;

  @override
  String toString() {
    return 'TsunamiComments(free: $free, warning: $warning)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TsunamiCommentsImpl &&
            (identical(other.free, free) || other.free == free) &&
            (identical(other.warning, warning) || other.warning == warning));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, free, warning);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TsunamiCommentsImplCopyWith<_$TsunamiCommentsImpl> get copyWith =>
      __$$TsunamiCommentsImplCopyWithImpl<_$TsunamiCommentsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TsunamiCommentsImplToJson(
      this,
    );
  }
}

abstract class _TsunamiComments implements TsunamiComments {
  const factory _TsunamiComments(
          {required final String? free,
          required final TsunamiForecastCommentWarning? warning}) =
      _$TsunamiCommentsImpl;

  factory _TsunamiComments.fromJson(Map<String, dynamic> json) =
      _$TsunamiCommentsImpl.fromJson;

  @override
  String? get free;
  @override
  TsunamiForecastCommentWarning? get warning;
  @override
  @JsonKey(ignore: true)
  _$$TsunamiCommentsImplCopyWith<_$TsunamiCommentsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TsunamiForecastCommentWarning _$TsunamiForecastCommentWarningFromJson(
    Map<String, dynamic> json) {
  return _TsunamiForecastCommentWarning.fromJson(json);
}

/// @nodoc
mixin _$TsunamiForecastCommentWarning {
  String get text => throw _privateConstructorUsedError;
  List<String> get codes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TsunamiForecastCommentWarningCopyWith<TsunamiForecastCommentWarning>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TsunamiForecastCommentWarningCopyWith<$Res> {
  factory $TsunamiForecastCommentWarningCopyWith(
          TsunamiForecastCommentWarning value,
          $Res Function(TsunamiForecastCommentWarning) then) =
      _$TsunamiForecastCommentWarningCopyWithImpl<$Res,
          TsunamiForecastCommentWarning>;
  @useResult
  $Res call({String text, List<String> codes});
}

/// @nodoc
class _$TsunamiForecastCommentWarningCopyWithImpl<$Res,
        $Val extends TsunamiForecastCommentWarning>
    implements $TsunamiForecastCommentWarningCopyWith<$Res> {
  _$TsunamiForecastCommentWarningCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? codes = null,
  }) {
    return _then(_value.copyWith(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      codes: null == codes
          ? _value.codes
          : codes // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TsunamiForecastCommentWarningImplCopyWith<$Res>
    implements $TsunamiForecastCommentWarningCopyWith<$Res> {
  factory _$$TsunamiForecastCommentWarningImplCopyWith(
          _$TsunamiForecastCommentWarningImpl value,
          $Res Function(_$TsunamiForecastCommentWarningImpl) then) =
      __$$TsunamiForecastCommentWarningImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String text, List<String> codes});
}

/// @nodoc
class __$$TsunamiForecastCommentWarningImplCopyWithImpl<$Res>
    extends _$TsunamiForecastCommentWarningCopyWithImpl<$Res,
        _$TsunamiForecastCommentWarningImpl>
    implements _$$TsunamiForecastCommentWarningImplCopyWith<$Res> {
  __$$TsunamiForecastCommentWarningImplCopyWithImpl(
      _$TsunamiForecastCommentWarningImpl _value,
      $Res Function(_$TsunamiForecastCommentWarningImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? codes = null,
  }) {
    return _then(_$TsunamiForecastCommentWarningImpl(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      codes: null == codes
          ? _value._codes
          : codes // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TsunamiForecastCommentWarningImpl
    implements _TsunamiForecastCommentWarning {
  const _$TsunamiForecastCommentWarningImpl(
      {required this.text, required final List<String> codes})
      : _codes = codes;

  factory _$TsunamiForecastCommentWarningImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$TsunamiForecastCommentWarningImplFromJson(json);

  @override
  final String text;
  final List<String> _codes;
  @override
  List<String> get codes {
    if (_codes is EqualUnmodifiableListView) return _codes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_codes);
  }

  @override
  String toString() {
    return 'TsunamiForecastCommentWarning(text: $text, codes: $codes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TsunamiForecastCommentWarningImpl &&
            (identical(other.text, text) || other.text == text) &&
            const DeepCollectionEquality().equals(other._codes, _codes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, text, const DeepCollectionEquality().hash(_codes));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TsunamiForecastCommentWarningImplCopyWith<
          _$TsunamiForecastCommentWarningImpl>
      get copyWith => __$$TsunamiForecastCommentWarningImplCopyWithImpl<
          _$TsunamiForecastCommentWarningImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TsunamiForecastCommentWarningImplToJson(
      this,
    );
  }
}

abstract class _TsunamiForecastCommentWarning
    implements TsunamiForecastCommentWarning {
  const factory _TsunamiForecastCommentWarning(
      {required final String text,
      required final List<String> codes}) = _$TsunamiForecastCommentWarningImpl;

  factory _TsunamiForecastCommentWarning.fromJson(Map<String, dynamic> json) =
      _$TsunamiForecastCommentWarningImpl.fromJson;

  @override
  String get text;
  @override
  List<String> get codes;
  @override
  @JsonKey(ignore: true)
  _$$TsunamiForecastCommentWarningImplCopyWith<
          _$TsunamiForecastCommentWarningImpl>
      get copyWith => throw _privateConstructorUsedError;
}
