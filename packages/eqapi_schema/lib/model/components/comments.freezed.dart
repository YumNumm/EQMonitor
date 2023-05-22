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
abstract class _$$_CommentsCopyWith<$Res> implements $CommentsCopyWith<$Res> {
  factory _$$_CommentsCopyWith(
          _$_Comments value, $Res Function(_$_Comments) then) =
      __$$_CommentsCopyWithImpl<$Res>;
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
class __$$_CommentsCopyWithImpl<$Res>
    extends _$CommentsCopyWithImpl<$Res, _$_Comments>
    implements _$$_CommentsCopyWith<$Res> {
  __$$_CommentsCopyWithImpl(
      _$_Comments _value, $Res Function(_$_Comments) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? free = freezed,
    Object? forecast = freezed,
    Object? varComments = freezed,
  }) {
    return _then(_$_Comments(
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
@JsonSerializable()
class _$_Comments implements _Comments {
  const _$_Comments(
      {required this.free,
      required this.forecast,
      @JsonValue('var') required this.varComments});

  factory _$_Comments.fromJson(Map<String, dynamic> json) =>
      _$$_CommentsFromJson(json);

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Comments &&
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
  _$$_CommentsCopyWith<_$_Comments> get copyWith =>
      __$$_CommentsCopyWithImpl<_$_Comments>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CommentsToJson(
      this,
    );
  }
}

abstract class _Comments implements Comments {
  const factory _Comments(
      {required final String? free,
      required final ForecastComments? forecast,
      @JsonValue('var') required final VarComments? varComments}) = _$_Comments;

  factory _Comments.fromJson(Map<String, dynamic> json) = _$_Comments.fromJson;

  @override
  String? get free;
  @override
  ForecastComments? get forecast;
  @override
  @JsonValue('var')
  VarComments? get varComments;
  @override
  @JsonKey(ignore: true)
  _$$_CommentsCopyWith<_$_Comments> get copyWith =>
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
abstract class _$$_CommentsOmitVarCopyWith<$Res>
    implements $CommentsOmitVarCopyWith<$Res> {
  factory _$$_CommentsOmitVarCopyWith(
          _$_CommentsOmitVar value, $Res Function(_$_CommentsOmitVar) then) =
      __$$_CommentsOmitVarCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? free, ForecastComments? forecast});

  @override
  $ForecastCommentsCopyWith<$Res>? get forecast;
}

/// @nodoc
class __$$_CommentsOmitVarCopyWithImpl<$Res>
    extends _$CommentsOmitVarCopyWithImpl<$Res, _$_CommentsOmitVar>
    implements _$$_CommentsOmitVarCopyWith<$Res> {
  __$$_CommentsOmitVarCopyWithImpl(
      _$_CommentsOmitVar _value, $Res Function(_$_CommentsOmitVar) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? free = freezed,
    Object? forecast = freezed,
  }) {
    return _then(_$_CommentsOmitVar(
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
@JsonSerializable()
class _$_CommentsOmitVar implements _CommentsOmitVar {
  const _$_CommentsOmitVar({required this.free, required this.forecast});

  factory _$_CommentsOmitVar.fromJson(Map<String, dynamic> json) =>
      _$$_CommentsOmitVarFromJson(json);

  @override
  final String? free;
  @override
  final ForecastComments? forecast;

  @override
  String toString() {
    return 'CommentsOmitVar(free: $free, forecast: $forecast)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CommentsOmitVar &&
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
  _$$_CommentsOmitVarCopyWith<_$_CommentsOmitVar> get copyWith =>
      __$$_CommentsOmitVarCopyWithImpl<_$_CommentsOmitVar>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CommentsOmitVarToJson(
      this,
    );
  }
}

abstract class _CommentsOmitVar implements CommentsOmitVar {
  const factory _CommentsOmitVar(
      {required final String? free,
      required final ForecastComments? forecast}) = _$_CommentsOmitVar;

  factory _CommentsOmitVar.fromJson(Map<String, dynamic> json) =
      _$_CommentsOmitVar.fromJson;

  @override
  String? get free;
  @override
  ForecastComments? get forecast;
  @override
  @JsonKey(ignore: true)
  _$$_CommentsOmitVarCopyWith<_$_CommentsOmitVar> get copyWith =>
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
abstract class _$$_ForecastCommentsCopyWith<$Res>
    implements $ForecastCommentsCopyWith<$Res> {
  factory _$$_ForecastCommentsCopyWith(
          _$_ForecastComments value, $Res Function(_$_ForecastComments) then) =
      __$$_ForecastCommentsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String text, List<String> codes});
}

/// @nodoc
class __$$_ForecastCommentsCopyWithImpl<$Res>
    extends _$ForecastCommentsCopyWithImpl<$Res, _$_ForecastComments>
    implements _$$_ForecastCommentsCopyWith<$Res> {
  __$$_ForecastCommentsCopyWithImpl(
      _$_ForecastComments _value, $Res Function(_$_ForecastComments) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? codes = null,
  }) {
    return _then(_$_ForecastComments(
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
class _$_ForecastComments implements _ForecastComments {
  const _$_ForecastComments(
      {required this.text, required final List<String> codes})
      : _codes = codes;

  factory _$_ForecastComments.fromJson(Map<String, dynamic> json) =>
      _$$_ForecastCommentsFromJson(json);

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ForecastComments &&
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
  _$$_ForecastCommentsCopyWith<_$_ForecastComments> get copyWith =>
      __$$_ForecastCommentsCopyWithImpl<_$_ForecastComments>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ForecastCommentsToJson(
      this,
    );
  }
}

abstract class _ForecastComments implements ForecastComments {
  const factory _ForecastComments(
      {required final String text,
      required final List<String> codes}) = _$_ForecastComments;

  factory _ForecastComments.fromJson(Map<String, dynamic> json) =
      _$_ForecastComments.fromJson;

  @override
  String get text;
  @override
  List<String> get codes;
  @override
  @JsonKey(ignore: true)
  _$$_ForecastCommentsCopyWith<_$_ForecastComments> get copyWith =>
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
abstract class _$$_VarCommentsCopyWith<$Res>
    implements $VarCommentsCopyWith<$Res> {
  factory _$$_VarCommentsCopyWith(
          _$_VarComments value, $Res Function(_$_VarComments) then) =
      __$$_VarCommentsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String text, List<String> codes});
}

/// @nodoc
class __$$_VarCommentsCopyWithImpl<$Res>
    extends _$VarCommentsCopyWithImpl<$Res, _$_VarComments>
    implements _$$_VarCommentsCopyWith<$Res> {
  __$$_VarCommentsCopyWithImpl(
      _$_VarComments _value, $Res Function(_$_VarComments) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? codes = null,
  }) {
    return _then(_$_VarComments(
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
class _$_VarComments implements _VarComments {
  const _$_VarComments({required this.text, required final List<String> codes})
      : _codes = codes;

  factory _$_VarComments.fromJson(Map<String, dynamic> json) =>
      _$$_VarCommentsFromJson(json);

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_VarComments &&
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
  _$$_VarCommentsCopyWith<_$_VarComments> get copyWith =>
      __$$_VarCommentsCopyWithImpl<_$_VarComments>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_VarCommentsToJson(
      this,
    );
  }
}

abstract class _VarComments implements VarComments {
  const factory _VarComments(
      {required final String text,
      required final List<String> codes}) = _$_VarComments;

  factory _VarComments.fromJson(Map<String, dynamic> json) =
      _$_VarComments.fromJson;

  @override
  String get text;
  @override
  List<String> get codes;
  @override
  @JsonKey(ignore: true)
  _$$_VarCommentsCopyWith<_$_VarComments> get copyWith =>
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
abstract class _$$_CommentsOnlyFreeCopyWith<$Res>
    implements $CommentsOnlyFreeCopyWith<$Res> {
  factory _$$_CommentsOnlyFreeCopyWith(
          _$_CommentsOnlyFree value, $Res Function(_$_CommentsOnlyFree) then) =
      __$$_CommentsOnlyFreeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String free});
}

/// @nodoc
class __$$_CommentsOnlyFreeCopyWithImpl<$Res>
    extends _$CommentsOnlyFreeCopyWithImpl<$Res, _$_CommentsOnlyFree>
    implements _$$_CommentsOnlyFreeCopyWith<$Res> {
  __$$_CommentsOnlyFreeCopyWithImpl(
      _$_CommentsOnlyFree _value, $Res Function(_$_CommentsOnlyFree) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? free = null,
  }) {
    return _then(_$_CommentsOnlyFree(
      free: null == free
          ? _value.free
          : free // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CommentsOnlyFree implements _CommentsOnlyFree {
  const _$_CommentsOnlyFree({required this.free});

  factory _$_CommentsOnlyFree.fromJson(Map<String, dynamic> json) =>
      _$$_CommentsOnlyFreeFromJson(json);

  @override
  final String free;

  @override
  String toString() {
    return 'CommentsOnlyFree(free: $free)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CommentsOnlyFree &&
            (identical(other.free, free) || other.free == free));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, free);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CommentsOnlyFreeCopyWith<_$_CommentsOnlyFree> get copyWith =>
      __$$_CommentsOnlyFreeCopyWithImpl<_$_CommentsOnlyFree>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CommentsOnlyFreeToJson(
      this,
    );
  }
}

abstract class _CommentsOnlyFree implements CommentsOnlyFree {
  const factory _CommentsOnlyFree({required final String free}) =
      _$_CommentsOnlyFree;

  factory _CommentsOnlyFree.fromJson(Map<String, dynamic> json) =
      _$_CommentsOnlyFree.fromJson;

  @override
  String get free;
  @override
  @JsonKey(ignore: true)
  _$$_CommentsOnlyFreeCopyWith<_$_CommentsOnlyFree> get copyWith =>
      throw _privateConstructorUsedError;
}
