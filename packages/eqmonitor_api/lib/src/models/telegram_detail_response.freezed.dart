// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'telegram_detail_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TelegramDetailResponse {

 TelegramDetail get telegram;@JsonKey(includeIfNull: true) TelegramComments? get comments;
/// Create a copy of TelegramDetailResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TelegramDetailResponseCopyWith<TelegramDetailResponse> get copyWith => _$TelegramDetailResponseCopyWithImpl<TelegramDetailResponse>(this as TelegramDetailResponse, _$identity);

  /// Serializes this TelegramDetailResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TelegramDetailResponse&&(identical(other.telegram, telegram) || other.telegram == telegram)&&(identical(other.comments, comments) || other.comments == comments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,telegram,comments);

@override
String toString() {
  return 'TelegramDetailResponse(telegram: $telegram, comments: $comments)';
}


}

/// @nodoc
abstract mixin class $TelegramDetailResponseCopyWith<$Res>  {
  factory $TelegramDetailResponseCopyWith(TelegramDetailResponse value, $Res Function(TelegramDetailResponse) _then) = _$TelegramDetailResponseCopyWithImpl;
@useResult
$Res call({
 TelegramDetail telegram,@JsonKey(includeIfNull: true) TelegramComments? comments
});


$TelegramDetailCopyWith<$Res> get telegram;$TelegramCommentsCopyWith<$Res>? get comments;

}
/// @nodoc
class _$TelegramDetailResponseCopyWithImpl<$Res>
    implements $TelegramDetailResponseCopyWith<$Res> {
  _$TelegramDetailResponseCopyWithImpl(this._self, this._then);

  final TelegramDetailResponse _self;
  final $Res Function(TelegramDetailResponse) _then;

/// Create a copy of TelegramDetailResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? telegram = null,Object? comments = freezed,}) {
  return _then(TelegramDetailResponse(
telegram: null == telegram ? _self.telegram : telegram // ignore: cast_nullable_to_non_nullable
as TelegramDetail,comments: freezed == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as TelegramComments?,
  ));
}
/// Create a copy of TelegramDetailResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TelegramDetailCopyWith<$Res> get telegram {
  
  return $TelegramDetailCopyWith<$Res>(_self.telegram, (value) {
    return _then(_self.copyWith(telegram: value));
  });
}/// Create a copy of TelegramDetailResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TelegramCommentsCopyWith<$Res>? get comments {
    if (_self.comments == null) {
    return null;
  }

  return $TelegramCommentsCopyWith<$Res>(_self.comments!, (value) {
    return _then(_self.copyWith(comments: value));
  });
}
}


/// Adds pattern-matching-related methods to [TelegramDetailResponse].
extension TelegramDetailResponsePatterns on TelegramDetailResponse {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TelegramDetailResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TelegramDetailResponse() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TelegramDetailResponse value)  $default,){
final _that = this;
switch (_that) {
case _TelegramDetailResponse():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TelegramDetailResponse value)?  $default,){
final _that = this;
switch (_that) {
case _TelegramDetailResponse() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TelegramDetail telegram, @JsonKey(includeIfNull: true)  TelegramComments? comments)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TelegramDetailResponse() when $default != null:
return $default(_that.telegram,_that.comments);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TelegramDetail telegram, @JsonKey(includeIfNull: true)  TelegramComments? comments)  $default,) {final _that = this;
switch (_that) {
case _TelegramDetailResponse():
return $default(_that.telegram,_that.comments);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TelegramDetail telegram, @JsonKey(includeIfNull: true)  TelegramComments? comments)?  $default,) {final _that = this;
switch (_that) {
case _TelegramDetailResponse() when $default != null:
return $default(_that.telegram,_that.comments);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TelegramDetailResponse implements TelegramDetailResponse {
  const _TelegramDetailResponse({required this.telegram, @JsonKey(includeIfNull: true) required this.comments});
  factory _TelegramDetailResponse.fromJson(Map<String, dynamic> json) => _$TelegramDetailResponseFromJson(json);

@override final  TelegramDetail telegram;
@override@JsonKey(includeIfNull: true) final  TelegramComments? comments;

/// Create a copy of TelegramDetailResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TelegramDetailResponseCopyWith<_TelegramDetailResponse> get copyWith => __$TelegramDetailResponseCopyWithImpl<_TelegramDetailResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TelegramDetailResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TelegramDetailResponse&&(identical(other.telegram, telegram) || other.telegram == telegram)&&(identical(other.comments, comments) || other.comments == comments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,telegram,comments);

@override
String toString() {
  return 'TelegramDetailResponse(telegram: $telegram, comments: $comments)';
}


}

/// @nodoc
abstract mixin class _$TelegramDetailResponseCopyWith<$Res> implements $TelegramDetailResponseCopyWith<$Res> {
  factory _$TelegramDetailResponseCopyWith(_TelegramDetailResponse value, $Res Function(_TelegramDetailResponse) _then) = __$TelegramDetailResponseCopyWithImpl;
@override @useResult
$Res call({
 TelegramDetail telegram,@JsonKey(includeIfNull: true) TelegramComments? comments
});


@override $TelegramDetailCopyWith<$Res> get telegram;@override $TelegramCommentsCopyWith<$Res>? get comments;

}
/// @nodoc
class __$TelegramDetailResponseCopyWithImpl<$Res>
    implements _$TelegramDetailResponseCopyWith<$Res> {
  __$TelegramDetailResponseCopyWithImpl(this._self, this._then);

  final _TelegramDetailResponse _self;
  final $Res Function(_TelegramDetailResponse) _then;

/// Create a copy of TelegramDetailResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? telegram = null,Object? comments = freezed,}) {
  return _then(_TelegramDetailResponse(
telegram: null == telegram ? _self.telegram : telegram // ignore: cast_nullable_to_non_nullable
as TelegramDetail,comments: freezed == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as TelegramComments?,
  ));
}

/// Create a copy of TelegramDetailResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TelegramDetailCopyWith<$Res> get telegram {
  
  return $TelegramDetailCopyWith<$Res>(_self.telegram, (value) {
    return _then(_self.copyWith(telegram: value));
  });
}/// Create a copy of TelegramDetailResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TelegramCommentsCopyWith<$Res>? get comments {
    if (_self.comments == null) {
    return null;
  }

  return $TelegramCommentsCopyWith<$Res>(_self.comments!, (value) {
    return _then(_self.copyWith(comments: value));
  });
}
}

// dart format on
