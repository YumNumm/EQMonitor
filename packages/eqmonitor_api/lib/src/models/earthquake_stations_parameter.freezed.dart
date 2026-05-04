// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_stations_parameter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EarthquakeStationsParameter {

 ParameterMetadata get metadata; List<EarthquakeStationPrefecture> get prefectures;
/// Create a copy of EarthquakeStationsParameter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeStationsParameterCopyWith<EarthquakeStationsParameter> get copyWith => _$EarthquakeStationsParameterCopyWithImpl<EarthquakeStationsParameter>(this as EarthquakeStationsParameter, _$identity);

  /// Serializes this EarthquakeStationsParameter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeStationsParameter&&(identical(other.metadata, metadata) || other.metadata == metadata)&&const DeepCollectionEquality().equals(other.prefectures, prefectures));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,metadata,const DeepCollectionEquality().hash(prefectures));

@override
String toString() {
  return 'EarthquakeStationsParameter(metadata: $metadata, prefectures: $prefectures)';
}


}

/// @nodoc
abstract mixin class $EarthquakeStationsParameterCopyWith<$Res>  {
  factory $EarthquakeStationsParameterCopyWith(EarthquakeStationsParameter value, $Res Function(EarthquakeStationsParameter) _then) = _$EarthquakeStationsParameterCopyWithImpl;
@useResult
$Res call({
 ParameterMetadata metadata, List<EarthquakeStationPrefecture> prefectures
});


$ParameterMetadataCopyWith<$Res> get metadata;

}
/// @nodoc
class _$EarthquakeStationsParameterCopyWithImpl<$Res>
    implements $EarthquakeStationsParameterCopyWith<$Res> {
  _$EarthquakeStationsParameterCopyWithImpl(this._self, this._then);

  final EarthquakeStationsParameter _self;
  final $Res Function(EarthquakeStationsParameter) _then;

/// Create a copy of EarthquakeStationsParameter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? metadata = null,Object? prefectures = null,}) {
  return _then(_self.copyWith(
metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as ParameterMetadata,prefectures: null == prefectures ? _self.prefectures : prefectures // ignore: cast_nullable_to_non_nullable
as List<EarthquakeStationPrefecture>,
  ));
}
/// Create a copy of EarthquakeStationsParameter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ParameterMetadataCopyWith<$Res> get metadata {
  
  return $ParameterMetadataCopyWith<$Res>(_self.metadata, (value) {
    return _then(_self.copyWith(metadata: value));
  });
}
}


/// Adds pattern-matching-related methods to [EarthquakeStationsParameter].
extension EarthquakeStationsParameterPatterns on EarthquakeStationsParameter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeStationsParameter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeStationsParameter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeStationsParameter value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeStationsParameter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeStationsParameter value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeStationsParameter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ParameterMetadata metadata,  List<EarthquakeStationPrefecture> prefectures)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeStationsParameter() when $default != null:
return $default(_that.metadata,_that.prefectures);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ParameterMetadata metadata,  List<EarthquakeStationPrefecture> prefectures)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeStationsParameter():
return $default(_that.metadata,_that.prefectures);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ParameterMetadata metadata,  List<EarthquakeStationPrefecture> prefectures)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeStationsParameter() when $default != null:
return $default(_that.metadata,_that.prefectures);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarthquakeStationsParameter implements EarthquakeStationsParameter {
  const _EarthquakeStationsParameter({required this.metadata, required final  List<EarthquakeStationPrefecture> prefectures}): _prefectures = prefectures;
  factory _EarthquakeStationsParameter.fromJson(Map<String, dynamic> json) => _$EarthquakeStationsParameterFromJson(json);

@override final  ParameterMetadata metadata;
 final  List<EarthquakeStationPrefecture> _prefectures;
@override List<EarthquakeStationPrefecture> get prefectures {
  if (_prefectures is EqualUnmodifiableListView) return _prefectures;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_prefectures);
}


/// Create a copy of EarthquakeStationsParameter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeStationsParameterCopyWith<_EarthquakeStationsParameter> get copyWith => __$EarthquakeStationsParameterCopyWithImpl<_EarthquakeStationsParameter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeStationsParameterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeStationsParameter&&(identical(other.metadata, metadata) || other.metadata == metadata)&&const DeepCollectionEquality().equals(other._prefectures, _prefectures));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,metadata,const DeepCollectionEquality().hash(_prefectures));

@override
String toString() {
  return 'EarthquakeStationsParameter(metadata: $metadata, prefectures: $prefectures)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeStationsParameterCopyWith<$Res> implements $EarthquakeStationsParameterCopyWith<$Res> {
  factory _$EarthquakeStationsParameterCopyWith(_EarthquakeStationsParameter value, $Res Function(_EarthquakeStationsParameter) _then) = __$EarthquakeStationsParameterCopyWithImpl;
@override @useResult
$Res call({
 ParameterMetadata metadata, List<EarthquakeStationPrefecture> prefectures
});


@override $ParameterMetadataCopyWith<$Res> get metadata;

}
/// @nodoc
class __$EarthquakeStationsParameterCopyWithImpl<$Res>
    implements _$EarthquakeStationsParameterCopyWith<$Res> {
  __$EarthquakeStationsParameterCopyWithImpl(this._self, this._then);

  final _EarthquakeStationsParameter _self;
  final $Res Function(_EarthquakeStationsParameter) _then;

/// Create a copy of EarthquakeStationsParameter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? metadata = null,Object? prefectures = null,}) {
  return _then(_EarthquakeStationsParameter(
metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as ParameterMetadata,prefectures: null == prefectures ? _self._prefectures : prefectures // ignore: cast_nullable_to_non_nullable
as List<EarthquakeStationPrefecture>,
  ));
}

/// Create a copy of EarthquakeStationsParameter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ParameterMetadataCopyWith<$Res> get metadata {
  
  return $ParameterMetadataCopyWith<$Res>(_self.metadata, (value) {
    return _then(_self.copyWith(metadata: value));
  });
}
}

// dart format on
