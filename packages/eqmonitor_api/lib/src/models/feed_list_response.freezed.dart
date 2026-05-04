// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_list_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FeedListResponse {

 List<FeedItem> get feeds;@JsonKey(includeIfNull: true, name: 'next_cursor') String? get nextCursor;
/// Create a copy of FeedListResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedListResponseCopyWith<FeedListResponse> get copyWith => _$FeedListResponseCopyWithImpl<FeedListResponse>(this as FeedListResponse, _$identity);

  /// Serializes this FeedListResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedListResponse&&const DeepCollectionEquality().equals(other.feeds, feeds)&&(identical(other.nextCursor, nextCursor) || other.nextCursor == nextCursor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(feeds),nextCursor);

@override
String toString() {
  return 'FeedListResponse(feeds: $feeds, nextCursor: $nextCursor)';
}


}

/// @nodoc
abstract mixin class $FeedListResponseCopyWith<$Res>  {
  factory $FeedListResponseCopyWith(FeedListResponse value, $Res Function(FeedListResponse) _then) = _$FeedListResponseCopyWithImpl;
@useResult
$Res call({
 List<FeedItem> feeds,@JsonKey(includeIfNull: true, name: 'next_cursor') String? nextCursor
});




}
/// @nodoc
class _$FeedListResponseCopyWithImpl<$Res>
    implements $FeedListResponseCopyWith<$Res> {
  _$FeedListResponseCopyWithImpl(this._self, this._then);

  final FeedListResponse _self;
  final $Res Function(FeedListResponse) _then;

/// Create a copy of FeedListResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? feeds = null,Object? nextCursor = freezed,}) {
  return _then(_self.copyWith(
feeds: null == feeds ? _self.feeds : feeds // ignore: cast_nullable_to_non_nullable
as List<FeedItem>,nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FeedListResponse].
extension FeedListResponsePatterns on FeedListResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedListResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedListResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedListResponse value)  $default,){
final _that = this;
switch (_that) {
case _FeedListResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedListResponse value)?  $default,){
final _that = this;
switch (_that) {
case _FeedListResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<FeedItem> feeds, @JsonKey(includeIfNull: true, name: 'next_cursor')  String? nextCursor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedListResponse() when $default != null:
return $default(_that.feeds,_that.nextCursor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<FeedItem> feeds, @JsonKey(includeIfNull: true, name: 'next_cursor')  String? nextCursor)  $default,) {final _that = this;
switch (_that) {
case _FeedListResponse():
return $default(_that.feeds,_that.nextCursor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<FeedItem> feeds, @JsonKey(includeIfNull: true, name: 'next_cursor')  String? nextCursor)?  $default,) {final _that = this;
switch (_that) {
case _FeedListResponse() when $default != null:
return $default(_that.feeds,_that.nextCursor);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FeedListResponse implements FeedListResponse {
  const _FeedListResponse({required final  List<FeedItem> feeds, @JsonKey(includeIfNull: true, name: 'next_cursor') required this.nextCursor}): _feeds = feeds;
  factory _FeedListResponse.fromJson(Map<String, dynamic> json) => _$FeedListResponseFromJson(json);

 final  List<FeedItem> _feeds;
@override List<FeedItem> get feeds {
  if (_feeds is EqualUnmodifiableListView) return _feeds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_feeds);
}

@override@JsonKey(includeIfNull: true, name: 'next_cursor') final  String? nextCursor;

/// Create a copy of FeedListResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedListResponseCopyWith<_FeedListResponse> get copyWith => __$FeedListResponseCopyWithImpl<_FeedListResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeedListResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedListResponse&&const DeepCollectionEquality().equals(other._feeds, _feeds)&&(identical(other.nextCursor, nextCursor) || other.nextCursor == nextCursor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_feeds),nextCursor);

@override
String toString() {
  return 'FeedListResponse(feeds: $feeds, nextCursor: $nextCursor)';
}


}

/// @nodoc
abstract mixin class _$FeedListResponseCopyWith<$Res> implements $FeedListResponseCopyWith<$Res> {
  factory _$FeedListResponseCopyWith(_FeedListResponse value, $Res Function(_FeedListResponse) _then) = __$FeedListResponseCopyWithImpl;
@override @useResult
$Res call({
 List<FeedItem> feeds,@JsonKey(includeIfNull: true, name: 'next_cursor') String? nextCursor
});




}
/// @nodoc
class __$FeedListResponseCopyWithImpl<$Res>
    implements _$FeedListResponseCopyWith<$Res> {
  __$FeedListResponseCopyWithImpl(this._self, this._then);

  final _FeedListResponse _self;
  final $Res Function(_FeedListResponse) _then;

/// Create a copy of FeedListResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? feeds = null,Object? nextCursor = freezed,}) {
  return _then(_FeedListResponse(
feeds: null == feeds ? _self._feeds : feeds // ignore: cast_nullable_to_non_nullable
as List<FeedItem>,nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
