// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'parameter_data_response_union.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
ParameterDataResponseUnion _$ParameterDataResponseUnionFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'jmaCodeTableParameter':
          return ParameterDataResponseUnionJmaCodeTableParameter.fromJson(
            json
          );
                case 'kyoshinObservationPointsParameter':
          return ParameterDataResponseUnionKyoshinObservationPointsParameter.fromJson(
            json
          );
                case 'earthquakeStationsParameter':
          return ParameterDataResponseUnionEarthquakeStationsParameter.fromJson(
            json
          );
                case 'tsunamiStationsParameter':
          return ParameterDataResponseUnionTsunamiStationsParameter.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'ParameterDataResponseUnion',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$ParameterDataResponseUnion {

 Object get metadata;

  /// Serializes this ParameterDataResponseUnion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParameterDataResponseUnion&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'ParameterDataResponseUnion(metadata: $metadata)';
}


}

/// @nodoc
class $ParameterDataResponseUnionCopyWith<$Res>  {
$ParameterDataResponseUnionCopyWith(ParameterDataResponseUnion _, $Res Function(ParameterDataResponseUnion) __);
}


/// Adds pattern-matching-related methods to [ParameterDataResponseUnion].
extension ParameterDataResponseUnionPatterns on ParameterDataResponseUnion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ParameterDataResponseUnionJmaCodeTableParameter value)?  jmaCodeTableParameter,TResult Function( ParameterDataResponseUnionKyoshinObservationPointsParameter value)?  kyoshinObservationPointsParameter,TResult Function( ParameterDataResponseUnionEarthquakeStationsParameter value)?  earthquakeStationsParameter,TResult Function( ParameterDataResponseUnionTsunamiStationsParameter value)?  tsunamiStationsParameter,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ParameterDataResponseUnionJmaCodeTableParameter() when jmaCodeTableParameter != null:
return jmaCodeTableParameter(_that);case ParameterDataResponseUnionKyoshinObservationPointsParameter() when kyoshinObservationPointsParameter != null:
return kyoshinObservationPointsParameter(_that);case ParameterDataResponseUnionEarthquakeStationsParameter() when earthquakeStationsParameter != null:
return earthquakeStationsParameter(_that);case ParameterDataResponseUnionTsunamiStationsParameter() when tsunamiStationsParameter != null:
return tsunamiStationsParameter(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ParameterDataResponseUnionJmaCodeTableParameter value)  jmaCodeTableParameter,required TResult Function( ParameterDataResponseUnionKyoshinObservationPointsParameter value)  kyoshinObservationPointsParameter,required TResult Function( ParameterDataResponseUnionEarthquakeStationsParameter value)  earthquakeStationsParameter,required TResult Function( ParameterDataResponseUnionTsunamiStationsParameter value)  tsunamiStationsParameter,}){
final _that = this;
switch (_that) {
case ParameterDataResponseUnionJmaCodeTableParameter():
return jmaCodeTableParameter(_that);case ParameterDataResponseUnionKyoshinObservationPointsParameter():
return kyoshinObservationPointsParameter(_that);case ParameterDataResponseUnionEarthquakeStationsParameter():
return earthquakeStationsParameter(_that);case ParameterDataResponseUnionTsunamiStationsParameter():
return tsunamiStationsParameter(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ParameterDataResponseUnionJmaCodeTableParameter value)?  jmaCodeTableParameter,TResult? Function( ParameterDataResponseUnionKyoshinObservationPointsParameter value)?  kyoshinObservationPointsParameter,TResult? Function( ParameterDataResponseUnionEarthquakeStationsParameter value)?  earthquakeStationsParameter,TResult? Function( ParameterDataResponseUnionTsunamiStationsParameter value)?  tsunamiStationsParameter,}){
final _that = this;
switch (_that) {
case ParameterDataResponseUnionJmaCodeTableParameter() when jmaCodeTableParameter != null:
return jmaCodeTableParameter(_that);case ParameterDataResponseUnionKyoshinObservationPointsParameter() when kyoshinObservationPointsParameter != null:
return kyoshinObservationPointsParameter(_that);case ParameterDataResponseUnionEarthquakeStationsParameter() when earthquakeStationsParameter != null:
return earthquakeStationsParameter(_that);case ParameterDataResponseUnionTsunamiStationsParameter() when tsunamiStationsParameter != null:
return tsunamiStationsParameter(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( JmaCodeTableParameterMetadata metadata, @JsonKey(name: 'code_tables')  JmaCodeTableParameterCodeTables codeTables)?  jmaCodeTableParameter,TResult Function( KyoshinObservationPointsParameterMetadata metadata,  List<KyoshinObservationPoint> points)?  kyoshinObservationPointsParameter,TResult Function( ParameterMetadata metadata,  List<EarthquakeStationPrefecture> prefectures)?  earthquakeStationsParameter,TResult Function( TsunamiStationsParameterMetadata metadata,  List<TsunamiStationPrefecture> prefectures)?  tsunamiStationsParameter,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ParameterDataResponseUnionJmaCodeTableParameter() when jmaCodeTableParameter != null:
return jmaCodeTableParameter(_that.metadata,_that.codeTables);case ParameterDataResponseUnionKyoshinObservationPointsParameter() when kyoshinObservationPointsParameter != null:
return kyoshinObservationPointsParameter(_that.metadata,_that.points);case ParameterDataResponseUnionEarthquakeStationsParameter() when earthquakeStationsParameter != null:
return earthquakeStationsParameter(_that.metadata,_that.prefectures);case ParameterDataResponseUnionTsunamiStationsParameter() when tsunamiStationsParameter != null:
return tsunamiStationsParameter(_that.metadata,_that.prefectures);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( JmaCodeTableParameterMetadata metadata, @JsonKey(name: 'code_tables')  JmaCodeTableParameterCodeTables codeTables)  jmaCodeTableParameter,required TResult Function( KyoshinObservationPointsParameterMetadata metadata,  List<KyoshinObservationPoint> points)  kyoshinObservationPointsParameter,required TResult Function( ParameterMetadata metadata,  List<EarthquakeStationPrefecture> prefectures)  earthquakeStationsParameter,required TResult Function( TsunamiStationsParameterMetadata metadata,  List<TsunamiStationPrefecture> prefectures)  tsunamiStationsParameter,}) {final _that = this;
switch (_that) {
case ParameterDataResponseUnionJmaCodeTableParameter():
return jmaCodeTableParameter(_that.metadata,_that.codeTables);case ParameterDataResponseUnionKyoshinObservationPointsParameter():
return kyoshinObservationPointsParameter(_that.metadata,_that.points);case ParameterDataResponseUnionEarthquakeStationsParameter():
return earthquakeStationsParameter(_that.metadata,_that.prefectures);case ParameterDataResponseUnionTsunamiStationsParameter():
return tsunamiStationsParameter(_that.metadata,_that.prefectures);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( JmaCodeTableParameterMetadata metadata, @JsonKey(name: 'code_tables')  JmaCodeTableParameterCodeTables codeTables)?  jmaCodeTableParameter,TResult? Function( KyoshinObservationPointsParameterMetadata metadata,  List<KyoshinObservationPoint> points)?  kyoshinObservationPointsParameter,TResult? Function( ParameterMetadata metadata,  List<EarthquakeStationPrefecture> prefectures)?  earthquakeStationsParameter,TResult? Function( TsunamiStationsParameterMetadata metadata,  List<TsunamiStationPrefecture> prefectures)?  tsunamiStationsParameter,}) {final _that = this;
switch (_that) {
case ParameterDataResponseUnionJmaCodeTableParameter() when jmaCodeTableParameter != null:
return jmaCodeTableParameter(_that.metadata,_that.codeTables);case ParameterDataResponseUnionKyoshinObservationPointsParameter() when kyoshinObservationPointsParameter != null:
return kyoshinObservationPointsParameter(_that.metadata,_that.points);case ParameterDataResponseUnionEarthquakeStationsParameter() when earthquakeStationsParameter != null:
return earthquakeStationsParameter(_that.metadata,_that.prefectures);case ParameterDataResponseUnionTsunamiStationsParameter() when tsunamiStationsParameter != null:
return tsunamiStationsParameter(_that.metadata,_that.prefectures);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable()
class ParameterDataResponseUnionJmaCodeTableParameter implements ParameterDataResponseUnion {
  const ParameterDataResponseUnionJmaCodeTableParameter({required this.metadata, @JsonKey(name: 'code_tables') required this.codeTables, final  String? $type}): $type = $type ?? 'jmaCodeTableParameter';
  factory ParameterDataResponseUnionJmaCodeTableParameter.fromJson(Map<String, dynamic> json) => _$ParameterDataResponseUnionJmaCodeTableParameterFromJson(json);

@override final  JmaCodeTableParameterMetadata metadata;
@JsonKey(name: 'code_tables') final  JmaCodeTableParameterCodeTables codeTables;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of ParameterDataResponseUnion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParameterDataResponseUnionJmaCodeTableParameterCopyWith<ParameterDataResponseUnionJmaCodeTableParameter> get copyWith => _$ParameterDataResponseUnionJmaCodeTableParameterCopyWithImpl<ParameterDataResponseUnionJmaCodeTableParameter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ParameterDataResponseUnionJmaCodeTableParameterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParameterDataResponseUnionJmaCodeTableParameter&&(identical(other.metadata, metadata) || other.metadata == metadata)&&(identical(other.codeTables, codeTables) || other.codeTables == codeTables));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,metadata,codeTables);

@override
String toString() {
  return 'ParameterDataResponseUnion.jmaCodeTableParameter(metadata: $metadata, codeTables: $codeTables)';
}


}

/// @nodoc
abstract mixin class $ParameterDataResponseUnionJmaCodeTableParameterCopyWith<$Res> implements $ParameterDataResponseUnionCopyWith<$Res> {
  factory $ParameterDataResponseUnionJmaCodeTableParameterCopyWith(ParameterDataResponseUnionJmaCodeTableParameter value, $Res Function(ParameterDataResponseUnionJmaCodeTableParameter) _then) = _$ParameterDataResponseUnionJmaCodeTableParameterCopyWithImpl;
@useResult
$Res call({
 JmaCodeTableParameterMetadata metadata,@JsonKey(name: 'code_tables') JmaCodeTableParameterCodeTables codeTables
});


$JmaCodeTableParameterMetadataCopyWith<$Res> get metadata;$JmaCodeTableParameterCodeTablesCopyWith<$Res> get codeTables;

}
/// @nodoc
class _$ParameterDataResponseUnionJmaCodeTableParameterCopyWithImpl<$Res>
    implements $ParameterDataResponseUnionJmaCodeTableParameterCopyWith<$Res> {
  _$ParameterDataResponseUnionJmaCodeTableParameterCopyWithImpl(this._self, this._then);

  final ParameterDataResponseUnionJmaCodeTableParameter _self;
  final $Res Function(ParameterDataResponseUnionJmaCodeTableParameter) _then;

/// Create a copy of ParameterDataResponseUnion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? metadata = null,Object? codeTables = null,}) {
  return _then(ParameterDataResponseUnionJmaCodeTableParameter(
metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as JmaCodeTableParameterMetadata,codeTables: null == codeTables ? _self.codeTables : codeTables // ignore: cast_nullable_to_non_nullable
as JmaCodeTableParameterCodeTables,
  ));
}

/// Create a copy of ParameterDataResponseUnion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JmaCodeTableParameterMetadataCopyWith<$Res> get metadata {
  
  return $JmaCodeTableParameterMetadataCopyWith<$Res>(_self.metadata, (value) {
    return _then(_self.copyWith(metadata: value));
  });
}/// Create a copy of ParameterDataResponseUnion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JmaCodeTableParameterCodeTablesCopyWith<$Res> get codeTables {
  
  return $JmaCodeTableParameterCodeTablesCopyWith<$Res>(_self.codeTables, (value) {
    return _then(_self.copyWith(codeTables: value));
  });
}
}

/// @nodoc

@JsonSerializable()
class ParameterDataResponseUnionKyoshinObservationPointsParameter implements ParameterDataResponseUnion {
  const ParameterDataResponseUnionKyoshinObservationPointsParameter({required this.metadata, required final  List<KyoshinObservationPoint> points, final  String? $type}): _points = points,$type = $type ?? 'kyoshinObservationPointsParameter';
  factory ParameterDataResponseUnionKyoshinObservationPointsParameter.fromJson(Map<String, dynamic> json) => _$ParameterDataResponseUnionKyoshinObservationPointsParameterFromJson(json);

@override final  KyoshinObservationPointsParameterMetadata metadata;
 final  List<KyoshinObservationPoint> _points;
 List<KyoshinObservationPoint> get points {
  if (_points is EqualUnmodifiableListView) return _points;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_points);
}


@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of ParameterDataResponseUnion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParameterDataResponseUnionKyoshinObservationPointsParameterCopyWith<ParameterDataResponseUnionKyoshinObservationPointsParameter> get copyWith => _$ParameterDataResponseUnionKyoshinObservationPointsParameterCopyWithImpl<ParameterDataResponseUnionKyoshinObservationPointsParameter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ParameterDataResponseUnionKyoshinObservationPointsParameterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParameterDataResponseUnionKyoshinObservationPointsParameter&&(identical(other.metadata, metadata) || other.metadata == metadata)&&const DeepCollectionEquality().equals(other._points, _points));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,metadata,const DeepCollectionEquality().hash(_points));

@override
String toString() {
  return 'ParameterDataResponseUnion.kyoshinObservationPointsParameter(metadata: $metadata, points: $points)';
}


}

/// @nodoc
abstract mixin class $ParameterDataResponseUnionKyoshinObservationPointsParameterCopyWith<$Res> implements $ParameterDataResponseUnionCopyWith<$Res> {
  factory $ParameterDataResponseUnionKyoshinObservationPointsParameterCopyWith(ParameterDataResponseUnionKyoshinObservationPointsParameter value, $Res Function(ParameterDataResponseUnionKyoshinObservationPointsParameter) _then) = _$ParameterDataResponseUnionKyoshinObservationPointsParameterCopyWithImpl;
@useResult
$Res call({
 KyoshinObservationPointsParameterMetadata metadata, List<KyoshinObservationPoint> points
});


$KyoshinObservationPointsParameterMetadataCopyWith<$Res> get metadata;

}
/// @nodoc
class _$ParameterDataResponseUnionKyoshinObservationPointsParameterCopyWithImpl<$Res>
    implements $ParameterDataResponseUnionKyoshinObservationPointsParameterCopyWith<$Res> {
  _$ParameterDataResponseUnionKyoshinObservationPointsParameterCopyWithImpl(this._self, this._then);

  final ParameterDataResponseUnionKyoshinObservationPointsParameter _self;
  final $Res Function(ParameterDataResponseUnionKyoshinObservationPointsParameter) _then;

/// Create a copy of ParameterDataResponseUnion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? metadata = null,Object? points = null,}) {
  return _then(ParameterDataResponseUnionKyoshinObservationPointsParameter(
metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as KyoshinObservationPointsParameterMetadata,points: null == points ? _self._points : points // ignore: cast_nullable_to_non_nullable
as List<KyoshinObservationPoint>,
  ));
}

/// Create a copy of ParameterDataResponseUnion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KyoshinObservationPointsParameterMetadataCopyWith<$Res> get metadata {
  
  return $KyoshinObservationPointsParameterMetadataCopyWith<$Res>(_self.metadata, (value) {
    return _then(_self.copyWith(metadata: value));
  });
}
}

/// @nodoc

@JsonSerializable()
class ParameterDataResponseUnionEarthquakeStationsParameter implements ParameterDataResponseUnion {
  const ParameterDataResponseUnionEarthquakeStationsParameter({required this.metadata, required final  List<EarthquakeStationPrefecture> prefectures, final  String? $type}): _prefectures = prefectures,$type = $type ?? 'earthquakeStationsParameter';
  factory ParameterDataResponseUnionEarthquakeStationsParameter.fromJson(Map<String, dynamic> json) => _$ParameterDataResponseUnionEarthquakeStationsParameterFromJson(json);

@override final  ParameterMetadata metadata;
 final  List<EarthquakeStationPrefecture> _prefectures;
 List<EarthquakeStationPrefecture> get prefectures {
  if (_prefectures is EqualUnmodifiableListView) return _prefectures;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_prefectures);
}


@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of ParameterDataResponseUnion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParameterDataResponseUnionEarthquakeStationsParameterCopyWith<ParameterDataResponseUnionEarthquakeStationsParameter> get copyWith => _$ParameterDataResponseUnionEarthquakeStationsParameterCopyWithImpl<ParameterDataResponseUnionEarthquakeStationsParameter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ParameterDataResponseUnionEarthquakeStationsParameterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParameterDataResponseUnionEarthquakeStationsParameter&&(identical(other.metadata, metadata) || other.metadata == metadata)&&const DeepCollectionEquality().equals(other._prefectures, _prefectures));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,metadata,const DeepCollectionEquality().hash(_prefectures));

@override
String toString() {
  return 'ParameterDataResponseUnion.earthquakeStationsParameter(metadata: $metadata, prefectures: $prefectures)';
}


}

/// @nodoc
abstract mixin class $ParameterDataResponseUnionEarthquakeStationsParameterCopyWith<$Res> implements $ParameterDataResponseUnionCopyWith<$Res> {
  factory $ParameterDataResponseUnionEarthquakeStationsParameterCopyWith(ParameterDataResponseUnionEarthquakeStationsParameter value, $Res Function(ParameterDataResponseUnionEarthquakeStationsParameter) _then) = _$ParameterDataResponseUnionEarthquakeStationsParameterCopyWithImpl;
@useResult
$Res call({
 ParameterMetadata metadata, List<EarthquakeStationPrefecture> prefectures
});


$ParameterMetadataCopyWith<$Res> get metadata;

}
/// @nodoc
class _$ParameterDataResponseUnionEarthquakeStationsParameterCopyWithImpl<$Res>
    implements $ParameterDataResponseUnionEarthquakeStationsParameterCopyWith<$Res> {
  _$ParameterDataResponseUnionEarthquakeStationsParameterCopyWithImpl(this._self, this._then);

  final ParameterDataResponseUnionEarthquakeStationsParameter _self;
  final $Res Function(ParameterDataResponseUnionEarthquakeStationsParameter) _then;

/// Create a copy of ParameterDataResponseUnion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? metadata = null,Object? prefectures = null,}) {
  return _then(ParameterDataResponseUnionEarthquakeStationsParameter(
metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as ParameterMetadata,prefectures: null == prefectures ? _self._prefectures : prefectures // ignore: cast_nullable_to_non_nullable
as List<EarthquakeStationPrefecture>,
  ));
}

/// Create a copy of ParameterDataResponseUnion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ParameterMetadataCopyWith<$Res> get metadata {
  
  return $ParameterMetadataCopyWith<$Res>(_self.metadata, (value) {
    return _then(_self.copyWith(metadata: value));
  });
}
}

/// @nodoc

@JsonSerializable()
class ParameterDataResponseUnionTsunamiStationsParameter implements ParameterDataResponseUnion {
  const ParameterDataResponseUnionTsunamiStationsParameter({required this.metadata, required final  List<TsunamiStationPrefecture> prefectures, final  String? $type}): _prefectures = prefectures,$type = $type ?? 'tsunamiStationsParameter';
  factory ParameterDataResponseUnionTsunamiStationsParameter.fromJson(Map<String, dynamic> json) => _$ParameterDataResponseUnionTsunamiStationsParameterFromJson(json);

@override final  TsunamiStationsParameterMetadata metadata;
 final  List<TsunamiStationPrefecture> _prefectures;
 List<TsunamiStationPrefecture> get prefectures {
  if (_prefectures is EqualUnmodifiableListView) return _prefectures;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_prefectures);
}


@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of ParameterDataResponseUnion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParameterDataResponseUnionTsunamiStationsParameterCopyWith<ParameterDataResponseUnionTsunamiStationsParameter> get copyWith => _$ParameterDataResponseUnionTsunamiStationsParameterCopyWithImpl<ParameterDataResponseUnionTsunamiStationsParameter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ParameterDataResponseUnionTsunamiStationsParameterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParameterDataResponseUnionTsunamiStationsParameter&&(identical(other.metadata, metadata) || other.metadata == metadata)&&const DeepCollectionEquality().equals(other._prefectures, _prefectures));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,metadata,const DeepCollectionEquality().hash(_prefectures));

@override
String toString() {
  return 'ParameterDataResponseUnion.tsunamiStationsParameter(metadata: $metadata, prefectures: $prefectures)';
}


}

/// @nodoc
abstract mixin class $ParameterDataResponseUnionTsunamiStationsParameterCopyWith<$Res> implements $ParameterDataResponseUnionCopyWith<$Res> {
  factory $ParameterDataResponseUnionTsunamiStationsParameterCopyWith(ParameterDataResponseUnionTsunamiStationsParameter value, $Res Function(ParameterDataResponseUnionTsunamiStationsParameter) _then) = _$ParameterDataResponseUnionTsunamiStationsParameterCopyWithImpl;
@useResult
$Res call({
 TsunamiStationsParameterMetadata metadata, List<TsunamiStationPrefecture> prefectures
});


$TsunamiStationsParameterMetadataCopyWith<$Res> get metadata;

}
/// @nodoc
class _$ParameterDataResponseUnionTsunamiStationsParameterCopyWithImpl<$Res>
    implements $ParameterDataResponseUnionTsunamiStationsParameterCopyWith<$Res> {
  _$ParameterDataResponseUnionTsunamiStationsParameterCopyWithImpl(this._self, this._then);

  final ParameterDataResponseUnionTsunamiStationsParameter _self;
  final $Res Function(ParameterDataResponseUnionTsunamiStationsParameter) _then;

/// Create a copy of ParameterDataResponseUnion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? metadata = null,Object? prefectures = null,}) {
  return _then(ParameterDataResponseUnionTsunamiStationsParameter(
metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as TsunamiStationsParameterMetadata,prefectures: null == prefectures ? _self._prefectures : prefectures // ignore: cast_nullable_to_non_nullable
as List<TsunamiStationPrefecture>,
  ));
}

/// Create a copy of ParameterDataResponseUnion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiStationsParameterMetadataCopyWith<$Res> get metadata {
  
  return $TsunamiStationsParameterMetadataCopyWith<$Res>(_self.metadata, (value) {
    return _then(_self.copyWith(metadata: value));
  });
}
}

// dart format on
