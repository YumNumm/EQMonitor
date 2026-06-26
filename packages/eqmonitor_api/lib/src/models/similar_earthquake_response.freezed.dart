// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'similar_earthquake_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SimilarEarthquakeResponse {

 List<SimilarEarthquakeItem> get items;
/// Create a copy of SimilarEarthquakeResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SimilarEarthquakeResponseCopyWith<SimilarEarthquakeResponse> get copyWith => _$SimilarEarthquakeResponseCopyWithImpl<SimilarEarthquakeResponse>(this as SimilarEarthquakeResponse, _$identity);

  /// Serializes this SimilarEarthquakeResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SimilarEarthquakeResponse&&const DeepCollectionEquality().equals(other.items, items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'SimilarEarthquakeResponse(items: $items)';
}


}

/// @nodoc
abstract mixin class $SimilarEarthquakeResponseCopyWith<$Res>  {
  factory $SimilarEarthquakeResponseCopyWith(SimilarEarthquakeResponse value, $Res Function(SimilarEarthquakeResponse) _then) = _$SimilarEarthquakeResponseCopyWithImpl;
@useResult
$Res call({
 List<SimilarEarthquakeItem> items
});




}
/// @nodoc
class _$SimilarEarthquakeResponseCopyWithImpl<$Res>
    implements $SimilarEarthquakeResponseCopyWith<$Res> {
  _$SimilarEarthquakeResponseCopyWithImpl(this._self, this._then);

  final SimilarEarthquakeResponse _self;
  final $Res Function(SimilarEarthquakeResponse) _then;

/// Create a copy of SimilarEarthquakeResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<SimilarEarthquakeItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [SimilarEarthquakeResponse].
extension SimilarEarthquakeResponsePatterns on SimilarEarthquakeResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SimilarEarthquakeResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SimilarEarthquakeResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SimilarEarthquakeResponse value)  $default,){
final _that = this;
switch (_that) {
case _SimilarEarthquakeResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SimilarEarthquakeResponse value)?  $default,){
final _that = this;
switch (_that) {
case _SimilarEarthquakeResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<SimilarEarthquakeItem> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SimilarEarthquakeResponse() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<SimilarEarthquakeItem> items)  $default,) {final _that = this;
switch (_that) {
case _SimilarEarthquakeResponse():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<SimilarEarthquakeItem> items)?  $default,) {final _that = this;
switch (_that) {
case _SimilarEarthquakeResponse() when $default != null:
return $default(_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SimilarEarthquakeResponse implements SimilarEarthquakeResponse {
  const _SimilarEarthquakeResponse({required final  List<SimilarEarthquakeItem> items}): _items = items;
  factory _SimilarEarthquakeResponse.fromJson(Map<String, dynamic> json) => _$SimilarEarthquakeResponseFromJson(json);

 final  List<SimilarEarthquakeItem> _items;
@override List<SimilarEarthquakeItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of SimilarEarthquakeResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SimilarEarthquakeResponseCopyWith<_SimilarEarthquakeResponse> get copyWith => __$SimilarEarthquakeResponseCopyWithImpl<_SimilarEarthquakeResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SimilarEarthquakeResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SimilarEarthquakeResponse&&const DeepCollectionEquality().equals(other._items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'SimilarEarthquakeResponse(items: $items)';
}


}

/// @nodoc
abstract mixin class _$SimilarEarthquakeResponseCopyWith<$Res> implements $SimilarEarthquakeResponseCopyWith<$Res> {
  factory _$SimilarEarthquakeResponseCopyWith(_SimilarEarthquakeResponse value, $Res Function(_SimilarEarthquakeResponse) _then) = __$SimilarEarthquakeResponseCopyWithImpl;
@override @useResult
$Res call({
 List<SimilarEarthquakeItem> items
});




}
/// @nodoc
class __$SimilarEarthquakeResponseCopyWithImpl<$Res>
    implements _$SimilarEarthquakeResponseCopyWith<$Res> {
  __$SimilarEarthquakeResponseCopyWithImpl(this._self, this._then);

  final _SimilarEarthquakeResponse _self;
  final $Res Function(_SimilarEarthquakeResponse) _then;

/// Create a copy of SimilarEarthquakeResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,}) {
  return _then(_SimilarEarthquakeResponse(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<SimilarEarthquakeItem>,
  ));
}


}

// dart format on
