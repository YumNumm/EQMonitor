// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'intensity_prefecture_search_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IntensityPrefectureSearchResponse {

 List<IntensityPrefectureSearchItem> get items;/// カーソル情報（base64エンコード）
@JsonKey(includeIfNull: false, name: 'next_token') String? get nextToken;/// カーソル情報（base64エンコード）
@JsonKey(includeIfNull: false, name: 'next_pooling') String? get nextPooling;
/// Create a copy of IntensityPrefectureSearchResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntensityPrefectureSearchResponseCopyWith<IntensityPrefectureSearchResponse> get copyWith => _$IntensityPrefectureSearchResponseCopyWithImpl<IntensityPrefectureSearchResponse>(this as IntensityPrefectureSearchResponse, _$identity);

  /// Serializes this IntensityPrefectureSearchResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntensityPrefectureSearchResponse&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.nextToken, nextToken) || other.nextToken == nextToken)&&(identical(other.nextPooling, nextPooling) || other.nextPooling == nextPooling));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),nextToken,nextPooling);

@override
String toString() {
  return 'IntensityPrefectureSearchResponse(items: $items, nextToken: $nextToken, nextPooling: $nextPooling)';
}


}

/// @nodoc
abstract mixin class $IntensityPrefectureSearchResponseCopyWith<$Res>  {
  factory $IntensityPrefectureSearchResponseCopyWith(IntensityPrefectureSearchResponse value, $Res Function(IntensityPrefectureSearchResponse) _then) = _$IntensityPrefectureSearchResponseCopyWithImpl;
@useResult
$Res call({
 List<IntensityPrefectureSearchItem> items,@JsonKey(includeIfNull: false, name: 'next_token') String? nextToken,@JsonKey(includeIfNull: false, name: 'next_pooling') String? nextPooling
});




}
/// @nodoc
class _$IntensityPrefectureSearchResponseCopyWithImpl<$Res>
    implements $IntensityPrefectureSearchResponseCopyWith<$Res> {
  _$IntensityPrefectureSearchResponseCopyWithImpl(this._self, this._then);

  final IntensityPrefectureSearchResponse _self;
  final $Res Function(IntensityPrefectureSearchResponse) _then;

/// Create a copy of IntensityPrefectureSearchResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? nextToken = freezed,Object? nextPooling = freezed,}) {
  return _then(IntensityPrefectureSearchResponse(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<IntensityPrefectureSearchItem>,nextToken: freezed == nextToken ? _self.nextToken : nextToken // ignore: cast_nullable_to_non_nullable
as String?,nextPooling: freezed == nextPooling ? _self.nextPooling : nextPooling // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [IntensityPrefectureSearchResponse].
extension IntensityPrefectureSearchResponsePatterns on IntensityPrefectureSearchResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IntensityPrefectureSearchResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IntensityPrefectureSearchResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IntensityPrefectureSearchResponse value)  $default,){
final _that = this;
switch (_that) {
case _IntensityPrefectureSearchResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IntensityPrefectureSearchResponse value)?  $default,){
final _that = this;
switch (_that) {
case _IntensityPrefectureSearchResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<IntensityPrefectureSearchItem> items, @JsonKey(includeIfNull: false, name: 'next_token')  String? nextToken, @JsonKey(includeIfNull: false, name: 'next_pooling')  String? nextPooling)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IntensityPrefectureSearchResponse() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<IntensityPrefectureSearchItem> items, @JsonKey(includeIfNull: false, name: 'next_token')  String? nextToken, @JsonKey(includeIfNull: false, name: 'next_pooling')  String? nextPooling)  $default,) {final _that = this;
switch (_that) {
case _IntensityPrefectureSearchResponse():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<IntensityPrefectureSearchItem> items, @JsonKey(includeIfNull: false, name: 'next_token')  String? nextToken, @JsonKey(includeIfNull: false, name: 'next_pooling')  String? nextPooling)?  $default,) {final _that = this;
switch (_that) {
case _IntensityPrefectureSearchResponse() when $default != null:
return $default(_that.items,_that.nextToken,_that.nextPooling);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IntensityPrefectureSearchResponse implements IntensityPrefectureSearchResponse {
  const _IntensityPrefectureSearchResponse({required  List<IntensityPrefectureSearchItem> items, @JsonKey(includeIfNull: false, name: 'next_token') this.nextToken, @JsonKey(includeIfNull: false, name: 'next_pooling') this.nextPooling}): _items = items;
  factory _IntensityPrefectureSearchResponse.fromJson(Map<String, dynamic> json) => _$IntensityPrefectureSearchResponseFromJson(json);

 final  List<IntensityPrefectureSearchItem> _items;
@override List<IntensityPrefectureSearchItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

/// カーソル情報（base64エンコード）
@override@JsonKey(includeIfNull: false, name: 'next_token') final  String? nextToken;
/// カーソル情報（base64エンコード）
@override@JsonKey(includeIfNull: false, name: 'next_pooling') final  String? nextPooling;

/// Create a copy of IntensityPrefectureSearchResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntensityPrefectureSearchResponseCopyWith<_IntensityPrefectureSearchResponse> get copyWith => __$IntensityPrefectureSearchResponseCopyWithImpl<_IntensityPrefectureSearchResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IntensityPrefectureSearchResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntensityPrefectureSearchResponse&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.nextToken, nextToken) || other.nextToken == nextToken)&&(identical(other.nextPooling, nextPooling) || other.nextPooling == nextPooling));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),nextToken,nextPooling);

@override
String toString() {
  return 'IntensityPrefectureSearchResponse(items: $items, nextToken: $nextToken, nextPooling: $nextPooling)';
}


}

/// @nodoc
abstract mixin class _$IntensityPrefectureSearchResponseCopyWith<$Res> implements $IntensityPrefectureSearchResponseCopyWith<$Res> {
  factory _$IntensityPrefectureSearchResponseCopyWith(_IntensityPrefectureSearchResponse value, $Res Function(_IntensityPrefectureSearchResponse) _then) = __$IntensityPrefectureSearchResponseCopyWithImpl;
@override @useResult
$Res call({
 List<IntensityPrefectureSearchItem> items,@JsonKey(includeIfNull: false, name: 'next_token') String? nextToken,@JsonKey(includeIfNull: false, name: 'next_pooling') String? nextPooling
});




}
/// @nodoc
class __$IntensityPrefectureSearchResponseCopyWithImpl<$Res>
    implements _$IntensityPrefectureSearchResponseCopyWith<$Res> {
  __$IntensityPrefectureSearchResponseCopyWithImpl(this._self, this._then);

  final _IntensityPrefectureSearchResponse _self;
  final $Res Function(_IntensityPrefectureSearchResponse) _then;

/// Create a copy of IntensityPrefectureSearchResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? nextToken = freezed,Object? nextPooling = freezed,}) {
  return _then(_IntensityPrefectureSearchResponse(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<IntensityPrefectureSearchItem>,nextToken: freezed == nextToken ? _self.nextToken : nextToken // ignore: cast_nullable_to_non_nullable
as String?,nextPooling: freezed == nextPooling ? _self.nextPooling : nextPooling // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
