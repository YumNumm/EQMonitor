// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eew_latest_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EewLatestResponse {

 List<EewItemWithRelations> get items;
/// Create a copy of EewLatestResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewLatestResponseCopyWith<EewLatestResponse> get copyWith => _$EewLatestResponseCopyWithImpl<EewLatestResponse>(this as EewLatestResponse, _$identity);

  /// Serializes this EewLatestResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewLatestResponse&&const DeepCollectionEquality().equals(other.items, items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'EewLatestResponse(items: $items)';
}


}

/// @nodoc
abstract mixin class $EewLatestResponseCopyWith<$Res>  {
  factory $EewLatestResponseCopyWith(EewLatestResponse value, $Res Function(EewLatestResponse) _then) = _$EewLatestResponseCopyWithImpl;
@useResult
$Res call({
 List<EewItemWithRelations> items
});




}
/// @nodoc
class _$EewLatestResponseCopyWithImpl<$Res>
    implements $EewLatestResponseCopyWith<$Res> {
  _$EewLatestResponseCopyWithImpl(this._self, this._then);

  final EewLatestResponse _self;
  final $Res Function(EewLatestResponse) _then;

/// Create a copy of EewLatestResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,}) {
  return _then(EewLatestResponse(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<EewItemWithRelations>,
  ));
}

}


/// Adds pattern-matching-related methods to [EewLatestResponse].
extension EewLatestResponsePatterns on EewLatestResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EewLatestResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EewLatestResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EewLatestResponse value)  $default,){
final _that = this;
switch (_that) {
case _EewLatestResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EewLatestResponse value)?  $default,){
final _that = this;
switch (_that) {
case _EewLatestResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<EewItemWithRelations> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EewLatestResponse() when $default != null:
return $default(_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<EewItemWithRelations> items)  $default,) {final _that = this;
switch (_that) {
case _EewLatestResponse():
return $default(_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<EewItemWithRelations> items)?  $default,) {final _that = this;
switch (_that) {
case _EewLatestResponse() when $default != null:
return $default(_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EewLatestResponse implements EewLatestResponse {
  const _EewLatestResponse({required  List<EewItemWithRelations> items}): _items = items;
  factory _EewLatestResponse.fromJson(Map<String, dynamic> json) => _$EewLatestResponseFromJson(json);

 final  List<EewItemWithRelations> _items;
@override List<EewItemWithRelations> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of EewLatestResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EewLatestResponseCopyWith<_EewLatestResponse> get copyWith => __$EewLatestResponseCopyWithImpl<_EewLatestResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EewLatestResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EewLatestResponse&&const DeepCollectionEquality().equals(other._items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'EewLatestResponse(items: $items)';
}


}

/// @nodoc
abstract mixin class _$EewLatestResponseCopyWith<$Res> implements $EewLatestResponseCopyWith<$Res> {
  factory _$EewLatestResponseCopyWith(_EewLatestResponse value, $Res Function(_EewLatestResponse) _then) = __$EewLatestResponseCopyWithImpl;
@override @useResult
$Res call({
 List<EewItemWithRelations> items
});




}
/// @nodoc
class __$EewLatestResponseCopyWithImpl<$Res>
    implements _$EewLatestResponseCopyWith<$Res> {
  __$EewLatestResponseCopyWithImpl(this._self, this._then);

  final _EewLatestResponse _self;
  final $Res Function(_EewLatestResponse) _then;

/// Create a copy of EewLatestResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,}) {
  return _then(_EewLatestResponse(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<EewItemWithRelations>,
  ));
}


}

// dart format on
