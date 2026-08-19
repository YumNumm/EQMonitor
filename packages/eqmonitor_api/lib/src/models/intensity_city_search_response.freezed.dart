// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'intensity_city_search_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IntensityCitySearchResponse {

 List<IntensityCitySearchItem> get items;/// カーソル情報（base64エンコード）
@JsonKey(includeIfNull: false, name: 'next_token') String? get nextToken;/// カーソル情報（base64エンコード）
@JsonKey(includeIfNull: false, name: 'next_pooling') String? get nextPooling;
/// Create a copy of IntensityCitySearchResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntensityCitySearchResponseCopyWith<IntensityCitySearchResponse> get copyWith => _$IntensityCitySearchResponseCopyWithImpl<IntensityCitySearchResponse>(this as IntensityCitySearchResponse, _$identity);

  /// Serializes this IntensityCitySearchResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntensityCitySearchResponse&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.nextToken, nextToken) || other.nextToken == nextToken)&&(identical(other.nextPooling, nextPooling) || other.nextPooling == nextPooling));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),nextToken,nextPooling);

@override
String toString() {
  return 'IntensityCitySearchResponse(items: $items, nextToken: $nextToken, nextPooling: $nextPooling)';
}


}

/// @nodoc
abstract mixin class $IntensityCitySearchResponseCopyWith<$Res>  {
  factory $IntensityCitySearchResponseCopyWith(IntensityCitySearchResponse value, $Res Function(IntensityCitySearchResponse) _then) = _$IntensityCitySearchResponseCopyWithImpl;
@useResult
$Res call({
 List<IntensityCitySearchItem> items,@JsonKey(includeIfNull: false, name: 'next_token') String? nextToken,@JsonKey(includeIfNull: false, name: 'next_pooling') String? nextPooling
});




}
/// @nodoc
class _$IntensityCitySearchResponseCopyWithImpl<$Res>
    implements $IntensityCitySearchResponseCopyWith<$Res> {
  _$IntensityCitySearchResponseCopyWithImpl(this._self, this._then);

  final IntensityCitySearchResponse _self;
  final $Res Function(IntensityCitySearchResponse) _then;

/// Create a copy of IntensityCitySearchResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? nextToken = freezed,Object? nextPooling = freezed,}) {
  return _then(IntensityCitySearchResponse(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<IntensityCitySearchItem>,nextToken: freezed == nextToken ? _self.nextToken : nextToken // ignore: cast_nullable_to_non_nullable
as String?,nextPooling: freezed == nextPooling ? _self.nextPooling : nextPooling // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [IntensityCitySearchResponse].
extension IntensityCitySearchResponsePatterns on IntensityCitySearchResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IntensityCitySearchResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IntensityCitySearchResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IntensityCitySearchResponse value)  $default,){
final _that = this;
switch (_that) {
case _IntensityCitySearchResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IntensityCitySearchResponse value)?  $default,){
final _that = this;
switch (_that) {
case _IntensityCitySearchResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<IntensityCitySearchItem> items, @JsonKey(includeIfNull: false, name: 'next_token')  String? nextToken, @JsonKey(includeIfNull: false, name: 'next_pooling')  String? nextPooling)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IntensityCitySearchResponse() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<IntensityCitySearchItem> items, @JsonKey(includeIfNull: false, name: 'next_token')  String? nextToken, @JsonKey(includeIfNull: false, name: 'next_pooling')  String? nextPooling)  $default,) {final _that = this;
switch (_that) {
case _IntensityCitySearchResponse():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<IntensityCitySearchItem> items, @JsonKey(includeIfNull: false, name: 'next_token')  String? nextToken, @JsonKey(includeIfNull: false, name: 'next_pooling')  String? nextPooling)?  $default,) {final _that = this;
switch (_that) {
case _IntensityCitySearchResponse() when $default != null:
return $default(_that.items,_that.nextToken,_that.nextPooling);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IntensityCitySearchResponse implements IntensityCitySearchResponse {
  const _IntensityCitySearchResponse({required  List<IntensityCitySearchItem> items, @JsonKey(includeIfNull: false, name: 'next_token') this.nextToken, @JsonKey(includeIfNull: false, name: 'next_pooling') this.nextPooling}): _items = items;
  factory _IntensityCitySearchResponse.fromJson(Map<String, dynamic> json) => _$IntensityCitySearchResponseFromJson(json);

 final  List<IntensityCitySearchItem> _items;
@override List<IntensityCitySearchItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

/// カーソル情報（base64エンコード）
@override@JsonKey(includeIfNull: false, name: 'next_token') final  String? nextToken;
/// カーソル情報（base64エンコード）
@override@JsonKey(includeIfNull: false, name: 'next_pooling') final  String? nextPooling;

/// Create a copy of IntensityCitySearchResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntensityCitySearchResponseCopyWith<_IntensityCitySearchResponse> get copyWith => __$IntensityCitySearchResponseCopyWithImpl<_IntensityCitySearchResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IntensityCitySearchResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntensityCitySearchResponse&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.nextToken, nextToken) || other.nextToken == nextToken)&&(identical(other.nextPooling, nextPooling) || other.nextPooling == nextPooling));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),nextToken,nextPooling);

@override
String toString() {
  return 'IntensityCitySearchResponse(items: $items, nextToken: $nextToken, nextPooling: $nextPooling)';
}


}

/// @nodoc
abstract mixin class _$IntensityCitySearchResponseCopyWith<$Res> implements $IntensityCitySearchResponseCopyWith<$Res> {
  factory _$IntensityCitySearchResponseCopyWith(_IntensityCitySearchResponse value, $Res Function(_IntensityCitySearchResponse) _then) = __$IntensityCitySearchResponseCopyWithImpl;
@override @useResult
$Res call({
 List<IntensityCitySearchItem> items,@JsonKey(includeIfNull: false, name: 'next_token') String? nextToken,@JsonKey(includeIfNull: false, name: 'next_pooling') String? nextPooling
});




}
/// @nodoc
class __$IntensityCitySearchResponseCopyWithImpl<$Res>
    implements _$IntensityCitySearchResponseCopyWith<$Res> {
  __$IntensityCitySearchResponseCopyWithImpl(this._self, this._then);

  final _IntensityCitySearchResponse _self;
  final $Res Function(_IntensityCitySearchResponse) _then;

/// Create a copy of IntensityCitySearchResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? nextToken = freezed,Object? nextPooling = freezed,}) {
  return _then(_IntensityCitySearchResponse(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<IntensityCitySearchItem>,nextToken: freezed == nextToken ? _self.nextToken : nextToken // ignore: cast_nullable_to_non_nullable
as String?,nextPooling: freezed == nextPooling ? _self.nextPooling : nextPooling // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
