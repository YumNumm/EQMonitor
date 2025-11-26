// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EarthquakeParameter {

 String get responseId; DateTime get responseTime; String get status; DateTime get changeTime; String get version; List<EarthquakeParmaeterItem> get items;
/// Create a copy of EarthquakeParameter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeParameterCopyWith<EarthquakeParameter> get copyWith => _$EarthquakeParameterCopyWithImpl<EarthquakeParameter>(this as EarthquakeParameter, _$identity);

  /// Serializes this EarthquakeParameter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeParameter&&(identical(other.responseId, responseId) || other.responseId == responseId)&&(identical(other.responseTime, responseTime) || other.responseTime == responseTime)&&(identical(other.status, status) || other.status == status)&&(identical(other.changeTime, changeTime) || other.changeTime == changeTime)&&(identical(other.version, version) || other.version == version)&&const DeepCollectionEquality().equals(other.items, items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,responseId,responseTime,status,changeTime,version,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'EarthquakeParameter(responseId: $responseId, responseTime: $responseTime, status: $status, changeTime: $changeTime, version: $version, items: $items)';
}


}

/// @nodoc
abstract mixin class $EarthquakeParameterCopyWith<$Res>  {
  factory $EarthquakeParameterCopyWith(EarthquakeParameter value, $Res Function(EarthquakeParameter) _then) = _$EarthquakeParameterCopyWithImpl;
@useResult
$Res call({
 String responseId, DateTime responseTime, String status, DateTime changeTime, String version, List<EarthquakeParmaeterItem> items
});




}
/// @nodoc
class _$EarthquakeParameterCopyWithImpl<$Res>
    implements $EarthquakeParameterCopyWith<$Res> {
  _$EarthquakeParameterCopyWithImpl(this._self, this._then);

  final EarthquakeParameter _self;
  final $Res Function(EarthquakeParameter) _then;

/// Create a copy of EarthquakeParameter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? responseId = null,Object? responseTime = null,Object? status = null,Object? changeTime = null,Object? version = null,Object? items = null,}) {
  return _then(_self.copyWith(
responseId: null == responseId ? _self.responseId : responseId // ignore: cast_nullable_to_non_nullable
as String,responseTime: null == responseTime ? _self.responseTime : responseTime // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,changeTime: null == changeTime ? _self.changeTime : changeTime // ignore: cast_nullable_to_non_nullable
as DateTime,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<EarthquakeParmaeterItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [EarthquakeParameter].
extension EarthquakeParameterPatterns on EarthquakeParameter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeParameter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeParameter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeParameter value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeParameter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeParameter value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeParameter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String responseId,  DateTime responseTime,  String status,  DateTime changeTime,  String version,  List<EarthquakeParmaeterItem> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeParameter() when $default != null:
return $default(_that.responseId,_that.responseTime,_that.status,_that.changeTime,_that.version,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String responseId,  DateTime responseTime,  String status,  DateTime changeTime,  String version,  List<EarthquakeParmaeterItem> items)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeParameter():
return $default(_that.responseId,_that.responseTime,_that.status,_that.changeTime,_that.version,_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String responseId,  DateTime responseTime,  String status,  DateTime changeTime,  String version,  List<EarthquakeParmaeterItem> items)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeParameter() when $default != null:
return $default(_that.responseId,_that.responseTime,_that.status,_that.changeTime,_that.version,_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarthquakeParameter implements EarthquakeParameter {
  const _EarthquakeParameter({required this.responseId, required this.responseTime, required this.status, required this.changeTime, required this.version, required final  List<EarthquakeParmaeterItem> items}): _items = items;
  factory _EarthquakeParameter.fromJson(Map<String, dynamic> json) => _$EarthquakeParameterFromJson(json);

@override final  String responseId;
@override final  DateTime responseTime;
@override final  String status;
@override final  DateTime changeTime;
@override final  String version;
 final  List<EarthquakeParmaeterItem> _items;
@override List<EarthquakeParmaeterItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of EarthquakeParameter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeParameterCopyWith<_EarthquakeParameter> get copyWith => __$EarthquakeParameterCopyWithImpl<_EarthquakeParameter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeParameterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeParameter&&(identical(other.responseId, responseId) || other.responseId == responseId)&&(identical(other.responseTime, responseTime) || other.responseTime == responseTime)&&(identical(other.status, status) || other.status == status)&&(identical(other.changeTime, changeTime) || other.changeTime == changeTime)&&(identical(other.version, version) || other.version == version)&&const DeepCollectionEquality().equals(other._items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,responseId,responseTime,status,changeTime,version,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'EarthquakeParameter(responseId: $responseId, responseTime: $responseTime, status: $status, changeTime: $changeTime, version: $version, items: $items)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeParameterCopyWith<$Res> implements $EarthquakeParameterCopyWith<$Res> {
  factory _$EarthquakeParameterCopyWith(_EarthquakeParameter value, $Res Function(_EarthquakeParameter) _then) = __$EarthquakeParameterCopyWithImpl;
@override @useResult
$Res call({
 String responseId, DateTime responseTime, String status, DateTime changeTime, String version, List<EarthquakeParmaeterItem> items
});




}
/// @nodoc
class __$EarthquakeParameterCopyWithImpl<$Res>
    implements _$EarthquakeParameterCopyWith<$Res> {
  __$EarthquakeParameterCopyWithImpl(this._self, this._then);

  final _EarthquakeParameter _self;
  final $Res Function(_EarthquakeParameter) _then;

/// Create a copy of EarthquakeParameter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? responseId = null,Object? responseTime = null,Object? status = null,Object? changeTime = null,Object? version = null,Object? items = null,}) {
  return _then(_EarthquakeParameter(
responseId: null == responseId ? _self.responseId : responseId // ignore: cast_nullable_to_non_nullable
as String,responseTime: null == responseTime ? _self.responseTime : responseTime // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,changeTime: null == changeTime ? _self.changeTime : changeTime // ignore: cast_nullable_to_non_nullable
as DateTime,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<EarthquakeParmaeterItem>,
  ));
}


}


/// @nodoc
mixin _$EarthquakeParmaeterItem {

 ParameterRegion get region; ParameterCity get city; String get noCode; String get code; String get name; String get kana; String get status; String get owner;@JsonKey(fromJson: doubleFromString, toJson: doubleToString) double get latitude;@JsonKey(fromJson: doubleFromString, toJson: doubleToString) double get longitude;
/// Create a copy of EarthquakeParmaeterItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeParmaeterItemCopyWith<EarthquakeParmaeterItem> get copyWith => _$EarthquakeParmaeterItemCopyWithImpl<EarthquakeParmaeterItem>(this as EarthquakeParmaeterItem, _$identity);

  /// Serializes this EarthquakeParmaeterItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeParmaeterItem&&(identical(other.region, region) || other.region == region)&&(identical(other.city, city) || other.city == city)&&(identical(other.noCode, noCode) || other.noCode == noCode)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.kana, kana) || other.kana == kana)&&(identical(other.status, status) || other.status == status)&&(identical(other.owner, owner) || other.owner == owner)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,region,city,noCode,code,name,kana,status,owner,latitude,longitude);

@override
String toString() {
  return 'EarthquakeParmaeterItem(region: $region, city: $city, noCode: $noCode, code: $code, name: $name, kana: $kana, status: $status, owner: $owner, latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class $EarthquakeParmaeterItemCopyWith<$Res>  {
  factory $EarthquakeParmaeterItemCopyWith(EarthquakeParmaeterItem value, $Res Function(EarthquakeParmaeterItem) _then) = _$EarthquakeParmaeterItemCopyWithImpl;
@useResult
$Res call({
 ParameterRegion region, ParameterCity city, String noCode, String code, String name, String kana, String status, String owner,@JsonKey(fromJson: doubleFromString, toJson: doubleToString) double latitude,@JsonKey(fromJson: doubleFromString, toJson: doubleToString) double longitude
});


$ParameterRegionCopyWith<$Res> get region;$ParameterCityCopyWith<$Res> get city;

}
/// @nodoc
class _$EarthquakeParmaeterItemCopyWithImpl<$Res>
    implements $EarthquakeParmaeterItemCopyWith<$Res> {
  _$EarthquakeParmaeterItemCopyWithImpl(this._self, this._then);

  final EarthquakeParmaeterItem _self;
  final $Res Function(EarthquakeParmaeterItem) _then;

/// Create a copy of EarthquakeParmaeterItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? region = null,Object? city = null,Object? noCode = null,Object? code = null,Object? name = null,Object? kana = null,Object? status = null,Object? owner = null,Object? latitude = null,Object? longitude = null,}) {
  return _then(_self.copyWith(
region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as ParameterRegion,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as ParameterCity,noCode: null == noCode ? _self.noCode : noCode // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kana: null == kana ? _self.kana : kana // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,owner: null == owner ? _self.owner : owner // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,
  ));
}
/// Create a copy of EarthquakeParmaeterItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ParameterRegionCopyWith<$Res> get region {
  
  return $ParameterRegionCopyWith<$Res>(_self.region, (value) {
    return _then(_self.copyWith(region: value));
  });
}/// Create a copy of EarthquakeParmaeterItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ParameterCityCopyWith<$Res> get city {
  
  return $ParameterCityCopyWith<$Res>(_self.city, (value) {
    return _then(_self.copyWith(city: value));
  });
}
}


/// Adds pattern-matching-related methods to [EarthquakeParmaeterItem].
extension EarthquakeParmaeterItemPatterns on EarthquakeParmaeterItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeParmaeterItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeParmaeterItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeParmaeterItem value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeParmaeterItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeParmaeterItem value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeParmaeterItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ParameterRegion region,  ParameterCity city,  String noCode,  String code,  String name,  String kana,  String status,  String owner, @JsonKey(fromJson: doubleFromString, toJson: doubleToString)  double latitude, @JsonKey(fromJson: doubleFromString, toJson: doubleToString)  double longitude)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeParmaeterItem() when $default != null:
return $default(_that.region,_that.city,_that.noCode,_that.code,_that.name,_that.kana,_that.status,_that.owner,_that.latitude,_that.longitude);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ParameterRegion region,  ParameterCity city,  String noCode,  String code,  String name,  String kana,  String status,  String owner, @JsonKey(fromJson: doubleFromString, toJson: doubleToString)  double latitude, @JsonKey(fromJson: doubleFromString, toJson: doubleToString)  double longitude)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeParmaeterItem():
return $default(_that.region,_that.city,_that.noCode,_that.code,_that.name,_that.kana,_that.status,_that.owner,_that.latitude,_that.longitude);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ParameterRegion region,  ParameterCity city,  String noCode,  String code,  String name,  String kana,  String status,  String owner, @JsonKey(fromJson: doubleFromString, toJson: doubleToString)  double latitude, @JsonKey(fromJson: doubleFromString, toJson: doubleToString)  double longitude)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeParmaeterItem() when $default != null:
return $default(_that.region,_that.city,_that.noCode,_that.code,_that.name,_that.kana,_that.status,_that.owner,_that.latitude,_that.longitude);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarthquakeParmaeterItem implements EarthquakeParmaeterItem {
  const _EarthquakeParmaeterItem({required this.region, required this.city, required this.noCode, required this.code, required this.name, required this.kana, required this.status, required this.owner, @JsonKey(fromJson: doubleFromString, toJson: doubleToString) required this.latitude, @JsonKey(fromJson: doubleFromString, toJson: doubleToString) required this.longitude});
  factory _EarthquakeParmaeterItem.fromJson(Map<String, dynamic> json) => _$EarthquakeParmaeterItemFromJson(json);

@override final  ParameterRegion region;
@override final  ParameterCity city;
@override final  String noCode;
@override final  String code;
@override final  String name;
@override final  String kana;
@override final  String status;
@override final  String owner;
@override@JsonKey(fromJson: doubleFromString, toJson: doubleToString) final  double latitude;
@override@JsonKey(fromJson: doubleFromString, toJson: doubleToString) final  double longitude;

/// Create a copy of EarthquakeParmaeterItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeParmaeterItemCopyWith<_EarthquakeParmaeterItem> get copyWith => __$EarthquakeParmaeterItemCopyWithImpl<_EarthquakeParmaeterItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeParmaeterItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeParmaeterItem&&(identical(other.region, region) || other.region == region)&&(identical(other.city, city) || other.city == city)&&(identical(other.noCode, noCode) || other.noCode == noCode)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.kana, kana) || other.kana == kana)&&(identical(other.status, status) || other.status == status)&&(identical(other.owner, owner) || other.owner == owner)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,region,city,noCode,code,name,kana,status,owner,latitude,longitude);

@override
String toString() {
  return 'EarthquakeParmaeterItem(region: $region, city: $city, noCode: $noCode, code: $code, name: $name, kana: $kana, status: $status, owner: $owner, latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeParmaeterItemCopyWith<$Res> implements $EarthquakeParmaeterItemCopyWith<$Res> {
  factory _$EarthquakeParmaeterItemCopyWith(_EarthquakeParmaeterItem value, $Res Function(_EarthquakeParmaeterItem) _then) = __$EarthquakeParmaeterItemCopyWithImpl;
@override @useResult
$Res call({
 ParameterRegion region, ParameterCity city, String noCode, String code, String name, String kana, String status, String owner,@JsonKey(fromJson: doubleFromString, toJson: doubleToString) double latitude,@JsonKey(fromJson: doubleFromString, toJson: doubleToString) double longitude
});


@override $ParameterRegionCopyWith<$Res> get region;@override $ParameterCityCopyWith<$Res> get city;

}
/// @nodoc
class __$EarthquakeParmaeterItemCopyWithImpl<$Res>
    implements _$EarthquakeParmaeterItemCopyWith<$Res> {
  __$EarthquakeParmaeterItemCopyWithImpl(this._self, this._then);

  final _EarthquakeParmaeterItem _self;
  final $Res Function(_EarthquakeParmaeterItem) _then;

/// Create a copy of EarthquakeParmaeterItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? region = null,Object? city = null,Object? noCode = null,Object? code = null,Object? name = null,Object? kana = null,Object? status = null,Object? owner = null,Object? latitude = null,Object? longitude = null,}) {
  return _then(_EarthquakeParmaeterItem(
region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as ParameterRegion,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as ParameterCity,noCode: null == noCode ? _self.noCode : noCode // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kana: null == kana ? _self.kana : kana // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,owner: null == owner ? _self.owner : owner // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

/// Create a copy of EarthquakeParmaeterItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ParameterRegionCopyWith<$Res> get region {
  
  return $ParameterRegionCopyWith<$Res>(_self.region, (value) {
    return _then(_self.copyWith(region: value));
  });
}/// Create a copy of EarthquakeParmaeterItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ParameterCityCopyWith<$Res> get city {
  
  return $ParameterCityCopyWith<$Res>(_self.city, (value) {
    return _then(_self.copyWith(city: value));
  });
}
}

// dart format on
