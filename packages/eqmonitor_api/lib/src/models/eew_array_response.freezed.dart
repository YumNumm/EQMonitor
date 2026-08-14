// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eew_array_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EewArrayResponse {

 List<EewItemWithRelations> get items;
/// Create a copy of EewArrayResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewArrayResponseCopyWith<EewArrayResponse> get copyWith => _$EewArrayResponseCopyWithImpl<EewArrayResponse>(this as EewArrayResponse, _$identity);

  /// Serializes this EewArrayResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewArrayResponse&&const DeepCollectionEquality().equals(other.items, items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'EewArrayResponse(items: $items)';
}


}

/// @nodoc
abstract mixin class $EewArrayResponseCopyWith<$Res>  {
  factory $EewArrayResponseCopyWith(EewArrayResponse value, $Res Function(EewArrayResponse) _then) = _$EewArrayResponseCopyWithImpl;
@useResult
$Res call({
 List<EewItemWithRelations> items
});




}
/// @nodoc
class _$EewArrayResponseCopyWithImpl<$Res>
    implements $EewArrayResponseCopyWith<$Res> {
  _$EewArrayResponseCopyWithImpl(this._self, this._then);

  final EewArrayResponse _self;
  final $Res Function(EewArrayResponse) _then;

/// Create a copy of EewArrayResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,}) {
  return _then(EewArrayResponse(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<EewItemWithRelations>,
  ));
}

}


/// Adds pattern-matching-related methods to [EewArrayResponse].
extension EewArrayResponsePatterns on EewArrayResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EewArrayResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EewArrayResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EewArrayResponse value)  $default,){
final _that = this;
switch (_that) {
case _EewArrayResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EewArrayResponse value)?  $default,){
final _that = this;
switch (_that) {
case _EewArrayResponse() when $default != null:
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
case _EewArrayResponse() when $default != null:
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
case _EewArrayResponse():
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
case _EewArrayResponse() when $default != null:
return $default(_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EewArrayResponse implements EewArrayResponse {
  const _EewArrayResponse({required  List<EewItemWithRelations> items}): _items = items;
  factory _EewArrayResponse.fromJson(Map<String, dynamic> json) => _$EewArrayResponseFromJson(json);

 final  List<EewItemWithRelations> _items;
@override List<EewItemWithRelations> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of EewArrayResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EewArrayResponseCopyWith<_EewArrayResponse> get copyWith => __$EewArrayResponseCopyWithImpl<_EewArrayResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EewArrayResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EewArrayResponse&&const DeepCollectionEquality().equals(other._items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'EewArrayResponse(items: $items)';
}


}

/// @nodoc
abstract mixin class _$EewArrayResponseCopyWith<$Res> implements $EewArrayResponseCopyWith<$Res> {
  factory _$EewArrayResponseCopyWith(_EewArrayResponse value, $Res Function(_EewArrayResponse) _then) = __$EewArrayResponseCopyWithImpl;
@override @useResult
$Res call({
 List<EewItemWithRelations> items
});




}
/// @nodoc
class __$EewArrayResponseCopyWithImpl<$Res>
    implements _$EewArrayResponseCopyWith<$Res> {
  __$EewArrayResponseCopyWithImpl(this._self, this._then);

  final _EewArrayResponse _self;
  final $Res Function(_EewArrayResponse) _then;

/// Create a copy of EewArrayResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,}) {
  return _then(_EewArrayResponse(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<EewItemWithRelations>,
  ));
}


}

// dart format on
