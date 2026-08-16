// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_telegram_body_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EarthquakeTelegramBodyModel {

 EarthquakeTelegramBodyQuakeModel? get quake; List<EarthquakeTelegramBodyIntensityRegionModel>? get intensityRegions; List<EarthquakeTelegramBodyIntensityRegionModel>? get intensityPrefectures; List<EarthquakeTelegramBodyIntensityRegionModel>? get intensityCities;
/// Create a copy of EarthquakeTelegramBodyModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeTelegramBodyModelCopyWith<EarthquakeTelegramBodyModel> get copyWith => _$EarthquakeTelegramBodyModelCopyWithImpl<EarthquakeTelegramBodyModel>(this as EarthquakeTelegramBodyModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeTelegramBodyModel&&(identical(other.quake, quake) || other.quake == quake)&&const DeepCollectionEquality().equals(other.intensityRegions, intensityRegions)&&const DeepCollectionEquality().equals(other.intensityPrefectures, intensityPrefectures)&&const DeepCollectionEquality().equals(other.intensityCities, intensityCities));
}


@override
int get hashCode => Object.hash(runtimeType,quake,const DeepCollectionEquality().hash(intensityRegions),const DeepCollectionEquality().hash(intensityPrefectures),const DeepCollectionEquality().hash(intensityCities));

@override
String toString() {
  return 'EarthquakeTelegramBodyModel(quake: $quake, intensityRegions: $intensityRegions, intensityPrefectures: $intensityPrefectures, intensityCities: $intensityCities)';
}


}

/// @nodoc
abstract mixin class $EarthquakeTelegramBodyModelCopyWith<$Res>  {
  factory $EarthquakeTelegramBodyModelCopyWith(EarthquakeTelegramBodyModel value, $Res Function(EarthquakeTelegramBodyModel) _then) = _$EarthquakeTelegramBodyModelCopyWithImpl;
@useResult
$Res call({
 EarthquakeTelegramBodyQuakeModel? quake, List<EarthquakeTelegramBodyIntensityRegionModel>? intensityRegions, List<EarthquakeTelegramBodyIntensityRegionModel>? intensityPrefectures, List<EarthquakeTelegramBodyIntensityRegionModel>? intensityCities
});


$EarthquakeTelegramBodyQuakeModelCopyWith<$Res>? get quake;

}
/// @nodoc
class _$EarthquakeTelegramBodyModelCopyWithImpl<$Res>
    implements $EarthquakeTelegramBodyModelCopyWith<$Res> {
  _$EarthquakeTelegramBodyModelCopyWithImpl(this._self, this._then);

  final EarthquakeTelegramBodyModel _self;
  final $Res Function(EarthquakeTelegramBodyModel) _then;

/// Create a copy of EarthquakeTelegramBodyModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? quake = freezed,Object? intensityRegions = freezed,Object? intensityPrefectures = freezed,Object? intensityCities = freezed,}) {
  return _then(EarthquakeTelegramBodyModel(
quake: freezed == quake ? _self.quake : quake // ignore: cast_nullable_to_non_nullable
as EarthquakeTelegramBodyQuakeModel?,intensityRegions: freezed == intensityRegions ? _self.intensityRegions : intensityRegions // ignore: cast_nullable_to_non_nullable
as List<EarthquakeTelegramBodyIntensityRegionModel>?,intensityPrefectures: freezed == intensityPrefectures ? _self.intensityPrefectures : intensityPrefectures // ignore: cast_nullable_to_non_nullable
as List<EarthquakeTelegramBodyIntensityRegionModel>?,intensityCities: freezed == intensityCities ? _self.intensityCities : intensityCities // ignore: cast_nullable_to_non_nullable
as List<EarthquakeTelegramBodyIntensityRegionModel>?,
  ));
}
/// Create a copy of EarthquakeTelegramBodyModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeTelegramBodyQuakeModelCopyWith<$Res>? get quake {
    if (_self.quake == null) {
    return null;
  }

  return $EarthquakeTelegramBodyQuakeModelCopyWith<$Res>(_self.quake!, (value) {
    return _then(_self.copyWith(quake: value));
  });
}
}


/// Adds pattern-matching-related methods to [EarthquakeTelegramBodyModel].
extension EarthquakeTelegramBodyModelPatterns on EarthquakeTelegramBodyModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeTelegramBodyModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeTelegramBodyModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeTelegramBodyModel value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeTelegramBodyModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeTelegramBodyModel value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeTelegramBodyModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( EarthquakeTelegramBodyQuakeModel? quake,  List<EarthquakeTelegramBodyIntensityRegionModel>? intensityRegions,  List<EarthquakeTelegramBodyIntensityRegionModel>? intensityPrefectures,  List<EarthquakeTelegramBodyIntensityRegionModel>? intensityCities)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeTelegramBodyModel() when $default != null:
return $default(_that.quake,_that.intensityRegions,_that.intensityPrefectures,_that.intensityCities);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( EarthquakeTelegramBodyQuakeModel? quake,  List<EarthquakeTelegramBodyIntensityRegionModel>? intensityRegions,  List<EarthquakeTelegramBodyIntensityRegionModel>? intensityPrefectures,  List<EarthquakeTelegramBodyIntensityRegionModel>? intensityCities)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeTelegramBodyModel():
return $default(_that.quake,_that.intensityRegions,_that.intensityPrefectures,_that.intensityCities);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( EarthquakeTelegramBodyQuakeModel? quake,  List<EarthquakeTelegramBodyIntensityRegionModel>? intensityRegions,  List<EarthquakeTelegramBodyIntensityRegionModel>? intensityPrefectures,  List<EarthquakeTelegramBodyIntensityRegionModel>? intensityCities)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeTelegramBodyModel() when $default != null:
return $default(_that.quake,_that.intensityRegions,_that.intensityPrefectures,_that.intensityCities);case _:
  return null;

}
}

}

/// @nodoc


class _EarthquakeTelegramBodyModel implements EarthquakeTelegramBodyModel {
  const _EarthquakeTelegramBodyModel({this.quake,  List<EarthquakeTelegramBodyIntensityRegionModel>? intensityRegions,  List<EarthquakeTelegramBodyIntensityRegionModel>? intensityPrefectures,  List<EarthquakeTelegramBodyIntensityRegionModel>? intensityCities}): _intensityRegions = intensityRegions,_intensityPrefectures = intensityPrefectures,_intensityCities = intensityCities;
  

@override final  EarthquakeTelegramBodyQuakeModel? quake;
 final  List<EarthquakeTelegramBodyIntensityRegionModel>? _intensityRegions;
@override List<EarthquakeTelegramBodyIntensityRegionModel>? get intensityRegions {
  final value = _intensityRegions;
  if (value == null) return null;
  if (_intensityRegions is EqualUnmodifiableListView) return _intensityRegions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<EarthquakeTelegramBodyIntensityRegionModel>? _intensityPrefectures;
@override List<EarthquakeTelegramBodyIntensityRegionModel>? get intensityPrefectures {
  final value = _intensityPrefectures;
  if (value == null) return null;
  if (_intensityPrefectures is EqualUnmodifiableListView) return _intensityPrefectures;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<EarthquakeTelegramBodyIntensityRegionModel>? _intensityCities;
@override List<EarthquakeTelegramBodyIntensityRegionModel>? get intensityCities {
  final value = _intensityCities;
  if (value == null) return null;
  if (_intensityCities is EqualUnmodifiableListView) return _intensityCities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of EarthquakeTelegramBodyModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeTelegramBodyModelCopyWith<_EarthquakeTelegramBodyModel> get copyWith => __$EarthquakeTelegramBodyModelCopyWithImpl<_EarthquakeTelegramBodyModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeTelegramBodyModel&&(identical(other.quake, quake) || other.quake == quake)&&const DeepCollectionEquality().equals(other._intensityRegions, _intensityRegions)&&const DeepCollectionEquality().equals(other._intensityPrefectures, _intensityPrefectures)&&const DeepCollectionEquality().equals(other._intensityCities, _intensityCities));
}


@override
int get hashCode => Object.hash(runtimeType,quake,const DeepCollectionEquality().hash(_intensityRegions),const DeepCollectionEquality().hash(_intensityPrefectures),const DeepCollectionEquality().hash(_intensityCities));

@override
String toString() {
  return 'EarthquakeTelegramBodyModel(quake: $quake, intensityRegions: $intensityRegions, intensityPrefectures: $intensityPrefectures, intensityCities: $intensityCities)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeTelegramBodyModelCopyWith<$Res> implements $EarthquakeTelegramBodyModelCopyWith<$Res> {
  factory _$EarthquakeTelegramBodyModelCopyWith(_EarthquakeTelegramBodyModel value, $Res Function(_EarthquakeTelegramBodyModel) _then) = __$EarthquakeTelegramBodyModelCopyWithImpl;
@override @useResult
$Res call({
 EarthquakeTelegramBodyQuakeModel? quake, List<EarthquakeTelegramBodyIntensityRegionModel>? intensityRegions, List<EarthquakeTelegramBodyIntensityRegionModel>? intensityPrefectures, List<EarthquakeTelegramBodyIntensityRegionModel>? intensityCities
});


@override $EarthquakeTelegramBodyQuakeModelCopyWith<$Res>? get quake;

}
/// @nodoc
class __$EarthquakeTelegramBodyModelCopyWithImpl<$Res>
    implements _$EarthquakeTelegramBodyModelCopyWith<$Res> {
  __$EarthquakeTelegramBodyModelCopyWithImpl(this._self, this._then);

  final _EarthquakeTelegramBodyModel _self;
  final $Res Function(_EarthquakeTelegramBodyModel) _then;

/// Create a copy of EarthquakeTelegramBodyModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? quake = freezed,Object? intensityRegions = freezed,Object? intensityPrefectures = freezed,Object? intensityCities = freezed,}) {
  return _then(_EarthquakeTelegramBodyModel(
quake: freezed == quake ? _self.quake : quake // ignore: cast_nullable_to_non_nullable
as EarthquakeTelegramBodyQuakeModel?,intensityRegions: freezed == intensityRegions ? _self._intensityRegions : intensityRegions // ignore: cast_nullable_to_non_nullable
as List<EarthquakeTelegramBodyIntensityRegionModel>?,intensityPrefectures: freezed == intensityPrefectures ? _self._intensityPrefectures : intensityPrefectures // ignore: cast_nullable_to_non_nullable
as List<EarthquakeTelegramBodyIntensityRegionModel>?,intensityCities: freezed == intensityCities ? _self._intensityCities : intensityCities // ignore: cast_nullable_to_non_nullable
as List<EarthquakeTelegramBodyIntensityRegionModel>?,
  ));
}

/// Create a copy of EarthquakeTelegramBodyModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeTelegramBodyQuakeModelCopyWith<$Res>? get quake {
    if (_self.quake == null) {
    return null;
  }

  return $EarthquakeTelegramBodyQuakeModelCopyWith<$Res>(_self.quake!, (value) {
    return _then(_self.copyWith(quake: value));
  });
}
}

// dart format on
