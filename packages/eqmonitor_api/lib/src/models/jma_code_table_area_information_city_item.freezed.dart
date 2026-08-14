// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'jma_code_table_area_information_city_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JmaCodeTableAreaInformationCityItem {

 String get code; LocalizedName get name;@JsonKey(name: 'parent_area_forecast_local_eew_code') String get parentAreaForecastLocalEewCode;@JsonKey(name: 'parent_area_information_prefecture_earthquake_code') String get parentAreaInformationPrefectureEarthquakeCode;
/// Create a copy of JmaCodeTableAreaInformationCityItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JmaCodeTableAreaInformationCityItemCopyWith<JmaCodeTableAreaInformationCityItem> get copyWith => _$JmaCodeTableAreaInformationCityItemCopyWithImpl<JmaCodeTableAreaInformationCityItem>(this as JmaCodeTableAreaInformationCityItem, _$identity);

  /// Serializes this JmaCodeTableAreaInformationCityItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JmaCodeTableAreaInformationCityItem&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.parentAreaForecastLocalEewCode, parentAreaForecastLocalEewCode) || other.parentAreaForecastLocalEewCode == parentAreaForecastLocalEewCode)&&(identical(other.parentAreaInformationPrefectureEarthquakeCode, parentAreaInformationPrefectureEarthquakeCode) || other.parentAreaInformationPrefectureEarthquakeCode == parentAreaInformationPrefectureEarthquakeCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,parentAreaForecastLocalEewCode,parentAreaInformationPrefectureEarthquakeCode);

@override
String toString() {
  return 'JmaCodeTableAreaInformationCityItem(code: $code, name: $name, parentAreaForecastLocalEewCode: $parentAreaForecastLocalEewCode, parentAreaInformationPrefectureEarthquakeCode: $parentAreaInformationPrefectureEarthquakeCode)';
}


}

/// @nodoc
abstract mixin class $JmaCodeTableAreaInformationCityItemCopyWith<$Res>  {
  factory $JmaCodeTableAreaInformationCityItemCopyWith(JmaCodeTableAreaInformationCityItem value, $Res Function(JmaCodeTableAreaInformationCityItem) _then) = _$JmaCodeTableAreaInformationCityItemCopyWithImpl;
@useResult
$Res call({
 String code, LocalizedName name,@JsonKey(name: 'parent_area_forecast_local_eew_code') String parentAreaForecastLocalEewCode,@JsonKey(name: 'parent_area_information_prefecture_earthquake_code') String parentAreaInformationPrefectureEarthquakeCode
});


$LocalizedNameCopyWith<$Res> get name;

}
/// @nodoc
class _$JmaCodeTableAreaInformationCityItemCopyWithImpl<$Res>
    implements $JmaCodeTableAreaInformationCityItemCopyWith<$Res> {
  _$JmaCodeTableAreaInformationCityItemCopyWithImpl(this._self, this._then);

  final JmaCodeTableAreaInformationCityItem _self;
  final $Res Function(JmaCodeTableAreaInformationCityItem) _then;

/// Create a copy of JmaCodeTableAreaInformationCityItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? parentAreaForecastLocalEewCode = null,Object? parentAreaInformationPrefectureEarthquakeCode = null,}) {
  return _then(JmaCodeTableAreaInformationCityItem(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedName,parentAreaForecastLocalEewCode: null == parentAreaForecastLocalEewCode ? _self.parentAreaForecastLocalEewCode : parentAreaForecastLocalEewCode // ignore: cast_nullable_to_non_nullable
as String,parentAreaInformationPrefectureEarthquakeCode: null == parentAreaInformationPrefectureEarthquakeCode ? _self.parentAreaInformationPrefectureEarthquakeCode : parentAreaInformationPrefectureEarthquakeCode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of JmaCodeTableAreaInformationCityItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedNameCopyWith<$Res> get name {

  return $LocalizedNameCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}
}


/// Adds pattern-matching-related methods to [JmaCodeTableAreaInformationCityItem].
extension JmaCodeTableAreaInformationCityItemPatterns on JmaCodeTableAreaInformationCityItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JmaCodeTableAreaInformationCityItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JmaCodeTableAreaInformationCityItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JmaCodeTableAreaInformationCityItem value)  $default,){
final _that = this;
switch (_that) {
case _JmaCodeTableAreaInformationCityItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JmaCodeTableAreaInformationCityItem value)?  $default,){
final _that = this;
switch (_that) {
case _JmaCodeTableAreaInformationCityItem() when $default != null:
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
case _JmaCodeTableAreaInformationCityItem() when $default != null:
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
case _JmaCodeTableAreaInformationCityItem():
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
case _JmaCodeTableAreaInformationCityItem() when $default != null:
return $default(_that.code,_that.name,_that.parentAreaForecastLocalEewCode,_that.parentAreaInformationPrefectureEarthquakeCode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JmaCodeTableAreaInformationCityItem implements JmaCodeTableAreaInformationCityItem {
  const _JmaCodeTableAreaInformationCityItem({required this.code, required this.name, @JsonKey(name: 'parent_area_forecast_local_eew_code') required this.parentAreaForecastLocalEewCode, @JsonKey(name: 'parent_area_information_prefecture_earthquake_code') required this.parentAreaInformationPrefectureEarthquakeCode});
  factory _JmaCodeTableAreaInformationCityItem.fromJson(Map<String, dynamic> json) => _$JmaCodeTableAreaInformationCityItemFromJson(json);

@override final  String code;
@override final  LocalizedName name;
@override@JsonKey(name: 'parent_area_forecast_local_eew_code') final  String parentAreaForecastLocalEewCode;
@override@JsonKey(name: 'parent_area_information_prefecture_earthquake_code') final  String parentAreaInformationPrefectureEarthquakeCode;

/// Create a copy of JmaCodeTableAreaInformationCityItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JmaCodeTableAreaInformationCityItemCopyWith<_JmaCodeTableAreaInformationCityItem> get copyWith => __$JmaCodeTableAreaInformationCityItemCopyWithImpl<_JmaCodeTableAreaInformationCityItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JmaCodeTableAreaInformationCityItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JmaCodeTableAreaInformationCityItem&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.parentAreaForecastLocalEewCode, parentAreaForecastLocalEewCode) || other.parentAreaForecastLocalEewCode == parentAreaForecastLocalEewCode)&&(identical(other.parentAreaInformationPrefectureEarthquakeCode, parentAreaInformationPrefectureEarthquakeCode) || other.parentAreaInformationPrefectureEarthquakeCode == parentAreaInformationPrefectureEarthquakeCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,parentAreaForecastLocalEewCode,parentAreaInformationPrefectureEarthquakeCode);

@override
String toString() {
  return 'JmaCodeTableAreaInformationCityItem(code: $code, name: $name, parentAreaForecastLocalEewCode: $parentAreaForecastLocalEewCode, parentAreaInformationPrefectureEarthquakeCode: $parentAreaInformationPrefectureEarthquakeCode)';
}


}

/// @nodoc
abstract mixin class _$JmaCodeTableAreaInformationCityItemCopyWith<$Res> implements $JmaCodeTableAreaInformationCityItemCopyWith<$Res> {
  factory _$JmaCodeTableAreaInformationCityItemCopyWith(_JmaCodeTableAreaInformationCityItem value, $Res Function(_JmaCodeTableAreaInformationCityItem) _then) = __$JmaCodeTableAreaInformationCityItemCopyWithImpl;
@override @useResult
$Res call({
 String code, LocalizedName name,@JsonKey(name: 'parent_area_forecast_local_eew_code') String parentAreaForecastLocalEewCode,@JsonKey(name: 'parent_area_information_prefecture_earthquake_code') String parentAreaInformationPrefectureEarthquakeCode
});


@override $LocalizedNameCopyWith<$Res> get name;

}
/// @nodoc
class __$JmaCodeTableAreaInformationCityItemCopyWithImpl<$Res>
    implements _$JmaCodeTableAreaInformationCityItemCopyWith<$Res> {
  __$JmaCodeTableAreaInformationCityItemCopyWithImpl(this._self, this._then);

  final _JmaCodeTableAreaInformationCityItem _self;
  final $Res Function(_JmaCodeTableAreaInformationCityItem) _then;

/// Create a copy of JmaCodeTableAreaInformationCityItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? parentAreaForecastLocalEewCode = null,Object? parentAreaInformationPrefectureEarthquakeCode = null,}) {
  return _then(_JmaCodeTableAreaInformationCityItem(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedName,parentAreaForecastLocalEewCode: null == parentAreaForecastLocalEewCode ? _self.parentAreaForecastLocalEewCode : parentAreaForecastLocalEewCode // ignore: cast_nullable_to_non_nullable
as String,parentAreaInformationPrefectureEarthquakeCode: null == parentAreaInformationPrefectureEarthquakeCode ? _self.parentAreaInformationPrefectureEarthquakeCode : parentAreaInformationPrefectureEarthquakeCode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of JmaCodeTableAreaInformationCityItem
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
