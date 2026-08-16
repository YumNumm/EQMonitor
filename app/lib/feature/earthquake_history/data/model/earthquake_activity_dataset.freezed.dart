// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_activity_dataset.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EarthquakeActivityDataset {

 List<EarthquakePartialNormal> get items; DateTime get fetchedAt;
/// Create a copy of EarthquakeActivityDataset
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeActivityDatasetCopyWith<EarthquakeActivityDataset> get copyWith => _$EarthquakeActivityDatasetCopyWithImpl<EarthquakeActivityDataset>(this as EarthquakeActivityDataset, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeActivityDataset&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.fetchedAt, fetchedAt) || other.fetchedAt == fetchedAt));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),fetchedAt);

@override
String toString() {
  return 'EarthquakeActivityDataset(items: $items, fetchedAt: $fetchedAt)';
}


}

/// @nodoc
abstract mixin class $EarthquakeActivityDatasetCopyWith<$Res>  {
  factory $EarthquakeActivityDatasetCopyWith(EarthquakeActivityDataset value, $Res Function(EarthquakeActivityDataset) _then) = _$EarthquakeActivityDatasetCopyWithImpl;
@useResult
$Res call({
 List<EarthquakePartialNormal> items, DateTime fetchedAt
});




}
/// @nodoc
class _$EarthquakeActivityDatasetCopyWithImpl<$Res>
    implements $EarthquakeActivityDatasetCopyWith<$Res> {
  _$EarthquakeActivityDatasetCopyWithImpl(this._self, this._then);

  final EarthquakeActivityDataset _self;
  final $Res Function(EarthquakeActivityDataset) _then;

/// Create a copy of EarthquakeActivityDataset
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? fetchedAt = null,}) {
  return _then(EarthquakeActivityDataset(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<EarthquakePartialNormal>,fetchedAt: null == fetchedAt ? _self.fetchedAt : fetchedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [EarthquakeActivityDataset].
extension EarthquakeActivityDatasetPatterns on EarthquakeActivityDataset {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeActivityDataset value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeActivityDataset() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeActivityDataset value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeActivityDataset():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeActivityDataset value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeActivityDataset() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<EarthquakePartialNormal> items,  DateTime fetchedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeActivityDataset() when $default != null:
return $default(_that.items,_that.fetchedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<EarthquakePartialNormal> items,  DateTime fetchedAt)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeActivityDataset():
return $default(_that.items,_that.fetchedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<EarthquakePartialNormal> items,  DateTime fetchedAt)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeActivityDataset() when $default != null:
return $default(_that.items,_that.fetchedAt);case _:
  return null;

}
}

}

/// @nodoc


class _EarthquakeActivityDataset implements EarthquakeActivityDataset {
  const _EarthquakeActivityDataset({required  List<EarthquakePartialNormal> items, required this.fetchedAt}): _items = items;
  

 final  List<EarthquakePartialNormal> _items;
@override List<EarthquakePartialNormal> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  DateTime fetchedAt;

/// Create a copy of EarthquakeActivityDataset
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeActivityDatasetCopyWith<_EarthquakeActivityDataset> get copyWith => __$EarthquakeActivityDatasetCopyWithImpl<_EarthquakeActivityDataset>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeActivityDataset&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.fetchedAt, fetchedAt) || other.fetchedAt == fetchedAt));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),fetchedAt);

@override
String toString() {
  return 'EarthquakeActivityDataset(items: $items, fetchedAt: $fetchedAt)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeActivityDatasetCopyWith<$Res> implements $EarthquakeActivityDatasetCopyWith<$Res> {
  factory _$EarthquakeActivityDatasetCopyWith(_EarthquakeActivityDataset value, $Res Function(_EarthquakeActivityDataset) _then) = __$EarthquakeActivityDatasetCopyWithImpl;
@override @useResult
$Res call({
 List<EarthquakePartialNormal> items, DateTime fetchedAt
});




}
/// @nodoc
class __$EarthquakeActivityDatasetCopyWithImpl<$Res>
    implements _$EarthquakeActivityDatasetCopyWith<$Res> {
  __$EarthquakeActivityDatasetCopyWithImpl(this._self, this._then);

  final _EarthquakeActivityDataset _self;
  final $Res Function(_EarthquakeActivityDataset) _then;

/// Create a copy of EarthquakeActivityDataset
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? fetchedAt = null,}) {
  return _then(_EarthquakeActivityDataset(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<EarthquakePartialNormal>,fetchedAt: null == fetchedAt ? _self.fetchedAt : fetchedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
