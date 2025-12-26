// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'responses.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TelegramListResponse {

 List<Telegram> get items; String? get nextToken; String? get nextPooling;
/// Create a copy of TelegramListResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TelegramListResponseCopyWith<TelegramListResponse> get copyWith => _$TelegramListResponseCopyWithImpl<TelegramListResponse>(this as TelegramListResponse, _$identity);

  /// Serializes this TelegramListResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TelegramListResponse&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.nextToken, nextToken) || other.nextToken == nextToken)&&(identical(other.nextPooling, nextPooling) || other.nextPooling == nextPooling));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),nextToken,nextPooling);

@override
String toString() {
  return 'TelegramListResponse(items: $items, nextToken: $nextToken, nextPooling: $nextPooling)';
}


}

/// @nodoc
abstract mixin class $TelegramListResponseCopyWith<$Res>  {
  factory $TelegramListResponseCopyWith(TelegramListResponse value, $Res Function(TelegramListResponse) _then) = _$TelegramListResponseCopyWithImpl;
@useResult
$Res call({
 List<Telegram> items, String? nextToken, String? nextPooling
});




}
/// @nodoc
class _$TelegramListResponseCopyWithImpl<$Res>
    implements $TelegramListResponseCopyWith<$Res> {
  _$TelegramListResponseCopyWithImpl(this._self, this._then);

  final TelegramListResponse _self;
  final $Res Function(TelegramListResponse) _then;

/// Create a copy of TelegramListResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? nextToken = freezed,Object? nextPooling = freezed,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<Telegram>,nextToken: freezed == nextToken ? _self.nextToken : nextToken // ignore: cast_nullable_to_non_nullable
as String?,nextPooling: freezed == nextPooling ? _self.nextPooling : nextPooling // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TelegramListResponse].
extension TelegramListResponsePatterns on TelegramListResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TelegramListResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TelegramListResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TelegramListResponse value)  $default,){
final _that = this;
switch (_that) {
case _TelegramListResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TelegramListResponse value)?  $default,){
final _that = this;
switch (_that) {
case _TelegramListResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Telegram> items,  String? nextToken,  String? nextPooling)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TelegramListResponse() when $default != null:
return $default(_that.items,_that.nextToken,_that.nextPooling);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Telegram> items,  String? nextToken,  String? nextPooling)  $default,) {final _that = this;
switch (_that) {
case _TelegramListResponse():
return $default(_that.items,_that.nextToken,_that.nextPooling);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Telegram> items,  String? nextToken,  String? nextPooling)?  $default,) {final _that = this;
switch (_that) {
case _TelegramListResponse() when $default != null:
return $default(_that.items,_that.nextToken,_that.nextPooling);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TelegramListResponse implements TelegramListResponse {
  const _TelegramListResponse({required final  List<Telegram> items, this.nextToken, this.nextPooling}): _items = items;
  factory _TelegramListResponse.fromJson(Map<String, dynamic> json) => _$TelegramListResponseFromJson(json);

 final  List<Telegram> _items;
@override List<Telegram> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  String? nextToken;
@override final  String? nextPooling;

/// Create a copy of TelegramListResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TelegramListResponseCopyWith<_TelegramListResponse> get copyWith => __$TelegramListResponseCopyWithImpl<_TelegramListResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TelegramListResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TelegramListResponse&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.nextToken, nextToken) || other.nextToken == nextToken)&&(identical(other.nextPooling, nextPooling) || other.nextPooling == nextPooling));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),nextToken,nextPooling);

@override
String toString() {
  return 'TelegramListResponse(items: $items, nextToken: $nextToken, nextPooling: $nextPooling)';
}


}

/// @nodoc
abstract mixin class _$TelegramListResponseCopyWith<$Res> implements $TelegramListResponseCopyWith<$Res> {
  factory _$TelegramListResponseCopyWith(_TelegramListResponse value, $Res Function(_TelegramListResponse) _then) = __$TelegramListResponseCopyWithImpl;
@override @useResult
$Res call({
 List<Telegram> items, String? nextToken, String? nextPooling
});




}
/// @nodoc
class __$TelegramListResponseCopyWithImpl<$Res>
    implements _$TelegramListResponseCopyWith<$Res> {
  __$TelegramListResponseCopyWithImpl(this._self, this._then);

  final _TelegramListResponse _self;
  final $Res Function(_TelegramListResponse) _then;

/// Create a copy of TelegramListResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? nextToken = freezed,Object? nextPooling = freezed,}) {
  return _then(_TelegramListResponse(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<Telegram>,nextToken: freezed == nextToken ? _self.nextToken : nextToken // ignore: cast_nullable_to_non_nullable
as String?,nextPooling: freezed == nextPooling ? _self.nextPooling : nextPooling // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$TelegramDetailResponse {

 TelegramDetail get telegram; TelegramComments? get comments;
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
 TelegramDetail telegram, TelegramComments? comments
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
  return _then(_self.copyWith(
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TelegramDetail telegram,  TelegramComments? comments)?  $default,{required TResult orElse(),}) {final _that = this;
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TelegramDetail telegram,  TelegramComments? comments)  $default,) {final _that = this;
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TelegramDetail telegram,  TelegramComments? comments)?  $default,) {final _that = this;
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
  const _TelegramDetailResponse({required this.telegram, this.comments});
  factory _TelegramDetailResponse.fromJson(Map<String, dynamic> json) => _$TelegramDetailResponseFromJson(json);

@override final  TelegramDetail telegram;
@override final  TelegramComments? comments;

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
 TelegramDetail telegram, TelegramComments? comments
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
