// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'jma_code_table_parameter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JmaCodeTableParameter {

 ParameterMetadata get metadata; JmaCodeTableCodeTables get codeTables;
/// Create a copy of JmaCodeTableParameter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JmaCodeTableParameterCopyWith<JmaCodeTableParameter> get copyWith => _$JmaCodeTableParameterCopyWithImpl<JmaCodeTableParameter>(this as JmaCodeTableParameter, _$identity);

  /// Serializes this JmaCodeTableParameter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JmaCodeTableParameter&&(identical(other.metadata, metadata) || other.metadata == metadata)&&(identical(other.codeTables, codeTables) || other.codeTables == codeTables));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,metadata,codeTables);

@override
String toString() {
  return 'JmaCodeTableParameter(metadata: $metadata, codeTables: $codeTables)';
}


}

/// @nodoc
abstract mixin class $JmaCodeTableParameterCopyWith<$Res>  {
  factory $JmaCodeTableParameterCopyWith(JmaCodeTableParameter value, $Res Function(JmaCodeTableParameter) _then) = _$JmaCodeTableParameterCopyWithImpl;
@useResult
$Res call({
 ParameterMetadata metadata, JmaCodeTableCodeTables codeTables
});


$ParameterMetadataCopyWith<$Res> get metadata;$JmaCodeTableCodeTablesCopyWith<$Res> get codeTables;

}
/// @nodoc
class _$JmaCodeTableParameterCopyWithImpl<$Res>
    implements $JmaCodeTableParameterCopyWith<$Res> {
  _$JmaCodeTableParameterCopyWithImpl(this._self, this._then);

  final JmaCodeTableParameter _self;
  final $Res Function(JmaCodeTableParameter) _then;

/// Create a copy of JmaCodeTableParameter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? metadata = null,Object? codeTables = null,}) {
  return _then(_self.copyWith(
metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as ParameterMetadata,codeTables: null == codeTables ? _self.codeTables : codeTables // ignore: cast_nullable_to_non_nullable
as JmaCodeTableCodeTables,
  ));
}
/// Create a copy of JmaCodeTableParameter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ParameterMetadataCopyWith<$Res> get metadata {
  
  return $ParameterMetadataCopyWith<$Res>(_self.metadata, (value) {
    return _then(_self.copyWith(metadata: value));
  });
}/// Create a copy of JmaCodeTableParameter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JmaCodeTableCodeTablesCopyWith<$Res> get codeTables {
  
  return $JmaCodeTableCodeTablesCopyWith<$Res>(_self.codeTables, (value) {
    return _then(_self.copyWith(codeTables: value));
  });
}
}


/// Adds pattern-matching-related methods to [JmaCodeTableParameter].
extension JmaCodeTableParameterPatterns on JmaCodeTableParameter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JmaCodeTableParameter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JmaCodeTableParameter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JmaCodeTableParameter value)  $default,){
final _that = this;
switch (_that) {
case _JmaCodeTableParameter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JmaCodeTableParameter value)?  $default,){
final _that = this;
switch (_that) {
case _JmaCodeTableParameter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ParameterMetadata metadata,  JmaCodeTableCodeTables codeTables)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JmaCodeTableParameter() when $default != null:
return $default(_that.metadata,_that.codeTables);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ParameterMetadata metadata,  JmaCodeTableCodeTables codeTables)  $default,) {final _that = this;
switch (_that) {
case _JmaCodeTableParameter():
return $default(_that.metadata,_that.codeTables);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ParameterMetadata metadata,  JmaCodeTableCodeTables codeTables)?  $default,) {final _that = this;
switch (_that) {
case _JmaCodeTableParameter() when $default != null:
return $default(_that.metadata,_that.codeTables);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JmaCodeTableParameter implements JmaCodeTableParameter {
  const _JmaCodeTableParameter({required this.metadata, required this.codeTables});
  factory _JmaCodeTableParameter.fromJson(Map<String, dynamic> json) => _$JmaCodeTableParameterFromJson(json);

@override final  ParameterMetadata metadata;
@override final  JmaCodeTableCodeTables codeTables;

/// Create a copy of JmaCodeTableParameter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JmaCodeTableParameterCopyWith<_JmaCodeTableParameter> get copyWith => __$JmaCodeTableParameterCopyWithImpl<_JmaCodeTableParameter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JmaCodeTableParameterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JmaCodeTableParameter&&(identical(other.metadata, metadata) || other.metadata == metadata)&&(identical(other.codeTables, codeTables) || other.codeTables == codeTables));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,metadata,codeTables);

@override
String toString() {
  return 'JmaCodeTableParameter(metadata: $metadata, codeTables: $codeTables)';
}


}

/// @nodoc
abstract mixin class _$JmaCodeTableParameterCopyWith<$Res> implements $JmaCodeTableParameterCopyWith<$Res> {
  factory _$JmaCodeTableParameterCopyWith(_JmaCodeTableParameter value, $Res Function(_JmaCodeTableParameter) _then) = __$JmaCodeTableParameterCopyWithImpl;
@override @useResult
$Res call({
 ParameterMetadata metadata, JmaCodeTableCodeTables codeTables
});


@override $ParameterMetadataCopyWith<$Res> get metadata;@override $JmaCodeTableCodeTablesCopyWith<$Res> get codeTables;

}
/// @nodoc
class __$JmaCodeTableParameterCopyWithImpl<$Res>
    implements _$JmaCodeTableParameterCopyWith<$Res> {
  __$JmaCodeTableParameterCopyWithImpl(this._self, this._then);

  final _JmaCodeTableParameter _self;
  final $Res Function(_JmaCodeTableParameter) _then;

/// Create a copy of JmaCodeTableParameter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? metadata = null,Object? codeTables = null,}) {
  return _then(_JmaCodeTableParameter(
metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as ParameterMetadata,codeTables: null == codeTables ? _self.codeTables : codeTables // ignore: cast_nullable_to_non_nullable
as JmaCodeTableCodeTables,
  ));
}

/// Create a copy of JmaCodeTableParameter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ParameterMetadataCopyWith<$Res> get metadata {
  
  return $ParameterMetadataCopyWith<$Res>(_self.metadata, (value) {
    return _then(_self.copyWith(metadata: value));
  });
}/// Create a copy of JmaCodeTableParameter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JmaCodeTableCodeTablesCopyWith<$Res> get codeTables {
  
  return $JmaCodeTableCodeTablesCopyWith<$Res>(_self.codeTables, (value) {
    return _then(_self.copyWith(codeTables: value));
  });
}
}


/// @nodoc
mixin _$JmaCodeTableCodeTables {

 List<JmaCodeTableItem> get areaForecastLocalEew; List<JmaCodeTableItem> get areaInformationPrefectureEarthquake; List<JmaCodeTableCityItem> get areaInformationCity; List<JmaCodeTableItem> get areaEpicenter; List<JmaCodeTableItem> get areaEpicenterAbbreviation; List<JmaCodeTableItem> get areaEpicenterDetail;
/// Create a copy of JmaCodeTableCodeTables
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JmaCodeTableCodeTablesCopyWith<JmaCodeTableCodeTables> get copyWith => _$JmaCodeTableCodeTablesCopyWithImpl<JmaCodeTableCodeTables>(this as JmaCodeTableCodeTables, _$identity);

  /// Serializes this JmaCodeTableCodeTables to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JmaCodeTableCodeTables&&const DeepCollectionEquality().equals(other.areaForecastLocalEew, areaForecastLocalEew)&&const DeepCollectionEquality().equals(other.areaInformationPrefectureEarthquake, areaInformationPrefectureEarthquake)&&const DeepCollectionEquality().equals(other.areaInformationCity, areaInformationCity)&&const DeepCollectionEquality().equals(other.areaEpicenter, areaEpicenter)&&const DeepCollectionEquality().equals(other.areaEpicenterAbbreviation, areaEpicenterAbbreviation)&&const DeepCollectionEquality().equals(other.areaEpicenterDetail, areaEpicenterDetail));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(areaForecastLocalEew),const DeepCollectionEquality().hash(areaInformationPrefectureEarthquake),const DeepCollectionEquality().hash(areaInformationCity),const DeepCollectionEquality().hash(areaEpicenter),const DeepCollectionEquality().hash(areaEpicenterAbbreviation),const DeepCollectionEquality().hash(areaEpicenterDetail));

@override
String toString() {
  return 'JmaCodeTableCodeTables(areaForecastLocalEew: $areaForecastLocalEew, areaInformationPrefectureEarthquake: $areaInformationPrefectureEarthquake, areaInformationCity: $areaInformationCity, areaEpicenter: $areaEpicenter, areaEpicenterAbbreviation: $areaEpicenterAbbreviation, areaEpicenterDetail: $areaEpicenterDetail)';
}


}

/// @nodoc
abstract mixin class $JmaCodeTableCodeTablesCopyWith<$Res>  {
  factory $JmaCodeTableCodeTablesCopyWith(JmaCodeTableCodeTables value, $Res Function(JmaCodeTableCodeTables) _then) = _$JmaCodeTableCodeTablesCopyWithImpl;
@useResult
$Res call({
 List<JmaCodeTableItem> areaForecastLocalEew, List<JmaCodeTableItem> areaInformationPrefectureEarthquake, List<JmaCodeTableCityItem> areaInformationCity, List<JmaCodeTableItem> areaEpicenter, List<JmaCodeTableItem> areaEpicenterAbbreviation, List<JmaCodeTableItem> areaEpicenterDetail
});




}
/// @nodoc
class _$JmaCodeTableCodeTablesCopyWithImpl<$Res>
    implements $JmaCodeTableCodeTablesCopyWith<$Res> {
  _$JmaCodeTableCodeTablesCopyWithImpl(this._self, this._then);

  final JmaCodeTableCodeTables _self;
  final $Res Function(JmaCodeTableCodeTables) _then;

/// Create a copy of JmaCodeTableCodeTables
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? areaForecastLocalEew = null,Object? areaInformationPrefectureEarthquake = null,Object? areaInformationCity = null,Object? areaEpicenter = null,Object? areaEpicenterAbbreviation = null,Object? areaEpicenterDetail = null,}) {
  return _then(_self.copyWith(
areaForecastLocalEew: null == areaForecastLocalEew ? _self.areaForecastLocalEew : areaForecastLocalEew // ignore: cast_nullable_to_non_nullable
as List<JmaCodeTableItem>,areaInformationPrefectureEarthquake: null == areaInformationPrefectureEarthquake ? _self.areaInformationPrefectureEarthquake : areaInformationPrefectureEarthquake // ignore: cast_nullable_to_non_nullable
as List<JmaCodeTableItem>,areaInformationCity: null == areaInformationCity ? _self.areaInformationCity : areaInformationCity // ignore: cast_nullable_to_non_nullable
as List<JmaCodeTableCityItem>,areaEpicenter: null == areaEpicenter ? _self.areaEpicenter : areaEpicenter // ignore: cast_nullable_to_non_nullable
as List<JmaCodeTableItem>,areaEpicenterAbbreviation: null == areaEpicenterAbbreviation ? _self.areaEpicenterAbbreviation : areaEpicenterAbbreviation // ignore: cast_nullable_to_non_nullable
as List<JmaCodeTableItem>,areaEpicenterDetail: null == areaEpicenterDetail ? _self.areaEpicenterDetail : areaEpicenterDetail // ignore: cast_nullable_to_non_nullable
as List<JmaCodeTableItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [JmaCodeTableCodeTables].
extension JmaCodeTableCodeTablesPatterns on JmaCodeTableCodeTables {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JmaCodeTableCodeTables value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JmaCodeTableCodeTables() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JmaCodeTableCodeTables value)  $default,){
final _that = this;
switch (_that) {
case _JmaCodeTableCodeTables():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JmaCodeTableCodeTables value)?  $default,){
final _that = this;
switch (_that) {
case _JmaCodeTableCodeTables() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<JmaCodeTableItem> areaForecastLocalEew,  List<JmaCodeTableItem> areaInformationPrefectureEarthquake,  List<JmaCodeTableCityItem> areaInformationCity,  List<JmaCodeTableItem> areaEpicenter,  List<JmaCodeTableItem> areaEpicenterAbbreviation,  List<JmaCodeTableItem> areaEpicenterDetail)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JmaCodeTableCodeTables() when $default != null:
return $default(_that.areaForecastLocalEew,_that.areaInformationPrefectureEarthquake,_that.areaInformationCity,_that.areaEpicenter,_that.areaEpicenterAbbreviation,_that.areaEpicenterDetail);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<JmaCodeTableItem> areaForecastLocalEew,  List<JmaCodeTableItem> areaInformationPrefectureEarthquake,  List<JmaCodeTableCityItem> areaInformationCity,  List<JmaCodeTableItem> areaEpicenter,  List<JmaCodeTableItem> areaEpicenterAbbreviation,  List<JmaCodeTableItem> areaEpicenterDetail)  $default,) {final _that = this;
switch (_that) {
case _JmaCodeTableCodeTables():
return $default(_that.areaForecastLocalEew,_that.areaInformationPrefectureEarthquake,_that.areaInformationCity,_that.areaEpicenter,_that.areaEpicenterAbbreviation,_that.areaEpicenterDetail);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<JmaCodeTableItem> areaForecastLocalEew,  List<JmaCodeTableItem> areaInformationPrefectureEarthquake,  List<JmaCodeTableCityItem> areaInformationCity,  List<JmaCodeTableItem> areaEpicenter,  List<JmaCodeTableItem> areaEpicenterAbbreviation,  List<JmaCodeTableItem> areaEpicenterDetail)?  $default,) {final _that = this;
switch (_that) {
case _JmaCodeTableCodeTables() when $default != null:
return $default(_that.areaForecastLocalEew,_that.areaInformationPrefectureEarthquake,_that.areaInformationCity,_that.areaEpicenter,_that.areaEpicenterAbbreviation,_that.areaEpicenterDetail);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JmaCodeTableCodeTables implements JmaCodeTableCodeTables {
  const _JmaCodeTableCodeTables({required final  List<JmaCodeTableItem> areaForecastLocalEew, required final  List<JmaCodeTableItem> areaInformationPrefectureEarthquake, required final  List<JmaCodeTableCityItem> areaInformationCity, required final  List<JmaCodeTableItem> areaEpicenter, required final  List<JmaCodeTableItem> areaEpicenterAbbreviation, required final  List<JmaCodeTableItem> areaEpicenterDetail}): _areaForecastLocalEew = areaForecastLocalEew,_areaInformationPrefectureEarthquake = areaInformationPrefectureEarthquake,_areaInformationCity = areaInformationCity,_areaEpicenter = areaEpicenter,_areaEpicenterAbbreviation = areaEpicenterAbbreviation,_areaEpicenterDetail = areaEpicenterDetail;
  factory _JmaCodeTableCodeTables.fromJson(Map<String, dynamic> json) => _$JmaCodeTableCodeTablesFromJson(json);

 final  List<JmaCodeTableItem> _areaForecastLocalEew;
@override List<JmaCodeTableItem> get areaForecastLocalEew {
  if (_areaForecastLocalEew is EqualUnmodifiableListView) return _areaForecastLocalEew;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_areaForecastLocalEew);
}

 final  List<JmaCodeTableItem> _areaInformationPrefectureEarthquake;
@override List<JmaCodeTableItem> get areaInformationPrefectureEarthquake {
  if (_areaInformationPrefectureEarthquake is EqualUnmodifiableListView) return _areaInformationPrefectureEarthquake;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_areaInformationPrefectureEarthquake);
}

 final  List<JmaCodeTableCityItem> _areaInformationCity;
@override List<JmaCodeTableCityItem> get areaInformationCity {
  if (_areaInformationCity is EqualUnmodifiableListView) return _areaInformationCity;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_areaInformationCity);
}

 final  List<JmaCodeTableItem> _areaEpicenter;
@override List<JmaCodeTableItem> get areaEpicenter {
  if (_areaEpicenter is EqualUnmodifiableListView) return _areaEpicenter;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_areaEpicenter);
}

 final  List<JmaCodeTableItem> _areaEpicenterAbbreviation;
@override List<JmaCodeTableItem> get areaEpicenterAbbreviation {
  if (_areaEpicenterAbbreviation is EqualUnmodifiableListView) return _areaEpicenterAbbreviation;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_areaEpicenterAbbreviation);
}

 final  List<JmaCodeTableItem> _areaEpicenterDetail;
@override List<JmaCodeTableItem> get areaEpicenterDetail {
  if (_areaEpicenterDetail is EqualUnmodifiableListView) return _areaEpicenterDetail;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_areaEpicenterDetail);
}


/// Create a copy of JmaCodeTableCodeTables
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JmaCodeTableCodeTablesCopyWith<_JmaCodeTableCodeTables> get copyWith => __$JmaCodeTableCodeTablesCopyWithImpl<_JmaCodeTableCodeTables>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JmaCodeTableCodeTablesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JmaCodeTableCodeTables&&const DeepCollectionEquality().equals(other._areaForecastLocalEew, _areaForecastLocalEew)&&const DeepCollectionEquality().equals(other._areaInformationPrefectureEarthquake, _areaInformationPrefectureEarthquake)&&const DeepCollectionEquality().equals(other._areaInformationCity, _areaInformationCity)&&const DeepCollectionEquality().equals(other._areaEpicenter, _areaEpicenter)&&const DeepCollectionEquality().equals(other._areaEpicenterAbbreviation, _areaEpicenterAbbreviation)&&const DeepCollectionEquality().equals(other._areaEpicenterDetail, _areaEpicenterDetail));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_areaForecastLocalEew),const DeepCollectionEquality().hash(_areaInformationPrefectureEarthquake),const DeepCollectionEquality().hash(_areaInformationCity),const DeepCollectionEquality().hash(_areaEpicenter),const DeepCollectionEquality().hash(_areaEpicenterAbbreviation),const DeepCollectionEquality().hash(_areaEpicenterDetail));

@override
String toString() {
  return 'JmaCodeTableCodeTables(areaForecastLocalEew: $areaForecastLocalEew, areaInformationPrefectureEarthquake: $areaInformationPrefectureEarthquake, areaInformationCity: $areaInformationCity, areaEpicenter: $areaEpicenter, areaEpicenterAbbreviation: $areaEpicenterAbbreviation, areaEpicenterDetail: $areaEpicenterDetail)';
}


}

/// @nodoc
abstract mixin class _$JmaCodeTableCodeTablesCopyWith<$Res> implements $JmaCodeTableCodeTablesCopyWith<$Res> {
  factory _$JmaCodeTableCodeTablesCopyWith(_JmaCodeTableCodeTables value, $Res Function(_JmaCodeTableCodeTables) _then) = __$JmaCodeTableCodeTablesCopyWithImpl;
@override @useResult
$Res call({
 List<JmaCodeTableItem> areaForecastLocalEew, List<JmaCodeTableItem> areaInformationPrefectureEarthquake, List<JmaCodeTableCityItem> areaInformationCity, List<JmaCodeTableItem> areaEpicenter, List<JmaCodeTableItem> areaEpicenterAbbreviation, List<JmaCodeTableItem> areaEpicenterDetail
});




}
/// @nodoc
class __$JmaCodeTableCodeTablesCopyWithImpl<$Res>
    implements _$JmaCodeTableCodeTablesCopyWith<$Res> {
  __$JmaCodeTableCodeTablesCopyWithImpl(this._self, this._then);

  final _JmaCodeTableCodeTables _self;
  final $Res Function(_JmaCodeTableCodeTables) _then;

/// Create a copy of JmaCodeTableCodeTables
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? areaForecastLocalEew = null,Object? areaInformationPrefectureEarthquake = null,Object? areaInformationCity = null,Object? areaEpicenter = null,Object? areaEpicenterAbbreviation = null,Object? areaEpicenterDetail = null,}) {
  return _then(_JmaCodeTableCodeTables(
areaForecastLocalEew: null == areaForecastLocalEew ? _self._areaForecastLocalEew : areaForecastLocalEew // ignore: cast_nullable_to_non_nullable
as List<JmaCodeTableItem>,areaInformationPrefectureEarthquake: null == areaInformationPrefectureEarthquake ? _self._areaInformationPrefectureEarthquake : areaInformationPrefectureEarthquake // ignore: cast_nullable_to_non_nullable
as List<JmaCodeTableItem>,areaInformationCity: null == areaInformationCity ? _self._areaInformationCity : areaInformationCity // ignore: cast_nullable_to_non_nullable
as List<JmaCodeTableCityItem>,areaEpicenter: null == areaEpicenter ? _self._areaEpicenter : areaEpicenter // ignore: cast_nullable_to_non_nullable
as List<JmaCodeTableItem>,areaEpicenterAbbreviation: null == areaEpicenterAbbreviation ? _self._areaEpicenterAbbreviation : areaEpicenterAbbreviation // ignore: cast_nullable_to_non_nullable
as List<JmaCodeTableItem>,areaEpicenterDetail: null == areaEpicenterDetail ? _self._areaEpicenterDetail : areaEpicenterDetail // ignore: cast_nullable_to_non_nullable
as List<JmaCodeTableItem>,
  ));
}


}


/// @nodoc
mixin _$JmaCodeTableCityItem {

 String get code; LocalizedName get name;@JsonKey(name: 'parent_area_forecast_local_eew_code') String get parentAreaForecastLocalEewCode;@JsonKey(name: 'parent_area_information_prefecture_earthquake_code') String get parentAreaInformationPrefectureEarthquakeCode;
/// Create a copy of JmaCodeTableCityItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JmaCodeTableCityItemCopyWith<JmaCodeTableCityItem> get copyWith => _$JmaCodeTableCityItemCopyWithImpl<JmaCodeTableCityItem>(this as JmaCodeTableCityItem, _$identity);

  /// Serializes this JmaCodeTableCityItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JmaCodeTableCityItem&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.parentAreaForecastLocalEewCode, parentAreaForecastLocalEewCode) || other.parentAreaForecastLocalEewCode == parentAreaForecastLocalEewCode)&&(identical(other.parentAreaInformationPrefectureEarthquakeCode, parentAreaInformationPrefectureEarthquakeCode) || other.parentAreaInformationPrefectureEarthquakeCode == parentAreaInformationPrefectureEarthquakeCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,parentAreaForecastLocalEewCode,parentAreaInformationPrefectureEarthquakeCode);

@override
String toString() {
  return 'JmaCodeTableCityItem(code: $code, name: $name, parentAreaForecastLocalEewCode: $parentAreaForecastLocalEewCode, parentAreaInformationPrefectureEarthquakeCode: $parentAreaInformationPrefectureEarthquakeCode)';
}


}

/// @nodoc
abstract mixin class $JmaCodeTableCityItemCopyWith<$Res>  {
  factory $JmaCodeTableCityItemCopyWith(JmaCodeTableCityItem value, $Res Function(JmaCodeTableCityItem) _then) = _$JmaCodeTableCityItemCopyWithImpl;
@useResult
$Res call({
 String code, LocalizedName name,@JsonKey(name: 'parent_area_forecast_local_eew_code') String parentAreaForecastLocalEewCode,@JsonKey(name: 'parent_area_information_prefecture_earthquake_code') String parentAreaInformationPrefectureEarthquakeCode
});


$LocalizedNameCopyWith<$Res> get name;

}
/// @nodoc
class _$JmaCodeTableCityItemCopyWithImpl<$Res>
    implements $JmaCodeTableCityItemCopyWith<$Res> {
  _$JmaCodeTableCityItemCopyWithImpl(this._self, this._then);

  final JmaCodeTableCityItem _self;
  final $Res Function(JmaCodeTableCityItem) _then;

/// Create a copy of JmaCodeTableCityItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? parentAreaForecastLocalEewCode = null,Object? parentAreaInformationPrefectureEarthquakeCode = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedName,parentAreaForecastLocalEewCode: null == parentAreaForecastLocalEewCode ? _self.parentAreaForecastLocalEewCode : parentAreaForecastLocalEewCode // ignore: cast_nullable_to_non_nullable
as String,parentAreaInformationPrefectureEarthquakeCode: null == parentAreaInformationPrefectureEarthquakeCode ? _self.parentAreaInformationPrefectureEarthquakeCode : parentAreaInformationPrefectureEarthquakeCode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of JmaCodeTableCityItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedNameCopyWith<$Res> get name {
  
  return $LocalizedNameCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}
}


/// Adds pattern-matching-related methods to [JmaCodeTableCityItem].
extension JmaCodeTableCityItemPatterns on JmaCodeTableCityItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JmaCodeTableCityItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JmaCodeTableCityItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JmaCodeTableCityItem value)  $default,){
final _that = this;
switch (_that) {
case _JmaCodeTableCityItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JmaCodeTableCityItem value)?  $default,){
final _that = this;
switch (_that) {
case _JmaCodeTableCityItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  LocalizedName name, @JsonKey(name: 'parent_area_forecast_local_eew_code')  String parentAreaForecastLocalEewCode, @JsonKey(name: 'parent_area_information_prefecture_earthquake_code')  String parentAreaInformationPrefectureEarthquakeCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JmaCodeTableCityItem() when $default != null:
return $default(_that.code,_that.name,_that.parentAreaForecastLocalEewCode,_that.parentAreaInformationPrefectureEarthquakeCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  LocalizedName name, @JsonKey(name: 'parent_area_forecast_local_eew_code')  String parentAreaForecastLocalEewCode, @JsonKey(name: 'parent_area_information_prefecture_earthquake_code')  String parentAreaInformationPrefectureEarthquakeCode)  $default,) {final _that = this;
switch (_that) {
case _JmaCodeTableCityItem():
return $default(_that.code,_that.name,_that.parentAreaForecastLocalEewCode,_that.parentAreaInformationPrefectureEarthquakeCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  LocalizedName name, @JsonKey(name: 'parent_area_forecast_local_eew_code')  String parentAreaForecastLocalEewCode, @JsonKey(name: 'parent_area_information_prefecture_earthquake_code')  String parentAreaInformationPrefectureEarthquakeCode)?  $default,) {final _that = this;
switch (_that) {
case _JmaCodeTableCityItem() when $default != null:
return $default(_that.code,_that.name,_that.parentAreaForecastLocalEewCode,_that.parentAreaInformationPrefectureEarthquakeCode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JmaCodeTableCityItem implements JmaCodeTableCityItem {
  const _JmaCodeTableCityItem({required this.code, required this.name, @JsonKey(name: 'parent_area_forecast_local_eew_code') required this.parentAreaForecastLocalEewCode, @JsonKey(name: 'parent_area_information_prefecture_earthquake_code') required this.parentAreaInformationPrefectureEarthquakeCode});
  factory _JmaCodeTableCityItem.fromJson(Map<String, dynamic> json) => _$JmaCodeTableCityItemFromJson(json);

@override final  String code;
@override final  LocalizedName name;
@override@JsonKey(name: 'parent_area_forecast_local_eew_code') final  String parentAreaForecastLocalEewCode;
@override@JsonKey(name: 'parent_area_information_prefecture_earthquake_code') final  String parentAreaInformationPrefectureEarthquakeCode;

/// Create a copy of JmaCodeTableCityItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JmaCodeTableCityItemCopyWith<_JmaCodeTableCityItem> get copyWith => __$JmaCodeTableCityItemCopyWithImpl<_JmaCodeTableCityItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JmaCodeTableCityItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JmaCodeTableCityItem&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.parentAreaForecastLocalEewCode, parentAreaForecastLocalEewCode) || other.parentAreaForecastLocalEewCode == parentAreaForecastLocalEewCode)&&(identical(other.parentAreaInformationPrefectureEarthquakeCode, parentAreaInformationPrefectureEarthquakeCode) || other.parentAreaInformationPrefectureEarthquakeCode == parentAreaInformationPrefectureEarthquakeCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,parentAreaForecastLocalEewCode,parentAreaInformationPrefectureEarthquakeCode);

@override
String toString() {
  return 'JmaCodeTableCityItem(code: $code, name: $name, parentAreaForecastLocalEewCode: $parentAreaForecastLocalEewCode, parentAreaInformationPrefectureEarthquakeCode: $parentAreaInformationPrefectureEarthquakeCode)';
}


}

/// @nodoc
abstract mixin class _$JmaCodeTableCityItemCopyWith<$Res> implements $JmaCodeTableCityItemCopyWith<$Res> {
  factory _$JmaCodeTableCityItemCopyWith(_JmaCodeTableCityItem value, $Res Function(_JmaCodeTableCityItem) _then) = __$JmaCodeTableCityItemCopyWithImpl;
@override @useResult
$Res call({
 String code, LocalizedName name,@JsonKey(name: 'parent_area_forecast_local_eew_code') String parentAreaForecastLocalEewCode,@JsonKey(name: 'parent_area_information_prefecture_earthquake_code') String parentAreaInformationPrefectureEarthquakeCode
});


@override $LocalizedNameCopyWith<$Res> get name;

}
/// @nodoc
class __$JmaCodeTableCityItemCopyWithImpl<$Res>
    implements _$JmaCodeTableCityItemCopyWith<$Res> {
  __$JmaCodeTableCityItemCopyWithImpl(this._self, this._then);

  final _JmaCodeTableCityItem _self;
  final $Res Function(_JmaCodeTableCityItem) _then;

/// Create a copy of JmaCodeTableCityItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? parentAreaForecastLocalEewCode = null,Object? parentAreaInformationPrefectureEarthquakeCode = null,}) {
  return _then(_JmaCodeTableCityItem(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedName,parentAreaForecastLocalEewCode: null == parentAreaForecastLocalEewCode ? _self.parentAreaForecastLocalEewCode : parentAreaForecastLocalEewCode // ignore: cast_nullable_to_non_nullable
as String,parentAreaInformationPrefectureEarthquakeCode: null == parentAreaInformationPrefectureEarthquakeCode ? _self.parentAreaInformationPrefectureEarthquakeCode : parentAreaInformationPrefectureEarthquakeCode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of JmaCodeTableCityItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedNameCopyWith<$Res> get name {
  
  return $LocalizedNameCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}
}


/// @nodoc
mixin _$JmaCodeTableItem {

 String get code; LocalizedName get name; String? get kana; String? get description;
/// Create a copy of JmaCodeTableItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JmaCodeTableItemCopyWith<JmaCodeTableItem> get copyWith => _$JmaCodeTableItemCopyWithImpl<JmaCodeTableItem>(this as JmaCodeTableItem, _$identity);

  /// Serializes this JmaCodeTableItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JmaCodeTableItem&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.kana, kana) || other.kana == kana)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,kana,description);

@override
String toString() {
  return 'JmaCodeTableItem(code: $code, name: $name, kana: $kana, description: $description)';
}


}

/// @nodoc
abstract mixin class $JmaCodeTableItemCopyWith<$Res>  {
  factory $JmaCodeTableItemCopyWith(JmaCodeTableItem value, $Res Function(JmaCodeTableItem) _then) = _$JmaCodeTableItemCopyWithImpl;
@useResult
$Res call({
 String code, LocalizedName name, String? kana, String? description
});


$LocalizedNameCopyWith<$Res> get name;

}
/// @nodoc
class _$JmaCodeTableItemCopyWithImpl<$Res>
    implements $JmaCodeTableItemCopyWith<$Res> {
  _$JmaCodeTableItemCopyWithImpl(this._self, this._then);

  final JmaCodeTableItem _self;
  final $Res Function(JmaCodeTableItem) _then;

/// Create a copy of JmaCodeTableItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? kana = freezed,Object? description = freezed,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedName,kana: freezed == kana ? _self.kana : kana // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of JmaCodeTableItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedNameCopyWith<$Res> get name {
  
  return $LocalizedNameCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}
}


/// Adds pattern-matching-related methods to [JmaCodeTableItem].
extension JmaCodeTableItemPatterns on JmaCodeTableItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JmaCodeTableItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JmaCodeTableItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JmaCodeTableItem value)  $default,){
final _that = this;
switch (_that) {
case _JmaCodeTableItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JmaCodeTableItem value)?  $default,){
final _that = this;
switch (_that) {
case _JmaCodeTableItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  LocalizedName name,  String? kana,  String? description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JmaCodeTableItem() when $default != null:
return $default(_that.code,_that.name,_that.kana,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  LocalizedName name,  String? kana,  String? description)  $default,) {final _that = this;
switch (_that) {
case _JmaCodeTableItem():
return $default(_that.code,_that.name,_that.kana,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  LocalizedName name,  String? kana,  String? description)?  $default,) {final _that = this;
switch (_that) {
case _JmaCodeTableItem() when $default != null:
return $default(_that.code,_that.name,_that.kana,_that.description);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JmaCodeTableItem implements JmaCodeTableItem {
  const _JmaCodeTableItem({required this.code, required this.name, required this.kana, required this.description});
  factory _JmaCodeTableItem.fromJson(Map<String, dynamic> json) => _$JmaCodeTableItemFromJson(json);

@override final  String code;
@override final  LocalizedName name;
@override final  String? kana;
@override final  String? description;

/// Create a copy of JmaCodeTableItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JmaCodeTableItemCopyWith<_JmaCodeTableItem> get copyWith => __$JmaCodeTableItemCopyWithImpl<_JmaCodeTableItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JmaCodeTableItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JmaCodeTableItem&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.kana, kana) || other.kana == kana)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,kana,description);

@override
String toString() {
  return 'JmaCodeTableItem(code: $code, name: $name, kana: $kana, description: $description)';
}


}

/// @nodoc
abstract mixin class _$JmaCodeTableItemCopyWith<$Res> implements $JmaCodeTableItemCopyWith<$Res> {
  factory _$JmaCodeTableItemCopyWith(_JmaCodeTableItem value, $Res Function(_JmaCodeTableItem) _then) = __$JmaCodeTableItemCopyWithImpl;
@override @useResult
$Res call({
 String code, LocalizedName name, String? kana, String? description
});


@override $LocalizedNameCopyWith<$Res> get name;

}
/// @nodoc
class __$JmaCodeTableItemCopyWithImpl<$Res>
    implements _$JmaCodeTableItemCopyWith<$Res> {
  __$JmaCodeTableItemCopyWithImpl(this._self, this._then);

  final _JmaCodeTableItem _self;
  final $Res Function(_JmaCodeTableItem) _then;

/// Create a copy of JmaCodeTableItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? kana = freezed,Object? description = freezed,}) {
  return _then(_JmaCodeTableItem(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedName,kana: freezed == kana ? _self.kana : kana // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of JmaCodeTableItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedNameCopyWith<$Res> get name {
  
  return $LocalizedNameCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}
}

// dart format on
