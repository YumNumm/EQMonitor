// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_v1_extended.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EarthquakeV1Extended {

 EarthquakeV1 get earthquake; List<String>? get maxIntensityRegionNames;
/// Create a copy of EarthquakeV1Extended
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeV1ExtendedCopyWith<EarthquakeV1Extended> get copyWith => _$EarthquakeV1ExtendedCopyWithImpl<EarthquakeV1Extended>(this as EarthquakeV1Extended, _$identity);

  /// Serializes this EarthquakeV1Extended to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeV1Extended&&(identical(other.earthquake, earthquake) || other.earthquake == earthquake)&&const DeepCollectionEquality().equals(other.maxIntensityRegionNames, maxIntensityRegionNames));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,earthquake,const DeepCollectionEquality().hash(maxIntensityRegionNames));

@override
String toString() {
  return 'EarthquakeV1Extended(earthquake: $earthquake, maxIntensityRegionNames: $maxIntensityRegionNames)';
}


}

/// @nodoc
abstract mixin class $EarthquakeV1ExtendedCopyWith<$Res>  {
  factory $EarthquakeV1ExtendedCopyWith(EarthquakeV1Extended value, $Res Function(EarthquakeV1Extended) _then) = _$EarthquakeV1ExtendedCopyWithImpl;
@useResult
$Res call({
 EarthquakeV1 earthquake, List<String>? maxIntensityRegionNames
});


$EarthquakeV1CopyWith<$Res> get earthquake;

}
/// @nodoc
class _$EarthquakeV1ExtendedCopyWithImpl<$Res>
    implements $EarthquakeV1ExtendedCopyWith<$Res> {
  _$EarthquakeV1ExtendedCopyWithImpl(this._self, this._then);

  final EarthquakeV1Extended _self;
  final $Res Function(EarthquakeV1Extended) _then;

/// Create a copy of EarthquakeV1Extended
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? earthquake = null,Object? maxIntensityRegionNames = freezed,}) {
  return _then(_self.copyWith(
earthquake: null == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as EarthquakeV1,maxIntensityRegionNames: freezed == maxIntensityRegionNames ? _self.maxIntensityRegionNames : maxIntensityRegionNames // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}
/// Create a copy of EarthquakeV1Extended
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeV1CopyWith<$Res> get earthquake {
  
  return $EarthquakeV1CopyWith<$Res>(_self.earthquake, (value) {
    return _then(_self.copyWith(earthquake: value));
  });
}
}


/// Adds pattern-matching-related methods to [EarthquakeV1Extended].
extension EarthquakeV1ExtendedPatterns on EarthquakeV1Extended {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeV1Extended value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeV1Extended() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeV1Extended value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeV1Extended():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeV1Extended value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeV1Extended() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( EarthquakeV1 earthquake,  List<String>? maxIntensityRegionNames)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeV1Extended() when $default != null:
return $default(_that.earthquake,_that.maxIntensityRegionNames);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( EarthquakeV1 earthquake,  List<String>? maxIntensityRegionNames)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeV1Extended():
return $default(_that.earthquake,_that.maxIntensityRegionNames);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( EarthquakeV1 earthquake,  List<String>? maxIntensityRegionNames)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeV1Extended() when $default != null:
return $default(_that.earthquake,_that.maxIntensityRegionNames);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarthquakeV1Extended extends EarthquakeV1Extended {
  const _EarthquakeV1Extended({required this.earthquake, required final  List<String>? maxIntensityRegionNames}): _maxIntensityRegionNames = maxIntensityRegionNames,super._();
  factory _EarthquakeV1Extended.fromJson(Map<String, dynamic> json) => _$EarthquakeV1ExtendedFromJson(json);

@override final  EarthquakeV1 earthquake;
 final  List<String>? _maxIntensityRegionNames;
@override List<String>? get maxIntensityRegionNames {
  final value = _maxIntensityRegionNames;
  if (value == null) return null;
  if (_maxIntensityRegionNames is EqualUnmodifiableListView) return _maxIntensityRegionNames;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of EarthquakeV1Extended
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeV1ExtendedCopyWith<_EarthquakeV1Extended> get copyWith => __$EarthquakeV1ExtendedCopyWithImpl<_EarthquakeV1Extended>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeV1ExtendedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeV1Extended&&(identical(other.earthquake, earthquake) || other.earthquake == earthquake)&&const DeepCollectionEquality().equals(other._maxIntensityRegionNames, _maxIntensityRegionNames));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,earthquake,const DeepCollectionEquality().hash(_maxIntensityRegionNames));

@override
String toString() {
  return 'EarthquakeV1Extended(earthquake: $earthquake, maxIntensityRegionNames: $maxIntensityRegionNames)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeV1ExtendedCopyWith<$Res> implements $EarthquakeV1ExtendedCopyWith<$Res> {
  factory _$EarthquakeV1ExtendedCopyWith(_EarthquakeV1Extended value, $Res Function(_EarthquakeV1Extended) _then) = __$EarthquakeV1ExtendedCopyWithImpl;
@override @useResult
$Res call({
 EarthquakeV1 earthquake, List<String>? maxIntensityRegionNames
});


@override $EarthquakeV1CopyWith<$Res> get earthquake;

}
/// @nodoc
class __$EarthquakeV1ExtendedCopyWithImpl<$Res>
    implements _$EarthquakeV1ExtendedCopyWith<$Res> {
  __$EarthquakeV1ExtendedCopyWithImpl(this._self, this._then);

  final _EarthquakeV1Extended _self;
  final $Res Function(_EarthquakeV1Extended) _then;

/// Create a copy of EarthquakeV1Extended
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? earthquake = null,Object? maxIntensityRegionNames = freezed,}) {
  return _then(_EarthquakeV1Extended(
earthquake: null == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as EarthquakeV1,maxIntensityRegionNames: freezed == maxIntensityRegionNames ? _self._maxIntensityRegionNames : maxIntensityRegionNames // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

/// Create a copy of EarthquakeV1Extended
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeV1CopyWith<$Res> get earthquake {
  
  return $EarthquakeV1CopyWith<$Res>(_self.earthquake, (value) {
    return _then(_self.copyWith(earthquake: value));
  });
}
}

// dart format on
