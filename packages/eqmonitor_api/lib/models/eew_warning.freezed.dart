// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eew_warning.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EewWarning {

 List<EewWarningZoneItem> get zones; List<EewWarningZoneItem> get prefectures; List<EewWarningZoneItem> get regions;
/// Create a copy of EewWarning
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewWarningCopyWith<EewWarning> get copyWith => _$EewWarningCopyWithImpl<EewWarning>(this as EewWarning, _$identity);

  /// Serializes this EewWarning to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewWarning&&const DeepCollectionEquality().equals(other.zones, zones)&&const DeepCollectionEquality().equals(other.prefectures, prefectures)&&const DeepCollectionEquality().equals(other.regions, regions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(zones),const DeepCollectionEquality().hash(prefectures),const DeepCollectionEquality().hash(regions));

@override
String toString() {
  return 'EewWarning(zones: $zones, prefectures: $prefectures, regions: $regions)';
}


}

/// @nodoc
abstract mixin class $EewWarningCopyWith<$Res>  {
  factory $EewWarningCopyWith(EewWarning value, $Res Function(EewWarning) _then) = _$EewWarningCopyWithImpl;
@useResult
$Res call({
 List<EewWarningZoneItem> zones, List<EewWarningZoneItem> prefectures, List<EewWarningZoneItem> regions
});




}
/// @nodoc
class _$EewWarningCopyWithImpl<$Res>
    implements $EewWarningCopyWith<$Res> {
  _$EewWarningCopyWithImpl(this._self, this._then);

  final EewWarning _self;
  final $Res Function(EewWarning) _then;

/// Create a copy of EewWarning
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? zones = null,Object? prefectures = null,Object? regions = null,}) {
  return _then(_self.copyWith(
zones: null == zones ? _self.zones : zones // ignore: cast_nullable_to_non_nullable
as List<EewWarningZoneItem>,prefectures: null == prefectures ? _self.prefectures : prefectures // ignore: cast_nullable_to_non_nullable
as List<EewWarningZoneItem>,regions: null == regions ? _self.regions : regions // ignore: cast_nullable_to_non_nullable
as List<EewWarningZoneItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [EewWarning].
extension EewWarningPatterns on EewWarning {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EewWarning value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EewWarning() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EewWarning value)  $default,){
final _that = this;
switch (_that) {
case _EewWarning():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EewWarning value)?  $default,){
final _that = this;
switch (_that) {
case _EewWarning() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<EewWarningZoneItem> zones,  List<EewWarningZoneItem> prefectures,  List<EewWarningZoneItem> regions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EewWarning() when $default != null:
return $default(_that.zones,_that.prefectures,_that.regions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<EewWarningZoneItem> zones,  List<EewWarningZoneItem> prefectures,  List<EewWarningZoneItem> regions)  $default,) {final _that = this;
switch (_that) {
case _EewWarning():
return $default(_that.zones,_that.prefectures,_that.regions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<EewWarningZoneItem> zones,  List<EewWarningZoneItem> prefectures,  List<EewWarningZoneItem> regions)?  $default,) {final _that = this;
switch (_that) {
case _EewWarning() when $default != null:
return $default(_that.zones,_that.prefectures,_that.regions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EewWarning implements EewWarning {
  const _EewWarning({required final  List<EewWarningZoneItem> zones, required final  List<EewWarningZoneItem> prefectures, required final  List<EewWarningZoneItem> regions}): _zones = zones,_prefectures = prefectures,_regions = regions;
  factory _EewWarning.fromJson(Map<String, dynamic> json) => _$EewWarningFromJson(json);

 final  List<EewWarningZoneItem> _zones;
@override List<EewWarningZoneItem> get zones {
  if (_zones is EqualUnmodifiableListView) return _zones;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_zones);
}

 final  List<EewWarningZoneItem> _prefectures;
@override List<EewWarningZoneItem> get prefectures {
  if (_prefectures is EqualUnmodifiableListView) return _prefectures;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_prefectures);
}

 final  List<EewWarningZoneItem> _regions;
@override List<EewWarningZoneItem> get regions {
  if (_regions is EqualUnmodifiableListView) return _regions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_regions);
}


/// Create a copy of EewWarning
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EewWarningCopyWith<_EewWarning> get copyWith => __$EewWarningCopyWithImpl<_EewWarning>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EewWarningToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EewWarning&&const DeepCollectionEquality().equals(other._zones, _zones)&&const DeepCollectionEquality().equals(other._prefectures, _prefectures)&&const DeepCollectionEquality().equals(other._regions, _regions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_zones),const DeepCollectionEquality().hash(_prefectures),const DeepCollectionEquality().hash(_regions));

@override
String toString() {
  return 'EewWarning(zones: $zones, prefectures: $prefectures, regions: $regions)';
}


}

/// @nodoc
abstract mixin class _$EewWarningCopyWith<$Res> implements $EewWarningCopyWith<$Res> {
  factory _$EewWarningCopyWith(_EewWarning value, $Res Function(_EewWarning) _then) = __$EewWarningCopyWithImpl;
@override @useResult
$Res call({
 List<EewWarningZoneItem> zones, List<EewWarningZoneItem> prefectures, List<EewWarningZoneItem> regions
});




}
/// @nodoc
class __$EewWarningCopyWithImpl<$Res>
    implements _$EewWarningCopyWith<$Res> {
  __$EewWarningCopyWithImpl(this._self, this._then);

  final _EewWarning _self;
  final $Res Function(_EewWarning) _then;

/// Create a copy of EewWarning
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? zones = null,Object? prefectures = null,Object? regions = null,}) {
  return _then(_EewWarning(
zones: null == zones ? _self._zones : zones // ignore: cast_nullable_to_non_nullable
as List<EewWarningZoneItem>,prefectures: null == prefectures ? _self._prefectures : prefectures // ignore: cast_nullable_to_non_nullable
as List<EewWarningZoneItem>,regions: null == regions ? _self._regions : regions // ignore: cast_nullable_to_non_nullable
as List<EewWarningZoneItem>,
  ));
}


}

// dart format on
