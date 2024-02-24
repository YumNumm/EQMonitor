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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Comments _$CommentsFromJson(Map<String, dynamic> json) {
  return _Comments.fromJson(json);
}

/// @nodoc
mixin _$Comments {
  String? get free => throw _privateConstructorUsedError;
  ForecastComments? get forecast => throw _privateConstructorUsedError;
  @JsonValue('var')
  VarComments? get varComments => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CommentsCopyWith<Comments> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentsCopyWith<$Res> {
  factory $CommentsCopyWith(Comments value, $Res Function(Comments) then) =
      _$CommentsCopyWithImpl<$Res, Comments>;
  @useResult
  $Res call(
      {String? free,
      ForecastComments? forecast,
      @JsonValue('var') VarComments? varComments});

  $ForecastCommentsCopyWith<$Res>? get forecast;
  $VarCommentsCopyWith<$Res>? get varComments;
}

/// @nodoc
class _$CommentsCopyWithImpl<$Res, $Val extends Comments>
    implements $CommentsCopyWith<$Res> {
  _$CommentsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? free = freezed,
    Object? forecast = freezed,
    Object? varComments = freezed,
  }) {
    return _then(_value.copyWith(
      free: freezed == free
          ? _value.free
          : free // ignore: cast_nullable_to_non_nullable
              as String?,
      forecast: freezed == forecast
          ? _value.forecast
          : forecast // ignore: cast_nullable_to_non_nullable
              as ForecastComments?,
      varComments: freezed == varComments
          ? _value.varComments
          : varComments // ignore: cast_nullable_to_non_nullable
              as VarComments?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ForecastCommentsCopyWith<$Res>? get forecast {
    if (_value.forecast == null) {
      return null;
    }

    return $ForecastCommentsCopyWith<$Res>(_value.forecast!, (value) {
      return _then(_value.copyWith(forecast: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $VarCommentsCopyWith<$Res>? get varComments {
    if (_value.varComments == null) {
      return null;
    }

    return $VarCommentsCopyWith<$Res>(_value.varComments!, (value) {
      return _then(_value.copyWith(varComments: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CommentsImplCopyWith<$Res>
    implements $CommentsCopyWith<$Res> {
  factory _$$CommentsImplCopyWith(
          _$CommentsImpl value, $Res Function(_$CommentsImpl) then) =
      __$$CommentsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? free,
      ForecastComments? forecast,
      @JsonValue('var') VarComments? varComments});

  @override
  $ForecastCommentsCopyWith<$Res>? get forecast;
  @override
  $VarCommentsCopyWith<$Res>? get varComments;
}

/// @nodoc
class __$$CommentsImplCopyWithImpl<$Res>
    extends _$CommentsCopyWithImpl<$Res, _$CommentsImpl>
    implements _$$CommentsImplCopyWith<$Res> {
  __$$CommentsImplCopyWithImpl(
      _$CommentsImpl _value, $Res Function(_$CommentsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? free = freezed,
    Object? forecast = freezed,
    Object? varComments = freezed,
  }) {
    return _then(_$CommentsImpl(
      free: freezed == free
          ? _value.free
          : free // ignore: cast_nullable_to_non_nullable
              as String?,
      forecast: freezed == forecast
          ? _value.forecast
          : forecast // ignore: cast_nullable_to_non_nullable
              as ForecastComments?,
      varComments: freezed == varComments
          ? _value.varComments
          : varComments // ignore: cast_nullable_to_non_nullable
              as VarComments?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.none)
class _$CommentsImpl implements _Comments {
  const _$CommentsImpl(
      {required this.free,
      required this.forecast,
      @JsonValue('var') required this.varComments});

  factory _$CommentsImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommentsImplFromJson(json);

  @override
  final String? free;
  @override
  final ForecastComments? forecast;
  @override
  @JsonValue('var')
  final VarComments? varComments;

  @override
  String toString() {
    return 'Comments(free: $free, forecast: $forecast, varComments: $varComments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommentsImpl &&
            (identical(other.free, free) || other.free == free) &&
            (identical(other.forecast, forecast) ||
                other.forecast == forecast) &&
            (identical(other.varComments, varComments) ||
                other.varComments == varComments));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, free, forecast, varComments);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CommentsImplCopyWith<_$CommentsImpl> get copyWith =>
      __$$CommentsImplCopyWithImpl<_$CommentsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CommentsImplToJson(
      this,
    );
  }
}

abstract class _Comments implements Comments {
  const factory _Comments(
          {required final String? free,
          required final ForecastComments? forecast,
          @JsonValue('var') required final VarComments? varComments}) =
      _$CommentsImpl;

  factory _Comments.fromJson(Map<String, dynamic> json) =
      _$CommentsImpl.fromJson;

  @override
  String? get free;
  @override
  ForecastComments? get forecast;
  @override
  @JsonValue('var')
  VarComments? get varComments;
  @override
  @JsonKey(ignore: true)
  _$$CommentsImplCopyWith<_$CommentsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CommentsOmitVar _$CommentsOmitVarFromJson(Map<String, dynamic> json) {
  return _CommentsOmitVar.fromJson(json);
}

/// @nodoc
mixin _$CommentsOmitVar {
  String? get free => throw _privateConstructorUsedError;
  ForecastComments? get forecast => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CommentsOmitVarCopyWith<CommentsOmitVar> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentsOmitVarCopyWith<$Res> {
  factory $CommentsOmitVarCopyWith(
          CommentsOmitVar value, $Res Function(CommentsOmitVar) then) =
      _$CommentsOmitVarCopyWithImpl<$Res, CommentsOmitVar>;
  @useResult
  $Res call({String? free, ForecastComments? forecast});

  $ForecastCommentsCopyWith<$Res>? get forecast;
}

/// @nodoc
class _$CommentsOmitVarCopyWithImpl<$Res, $Val extends CommentsOmitVar>
    implements $CommentsOmitVarCopyWith<$Res> {
  _$CommentsOmitVarCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? free = freezed,
    Object? forecast = freezed,
  }) {
    return _then(_value.copyWith(
      free: freezed == free
          ? _value.free
          : free // ignore: cast_nullable_to_non_nullable
              as String?,
      forecast: freezed == forecast
          ? _value.forecast
          : forecast // ignore: cast_nullable_to_non_nullable
              as ForecastComments?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ForecastCommentsCopyWith<$Res>? get forecast {
    if (_value.forecast == null) {
      return null;
    }

    return $ForecastCommentsCopyWith<$Res>(_value.forecast!, (value) {
      return _then(_value.copyWith(forecast: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CommentsOmitVarImplCopyWith<$Res>
    implements $CommentsOmitVarCopyWith<$Res> {
  factory _$$CommentsOmitVarImplCopyWith(_$CommentsOmitVarImpl value,
          $Res Function(_$CommentsOmitVarImpl) then) =
      __$$CommentsOmitVarImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? free, ForecastComments? forecast});

  @override
  $ForecastCommentsCopyWith<$Res>? get forecast;
}

/// @nodoc
class __$$CommentsOmitVarImplCopyWithImpl<$Res>
    extends _$CommentsOmitVarCopyWithImpl<$Res, _$CommentsOmitVarImpl>
    implements _$$CommentsOmitVarImplCopyWith<$Res> {
  __$$CommentsOmitVarImplCopyWithImpl(
      _$CommentsOmitVarImpl _value, $Res Function(_$CommentsOmitVarImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? free = freezed,
    Object? forecast = freezed,
  }) {
    return _then(_$CommentsOmitVarImpl(
      free: freezed == free
          ? _value.free
          : free // ignore: cast_nullable_to_non_nullable
              as String?,
      forecast: freezed == forecast
          ? _value.forecast
          : forecast // ignore: cast_nullable_to_non_nullable
              as ForecastComments?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.none)
class _$CommentsOmitVarImpl implements _CommentsOmitVar {
  const _$CommentsOmitVarImpl({required this.free, required this.forecast});

  factory _$CommentsOmitVarImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommentsOmitVarImplFromJson(json);

  @override
  final String? free;
  @override
  final ForecastComments? forecast;

  @override
  String toString() {
    return 'CommentsOmitVar(free: $free, forecast: $forecast)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommentsOmitVarImpl &&
            (identical(other.free, free) || other.free == free) &&
            (identical(other.forecast, forecast) ||
                other.forecast == forecast));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, free, forecast);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CommentsOmitVarImplCopyWith<_$CommentsOmitVarImpl> get copyWith =>
      __$$CommentsOmitVarImplCopyWithImpl<_$CommentsOmitVarImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CommentsOmitVarImplToJson(
      this,
    );
  }
}

abstract class _CommentsOmitVar implements CommentsOmitVar {
  const factory _CommentsOmitVar(
      {required final String? free,
      required final ForecastComments? forecast}) = _$CommentsOmitVarImpl;

  factory _CommentsOmitVar.fromJson(Map<String, dynamic> json) =
      _$CommentsOmitVarImpl.fromJson;

  @override
  String? get free;
  @override
  ForecastComments? get forecast;
  @override
  @JsonKey(ignore: true)
  _$$CommentsOmitVarImplCopyWith<_$CommentsOmitVarImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ForecastComments _$ForecastCommentsFromJson(Map<String, dynamic> json) {
  return _ForecastComments.fromJson(json);
}

/// @nodoc
mixin _$ForecastComments {
  String get text => throw _privateConstructorUsedError;
  List<String> get codes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ForecastCommentsCopyWith<ForecastComments> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ForecastCommentsCopyWith<$Res> {
  factory $ForecastCommentsCopyWith(
          ForecastComments value, $Res Function(ForecastComments) then) =
      _$ForecastCommentsCopyWithImpl<$Res, ForecastComments>;
  @useResult
  $Res call({String text, List<String> codes});
}

/// @nodoc
class _$ForecastCommentsCopyWithImpl<$Res, $Val extends ForecastComments>
    implements $ForecastCommentsCopyWith<$Res> {
  _$ForecastCommentsCopyWithImpl(this._value, this._then);

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
abstract class _$$ForecastCommentsImplCopyWith<$Res>
    implements $ForecastCommentsCopyWith<$Res> {
  factory _$$ForecastCommentsImplCopyWith(_$ForecastCommentsImpl value,
          $Res Function(_$ForecastCommentsImpl) then) =
      __$$ForecastCommentsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String text, List<String> codes});
}

/// @nodoc
class __$$ForecastCommentsImplCopyWithImpl<$Res>
    extends _$ForecastCommentsCopyWithImpl<$Res, _$ForecastCommentsImpl>
    implements _$$ForecastCommentsImplCopyWith<$Res> {
  __$$ForecastCommentsImplCopyWithImpl(_$ForecastCommentsImpl _value,
      $Res Function(_$ForecastCommentsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? codes = null,
  }) {
    return _then(_$ForecastCommentsImpl(
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

@JsonSerializable(fieldRename: FieldRename.none)
class _$ForecastCommentsImpl implements _ForecastComments {
  const _$ForecastCommentsImpl(
      {required this.text, required final List<String> codes})
      : _codes = codes;

  factory _$ForecastCommentsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ForecastCommentsImplFromJson(json);

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
    return 'ForecastComments(text: $text, codes: $codes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ForecastCommentsImpl &&
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
  _$$ForecastCommentsImplCopyWith<_$ForecastCommentsImpl> get copyWith =>
      __$$ForecastCommentsImplCopyWithImpl<_$ForecastCommentsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ForecastCommentsImplToJson(
      this,
    );
  }
}

abstract class _ForecastComments implements ForecastComments {
  const factory _ForecastComments(
      {required final String text,
      required final List<String> codes}) = _$ForecastCommentsImpl;

  factory _ForecastComments.fromJson(Map<String, dynamic> json) =
      _$ForecastCommentsImpl.fromJson;

  @override
  String get text;
  @override
  List<String> get codes;
  @override
  @JsonKey(ignore: true)
  _$$ForecastCommentsImplCopyWith<_$ForecastCommentsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

VarComments _$VarCommentsFromJson(Map<String, dynamic> json) {
  return _VarComments.fromJson(json);
}

/// @nodoc
mixin _$VarComments {
  String get text => throw _privateConstructorUsedError;
  List<String> get codes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VarCommentsCopyWith<VarComments> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VarCommentsCopyWith<$Res> {
  factory $VarCommentsCopyWith(
          VarComments value, $Res Function(VarComments) then) =
      _$VarCommentsCopyWithImpl<$Res, VarComments>;
  @useResult
  $Res call({String text, List<String> codes});
}

/// @nodoc
class _$VarCommentsCopyWithImpl<$Res, $Val extends VarComments>
    implements $VarCommentsCopyWith<$Res> {
  _$VarCommentsCopyWithImpl(this._value, this._then);

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
abstract class _$$VarCommentsImplCopyWith<$Res>
    implements $VarCommentsCopyWith<$Res> {
  factory _$$VarCommentsImplCopyWith(
          _$VarCommentsImpl value, $Res Function(_$VarCommentsImpl) then) =
      __$$VarCommentsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String text, List<String> codes});
}

/// @nodoc
class __$$VarCommentsImplCopyWithImpl<$Res>
    extends _$VarCommentsCopyWithImpl<$Res, _$VarCommentsImpl>
    implements _$$VarCommentsImplCopyWith<$Res> {
  __$$VarCommentsImplCopyWithImpl(
      _$VarCommentsImpl _value, $Res Function(_$VarCommentsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? codes = null,
  }) {
    return _then(_$VarCommentsImpl(
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

@JsonSerializable(fieldRename: FieldRename.none)
class _$VarCommentsImpl implements _VarComments {
  const _$VarCommentsImpl(
      {required this.text, required final List<String> codes})
      : _codes = codes;

  factory _$VarCommentsImpl.fromJson(Map<String, dynamic> json) =>
      _$$VarCommentsImplFromJson(json);

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
    return 'VarComments(text: $text, codes: $codes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VarCommentsImpl &&
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
  _$$VarCommentsImplCopyWith<_$VarCommentsImpl> get copyWith =>
      __$$VarCommentsImplCopyWithImpl<_$VarCommentsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VarCommentsImplToJson(
      this,
    );
  }
}

abstract class _VarComments implements VarComments {
  const factory _VarComments(
      {required final String text,
      required final List<String> codes}) = _$VarCommentsImpl;

  factory _VarComments.fromJson(Map<String, dynamic> json) =
      _$VarCommentsImpl.fromJson;

  @override
  String get text;
  @override
  List<String> get codes;
  @override
  @JsonKey(ignore: true)
  _$$VarCommentsImplCopyWith<_$VarCommentsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CommentsOnlyFree _$CommentsOnlyFreeFromJson(Map<String, dynamic> json) {
  return _CommentsOnlyFree.fromJson(json);
}

/// @nodoc
mixin _$CommentsOnlyFree {
  String get free => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CommentsOnlyFreeCopyWith<CommentsOnlyFree> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentsOnlyFreeCopyWith<$Res> {
  factory $CommentsOnlyFreeCopyWith(
          CommentsOnlyFree value, $Res Function(CommentsOnlyFree) then) =
      _$CommentsOnlyFreeCopyWithImpl<$Res, CommentsOnlyFree>;
  @useResult
  $Res call({String free});
}

/// @nodoc
class _$CommentsOnlyFreeCopyWithImpl<$Res, $Val extends CommentsOnlyFree>
    implements $CommentsOnlyFreeCopyWith<$Res> {
  _$CommentsOnlyFreeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? free = null,
  }) {
    return _then(_value.copyWith(
      free: null == free
          ? _value.free
          : free // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CommentsOnlyFreeImplCopyWith<$Res>
    implements $CommentsOnlyFreeCopyWith<$Res> {
  factory _$$CommentsOnlyFreeImplCopyWith(_$CommentsOnlyFreeImpl value,
          $Res Function(_$CommentsOnlyFreeImpl) then) =
      __$$CommentsOnlyFreeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String free});
}

/// @nodoc
class __$$CommentsOnlyFreeImplCopyWithImpl<$Res>
    extends _$CommentsOnlyFreeCopyWithImpl<$Res, _$CommentsOnlyFreeImpl>
    implements _$$CommentsOnlyFreeImplCopyWith<$Res> {
  __$$CommentsOnlyFreeImplCopyWithImpl(_$CommentsOnlyFreeImpl _value,
      $Res Function(_$CommentsOnlyFreeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? free = null,
  }) {
    return _then(_$CommentsOnlyFreeImpl(
      free: null == free
          ? _value.free
          : free // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.none)
class _$CommentsOnlyFreeImpl implements _CommentsOnlyFree {
  const _$CommentsOnlyFreeImpl({required this.free});

  factory _$CommentsOnlyFreeImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommentsOnlyFreeImplFromJson(json);

  @override
  final String free;

  @override
  String toString() {
    return 'CommentsOnlyFree(free: $free)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommentsOnlyFreeImpl &&
            (identical(other.free, free) || other.free == free));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, free);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CommentsOnlyFreeImplCopyWith<_$CommentsOnlyFreeImpl> get copyWith =>
      __$$CommentsOnlyFreeImplCopyWithImpl<_$CommentsOnlyFreeImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CommentsOnlyFreeImplToJson(
      this,
    );
  }
}

abstract class _CommentsOnlyFree implements CommentsOnlyFree {
  const factory _CommentsOnlyFree({required final String free}) =
      _$CommentsOnlyFreeImpl;

  factory _CommentsOnlyFree.fromJson(Map<String, dynamic> json) =
      _$CommentsOnlyFreeImpl.fromJson;

  @override
  String get free;
  @override
  @JsonKey(ignore: true)
  _$$CommentsOnlyFreeImplCopyWith<_$CommentsOnlyFreeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
