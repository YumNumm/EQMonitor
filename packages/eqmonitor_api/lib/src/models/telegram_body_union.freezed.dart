// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'telegram_body_union.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
TelegramBodyUnion _$TelegramBodyUnionFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'earthquakeTelegramBody':
          return TelegramBodyUnionEarthquakeTelegramBody.fromJson(
            json
          );
                case 'eewTelegramBody':
          return TelegramBodyUnionEewTelegramBody.fromJson(
            json
          );
                case 'earthquakeNoticeTelegramBody':
          return TelegramBodyUnionEarthquakeNoticeTelegramBody.fromJson(
            json
          );
                case 'earthquakeExplanationTelegramBody':
          return TelegramBodyUnionEarthquakeExplanationTelegramBody.fromJson(
            json
          );
                case 'earthquakeCountsTelegramBody':
          return TelegramBodyUnionEarthquakeCountsTelegramBody.fromJson(
            json
          );
                case 'earthquakeNankaiTelegramBody':
          return TelegramBodyUnionEarthquakeNankaiTelegramBody.fromJson(
            json
          );
                case 'fallbackTelegramBody':
          return TelegramBodyUnionFallbackTelegramBody.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'TelegramBodyUnion',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$TelegramBodyUnion {

/// const: "EARTHQUAKE"
 String get type;
/// Create a copy of TelegramBodyUnion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TelegramBodyUnionCopyWith<TelegramBodyUnion> get copyWith => _$TelegramBodyUnionCopyWithImpl<TelegramBodyUnion>(this as TelegramBodyUnion, _$identity);

  /// Serializes this TelegramBodyUnion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TelegramBodyUnion&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type);

@override
String toString() {
  return 'TelegramBodyUnion(type: $type)';
}


}

/// @nodoc
abstract mixin class $TelegramBodyUnionCopyWith<$Res>  {
  factory $TelegramBodyUnionCopyWith(TelegramBodyUnion value, $Res Function(TelegramBodyUnion) _then) = _$TelegramBodyUnionCopyWithImpl;
@useResult
$Res call({
 String type
});




}
/// @nodoc
class _$TelegramBodyUnionCopyWithImpl<$Res>
    implements $TelegramBodyUnionCopyWith<$Res> {
  _$TelegramBodyUnionCopyWithImpl(this._self, this._then);

  final TelegramBodyUnion _self;
  final $Res Function(TelegramBodyUnion) _then;

/// Create a copy of TelegramBodyUnion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TelegramBodyUnion].
extension TelegramBodyUnionPatterns on TelegramBodyUnion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( TelegramBodyUnionEarthquakeTelegramBody value)?  earthquakeTelegramBody,TResult Function( TelegramBodyUnionEewTelegramBody value)?  eewTelegramBody,TResult Function( TelegramBodyUnionEarthquakeNoticeTelegramBody value)?  earthquakeNoticeTelegramBody,TResult Function( TelegramBodyUnionEarthquakeExplanationTelegramBody value)?  earthquakeExplanationTelegramBody,TResult Function( TelegramBodyUnionEarthquakeCountsTelegramBody value)?  earthquakeCountsTelegramBody,TResult Function( TelegramBodyUnionEarthquakeNankaiTelegramBody value)?  earthquakeNankaiTelegramBody,TResult Function( TelegramBodyUnionFallbackTelegramBody value)?  fallbackTelegramBody,required TResult orElse(),}){
final _that = this;
switch (_that) {
case TelegramBodyUnionEarthquakeTelegramBody() when earthquakeTelegramBody != null:
return earthquakeTelegramBody(_that);case TelegramBodyUnionEewTelegramBody() when eewTelegramBody != null:
return eewTelegramBody(_that);case TelegramBodyUnionEarthquakeNoticeTelegramBody() when earthquakeNoticeTelegramBody != null:
return earthquakeNoticeTelegramBody(_that);case TelegramBodyUnionEarthquakeExplanationTelegramBody() when earthquakeExplanationTelegramBody != null:
return earthquakeExplanationTelegramBody(_that);case TelegramBodyUnionEarthquakeCountsTelegramBody() when earthquakeCountsTelegramBody != null:
return earthquakeCountsTelegramBody(_that);case TelegramBodyUnionEarthquakeNankaiTelegramBody() when earthquakeNankaiTelegramBody != null:
return earthquakeNankaiTelegramBody(_that);case TelegramBodyUnionFallbackTelegramBody() when fallbackTelegramBody != null:
return fallbackTelegramBody(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( TelegramBodyUnionEarthquakeTelegramBody value)  earthquakeTelegramBody,required TResult Function( TelegramBodyUnionEewTelegramBody value)  eewTelegramBody,required TResult Function( TelegramBodyUnionEarthquakeNoticeTelegramBody value)  earthquakeNoticeTelegramBody,required TResult Function( TelegramBodyUnionEarthquakeExplanationTelegramBody value)  earthquakeExplanationTelegramBody,required TResult Function( TelegramBodyUnionEarthquakeCountsTelegramBody value)  earthquakeCountsTelegramBody,required TResult Function( TelegramBodyUnionEarthquakeNankaiTelegramBody value)  earthquakeNankaiTelegramBody,required TResult Function( TelegramBodyUnionFallbackTelegramBody value)  fallbackTelegramBody,}){
final _that = this;
switch (_that) {
case TelegramBodyUnionEarthquakeTelegramBody():
return earthquakeTelegramBody(_that);case TelegramBodyUnionEewTelegramBody():
return eewTelegramBody(_that);case TelegramBodyUnionEarthquakeNoticeTelegramBody():
return earthquakeNoticeTelegramBody(_that);case TelegramBodyUnionEarthquakeExplanationTelegramBody():
return earthquakeExplanationTelegramBody(_that);case TelegramBodyUnionEarthquakeCountsTelegramBody():
return earthquakeCountsTelegramBody(_that);case TelegramBodyUnionEarthquakeNankaiTelegramBody():
return earthquakeNankaiTelegramBody(_that);case TelegramBodyUnionFallbackTelegramBody():
return fallbackTelegramBody(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( TelegramBodyUnionEarthquakeTelegramBody value)?  earthquakeTelegramBody,TResult? Function( TelegramBodyUnionEewTelegramBody value)?  eewTelegramBody,TResult? Function( TelegramBodyUnionEarthquakeNoticeTelegramBody value)?  earthquakeNoticeTelegramBody,TResult? Function( TelegramBodyUnionEarthquakeExplanationTelegramBody value)?  earthquakeExplanationTelegramBody,TResult? Function( TelegramBodyUnionEarthquakeCountsTelegramBody value)?  earthquakeCountsTelegramBody,TResult? Function( TelegramBodyUnionEarthquakeNankaiTelegramBody value)?  earthquakeNankaiTelegramBody,TResult? Function( TelegramBodyUnionFallbackTelegramBody value)?  fallbackTelegramBody,}){
final _that = this;
switch (_that) {
case TelegramBodyUnionEarthquakeTelegramBody() when earthquakeTelegramBody != null:
return earthquakeTelegramBody(_that);case TelegramBodyUnionEewTelegramBody() when eewTelegramBody != null:
return eewTelegramBody(_that);case TelegramBodyUnionEarthquakeNoticeTelegramBody() when earthquakeNoticeTelegramBody != null:
return earthquakeNoticeTelegramBody(_that);case TelegramBodyUnionEarthquakeExplanationTelegramBody() when earthquakeExplanationTelegramBody != null:
return earthquakeExplanationTelegramBody(_that);case TelegramBodyUnionEarthquakeCountsTelegramBody() when earthquakeCountsTelegramBody != null:
return earthquakeCountsTelegramBody(_that);case TelegramBodyUnionEarthquakeNankaiTelegramBody() when earthquakeNankaiTelegramBody != null:
return earthquakeNankaiTelegramBody(_that);case TelegramBodyUnionFallbackTelegramBody() when fallbackTelegramBody != null:
return fallbackTelegramBody(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String type, @JsonKey(includeIfNull: false)  EarthquakeTelegramBodyQuake? earthquake, @JsonKey(includeIfNull: false)  List<EarthquakeTelegramBodyIntensityRegion>? intensityRegions, @JsonKey(includeIfNull: false)  List<EarthquakeTelegramBodyIntensityRegion>? intensityPrefectures, @JsonKey(includeIfNull: false)  List<EarthquakeTelegramBodyIntensityRegion>? intensityCities, @JsonKey(includeIfNull: false)  List<EarthquakeTelegramBodyIntensityStation>? intensityStations)?  earthquakeTelegramBody,TResult Function( String type,  Object? eew,  List<Object?> eewIntensityRegions,  List<Object?> eewWarningZones,  List<Object?> eewWarningPrefectures,  List<Object?> eewWarningRegions)?  eewTelegramBody,TResult Function( String type)?  earthquakeNoticeTelegramBody,TResult Function( String type,  String text)?  earthquakeExplanationTelegramBody,TResult Function( String type)?  earthquakeCountsTelegramBody,TResult Function( String type)?  earthquakeNankaiTelegramBody,TResult Function( String type)?  fallbackTelegramBody,required TResult orElse(),}) {final _that = this;
switch (_that) {
case TelegramBodyUnionEarthquakeTelegramBody() when earthquakeTelegramBody != null:
return earthquakeTelegramBody(_that.type,_that.earthquake,_that.intensityRegions,_that.intensityPrefectures,_that.intensityCities,_that.intensityStations);case TelegramBodyUnionEewTelegramBody() when eewTelegramBody != null:
return eewTelegramBody(_that.type,_that.eew,_that.eewIntensityRegions,_that.eewWarningZones,_that.eewWarningPrefectures,_that.eewWarningRegions);case TelegramBodyUnionEarthquakeNoticeTelegramBody() when earthquakeNoticeTelegramBody != null:
return earthquakeNoticeTelegramBody(_that.type);case TelegramBodyUnionEarthquakeExplanationTelegramBody() when earthquakeExplanationTelegramBody != null:
return earthquakeExplanationTelegramBody(_that.type,_that.text);case TelegramBodyUnionEarthquakeCountsTelegramBody() when earthquakeCountsTelegramBody != null:
return earthquakeCountsTelegramBody(_that.type);case TelegramBodyUnionEarthquakeNankaiTelegramBody() when earthquakeNankaiTelegramBody != null:
return earthquakeNankaiTelegramBody(_that.type);case TelegramBodyUnionFallbackTelegramBody() when fallbackTelegramBody != null:
return fallbackTelegramBody(_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String type, @JsonKey(includeIfNull: false)  EarthquakeTelegramBodyQuake? earthquake, @JsonKey(includeIfNull: false)  List<EarthquakeTelegramBodyIntensityRegion>? intensityRegions, @JsonKey(includeIfNull: false)  List<EarthquakeTelegramBodyIntensityRegion>? intensityPrefectures, @JsonKey(includeIfNull: false)  List<EarthquakeTelegramBodyIntensityRegion>? intensityCities, @JsonKey(includeIfNull: false)  List<EarthquakeTelegramBodyIntensityStation>? intensityStations)  earthquakeTelegramBody,required TResult Function( String type,  Object? eew,  List<Object?> eewIntensityRegions,  List<Object?> eewWarningZones,  List<Object?> eewWarningPrefectures,  List<Object?> eewWarningRegions)  eewTelegramBody,required TResult Function( String type)  earthquakeNoticeTelegramBody,required TResult Function( String type,  String text)  earthquakeExplanationTelegramBody,required TResult Function( String type)  earthquakeCountsTelegramBody,required TResult Function( String type)  earthquakeNankaiTelegramBody,required TResult Function( String type)  fallbackTelegramBody,}) {final _that = this;
switch (_that) {
case TelegramBodyUnionEarthquakeTelegramBody():
return earthquakeTelegramBody(_that.type,_that.earthquake,_that.intensityRegions,_that.intensityPrefectures,_that.intensityCities,_that.intensityStations);case TelegramBodyUnionEewTelegramBody():
return eewTelegramBody(_that.type,_that.eew,_that.eewIntensityRegions,_that.eewWarningZones,_that.eewWarningPrefectures,_that.eewWarningRegions);case TelegramBodyUnionEarthquakeNoticeTelegramBody():
return earthquakeNoticeTelegramBody(_that.type);case TelegramBodyUnionEarthquakeExplanationTelegramBody():
return earthquakeExplanationTelegramBody(_that.type,_that.text);case TelegramBodyUnionEarthquakeCountsTelegramBody():
return earthquakeCountsTelegramBody(_that.type);case TelegramBodyUnionEarthquakeNankaiTelegramBody():
return earthquakeNankaiTelegramBody(_that.type);case TelegramBodyUnionFallbackTelegramBody():
return fallbackTelegramBody(_that.type);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String type, @JsonKey(includeIfNull: false)  EarthquakeTelegramBodyQuake? earthquake, @JsonKey(includeIfNull: false)  List<EarthquakeTelegramBodyIntensityRegion>? intensityRegions, @JsonKey(includeIfNull: false)  List<EarthquakeTelegramBodyIntensityRegion>? intensityPrefectures, @JsonKey(includeIfNull: false)  List<EarthquakeTelegramBodyIntensityRegion>? intensityCities, @JsonKey(includeIfNull: false)  List<EarthquakeTelegramBodyIntensityStation>? intensityStations)?  earthquakeTelegramBody,TResult? Function( String type,  Object? eew,  List<Object?> eewIntensityRegions,  List<Object?> eewWarningZones,  List<Object?> eewWarningPrefectures,  List<Object?> eewWarningRegions)?  eewTelegramBody,TResult? Function( String type)?  earthquakeNoticeTelegramBody,TResult? Function( String type,  String text)?  earthquakeExplanationTelegramBody,TResult? Function( String type)?  earthquakeCountsTelegramBody,TResult? Function( String type)?  earthquakeNankaiTelegramBody,TResult? Function( String type)?  fallbackTelegramBody,}) {final _that = this;
switch (_that) {
case TelegramBodyUnionEarthquakeTelegramBody() when earthquakeTelegramBody != null:
return earthquakeTelegramBody(_that.type,_that.earthquake,_that.intensityRegions,_that.intensityPrefectures,_that.intensityCities,_that.intensityStations);case TelegramBodyUnionEewTelegramBody() when eewTelegramBody != null:
return eewTelegramBody(_that.type,_that.eew,_that.eewIntensityRegions,_that.eewWarningZones,_that.eewWarningPrefectures,_that.eewWarningRegions);case TelegramBodyUnionEarthquakeNoticeTelegramBody() when earthquakeNoticeTelegramBody != null:
return earthquakeNoticeTelegramBody(_that.type);case TelegramBodyUnionEarthquakeExplanationTelegramBody() when earthquakeExplanationTelegramBody != null:
return earthquakeExplanationTelegramBody(_that.type,_that.text);case TelegramBodyUnionEarthquakeCountsTelegramBody() when earthquakeCountsTelegramBody != null:
return earthquakeCountsTelegramBody(_that.type);case TelegramBodyUnionEarthquakeNankaiTelegramBody() when earthquakeNankaiTelegramBody != null:
return earthquakeNankaiTelegramBody(_that.type);case TelegramBodyUnionFallbackTelegramBody() when fallbackTelegramBody != null:
return fallbackTelegramBody(_that.type);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable()
class TelegramBodyUnionEarthquakeTelegramBody implements TelegramBodyUnion {
  const TelegramBodyUnionEarthquakeTelegramBody({required this.type, @JsonKey(includeIfNull: false) this.earthquake, @JsonKey(includeIfNull: false)  List<EarthquakeTelegramBodyIntensityRegion>? intensityRegions, @JsonKey(includeIfNull: false)  List<EarthquakeTelegramBodyIntensityRegion>? intensityPrefectures, @JsonKey(includeIfNull: false)  List<EarthquakeTelegramBodyIntensityRegion>? intensityCities, @JsonKey(includeIfNull: false)  List<EarthquakeTelegramBodyIntensityStation>? intensityStations,  String? $type}): _intensityRegions = intensityRegions,_intensityPrefectures = intensityPrefectures,_intensityCities = intensityCities,_intensityStations = intensityStations,$type = $type ?? 'earthquakeTelegramBody';
  factory TelegramBodyUnionEarthquakeTelegramBody.fromJson(Map<String, dynamic> json) => _$TelegramBodyUnionEarthquakeTelegramBodyFromJson(json);

/// const: "EARTHQUAKE"
@override final  String type;
@JsonKey(includeIfNull: false) final  EarthquakeTelegramBodyQuake? earthquake;
 final  List<EarthquakeTelegramBodyIntensityRegion>? _intensityRegions;
@JsonKey(includeIfNull: false) List<EarthquakeTelegramBodyIntensityRegion>? get intensityRegions {
  final value = _intensityRegions;
  if (value == null) return null;
  if (_intensityRegions is EqualUnmodifiableListView) return _intensityRegions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<EarthquakeTelegramBodyIntensityRegion>? _intensityPrefectures;
@JsonKey(includeIfNull: false) List<EarthquakeTelegramBodyIntensityRegion>? get intensityPrefectures {
  final value = _intensityPrefectures;
  if (value == null) return null;
  if (_intensityPrefectures is EqualUnmodifiableListView) return _intensityPrefectures;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<EarthquakeTelegramBodyIntensityRegion>? _intensityCities;
@JsonKey(includeIfNull: false) List<EarthquakeTelegramBodyIntensityRegion>? get intensityCities {
  final value = _intensityCities;
  if (value == null) return null;
  if (_intensityCities is EqualUnmodifiableListView) return _intensityCities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<EarthquakeTelegramBodyIntensityStation>? _intensityStations;
@JsonKey(includeIfNull: false) List<EarthquakeTelegramBodyIntensityStation>? get intensityStations {
  final value = _intensityStations;
  if (value == null) return null;
  if (_intensityStations is EqualUnmodifiableListView) return _intensityStations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of TelegramBodyUnion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TelegramBodyUnionEarthquakeTelegramBodyCopyWith<TelegramBodyUnionEarthquakeTelegramBody> get copyWith => _$TelegramBodyUnionEarthquakeTelegramBodyCopyWithImpl<TelegramBodyUnionEarthquakeTelegramBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TelegramBodyUnionEarthquakeTelegramBodyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TelegramBodyUnionEarthquakeTelegramBody&&(identical(other.type, type) || other.type == type)&&(identical(other.earthquake, earthquake) || other.earthquake == earthquake)&&const DeepCollectionEquality().equals(other._intensityRegions, _intensityRegions)&&const DeepCollectionEquality().equals(other._intensityPrefectures, _intensityPrefectures)&&const DeepCollectionEquality().equals(other._intensityCities, _intensityCities)&&const DeepCollectionEquality().equals(other._intensityStations, _intensityStations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,earthquake,const DeepCollectionEquality().hash(_intensityRegions),const DeepCollectionEquality().hash(_intensityPrefectures),const DeepCollectionEquality().hash(_intensityCities),const DeepCollectionEquality().hash(_intensityStations));

@override
String toString() {
  return 'TelegramBodyUnion.earthquakeTelegramBody(type: $type, earthquake: $earthquake, intensityRegions: $intensityRegions, intensityPrefectures: $intensityPrefectures, intensityCities: $intensityCities, intensityStations: $intensityStations)';
}


}

/// @nodoc
abstract mixin class $TelegramBodyUnionEarthquakeTelegramBodyCopyWith<$Res> implements $TelegramBodyUnionCopyWith<$Res> {
  factory $TelegramBodyUnionEarthquakeTelegramBodyCopyWith(TelegramBodyUnionEarthquakeTelegramBody value, $Res Function(TelegramBodyUnionEarthquakeTelegramBody) _then) = _$TelegramBodyUnionEarthquakeTelegramBodyCopyWithImpl;
@override @useResult
$Res call({
 String type,@JsonKey(includeIfNull: false) EarthquakeTelegramBodyQuake? earthquake,@JsonKey(includeIfNull: false) List<EarthquakeTelegramBodyIntensityRegion>? intensityRegions,@JsonKey(includeIfNull: false) List<EarthquakeTelegramBodyIntensityRegion>? intensityPrefectures,@JsonKey(includeIfNull: false) List<EarthquakeTelegramBodyIntensityRegion>? intensityCities,@JsonKey(includeIfNull: false) List<EarthquakeTelegramBodyIntensityStation>? intensityStations
});


$EarthquakeTelegramBodyQuakeCopyWith<$Res>? get earthquake;

}
/// @nodoc
class _$TelegramBodyUnionEarthquakeTelegramBodyCopyWithImpl<$Res>
    implements $TelegramBodyUnionEarthquakeTelegramBodyCopyWith<$Res> {
  _$TelegramBodyUnionEarthquakeTelegramBodyCopyWithImpl(this._self, this._then);

  final TelegramBodyUnionEarthquakeTelegramBody _self;
  final $Res Function(TelegramBodyUnionEarthquakeTelegramBody) _then;

/// Create a copy of TelegramBodyUnion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? earthquake = freezed,Object? intensityRegions = freezed,Object? intensityPrefectures = freezed,Object? intensityCities = freezed,Object? intensityStations = freezed,}) {
  return _then(TelegramBodyUnionEarthquakeTelegramBody(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,earthquake: freezed == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as EarthquakeTelegramBodyQuake?,intensityRegions: freezed == intensityRegions ? _self._intensityRegions : intensityRegions // ignore: cast_nullable_to_non_nullable
as List<EarthquakeTelegramBodyIntensityRegion>?,intensityPrefectures: freezed == intensityPrefectures ? _self._intensityPrefectures : intensityPrefectures // ignore: cast_nullable_to_non_nullable
as List<EarthquakeTelegramBodyIntensityRegion>?,intensityCities: freezed == intensityCities ? _self._intensityCities : intensityCities // ignore: cast_nullable_to_non_nullable
as List<EarthquakeTelegramBodyIntensityRegion>?,intensityStations: freezed == intensityStations ? _self._intensityStations : intensityStations // ignore: cast_nullable_to_non_nullable
as List<EarthquakeTelegramBodyIntensityStation>?,
  ));
}

/// Create a copy of TelegramBodyUnion
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

/// @nodoc

@JsonSerializable()
class TelegramBodyUnionEewTelegramBody implements TelegramBodyUnion {
  const TelegramBodyUnionEewTelegramBody({required this.type, required this.eew, required  List<Object?> eewIntensityRegions, required  List<Object?> eewWarningZones, required  List<Object?> eewWarningPrefectures, required  List<Object?> eewWarningRegions,  String? $type}): _eewIntensityRegions = eewIntensityRegions,_eewWarningZones = eewWarningZones,_eewWarningPrefectures = eewWarningPrefectures,_eewWarningRegions = eewWarningRegions,$type = $type ?? 'eewTelegramBody';
  factory TelegramBodyUnionEewTelegramBody.fromJson(Map<String, dynamic> json) => _$TelegramBodyUnionEewTelegramBodyFromJson(json);

/// const: "EEW"
@override final  String type;
 final  Object? eew;
 final  List<Object?> _eewIntensityRegions;
 List<Object?> get eewIntensityRegions {
  if (_eewIntensityRegions is EqualUnmodifiableListView) return _eewIntensityRegions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_eewIntensityRegions);
}

 final  List<Object?> _eewWarningZones;
 List<Object?> get eewWarningZones {
  if (_eewWarningZones is EqualUnmodifiableListView) return _eewWarningZones;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_eewWarningZones);
}

 final  List<Object?> _eewWarningPrefectures;
 List<Object?> get eewWarningPrefectures {
  if (_eewWarningPrefectures is EqualUnmodifiableListView) return _eewWarningPrefectures;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_eewWarningPrefectures);
}

 final  List<Object?> _eewWarningRegions;
 List<Object?> get eewWarningRegions {
  if (_eewWarningRegions is EqualUnmodifiableListView) return _eewWarningRegions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_eewWarningRegions);
}


@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of TelegramBodyUnion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TelegramBodyUnionEewTelegramBodyCopyWith<TelegramBodyUnionEewTelegramBody> get copyWith => _$TelegramBodyUnionEewTelegramBodyCopyWithImpl<TelegramBodyUnionEewTelegramBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TelegramBodyUnionEewTelegramBodyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TelegramBodyUnionEewTelegramBody&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.eew, eew)&&const DeepCollectionEquality().equals(other._eewIntensityRegions, _eewIntensityRegions)&&const DeepCollectionEquality().equals(other._eewWarningZones, _eewWarningZones)&&const DeepCollectionEquality().equals(other._eewWarningPrefectures, _eewWarningPrefectures)&&const DeepCollectionEquality().equals(other._eewWarningRegions, _eewWarningRegions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,const DeepCollectionEquality().hash(eew),const DeepCollectionEquality().hash(_eewIntensityRegions),const DeepCollectionEquality().hash(_eewWarningZones),const DeepCollectionEquality().hash(_eewWarningPrefectures),const DeepCollectionEquality().hash(_eewWarningRegions));

@override
String toString() {
  return 'TelegramBodyUnion.eewTelegramBody(type: $type, eew: $eew, eewIntensityRegions: $eewIntensityRegions, eewWarningZones: $eewWarningZones, eewWarningPrefectures: $eewWarningPrefectures, eewWarningRegions: $eewWarningRegions)';
}


}

/// @nodoc
abstract mixin class $TelegramBodyUnionEewTelegramBodyCopyWith<$Res> implements $TelegramBodyUnionCopyWith<$Res> {
  factory $TelegramBodyUnionEewTelegramBodyCopyWith(TelegramBodyUnionEewTelegramBody value, $Res Function(TelegramBodyUnionEewTelegramBody) _then) = _$TelegramBodyUnionEewTelegramBodyCopyWithImpl;
@override @useResult
$Res call({
 String type, Object? eew, List<Object?> eewIntensityRegions, List<Object?> eewWarningZones, List<Object?> eewWarningPrefectures, List<Object?> eewWarningRegions
});




}
/// @nodoc
class _$TelegramBodyUnionEewTelegramBodyCopyWithImpl<$Res>
    implements $TelegramBodyUnionEewTelegramBodyCopyWith<$Res> {
  _$TelegramBodyUnionEewTelegramBodyCopyWithImpl(this._self, this._then);

  final TelegramBodyUnionEewTelegramBody _self;
  final $Res Function(TelegramBodyUnionEewTelegramBody) _then;

/// Create a copy of TelegramBodyUnion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? eew = freezed,Object? eewIntensityRegions = null,Object? eewWarningZones = null,Object? eewWarningPrefectures = null,Object? eewWarningRegions = null,}) {
  return _then(TelegramBodyUnionEewTelegramBody(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,eew: freezed == eew ? _self.eew : eew ,eewIntensityRegions: null == eewIntensityRegions ? _self._eewIntensityRegions : eewIntensityRegions // ignore: cast_nullable_to_non_nullable
as List<Object?>,eewWarningZones: null == eewWarningZones ? _self._eewWarningZones : eewWarningZones // ignore: cast_nullable_to_non_nullable
as List<Object?>,eewWarningPrefectures: null == eewWarningPrefectures ? _self._eewWarningPrefectures : eewWarningPrefectures // ignore: cast_nullable_to_non_nullable
as List<Object?>,eewWarningRegions: null == eewWarningRegions ? _self._eewWarningRegions : eewWarningRegions // ignore: cast_nullable_to_non_nullable
as List<Object?>,
  ));
}


}

/// @nodoc

@JsonSerializable()
class TelegramBodyUnionEarthquakeNoticeTelegramBody implements TelegramBodyUnion {
  const TelegramBodyUnionEarthquakeNoticeTelegramBody({required this.type,  String? $type}): $type = $type ?? 'earthquakeNoticeTelegramBody';
  factory TelegramBodyUnionEarthquakeNoticeTelegramBody.fromJson(Map<String, dynamic> json) => _$TelegramBodyUnionEarthquakeNoticeTelegramBodyFromJson(json);

/// const: "EARTHQUAKE_NOTICE"
@override final  String type;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of TelegramBodyUnion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TelegramBodyUnionEarthquakeNoticeTelegramBodyCopyWith<TelegramBodyUnionEarthquakeNoticeTelegramBody> get copyWith => _$TelegramBodyUnionEarthquakeNoticeTelegramBodyCopyWithImpl<TelegramBodyUnionEarthquakeNoticeTelegramBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TelegramBodyUnionEarthquakeNoticeTelegramBodyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TelegramBodyUnionEarthquakeNoticeTelegramBody&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type);

@override
String toString() {
  return 'TelegramBodyUnion.earthquakeNoticeTelegramBody(type: $type)';
}


}

/// @nodoc
abstract mixin class $TelegramBodyUnionEarthquakeNoticeTelegramBodyCopyWith<$Res> implements $TelegramBodyUnionCopyWith<$Res> {
  factory $TelegramBodyUnionEarthquakeNoticeTelegramBodyCopyWith(TelegramBodyUnionEarthquakeNoticeTelegramBody value, $Res Function(TelegramBodyUnionEarthquakeNoticeTelegramBody) _then) = _$TelegramBodyUnionEarthquakeNoticeTelegramBodyCopyWithImpl;
@override @useResult
$Res call({
 String type
});




}
/// @nodoc
class _$TelegramBodyUnionEarthquakeNoticeTelegramBodyCopyWithImpl<$Res>
    implements $TelegramBodyUnionEarthquakeNoticeTelegramBodyCopyWith<$Res> {
  _$TelegramBodyUnionEarthquakeNoticeTelegramBodyCopyWithImpl(this._self, this._then);

  final TelegramBodyUnionEarthquakeNoticeTelegramBody _self;
  final $Res Function(TelegramBodyUnionEarthquakeNoticeTelegramBody) _then;

/// Create a copy of TelegramBodyUnion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,}) {
  return _then(TelegramBodyUnionEarthquakeNoticeTelegramBody(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc

@JsonSerializable()
class TelegramBodyUnionEarthquakeExplanationTelegramBody implements TelegramBodyUnion {
  const TelegramBodyUnionEarthquakeExplanationTelegramBody({required this.type, required this.text,  String? $type}): $type = $type ?? 'earthquakeExplanationTelegramBody';
  factory TelegramBodyUnionEarthquakeExplanationTelegramBody.fromJson(Map<String, dynamic> json) => _$TelegramBodyUnionEarthquakeExplanationTelegramBodyFromJson(json);

/// const: "EARTHQUAKE_EXPLANATION"
@override final  String type;
 final  String text;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of TelegramBodyUnion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TelegramBodyUnionEarthquakeExplanationTelegramBodyCopyWith<TelegramBodyUnionEarthquakeExplanationTelegramBody> get copyWith => _$TelegramBodyUnionEarthquakeExplanationTelegramBodyCopyWithImpl<TelegramBodyUnionEarthquakeExplanationTelegramBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TelegramBodyUnionEarthquakeExplanationTelegramBodyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TelegramBodyUnionEarthquakeExplanationTelegramBody&&(identical(other.type, type) || other.type == type)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,text);

@override
String toString() {
  return 'TelegramBodyUnion.earthquakeExplanationTelegramBody(type: $type, text: $text)';
}


}

/// @nodoc
abstract mixin class $TelegramBodyUnionEarthquakeExplanationTelegramBodyCopyWith<$Res> implements $TelegramBodyUnionCopyWith<$Res> {
  factory $TelegramBodyUnionEarthquakeExplanationTelegramBodyCopyWith(TelegramBodyUnionEarthquakeExplanationTelegramBody value, $Res Function(TelegramBodyUnionEarthquakeExplanationTelegramBody) _then) = _$TelegramBodyUnionEarthquakeExplanationTelegramBodyCopyWithImpl;
@override @useResult
$Res call({
 String type, String text
});




}
/// @nodoc
class _$TelegramBodyUnionEarthquakeExplanationTelegramBodyCopyWithImpl<$Res>
    implements $TelegramBodyUnionEarthquakeExplanationTelegramBodyCopyWith<$Res> {
  _$TelegramBodyUnionEarthquakeExplanationTelegramBodyCopyWithImpl(this._self, this._then);

  final TelegramBodyUnionEarthquakeExplanationTelegramBody _self;
  final $Res Function(TelegramBodyUnionEarthquakeExplanationTelegramBody) _then;

/// Create a copy of TelegramBodyUnion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? text = null,}) {
  return _then(TelegramBodyUnionEarthquakeExplanationTelegramBody(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc

@JsonSerializable()
class TelegramBodyUnionEarthquakeCountsTelegramBody implements TelegramBodyUnion {
  const TelegramBodyUnionEarthquakeCountsTelegramBody({required this.type,  String? $type}): $type = $type ?? 'earthquakeCountsTelegramBody';
  factory TelegramBodyUnionEarthquakeCountsTelegramBody.fromJson(Map<String, dynamic> json) => _$TelegramBodyUnionEarthquakeCountsTelegramBodyFromJson(json);

/// const: "EARTHQUAKE_COUNTS"
@override final  String type;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of TelegramBodyUnion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TelegramBodyUnionEarthquakeCountsTelegramBodyCopyWith<TelegramBodyUnionEarthquakeCountsTelegramBody> get copyWith => _$TelegramBodyUnionEarthquakeCountsTelegramBodyCopyWithImpl<TelegramBodyUnionEarthquakeCountsTelegramBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TelegramBodyUnionEarthquakeCountsTelegramBodyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TelegramBodyUnionEarthquakeCountsTelegramBody&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type);

@override
String toString() {
  return 'TelegramBodyUnion.earthquakeCountsTelegramBody(type: $type)';
}


}

/// @nodoc
abstract mixin class $TelegramBodyUnionEarthquakeCountsTelegramBodyCopyWith<$Res> implements $TelegramBodyUnionCopyWith<$Res> {
  factory $TelegramBodyUnionEarthquakeCountsTelegramBodyCopyWith(TelegramBodyUnionEarthquakeCountsTelegramBody value, $Res Function(TelegramBodyUnionEarthquakeCountsTelegramBody) _then) = _$TelegramBodyUnionEarthquakeCountsTelegramBodyCopyWithImpl;
@override @useResult
$Res call({
 String type
});




}
/// @nodoc
class _$TelegramBodyUnionEarthquakeCountsTelegramBodyCopyWithImpl<$Res>
    implements $TelegramBodyUnionEarthquakeCountsTelegramBodyCopyWith<$Res> {
  _$TelegramBodyUnionEarthquakeCountsTelegramBodyCopyWithImpl(this._self, this._then);

  final TelegramBodyUnionEarthquakeCountsTelegramBody _self;
  final $Res Function(TelegramBodyUnionEarthquakeCountsTelegramBody) _then;

/// Create a copy of TelegramBodyUnion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,}) {
  return _then(TelegramBodyUnionEarthquakeCountsTelegramBody(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc

@JsonSerializable()
class TelegramBodyUnionEarthquakeNankaiTelegramBody implements TelegramBodyUnion {
  const TelegramBodyUnionEarthquakeNankaiTelegramBody({required this.type,  String? $type}): $type = $type ?? 'earthquakeNankaiTelegramBody';
  factory TelegramBodyUnionEarthquakeNankaiTelegramBody.fromJson(Map<String, dynamic> json) => _$TelegramBodyUnionEarthquakeNankaiTelegramBodyFromJson(json);

/// const: "EARTHQUAKE_NANKAI"
@override final  String type;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of TelegramBodyUnion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TelegramBodyUnionEarthquakeNankaiTelegramBodyCopyWith<TelegramBodyUnionEarthquakeNankaiTelegramBody> get copyWith => _$TelegramBodyUnionEarthquakeNankaiTelegramBodyCopyWithImpl<TelegramBodyUnionEarthquakeNankaiTelegramBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TelegramBodyUnionEarthquakeNankaiTelegramBodyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TelegramBodyUnionEarthquakeNankaiTelegramBody&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type);

@override
String toString() {
  return 'TelegramBodyUnion.earthquakeNankaiTelegramBody(type: $type)';
}


}

/// @nodoc
abstract mixin class $TelegramBodyUnionEarthquakeNankaiTelegramBodyCopyWith<$Res> implements $TelegramBodyUnionCopyWith<$Res> {
  factory $TelegramBodyUnionEarthquakeNankaiTelegramBodyCopyWith(TelegramBodyUnionEarthquakeNankaiTelegramBody value, $Res Function(TelegramBodyUnionEarthquakeNankaiTelegramBody) _then) = _$TelegramBodyUnionEarthquakeNankaiTelegramBodyCopyWithImpl;
@override @useResult
$Res call({
 String type
});




}
/// @nodoc
class _$TelegramBodyUnionEarthquakeNankaiTelegramBodyCopyWithImpl<$Res>
    implements $TelegramBodyUnionEarthquakeNankaiTelegramBodyCopyWith<$Res> {
  _$TelegramBodyUnionEarthquakeNankaiTelegramBodyCopyWithImpl(this._self, this._then);

  final TelegramBodyUnionEarthquakeNankaiTelegramBody _self;
  final $Res Function(TelegramBodyUnionEarthquakeNankaiTelegramBody) _then;

/// Create a copy of TelegramBodyUnion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,}) {
  return _then(TelegramBodyUnionEarthquakeNankaiTelegramBody(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc

@JsonSerializable()
class TelegramBodyUnionFallbackTelegramBody implements TelegramBodyUnion {
  const TelegramBodyUnionFallbackTelegramBody({required this.type,  String? $type}): $type = $type ?? 'fallbackTelegramBody';
  factory TelegramBodyUnionFallbackTelegramBody.fromJson(Map<String, dynamic> json) => _$TelegramBodyUnionFallbackTelegramBodyFromJson(json);

@override final  String type;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of TelegramBodyUnion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TelegramBodyUnionFallbackTelegramBodyCopyWith<TelegramBodyUnionFallbackTelegramBody> get copyWith => _$TelegramBodyUnionFallbackTelegramBodyCopyWithImpl<TelegramBodyUnionFallbackTelegramBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TelegramBodyUnionFallbackTelegramBodyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TelegramBodyUnionFallbackTelegramBody&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type);

@override
String toString() {
  return 'TelegramBodyUnion.fallbackTelegramBody(type: $type)';
}


}

/// @nodoc
abstract mixin class $TelegramBodyUnionFallbackTelegramBodyCopyWith<$Res> implements $TelegramBodyUnionCopyWith<$Res> {
  factory $TelegramBodyUnionFallbackTelegramBodyCopyWith(TelegramBodyUnionFallbackTelegramBody value, $Res Function(TelegramBodyUnionFallbackTelegramBody) _then) = _$TelegramBodyUnionFallbackTelegramBodyCopyWithImpl;
@override @useResult
$Res call({
 String type
});




}
/// @nodoc
class _$TelegramBodyUnionFallbackTelegramBodyCopyWithImpl<$Res>
    implements $TelegramBodyUnionFallbackTelegramBodyCopyWith<$Res> {
  _$TelegramBodyUnionFallbackTelegramBodyCopyWithImpl(this._self, this._then);

  final TelegramBodyUnionFallbackTelegramBody _self;
  final $Res Function(TelegramBodyUnionFallbackTelegramBody) _then;

/// Create a copy of TelegramBodyUnion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,}) {
  return _then(TelegramBodyUnionFallbackTelegramBody(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
