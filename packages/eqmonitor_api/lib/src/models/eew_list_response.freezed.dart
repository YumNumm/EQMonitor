// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eew_list_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EewListResponse {

 List<EewItemWithRelations> get items;/// カーソル情報（base64エンコード）
@JsonKey(includeIfNull: false, name: 'next_token') String? get nextToken;/// カーソル情報（base64エンコード）
@JsonKey(includeIfNull: false, name: 'next_pooling') String? get nextPooling;
/// Create a copy of EewListResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewListResponseCopyWith<EewListResponse> get copyWith => _$EewListResponseCopyWithImpl<EewListResponse>(this as EewListResponse, _$identity);

  /// Serializes this EewListResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewListResponse&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.nextToken, nextToken) || other.nextToken == nextToken)&&(identical(other.nextPooling, nextPooling) || other.nextPooling == nextPooling));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),nextToken,nextPooling);

@override
String toString() {
  return 'EewListResponse(items: $items, nextToken: $nextToken, nextPooling: $nextPooling)';
}


}

/// @nodoc
abstract mixin class $EewListResponseCopyWith<$Res>  {
  factory $EewListResponseCopyWith(EewListResponse value, $Res Function(EewListResponse) _then) = _$EewListResponseCopyWithImpl;
@useResult
$Res call({
 List<EewItemWithRelations> items,@JsonKey(includeIfNull: false, name: 'next_token') String? nextToken,@JsonKey(includeIfNull: false, name: 'next_pooling') String? nextPooling
});




}
/// @nodoc
class _$EewListResponseCopyWithImpl<$Res>
    implements $EewListResponseCopyWith<$Res> {
  _$EewListResponseCopyWithImpl(this._self, this._then);

  final EewListResponse _self;
  final $Res Function(EewListResponse) _then;

/// Create a copy of EewListResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? nextToken = freezed,Object? nextPooling = freezed,}) {
  return _then(EewListResponse(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<EewItemWithRelations>,nextToken: freezed == nextToken ? _self.nextToken : nextToken // ignore: cast_nullable_to_non_nullable
as String?,nextPooling: freezed == nextPooling ? _self.nextPooling : nextPooling // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EewListResponse].
extension EewListResponsePatterns on EewListResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EewListResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EewListResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EewListResponse value)  $default,){
final _that = this;
switch (_that) {
case _EewListResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EewListResponse value)?  $default,){
final _that = this;
switch (_that) {
case _EewListResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<EewItemWithRelations> items, @JsonKey(includeIfNull: false, name: 'next_token')  String? nextToken, @JsonKey(includeIfNull: false, name: 'next_pooling')  String? nextPooling)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EewListResponse() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<EewItemWithRelations> items, @JsonKey(includeIfNull: false, name: 'next_token')  String? nextToken, @JsonKey(includeIfNull: false, name: 'next_pooling')  String? nextPooling)  $default,) {final _that = this;
switch (_that) {
case _EewListResponse():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<EewItemWithRelations> items, @JsonKey(includeIfNull: false, name: 'next_token')  String? nextToken, @JsonKey(includeIfNull: false, name: 'next_pooling')  String? nextPooling)?  $default,) {final _that = this;
switch (_that) {
case _EewListResponse() when $default != null:
return $default(_that.items,_that.nextToken,_that.nextPooling);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EewListResponse implements EewListResponse {
  const _EewListResponse({required  List<EewItemWithRelations> items, @JsonKey(includeIfNull: false, name: 'next_token') this.nextToken, @JsonKey(includeIfNull: false, name: 'next_pooling') this.nextPooling}): _items = items;
  factory _EewListResponse.fromJson(Map<String, dynamic> json) => _$EewListResponseFromJson(json);

 final  List<EewItemWithRelations> _items;
@override List<EewItemWithRelations> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

/// カーソル情報（base64エンコード）
@override@JsonKey(includeIfNull: false, name: 'next_token') final  String? nextToken;
/// カーソル情報（base64エンコード）
@override@JsonKey(includeIfNull: false, name: 'next_pooling') final  String? nextPooling;

/// Create a copy of EewListResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EewListResponseCopyWith<_EewListResponse> get copyWith => __$EewListResponseCopyWithImpl<_EewListResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EewListResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EewListResponse&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.nextToken, nextToken) || other.nextToken == nextToken)&&(identical(other.nextPooling, nextPooling) || other.nextPooling == nextPooling));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),nextToken,nextPooling);

@override
String toString() {
  return 'EewListResponse(items: $items, nextToken: $nextToken, nextPooling: $nextPooling)';
}


}

/// @nodoc
abstract mixin class _$EewListResponseCopyWith<$Res> implements $EewListResponseCopyWith<$Res> {
  factory _$EewListResponseCopyWith(_EewListResponse value, $Res Function(_EewListResponse) _then) = __$EewListResponseCopyWithImpl;
@override @useResult
$Res call({
 List<EewItemWithRelations> items,@JsonKey(includeIfNull: false, name: 'next_token') String? nextToken,@JsonKey(includeIfNull: false, name: 'next_pooling') String? nextPooling
});




}
/// @nodoc
class __$EewListResponseCopyWithImpl<$Res>
    implements _$EewListResponseCopyWith<$Res> {
  __$EewListResponseCopyWithImpl(this._self, this._then);

  final _EewListResponse _self;
  final $Res Function(_EewListResponse) _then;

/// Create a copy of EewListResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? nextToken = freezed,Object? nextPooling = freezed,}) {
  return _then(_EewListResponse(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<EewItemWithRelations>,nextToken: freezed == nextToken ? _self.nextToken : nextToken // ignore: cast_nullable_to_non_nullable
as String?,nextPooling: freezed == nextPooling ? _self.nextPooling : nextPooling // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
