// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TsunamiParameter {

 String get responseId; DateTime get responseTime; String get status; DateTime get changeTime; String get version; List<TsunamiParameterItem> get items;
/// Create a copy of TsunamiParameter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiParameterCopyWith<TsunamiParameter> get copyWith => _$TsunamiParameterCopyWithImpl<TsunamiParameter>(this as TsunamiParameter, _$identity);

  /// Serializes this TsunamiParameter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiParameter&&(identical(other.responseId, responseId) || other.responseId == responseId)&&(identical(other.responseTime, responseTime) || other.responseTime == responseTime)&&(identical(other.status, status) || other.status == status)&&(identical(other.changeTime, changeTime) || other.changeTime == changeTime)&&(identical(other.version, version) || other.version == version)&&const DeepCollectionEquality().equals(other.items, items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,responseId,responseTime,status,changeTime,version,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'TsunamiParameter(responseId: $responseId, responseTime: $responseTime, status: $status, changeTime: $changeTime, version: $version, items: $items)';
}


}

/// @nodoc
abstract mixin class $TsunamiParameterCopyWith<$Res>  {
  factory $TsunamiParameterCopyWith(TsunamiParameter value, $Res Function(TsunamiParameter) _then) = _$TsunamiParameterCopyWithImpl;
@useResult
$Res call({
 String responseId, DateTime responseTime, String status, DateTime changeTime, String version, List<TsunamiParameterItem> items
});




}
/// @nodoc
class _$TsunamiParameterCopyWithImpl<$Res>
    implements $TsunamiParameterCopyWith<$Res> {
  _$TsunamiParameterCopyWithImpl(this._self, this._then);

  final TsunamiParameter _self;
  final $Res Function(TsunamiParameter) _then;

/// Create a copy of TsunamiParameter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? responseId = null,Object? responseTime = null,Object? status = null,Object? changeTime = null,Object? version = null,Object? items = null,}) {
  return _then(_self.copyWith(
responseId: null == responseId ? _self.responseId : responseId // ignore: cast_nullable_to_non_nullable
as String,responseTime: null == responseTime ? _self.responseTime : responseTime // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,changeTime: null == changeTime ? _self.changeTime : changeTime // ignore: cast_nullable_to_non_nullable
as DateTime,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<TsunamiParameterItem>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _TsunamiParameter implements TsunamiParameter {
  const _TsunamiParameter({required this.responseId, required this.responseTime, required this.status, required this.changeTime, required this.version, required final  List<TsunamiParameterItem> items}): _items = items;
  factory _TsunamiParameter.fromJson(Map<String, dynamic> json) => _$TsunamiParameterFromJson(json);

@override final  String responseId;
@override final  DateTime responseTime;
@override final  String status;
@override final  DateTime changeTime;
@override final  String version;
 final  List<TsunamiParameterItem> _items;
@override List<TsunamiParameterItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of TsunamiParameter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiParameterCopyWith<_TsunamiParameter> get copyWith => __$TsunamiParameterCopyWithImpl<_TsunamiParameter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiParameterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiParameter&&(identical(other.responseId, responseId) || other.responseId == responseId)&&(identical(other.responseTime, responseTime) || other.responseTime == responseTime)&&(identical(other.status, status) || other.status == status)&&(identical(other.changeTime, changeTime) || other.changeTime == changeTime)&&(identical(other.version, version) || other.version == version)&&const DeepCollectionEquality().equals(other._items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,responseId,responseTime,status,changeTime,version,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'TsunamiParameter(responseId: $responseId, responseTime: $responseTime, status: $status, changeTime: $changeTime, version: $version, items: $items)';
}


}

/// @nodoc
abstract mixin class _$TsunamiParameterCopyWith<$Res> implements $TsunamiParameterCopyWith<$Res> {
  factory _$TsunamiParameterCopyWith(_TsunamiParameter value, $Res Function(_TsunamiParameter) _then) = __$TsunamiParameterCopyWithImpl;
@override @useResult
$Res call({
 String responseId, DateTime responseTime, String status, DateTime changeTime, String version, List<TsunamiParameterItem> items
});




}
/// @nodoc
class __$TsunamiParameterCopyWithImpl<$Res>
    implements _$TsunamiParameterCopyWith<$Res> {
  __$TsunamiParameterCopyWithImpl(this._self, this._then);

  final _TsunamiParameter _self;
  final $Res Function(_TsunamiParameter) _then;

/// Create a copy of TsunamiParameter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? responseId = null,Object? responseTime = null,Object? status = null,Object? changeTime = null,Object? version = null,Object? items = null,}) {
  return _then(_TsunamiParameter(
responseId: null == responseId ? _self.responseId : responseId // ignore: cast_nullable_to_non_nullable
as String,responseTime: null == responseTime ? _self.responseTime : responseTime // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,changeTime: null == changeTime ? _self.changeTime : changeTime // ignore: cast_nullable_to_non_nullable
as DateTime,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<TsunamiParameterItem>,
  ));
}


}


/// @nodoc
mixin _$TsunamiParameterItem {

 String? get area; String get prefecture; String get code; String get name; String get kana; String get owner;@JsonKey(fromJson: doubleFromString, toJson: doubleToString) double get latitude;@JsonKey(fromJson: doubleFromString, toJson: doubleToString) double get longitude;
/// Create a copy of TsunamiParameterItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiParameterItemCopyWith<TsunamiParameterItem> get copyWith => _$TsunamiParameterItemCopyWithImpl<TsunamiParameterItem>(this as TsunamiParameterItem, _$identity);

  /// Serializes this TsunamiParameterItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiParameterItem&&(identical(other.area, area) || other.area == area)&&(identical(other.prefecture, prefecture) || other.prefecture == prefecture)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.kana, kana) || other.kana == kana)&&(identical(other.owner, owner) || other.owner == owner)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,area,prefecture,code,name,kana,owner,latitude,longitude);

@override
String toString() {
  return 'TsunamiParameterItem(area: $area, prefecture: $prefecture, code: $code, name: $name, kana: $kana, owner: $owner, latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class $TsunamiParameterItemCopyWith<$Res>  {
  factory $TsunamiParameterItemCopyWith(TsunamiParameterItem value, $Res Function(TsunamiParameterItem) _then) = _$TsunamiParameterItemCopyWithImpl;
@useResult
$Res call({
 String? area, String prefecture, String code, String name, String kana, String owner,@JsonKey(fromJson: doubleFromString, toJson: doubleToString) double latitude,@JsonKey(fromJson: doubleFromString, toJson: doubleToString) double longitude
});




}
/// @nodoc
class _$TsunamiParameterItemCopyWithImpl<$Res>
    implements $TsunamiParameterItemCopyWith<$Res> {
  _$TsunamiParameterItemCopyWithImpl(this._self, this._then);

  final TsunamiParameterItem _self;
  final $Res Function(TsunamiParameterItem) _then;

/// Create a copy of TsunamiParameterItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? area = freezed,Object? prefecture = null,Object? code = null,Object? name = null,Object? kana = null,Object? owner = null,Object? latitude = null,Object? longitude = null,}) {
  return _then(_self.copyWith(
area: freezed == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as String?,prefecture: null == prefecture ? _self.prefecture : prefecture // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kana: null == kana ? _self.kana : kana // ignore: cast_nullable_to_non_nullable
as String,owner: null == owner ? _self.owner : owner // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _TsunamiParameterItem implements TsunamiParameterItem {
  const _TsunamiParameterItem({required this.area, required this.prefecture, required this.code, required this.name, required this.kana, required this.owner, @JsonKey(fromJson: doubleFromString, toJson: doubleToString) required this.latitude, @JsonKey(fromJson: doubleFromString, toJson: doubleToString) required this.longitude});
  factory _TsunamiParameterItem.fromJson(Map<String, dynamic> json) => _$TsunamiParameterItemFromJson(json);

@override final  String? area;
@override final  String prefecture;
@override final  String code;
@override final  String name;
@override final  String kana;
@override final  String owner;
@override@JsonKey(fromJson: doubleFromString, toJson: doubleToString) final  double latitude;
@override@JsonKey(fromJson: doubleFromString, toJson: doubleToString) final  double longitude;

/// Create a copy of TsunamiParameterItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiParameterItemCopyWith<_TsunamiParameterItem> get copyWith => __$TsunamiParameterItemCopyWithImpl<_TsunamiParameterItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiParameterItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiParameterItem&&(identical(other.area, area) || other.area == area)&&(identical(other.prefecture, prefecture) || other.prefecture == prefecture)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.kana, kana) || other.kana == kana)&&(identical(other.owner, owner) || other.owner == owner)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,area,prefecture,code,name,kana,owner,latitude,longitude);

@override
String toString() {
  return 'TsunamiParameterItem(area: $area, prefecture: $prefecture, code: $code, name: $name, kana: $kana, owner: $owner, latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class _$TsunamiParameterItemCopyWith<$Res> implements $TsunamiParameterItemCopyWith<$Res> {
  factory _$TsunamiParameterItemCopyWith(_TsunamiParameterItem value, $Res Function(_TsunamiParameterItem) _then) = __$TsunamiParameterItemCopyWithImpl;
@override @useResult
$Res call({
 String? area, String prefecture, String code, String name, String kana, String owner,@JsonKey(fromJson: doubleFromString, toJson: doubleToString) double latitude,@JsonKey(fromJson: doubleFromString, toJson: doubleToString) double longitude
});




}
/// @nodoc
class __$TsunamiParameterItemCopyWithImpl<$Res>
    implements _$TsunamiParameterItemCopyWith<$Res> {
  __$TsunamiParameterItemCopyWithImpl(this._self, this._then);

  final _TsunamiParameterItem _self;
  final $Res Function(_TsunamiParameterItem) _then;

/// Create a copy of TsunamiParameterItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? area = freezed,Object? prefecture = null,Object? code = null,Object? name = null,Object? kana = null,Object? owner = null,Object? latitude = null,Object? longitude = null,}) {
  return _then(_TsunamiParameterItem(
area: freezed == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as String?,prefecture: null == prefecture ? _self.prefecture : prefecture // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kana: null == kana ? _self.kana : kana // ignore: cast_nullable_to_non_nullable
as String,owner: null == owner ? _self.owner : owner // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
