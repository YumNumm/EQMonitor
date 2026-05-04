// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'jma_code_table_parameter_code_tables.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JmaCodeTableParameterCodeTables {

@JsonKey(name: 'area_forecast_local_eew') List<JmaCodeTableAreaForecastLocalEewItem> get areaForecastLocalEew;@JsonKey(name: 'area_information_prefecture_earthquake') List<JmaCodeTableItem> get areaInformationPrefectureEarthquake;@JsonKey(name: 'area_epicenter') List<JmaCodeTableItem> get areaEpicenter;@JsonKey(name: 'area_epicenter_abbreviation') List<JmaCodeTableItem> get areaEpicenterAbbreviation;@JsonKey(name: 'area_epicenter_detail') List<JmaCodeTableItem> get areaEpicenterDetail;
/// Create a copy of JmaCodeTableParameterCodeTables
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JmaCodeTableParameterCodeTablesCopyWith<JmaCodeTableParameterCodeTables> get copyWith => _$JmaCodeTableParameterCodeTablesCopyWithImpl<JmaCodeTableParameterCodeTables>(this as JmaCodeTableParameterCodeTables, _$identity);

  /// Serializes this JmaCodeTableParameterCodeTables to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JmaCodeTableParameterCodeTables&&const DeepCollectionEquality().equals(other.areaForecastLocalEew, areaForecastLocalEew)&&const DeepCollectionEquality().equals(other.areaInformationPrefectureEarthquake, areaInformationPrefectureEarthquake)&&const DeepCollectionEquality().equals(other.areaEpicenter, areaEpicenter)&&const DeepCollectionEquality().equals(other.areaEpicenterAbbreviation, areaEpicenterAbbreviation)&&const DeepCollectionEquality().equals(other.areaEpicenterDetail, areaEpicenterDetail));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(areaForecastLocalEew),const DeepCollectionEquality().hash(areaInformationPrefectureEarthquake),const DeepCollectionEquality().hash(areaEpicenter),const DeepCollectionEquality().hash(areaEpicenterAbbreviation),const DeepCollectionEquality().hash(areaEpicenterDetail));

@override
String toString() {
  return 'JmaCodeTableParameterCodeTables(areaForecastLocalEew: $areaForecastLocalEew, areaInformationPrefectureEarthquake: $areaInformationPrefectureEarthquake, areaEpicenter: $areaEpicenter, areaEpicenterAbbreviation: $areaEpicenterAbbreviation, areaEpicenterDetail: $areaEpicenterDetail)';
}


}

/// @nodoc
abstract mixin class $JmaCodeTableParameterCodeTablesCopyWith<$Res>  {
  factory $JmaCodeTableParameterCodeTablesCopyWith(JmaCodeTableParameterCodeTables value, $Res Function(JmaCodeTableParameterCodeTables) _then) = _$JmaCodeTableParameterCodeTablesCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'area_forecast_local_eew') List<JmaCodeTableAreaForecastLocalEewItem> areaForecastLocalEew,@JsonKey(name: 'area_information_prefecture_earthquake') List<JmaCodeTableItem> areaInformationPrefectureEarthquake,@JsonKey(name: 'area_epicenter') List<JmaCodeTableItem> areaEpicenter,@JsonKey(name: 'area_epicenter_abbreviation') List<JmaCodeTableItem> areaEpicenterAbbreviation,@JsonKey(name: 'area_epicenter_detail') List<JmaCodeTableItem> areaEpicenterDetail
});




}
/// @nodoc
class _$JmaCodeTableParameterCodeTablesCopyWithImpl<$Res>
    implements $JmaCodeTableParameterCodeTablesCopyWith<$Res> {
  _$JmaCodeTableParameterCodeTablesCopyWithImpl(this._self, this._then);

  final JmaCodeTableParameterCodeTables _self;
  final $Res Function(JmaCodeTableParameterCodeTables) _then;

/// Create a copy of JmaCodeTableParameterCodeTables
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? areaForecastLocalEew = null,Object? areaInformationPrefectureEarthquake = null,Object? areaEpicenter = null,Object? areaEpicenterAbbreviation = null,Object? areaEpicenterDetail = null,}) {
  return _then(_self.copyWith(
areaForecastLocalEew: null == areaForecastLocalEew ? _self.areaForecastLocalEew : areaForecastLocalEew // ignore: cast_nullable_to_non_nullable
as List<JmaCodeTableAreaForecastLocalEewItem>,areaInformationPrefectureEarthquake: null == areaInformationPrefectureEarthquake ? _self.areaInformationPrefectureEarthquake : areaInformationPrefectureEarthquake // ignore: cast_nullable_to_non_nullable
as List<JmaCodeTableItem>,areaEpicenter: null == areaEpicenter ? _self.areaEpicenter : areaEpicenter // ignore: cast_nullable_to_non_nullable
as List<JmaCodeTableItem>,areaEpicenterAbbreviation: null == areaEpicenterAbbreviation ? _self.areaEpicenterAbbreviation : areaEpicenterAbbreviation // ignore: cast_nullable_to_non_nullable
as List<JmaCodeTableItem>,areaEpicenterDetail: null == areaEpicenterDetail ? _self.areaEpicenterDetail : areaEpicenterDetail // ignore: cast_nullable_to_non_nullable
as List<JmaCodeTableItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [JmaCodeTableParameterCodeTables].
extension JmaCodeTableParameterCodeTablesPatterns on JmaCodeTableParameterCodeTables {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JmaCodeTableParameterCodeTables value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JmaCodeTableParameterCodeTables() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JmaCodeTableParameterCodeTables value)  $default,){
final _that = this;
switch (_that) {
case _JmaCodeTableParameterCodeTables():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JmaCodeTableParameterCodeTables value)?  $default,){
final _that = this;
switch (_that) {
case _JmaCodeTableParameterCodeTables() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'area_forecast_local_eew')  List<JmaCodeTableAreaForecastLocalEewItem> areaForecastLocalEew, @JsonKey(name: 'area_information_prefecture_earthquake')  List<JmaCodeTableItem> areaInformationPrefectureEarthquake, @JsonKey(name: 'area_epicenter')  List<JmaCodeTableItem> areaEpicenter, @JsonKey(name: 'area_epicenter_abbreviation')  List<JmaCodeTableItem> areaEpicenterAbbreviation, @JsonKey(name: 'area_epicenter_detail')  List<JmaCodeTableItem> areaEpicenterDetail)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JmaCodeTableParameterCodeTables() when $default != null:
return $default(_that.areaForecastLocalEew,_that.areaInformationPrefectureEarthquake,_that.areaEpicenter,_that.areaEpicenterAbbreviation,_that.areaEpicenterDetail);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'area_forecast_local_eew')  List<JmaCodeTableAreaForecastLocalEewItem> areaForecastLocalEew, @JsonKey(name: 'area_information_prefecture_earthquake')  List<JmaCodeTableItem> areaInformationPrefectureEarthquake, @JsonKey(name: 'area_epicenter')  List<JmaCodeTableItem> areaEpicenter, @JsonKey(name: 'area_epicenter_abbreviation')  List<JmaCodeTableItem> areaEpicenterAbbreviation, @JsonKey(name: 'area_epicenter_detail')  List<JmaCodeTableItem> areaEpicenterDetail)  $default,) {final _that = this;
switch (_that) {
case _JmaCodeTableParameterCodeTables():
return $default(_that.areaForecastLocalEew,_that.areaInformationPrefectureEarthquake,_that.areaEpicenter,_that.areaEpicenterAbbreviation,_that.areaEpicenterDetail);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'area_forecast_local_eew')  List<JmaCodeTableAreaForecastLocalEewItem> areaForecastLocalEew, @JsonKey(name: 'area_information_prefecture_earthquake')  List<JmaCodeTableItem> areaInformationPrefectureEarthquake, @JsonKey(name: 'area_epicenter')  List<JmaCodeTableItem> areaEpicenter, @JsonKey(name: 'area_epicenter_abbreviation')  List<JmaCodeTableItem> areaEpicenterAbbreviation, @JsonKey(name: 'area_epicenter_detail')  List<JmaCodeTableItem> areaEpicenterDetail)?  $default,) {final _that = this;
switch (_that) {
case _JmaCodeTableParameterCodeTables() when $default != null:
return $default(_that.areaForecastLocalEew,_that.areaInformationPrefectureEarthquake,_that.areaEpicenter,_that.areaEpicenterAbbreviation,_that.areaEpicenterDetail);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JmaCodeTableParameterCodeTables implements JmaCodeTableParameterCodeTables {
  const _JmaCodeTableParameterCodeTables({@JsonKey(name: 'area_forecast_local_eew') required final  List<JmaCodeTableAreaForecastLocalEewItem> areaForecastLocalEew, @JsonKey(name: 'area_information_prefecture_earthquake') required final  List<JmaCodeTableItem> areaInformationPrefectureEarthquake, @JsonKey(name: 'area_epicenter') required final  List<JmaCodeTableItem> areaEpicenter, @JsonKey(name: 'area_epicenter_abbreviation') required final  List<JmaCodeTableItem> areaEpicenterAbbreviation, @JsonKey(name: 'area_epicenter_detail') required final  List<JmaCodeTableItem> areaEpicenterDetail}): _areaForecastLocalEew = areaForecastLocalEew,_areaInformationPrefectureEarthquake = areaInformationPrefectureEarthquake,_areaEpicenter = areaEpicenter,_areaEpicenterAbbreviation = areaEpicenterAbbreviation,_areaEpicenterDetail = areaEpicenterDetail;
  factory _JmaCodeTableParameterCodeTables.fromJson(Map<String, dynamic> json) => _$JmaCodeTableParameterCodeTablesFromJson(json);

 final  List<JmaCodeTableAreaForecastLocalEewItem> _areaForecastLocalEew;
@override@JsonKey(name: 'area_forecast_local_eew') List<JmaCodeTableAreaForecastLocalEewItem> get areaForecastLocalEew {
  if (_areaForecastLocalEew is EqualUnmodifiableListView) return _areaForecastLocalEew;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_areaForecastLocalEew);
}

 final  List<JmaCodeTableItem> _areaInformationPrefectureEarthquake;
@override@JsonKey(name: 'area_information_prefecture_earthquake') List<JmaCodeTableItem> get areaInformationPrefectureEarthquake {
  if (_areaInformationPrefectureEarthquake is EqualUnmodifiableListView) return _areaInformationPrefectureEarthquake;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_areaInformationPrefectureEarthquake);
}

 final  List<JmaCodeTableItem> _areaEpicenter;
@override@JsonKey(name: 'area_epicenter') List<JmaCodeTableItem> get areaEpicenter {
  if (_areaEpicenter is EqualUnmodifiableListView) return _areaEpicenter;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_areaEpicenter);
}

 final  List<JmaCodeTableItem> _areaEpicenterAbbreviation;
@override@JsonKey(name: 'area_epicenter_abbreviation') List<JmaCodeTableItem> get areaEpicenterAbbreviation {
  if (_areaEpicenterAbbreviation is EqualUnmodifiableListView) return _areaEpicenterAbbreviation;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_areaEpicenterAbbreviation);
}

 final  List<JmaCodeTableItem> _areaEpicenterDetail;
@override@JsonKey(name: 'area_epicenter_detail') List<JmaCodeTableItem> get areaEpicenterDetail {
  if (_areaEpicenterDetail is EqualUnmodifiableListView) return _areaEpicenterDetail;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_areaEpicenterDetail);
}


/// Create a copy of JmaCodeTableParameterCodeTables
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JmaCodeTableParameterCodeTablesCopyWith<_JmaCodeTableParameterCodeTables> get copyWith => __$JmaCodeTableParameterCodeTablesCopyWithImpl<_JmaCodeTableParameterCodeTables>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JmaCodeTableParameterCodeTablesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JmaCodeTableParameterCodeTables&&const DeepCollectionEquality().equals(other._areaForecastLocalEew, _areaForecastLocalEew)&&const DeepCollectionEquality().equals(other._areaInformationPrefectureEarthquake, _areaInformationPrefectureEarthquake)&&const DeepCollectionEquality().equals(other._areaEpicenter, _areaEpicenter)&&const DeepCollectionEquality().equals(other._areaEpicenterAbbreviation, _areaEpicenterAbbreviation)&&const DeepCollectionEquality().equals(other._areaEpicenterDetail, _areaEpicenterDetail));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_areaForecastLocalEew),const DeepCollectionEquality().hash(_areaInformationPrefectureEarthquake),const DeepCollectionEquality().hash(_areaEpicenter),const DeepCollectionEquality().hash(_areaEpicenterAbbreviation),const DeepCollectionEquality().hash(_areaEpicenterDetail));

@override
String toString() {
  return 'JmaCodeTableParameterCodeTables(areaForecastLocalEew: $areaForecastLocalEew, areaInformationPrefectureEarthquake: $areaInformationPrefectureEarthquake, areaEpicenter: $areaEpicenter, areaEpicenterAbbreviation: $areaEpicenterAbbreviation, areaEpicenterDetail: $areaEpicenterDetail)';
}


}

/// @nodoc
abstract mixin class _$JmaCodeTableParameterCodeTablesCopyWith<$Res> implements $JmaCodeTableParameterCodeTablesCopyWith<$Res> {
  factory _$JmaCodeTableParameterCodeTablesCopyWith(_JmaCodeTableParameterCodeTables value, $Res Function(_JmaCodeTableParameterCodeTables) _then) = __$JmaCodeTableParameterCodeTablesCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'area_forecast_local_eew') List<JmaCodeTableAreaForecastLocalEewItem> areaForecastLocalEew,@JsonKey(name: 'area_information_prefecture_earthquake') List<JmaCodeTableItem> areaInformationPrefectureEarthquake,@JsonKey(name: 'area_epicenter') List<JmaCodeTableItem> areaEpicenter,@JsonKey(name: 'area_epicenter_abbreviation') List<JmaCodeTableItem> areaEpicenterAbbreviation,@JsonKey(name: 'area_epicenter_detail') List<JmaCodeTableItem> areaEpicenterDetail
});




}
/// @nodoc
class __$JmaCodeTableParameterCodeTablesCopyWithImpl<$Res>
    implements _$JmaCodeTableParameterCodeTablesCopyWith<$Res> {
  __$JmaCodeTableParameterCodeTablesCopyWithImpl(this._self, this._then);

  final _JmaCodeTableParameterCodeTables _self;
  final $Res Function(_JmaCodeTableParameterCodeTables) _then;

/// Create a copy of JmaCodeTableParameterCodeTables
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? areaForecastLocalEew = null,Object? areaInformationPrefectureEarthquake = null,Object? areaEpicenter = null,Object? areaEpicenterAbbreviation = null,Object? areaEpicenterDetail = null,}) {
  return _then(_JmaCodeTableParameterCodeTables(
areaForecastLocalEew: null == areaForecastLocalEew ? _self._areaForecastLocalEew : areaForecastLocalEew // ignore: cast_nullable_to_non_nullable
as List<JmaCodeTableAreaForecastLocalEewItem>,areaInformationPrefectureEarthquake: null == areaInformationPrefectureEarthquake ? _self._areaInformationPrefectureEarthquake : areaInformationPrefectureEarthquake // ignore: cast_nullable_to_non_nullable
as List<JmaCodeTableItem>,areaEpicenter: null == areaEpicenter ? _self._areaEpicenter : areaEpicenter // ignore: cast_nullable_to_non_nullable
as List<JmaCodeTableItem>,areaEpicenterAbbreviation: null == areaEpicenterAbbreviation ? _self._areaEpicenterAbbreviation : areaEpicenterAbbreviation // ignore: cast_nullable_to_non_nullable
as List<JmaCodeTableItem>,areaEpicenterDetail: null == areaEpicenterDetail ? _self._areaEpicenterDetail : areaEpicenterDetail // ignore: cast_nullable_to_non_nullable
as List<JmaCodeTableItem>,
  ));
}


}

// dart format on
