// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_telegram_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EarthquakeTelegramBody {

/// const: "EARTHQUAKE"
 String get type;@JsonKey(includeIfNull: false) EarthquakeTelegramBodyQuake? get earthquake;@JsonKey(includeIfNull: false) List<EarthquakeTelegramBodyIntensityRegion>? get intensityRegions;@JsonKey(includeIfNull: false) List<EarthquakeTelegramBodyIntensityRegion>? get intensityPrefectures;@JsonKey(includeIfNull: false) List<EarthquakeTelegramBodyIntensityRegion>? get intensityCities;@JsonKey(includeIfNull: false) List<EarthquakeTelegramBodyIntensityStation>? get intensityStations;
/// Create a copy of EarthquakeTelegramBody
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeTelegramBodyCopyWith<EarthquakeTelegramBody> get copyWith => _$EarthquakeTelegramBodyCopyWithImpl<EarthquakeTelegramBody>(this as EarthquakeTelegramBody, _$identity);

  /// Serializes this EarthquakeTelegramBody to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeTelegramBody&&(identical(other.type, type) || other.type == type)&&(identical(other.earthquake, earthquake) || other.earthquake == earthquake)&&const DeepCollectionEquality().equals(other.intensityRegions, intensityRegions)&&const DeepCollectionEquality().equals(other.intensityPrefectures, intensityPrefectures)&&const DeepCollectionEquality().equals(other.intensityCities, intensityCities)&&const DeepCollectionEquality().equals(other.intensityStations, intensityStations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,earthquake,const DeepCollectionEquality().hash(intensityRegions),const DeepCollectionEquality().hash(intensityPrefectures),const DeepCollectionEquality().hash(intensityCities),const DeepCollectionEquality().hash(intensityStations));

@override
String toString() {
  return 'EarthquakeTelegramBody(type: $type, earthquake: $earthquake, intensityRegions: $intensityRegions, intensityPrefectures: $intensityPrefectures, intensityCities: $intensityCities, intensityStations: $intensityStations)';
}


}

/// @nodoc
abstract mixin class $EarthquakeTelegramBodyCopyWith<$Res>  {
  factory $EarthquakeTelegramBodyCopyWith(EarthquakeTelegramBody value, $Res Function(EarthquakeTelegramBody) _then) = _$EarthquakeTelegramBodyCopyWithImpl;
@useResult
$Res call({
 String type,@JsonKey(includeIfNull: false) EarthquakeTelegramBodyQuake? earthquake,@JsonKey(includeIfNull: false) List<EarthquakeTelegramBodyIntensityRegion>? intensityRegions,@JsonKey(includeIfNull: false) List<EarthquakeTelegramBodyIntensityRegion>? intensityPrefectures,@JsonKey(includeIfNull: false) List<EarthquakeTelegramBodyIntensityRegion>? intensityCities,@JsonKey(includeIfNull: false) List<EarthquakeTelegramBodyIntensityStation>? intensityStations
});


$EarthquakeTelegramBodyQuakeCopyWith<$Res>? get earthquake;

}
/// @nodoc
class _$EarthquakeTelegramBodyCopyWithImpl<$Res>
    implements $EarthquakeTelegramBodyCopyWith<$Res> {
  _$EarthquakeTelegramBodyCopyWithImpl(this._self, this._then);

  final EarthquakeTelegramBody _self;
  final $Res Function(EarthquakeTelegramBody) _then;

/// Create a copy of EarthquakeTelegramBody
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? earthquake = freezed,Object? intensityRegions = freezed,Object? intensityPrefectures = freezed,Object? intensityCities = freezed,Object? intensityStations = freezed,}) {
  return _then(EarthquakeTelegramBody(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,earthquake: freezed == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as EarthquakeTelegramBodyQuake?,intensityRegions: freezed == intensityRegions ? _self.intensityRegions : intensityRegions // ignore: cast_nullable_to_non_nullable
as List<EarthquakeTelegramBodyIntensityRegion>?,intensityPrefectures: freezed == intensityPrefectures ? _self.intensityPrefectures : intensityPrefectures // ignore: cast_nullable_to_non_nullable
as List<EarthquakeTelegramBodyIntensityRegion>?,intensityCities: freezed == intensityCities ? _self.intensityCities : intensityCities // ignore: cast_nullable_to_non_nullable
as List<EarthquakeTelegramBodyIntensityRegion>?,intensityStations: freezed == intensityStations ? _self.intensityStations : intensityStations // ignore: cast_nullable_to_non_nullable
as List<EarthquakeTelegramBodyIntensityStation>?,
  ));
}
/// Create a copy of EarthquakeTelegramBody
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeTelegramBodyQuakeCopyWith<$Res>? get earthquake {
    if (_self.earthquake == null) {
    return null;
  }

  return $EarthquakeTelegramBodyQuakeCopyWith<$Res>(_self.earthquake!, (value) {
    return _then(_self.copyWith(earthquake: value));
  });
}
}


/// Adds pattern-matching-related methods to [EarthquakeTelegramBody].
extension EarthquakeTelegramBodyPatterns on EarthquakeTelegramBody {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeTelegramBody value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeTelegramBody() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeTelegramBody value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeTelegramBody():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeTelegramBody value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeTelegramBody() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type, @JsonKey(includeIfNull: false)  EarthquakeTelegramBodyQuake? earthquake, @JsonKey(includeIfNull: false)  List<EarthquakeTelegramBodyIntensityRegion>? intensityRegions, @JsonKey(includeIfNull: false)  List<EarthquakeTelegramBodyIntensityRegion>? intensityPrefectures, @JsonKey(includeIfNull: false)  List<EarthquakeTelegramBodyIntensityRegion>? intensityCities, @JsonKey(includeIfNull: false)  List<EarthquakeTelegramBodyIntensityStation>? intensityStations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeTelegramBody() when $default != null:
return $default(_that.type,_that.earthquake,_that.intensityRegions,_that.intensityPrefectures,_that.intensityCities,_that.intensityStations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type, @JsonKey(includeIfNull: false)  EarthquakeTelegramBodyQuake? earthquake, @JsonKey(includeIfNull: false)  List<EarthquakeTelegramBodyIntensityRegion>? intensityRegions, @JsonKey(includeIfNull: false)  List<EarthquakeTelegramBodyIntensityRegion>? intensityPrefectures, @JsonKey(includeIfNull: false)  List<EarthquakeTelegramBodyIntensityRegion>? intensityCities, @JsonKey(includeIfNull: false)  List<EarthquakeTelegramBodyIntensityStation>? intensityStations)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeTelegramBody():
return $default(_that.type,_that.earthquake,_that.intensityRegions,_that.intensityPrefectures,_that.intensityCities,_that.intensityStations);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type, @JsonKey(includeIfNull: false)  EarthquakeTelegramBodyQuake? earthquake, @JsonKey(includeIfNull: false)  List<EarthquakeTelegramBodyIntensityRegion>? intensityRegions, @JsonKey(includeIfNull: false)  List<EarthquakeTelegramBodyIntensityRegion>? intensityPrefectures, @JsonKey(includeIfNull: false)  List<EarthquakeTelegramBodyIntensityRegion>? intensityCities, @JsonKey(includeIfNull: false)  List<EarthquakeTelegramBodyIntensityStation>? intensityStations)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeTelegramBody() when $default != null:
return $default(_that.type,_that.earthquake,_that.intensityRegions,_that.intensityPrefectures,_that.intensityCities,_that.intensityStations);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarthquakeTelegramBody implements EarthquakeTelegramBody {
  const _EarthquakeTelegramBody({required this.type, @JsonKey(includeIfNull: false) this.earthquake, @JsonKey(includeIfNull: false)  List<EarthquakeTelegramBodyIntensityRegion>? intensityRegions, @JsonKey(includeIfNull: false)  List<EarthquakeTelegramBodyIntensityRegion>? intensityPrefectures, @JsonKey(includeIfNull: false)  List<EarthquakeTelegramBodyIntensityRegion>? intensityCities, @JsonKey(includeIfNull: false)  List<EarthquakeTelegramBodyIntensityStation>? intensityStations}): _intensityRegions = intensityRegions,_intensityPrefectures = intensityPrefectures,_intensityCities = intensityCities,_intensityStations = intensityStations;
  factory _EarthquakeTelegramBody.fromJson(Map<String, dynamic> json) => _$EarthquakeTelegramBodyFromJson(json);

/// const: "EARTHQUAKE"
@override final  String type;
@override@JsonKey(includeIfNull: false) final  EarthquakeTelegramBodyQuake? earthquake;
 final  List<EarthquakeTelegramBodyIntensityRegion>? _intensityRegions;
@override@JsonKey(includeIfNull: false) List<EarthquakeTelegramBodyIntensityRegion>? get intensityRegions {
  final value = _intensityRegions;
  if (value == null) return null;
  if (_intensityRegions is EqualUnmodifiableListView) return _intensityRegions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<EarthquakeTelegramBodyIntensityRegion>? _intensityPrefectures;
@override@JsonKey(includeIfNull: false) List<EarthquakeTelegramBodyIntensityRegion>? get intensityPrefectures {
  final value = _intensityPrefectures;
  if (value == null) return null;
  if (_intensityPrefectures is EqualUnmodifiableListView) return _intensityPrefectures;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<EarthquakeTelegramBodyIntensityRegion>? _intensityCities;
@override@JsonKey(includeIfNull: false) List<EarthquakeTelegramBodyIntensityRegion>? get intensityCities {
  final value = _intensityCities;
  if (value == null) return null;
  if (_intensityCities is EqualUnmodifiableListView) return _intensityCities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<EarthquakeTelegramBodyIntensityStation>? _intensityStations;
@override@JsonKey(includeIfNull: false) List<EarthquakeTelegramBodyIntensityStation>? get intensityStations {
  final value = _intensityStations;
  if (value == null) return null;
  if (_intensityStations is EqualUnmodifiableListView) return _intensityStations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of EarthquakeTelegramBody
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeTelegramBodyCopyWith<_EarthquakeTelegramBody> get copyWith => __$EarthquakeTelegramBodyCopyWithImpl<_EarthquakeTelegramBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeTelegramBodyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeTelegramBody&&(identical(other.type, type) || other.type == type)&&(identical(other.earthquake, earthquake) || other.earthquake == earthquake)&&const DeepCollectionEquality().equals(other._intensityRegions, _intensityRegions)&&const DeepCollectionEquality().equals(other._intensityPrefectures, _intensityPrefectures)&&const DeepCollectionEquality().equals(other._intensityCities, _intensityCities)&&const DeepCollectionEquality().equals(other._intensityStations, _intensityStations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,earthquake,const DeepCollectionEquality().hash(_intensityRegions),const DeepCollectionEquality().hash(_intensityPrefectures),const DeepCollectionEquality().hash(_intensityCities),const DeepCollectionEquality().hash(_intensityStations));

@override
String toString() {
  return 'EarthquakeTelegramBody(type: $type, earthquake: $earthquake, intensityRegions: $intensityRegions, intensityPrefectures: $intensityPrefectures, intensityCities: $intensityCities, intensityStations: $intensityStations)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeTelegramBodyCopyWith<$Res> implements $EarthquakeTelegramBodyCopyWith<$Res> {
  factory _$EarthquakeTelegramBodyCopyWith(_EarthquakeTelegramBody value, $Res Function(_EarthquakeTelegramBody) _then) = __$EarthquakeTelegramBodyCopyWithImpl;
@override @useResult
$Res call({
 String type,@JsonKey(includeIfNull: false) EarthquakeTelegramBodyQuake? earthquake,@JsonKey(includeIfNull: false) List<EarthquakeTelegramBodyIntensityRegion>? intensityRegions,@JsonKey(includeIfNull: false) List<EarthquakeTelegramBodyIntensityRegion>? intensityPrefectures,@JsonKey(includeIfNull: false) List<EarthquakeTelegramBodyIntensityRegion>? intensityCities,@JsonKey(includeIfNull: false) List<EarthquakeTelegramBodyIntensityStation>? intensityStations
});


@override $EarthquakeTelegramBodyQuakeCopyWith<$Res>? get earthquake;

}
/// @nodoc
class __$EarthquakeTelegramBodyCopyWithImpl<$Res>
    implements _$EarthquakeTelegramBodyCopyWith<$Res> {
  __$EarthquakeTelegramBodyCopyWithImpl(this._self, this._then);

  final _EarthquakeTelegramBody _self;
  final $Res Function(_EarthquakeTelegramBody) _then;

/// Create a copy of EarthquakeTelegramBody
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? earthquake = freezed,Object? intensityRegions = freezed,Object? intensityPrefectures = freezed,Object? intensityCities = freezed,Object? intensityStations = freezed,}) {
  return _then(_EarthquakeTelegramBody(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,earthquake: freezed == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as EarthquakeTelegramBodyQuake?,intensityRegions: freezed == intensityRegions ? _self._intensityRegions : intensityRegions // ignore: cast_nullable_to_non_nullable
as List<EarthquakeTelegramBodyIntensityRegion>?,intensityPrefectures: freezed == intensityPrefectures ? _self._intensityPrefectures : intensityPrefectures // ignore: cast_nullable_to_non_nullable
as List<EarthquakeTelegramBodyIntensityRegion>?,intensityCities: freezed == intensityCities ? _self._intensityCities : intensityCities // ignore: cast_nullable_to_non_nullable
as List<EarthquakeTelegramBodyIntensityRegion>?,intensityStations: freezed == intensityStations ? _self._intensityStations : intensityStations // ignore: cast_nullable_to_non_nullable
as List<EarthquakeTelegramBodyIntensityStation>?,
  ));
}

/// Create a copy of EarthquakeTelegramBody
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeTelegramBodyQuakeCopyWith<$Res>? get earthquake {
    if (_self.earthquake == null) {
    return null;
  }

  return $EarthquakeTelegramBodyQuakeCopyWith<$Res>(_self.earthquake!, (value) {
    return _then(_self.copyWith(earthquake: value));
  });
}
}

// dart format on
