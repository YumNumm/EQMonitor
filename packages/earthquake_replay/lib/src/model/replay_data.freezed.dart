// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'replay_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JmaXmlTelegramReplayData {

 ReplayDataType get type; DateTime get time; String get title; String get telegram;
/// Create a copy of JmaXmlTelegramReplayData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JmaXmlTelegramReplayDataCopyWith<JmaXmlTelegramReplayData> get copyWith => _$JmaXmlTelegramReplayDataCopyWithImpl<JmaXmlTelegramReplayData>(this as JmaXmlTelegramReplayData, _$identity);

  /// Serializes this JmaXmlTelegramReplayData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JmaXmlTelegramReplayData&&(identical(other.type, type) || other.type == type)&&(identical(other.time, time) || other.time == time)&&(identical(other.title, title) || other.title == title)&&(identical(other.telegram, telegram) || other.telegram == telegram));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,time,title,telegram);



}

/// @nodoc
abstract mixin class $JmaXmlTelegramReplayDataCopyWith<$Res>  {
  factory $JmaXmlTelegramReplayDataCopyWith(JmaXmlTelegramReplayData value, $Res Function(JmaXmlTelegramReplayData) _then) = _$JmaXmlTelegramReplayDataCopyWithImpl;
@useResult
$Res call({
 ReplayDataType type, DateTime time, String title, String telegram
});




}
/// @nodoc
class _$JmaXmlTelegramReplayDataCopyWithImpl<$Res>
    implements $JmaXmlTelegramReplayDataCopyWith<$Res> {
  _$JmaXmlTelegramReplayDataCopyWithImpl(this._self, this._then);

  final JmaXmlTelegramReplayData _self;
  final $Res Function(JmaXmlTelegramReplayData) _then;

/// Create a copy of JmaXmlTelegramReplayData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? time = null,Object? title = null,Object? telegram = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ReplayDataType,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as DateTime,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,telegram: null == telegram ? _self.telegram : telegram // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _JmaXmlTelegramReplayData extends JmaXmlTelegramReplayData {
  const _JmaXmlTelegramReplayData({required this.type, required this.time, required this.title, required this.telegram}): super._();
  factory _JmaXmlTelegramReplayData.fromJson(Map<String, dynamic> json) => _$JmaXmlTelegramReplayDataFromJson(json);

@override final  ReplayDataType type;
@override final  DateTime time;
@override final  String title;
@override final  String telegram;

/// Create a copy of JmaXmlTelegramReplayData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JmaXmlTelegramReplayDataCopyWith<_JmaXmlTelegramReplayData> get copyWith => __$JmaXmlTelegramReplayDataCopyWithImpl<_JmaXmlTelegramReplayData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JmaXmlTelegramReplayDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JmaXmlTelegramReplayData&&(identical(other.type, type) || other.type == type)&&(identical(other.time, time) || other.time == time)&&(identical(other.title, title) || other.title == title)&&(identical(other.telegram, telegram) || other.telegram == telegram));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,time,title,telegram);



}

/// @nodoc
abstract mixin class _$JmaXmlTelegramReplayDataCopyWith<$Res> implements $JmaXmlTelegramReplayDataCopyWith<$Res> {
  factory _$JmaXmlTelegramReplayDataCopyWith(_JmaXmlTelegramReplayData value, $Res Function(_JmaXmlTelegramReplayData) _then) = __$JmaXmlTelegramReplayDataCopyWithImpl;
@override @useResult
$Res call({
 ReplayDataType type, DateTime time, String title, String telegram
});




}
/// @nodoc
class __$JmaXmlTelegramReplayDataCopyWithImpl<$Res>
    implements _$JmaXmlTelegramReplayDataCopyWith<$Res> {
  __$JmaXmlTelegramReplayDataCopyWithImpl(this._self, this._then);

  final _JmaXmlTelegramReplayData _self;
  final $Res Function(_JmaXmlTelegramReplayData) _then;

/// Create a copy of JmaXmlTelegramReplayData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? time = null,Object? title = null,Object? telegram = null,}) {
  return _then(_JmaXmlTelegramReplayData(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ReplayDataType,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as DateTime,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,telegram: null == telegram ? _self.telegram : telegram // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$JmaBinaryTelegramReplayData {

 ReplayDataType get type; DateTime get time; String get telegramType; List<int> get data;
/// Create a copy of JmaBinaryTelegramReplayData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JmaBinaryTelegramReplayDataCopyWith<JmaBinaryTelegramReplayData> get copyWith => _$JmaBinaryTelegramReplayDataCopyWithImpl<JmaBinaryTelegramReplayData>(this as JmaBinaryTelegramReplayData, _$identity);

  /// Serializes this JmaBinaryTelegramReplayData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JmaBinaryTelegramReplayData&&(identical(other.type, type) || other.type == type)&&(identical(other.time, time) || other.time == time)&&(identical(other.telegramType, telegramType) || other.telegramType == telegramType)&&const DeepCollectionEquality().equals(other.data, data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,time,telegramType,const DeepCollectionEquality().hash(data));



}

/// @nodoc
abstract mixin class $JmaBinaryTelegramReplayDataCopyWith<$Res>  {
  factory $JmaBinaryTelegramReplayDataCopyWith(JmaBinaryTelegramReplayData value, $Res Function(JmaBinaryTelegramReplayData) _then) = _$JmaBinaryTelegramReplayDataCopyWithImpl;
@useResult
$Res call({
 ReplayDataType type, DateTime time, String telegramType, List<int> data
});




}
/// @nodoc
class _$JmaBinaryTelegramReplayDataCopyWithImpl<$Res>
    implements $JmaBinaryTelegramReplayDataCopyWith<$Res> {
  _$JmaBinaryTelegramReplayDataCopyWithImpl(this._self, this._then);

  final JmaBinaryTelegramReplayData _self;
  final $Res Function(JmaBinaryTelegramReplayData) _then;

/// Create a copy of JmaBinaryTelegramReplayData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? time = null,Object? telegramType = null,Object? data = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ReplayDataType,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as DateTime,telegramType: null == telegramType ? _self.telegramType : telegramType // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _JmaBinaryTelegramReplayData extends JmaBinaryTelegramReplayData {
  const _JmaBinaryTelegramReplayData({required this.type, required this.time, required this.telegramType, required final  List<int> data}): _data = data,super._();
  factory _JmaBinaryTelegramReplayData.fromJson(Map<String, dynamic> json) => _$JmaBinaryTelegramReplayDataFromJson(json);

@override final  ReplayDataType type;
@override final  DateTime time;
@override final  String telegramType;
 final  List<int> _data;
@override List<int> get data {
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_data);
}


/// Create a copy of JmaBinaryTelegramReplayData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JmaBinaryTelegramReplayDataCopyWith<_JmaBinaryTelegramReplayData> get copyWith => __$JmaBinaryTelegramReplayDataCopyWithImpl<_JmaBinaryTelegramReplayData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JmaBinaryTelegramReplayDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JmaBinaryTelegramReplayData&&(identical(other.type, type) || other.type == type)&&(identical(other.time, time) || other.time == time)&&(identical(other.telegramType, telegramType) || other.telegramType == telegramType)&&const DeepCollectionEquality().equals(other._data, _data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,time,telegramType,const DeepCollectionEquality().hash(_data));



}

/// @nodoc
abstract mixin class _$JmaBinaryTelegramReplayDataCopyWith<$Res> implements $JmaBinaryTelegramReplayDataCopyWith<$Res> {
  factory _$JmaBinaryTelegramReplayDataCopyWith(_JmaBinaryTelegramReplayData value, $Res Function(_JmaBinaryTelegramReplayData) _then) = __$JmaBinaryTelegramReplayDataCopyWithImpl;
@override @useResult
$Res call({
 ReplayDataType type, DateTime time, String telegramType, List<int> data
});




}
/// @nodoc
class __$JmaBinaryTelegramReplayDataCopyWithImpl<$Res>
    implements _$JmaBinaryTelegramReplayDataCopyWith<$Res> {
  __$JmaBinaryTelegramReplayDataCopyWithImpl(this._self, this._then);

  final _JmaBinaryTelegramReplayData _self;
  final $Res Function(_JmaBinaryTelegramReplayData) _then;

/// Create a copy of JmaBinaryTelegramReplayData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? time = null,Object? telegramType = null,Object? data = null,}) {
  return _then(_JmaBinaryTelegramReplayData(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ReplayDataType,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as DateTime,telegramType: null == telegramType ? _self.telegramType : telegramType // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}


/// @nodoc
mixin _$KyoshinMonitorImageReplayData {

 ReplayDataType get type; DateTime get time; Map<ImageType, List<int>> get images;
/// Create a copy of KyoshinMonitorImageReplayData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KyoshinMonitorImageReplayDataCopyWith<KyoshinMonitorImageReplayData> get copyWith => _$KyoshinMonitorImageReplayDataCopyWithImpl<KyoshinMonitorImageReplayData>(this as KyoshinMonitorImageReplayData, _$identity);

  /// Serializes this KyoshinMonitorImageReplayData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KyoshinMonitorImageReplayData&&(identical(other.type, type) || other.type == type)&&(identical(other.time, time) || other.time == time)&&const DeepCollectionEquality().equals(other.images, images));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,time,const DeepCollectionEquality().hash(images));



}

/// @nodoc
abstract mixin class $KyoshinMonitorImageReplayDataCopyWith<$Res>  {
  factory $KyoshinMonitorImageReplayDataCopyWith(KyoshinMonitorImageReplayData value, $Res Function(KyoshinMonitorImageReplayData) _then) = _$KyoshinMonitorImageReplayDataCopyWithImpl;
@useResult
$Res call({
 ReplayDataType type, DateTime time, Map<ImageType, List<int>> images
});




}
/// @nodoc
class _$KyoshinMonitorImageReplayDataCopyWithImpl<$Res>
    implements $KyoshinMonitorImageReplayDataCopyWith<$Res> {
  _$KyoshinMonitorImageReplayDataCopyWithImpl(this._self, this._then);

  final KyoshinMonitorImageReplayData _self;
  final $Res Function(KyoshinMonitorImageReplayData) _then;

/// Create a copy of KyoshinMonitorImageReplayData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? time = null,Object? images = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ReplayDataType,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as DateTime,images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as Map<ImageType, List<int>>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _KyoshinMonitorImageReplayData extends KyoshinMonitorImageReplayData {
  const _KyoshinMonitorImageReplayData({required this.type, required this.time, required final  Map<ImageType, List<int>> images}): _images = images,super._();
  factory _KyoshinMonitorImageReplayData.fromJson(Map<String, dynamic> json) => _$KyoshinMonitorImageReplayDataFromJson(json);

@override final  ReplayDataType type;
@override final  DateTime time;
 final  Map<ImageType, List<int>> _images;
@override Map<ImageType, List<int>> get images {
  if (_images is EqualUnmodifiableMapView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_images);
}


/// Create a copy of KyoshinMonitorImageReplayData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KyoshinMonitorImageReplayDataCopyWith<_KyoshinMonitorImageReplayData> get copyWith => __$KyoshinMonitorImageReplayDataCopyWithImpl<_KyoshinMonitorImageReplayData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KyoshinMonitorImageReplayDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KyoshinMonitorImageReplayData&&(identical(other.type, type) || other.type == type)&&(identical(other.time, time) || other.time == time)&&const DeepCollectionEquality().equals(other._images, _images));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,time,const DeepCollectionEquality().hash(_images));



}

/// @nodoc
abstract mixin class _$KyoshinMonitorImageReplayDataCopyWith<$Res> implements $KyoshinMonitorImageReplayDataCopyWith<$Res> {
  factory _$KyoshinMonitorImageReplayDataCopyWith(_KyoshinMonitorImageReplayData value, $Res Function(_KyoshinMonitorImageReplayData) _then) = __$KyoshinMonitorImageReplayDataCopyWithImpl;
@override @useResult
$Res call({
 ReplayDataType type, DateTime time, Map<ImageType, List<int>> images
});




}
/// @nodoc
class __$KyoshinMonitorImageReplayDataCopyWithImpl<$Res>
    implements _$KyoshinMonitorImageReplayDataCopyWith<$Res> {
  __$KyoshinMonitorImageReplayDataCopyWithImpl(this._self, this._then);

  final _KyoshinMonitorImageReplayData _self;
  final $Res Function(_KyoshinMonitorImageReplayData) _then;

/// Create a copy of KyoshinMonitorImageReplayData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? time = null,Object? images = null,}) {
  return _then(_KyoshinMonitorImageReplayData(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ReplayDataType,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as DateTime,images: null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as Map<ImageType, List<int>>,
  ));
}


}


/// @nodoc
mixin _$KyoshinMonitorEewJsonReplayData {

 ReplayDataType get type; DateTime get time; String get json;
/// Create a copy of KyoshinMonitorEewJsonReplayData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KyoshinMonitorEewJsonReplayDataCopyWith<KyoshinMonitorEewJsonReplayData> get copyWith => _$KyoshinMonitorEewJsonReplayDataCopyWithImpl<KyoshinMonitorEewJsonReplayData>(this as KyoshinMonitorEewJsonReplayData, _$identity);

  /// Serializes this KyoshinMonitorEewJsonReplayData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KyoshinMonitorEewJsonReplayData&&(identical(other.type, type) || other.type == type)&&(identical(other.time, time) || other.time == time)&&(identical(other.json, json) || other.json == json));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,time,json);



}

/// @nodoc
abstract mixin class $KyoshinMonitorEewJsonReplayDataCopyWith<$Res>  {
  factory $KyoshinMonitorEewJsonReplayDataCopyWith(KyoshinMonitorEewJsonReplayData value, $Res Function(KyoshinMonitorEewJsonReplayData) _then) = _$KyoshinMonitorEewJsonReplayDataCopyWithImpl;
@useResult
$Res call({
 ReplayDataType type, DateTime time, String json
});




}
/// @nodoc
class _$KyoshinMonitorEewJsonReplayDataCopyWithImpl<$Res>
    implements $KyoshinMonitorEewJsonReplayDataCopyWith<$Res> {
  _$KyoshinMonitorEewJsonReplayDataCopyWithImpl(this._self, this._then);

  final KyoshinMonitorEewJsonReplayData _self;
  final $Res Function(KyoshinMonitorEewJsonReplayData) _then;

/// Create a copy of KyoshinMonitorEewJsonReplayData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? time = null,Object? json = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ReplayDataType,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as DateTime,json: null == json ? _self.json : json // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _KyoshinMonitorEewJsonReplayData extends KyoshinMonitorEewJsonReplayData {
  const _KyoshinMonitorEewJsonReplayData({required this.type, required this.time, required this.json}): super._();
  factory _KyoshinMonitorEewJsonReplayData.fromJson(Map<String, dynamic> json) => _$KyoshinMonitorEewJsonReplayDataFromJson(json);

@override final  ReplayDataType type;
@override final  DateTime time;
@override final  String json;

/// Create a copy of KyoshinMonitorEewJsonReplayData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KyoshinMonitorEewJsonReplayDataCopyWith<_KyoshinMonitorEewJsonReplayData> get copyWith => __$KyoshinMonitorEewJsonReplayDataCopyWithImpl<_KyoshinMonitorEewJsonReplayData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KyoshinMonitorEewJsonReplayDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KyoshinMonitorEewJsonReplayData&&(identical(other.type, type) || other.type == type)&&(identical(other.time, time) || other.time == time)&&(identical(other.json, json) || other.json == json));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,time,json);



}

/// @nodoc
abstract mixin class _$KyoshinMonitorEewJsonReplayDataCopyWith<$Res> implements $KyoshinMonitorEewJsonReplayDataCopyWith<$Res> {
  factory _$KyoshinMonitorEewJsonReplayDataCopyWith(_KyoshinMonitorEewJsonReplayData value, $Res Function(_KyoshinMonitorEewJsonReplayData) _then) = __$KyoshinMonitorEewJsonReplayDataCopyWithImpl;
@override @useResult
$Res call({
 ReplayDataType type, DateTime time, String json
});




}
/// @nodoc
class __$KyoshinMonitorEewJsonReplayDataCopyWithImpl<$Res>
    implements _$KyoshinMonitorEewJsonReplayDataCopyWith<$Res> {
  __$KyoshinMonitorEewJsonReplayDataCopyWithImpl(this._self, this._then);

  final _KyoshinMonitorEewJsonReplayData _self;
  final $Res Function(_KyoshinMonitorEewJsonReplayData) _then;

/// Create a copy of KyoshinMonitorEewJsonReplayData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? time = null,Object? json = null,}) {
  return _then(_KyoshinMonitorEewJsonReplayData(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ReplayDataType,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as DateTime,json: null == json ? _self.json : json // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$KeviJsonReplayData {

 ReplayDataType get type; DateTime get time; JsonType get jsonType; String get json;
/// Create a copy of KeviJsonReplayData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KeviJsonReplayDataCopyWith<KeviJsonReplayData> get copyWith => _$KeviJsonReplayDataCopyWithImpl<KeviJsonReplayData>(this as KeviJsonReplayData, _$identity);

  /// Serializes this KeviJsonReplayData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KeviJsonReplayData&&(identical(other.type, type) || other.type == type)&&(identical(other.time, time) || other.time == time)&&(identical(other.jsonType, jsonType) || other.jsonType == jsonType)&&(identical(other.json, json) || other.json == json));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,time,jsonType,json);



}

/// @nodoc
abstract mixin class $KeviJsonReplayDataCopyWith<$Res>  {
  factory $KeviJsonReplayDataCopyWith(KeviJsonReplayData value, $Res Function(KeviJsonReplayData) _then) = _$KeviJsonReplayDataCopyWithImpl;
@useResult
$Res call({
 ReplayDataType type, DateTime time, JsonType jsonType, String json
});




}
/// @nodoc
class _$KeviJsonReplayDataCopyWithImpl<$Res>
    implements $KeviJsonReplayDataCopyWith<$Res> {
  _$KeviJsonReplayDataCopyWithImpl(this._self, this._then);

  final KeviJsonReplayData _self;
  final $Res Function(KeviJsonReplayData) _then;

/// Create a copy of KeviJsonReplayData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? time = null,Object? jsonType = null,Object? json = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ReplayDataType,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as DateTime,jsonType: null == jsonType ? _self.jsonType : jsonType // ignore: cast_nullable_to_non_nullable
as JsonType,json: null == json ? _self.json : json // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _KeviJsonReplayData extends KeviJsonReplayData {
  const _KeviJsonReplayData({required this.type, required this.time, required this.jsonType, required this.json}): super._();
  factory _KeviJsonReplayData.fromJson(Map<String, dynamic> json) => _$KeviJsonReplayDataFromJson(json);

@override final  ReplayDataType type;
@override final  DateTime time;
@override final  JsonType jsonType;
@override final  String json;

/// Create a copy of KeviJsonReplayData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KeviJsonReplayDataCopyWith<_KeviJsonReplayData> get copyWith => __$KeviJsonReplayDataCopyWithImpl<_KeviJsonReplayData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KeviJsonReplayDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KeviJsonReplayData&&(identical(other.type, type) || other.type == type)&&(identical(other.time, time) || other.time == time)&&(identical(other.jsonType, jsonType) || other.jsonType == jsonType)&&(identical(other.json, json) || other.json == json));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,time,jsonType,json);



}

/// @nodoc
abstract mixin class _$KeviJsonReplayDataCopyWith<$Res> implements $KeviJsonReplayDataCopyWith<$Res> {
  factory _$KeviJsonReplayDataCopyWith(_KeviJsonReplayData value, $Res Function(_KeviJsonReplayData) _then) = __$KeviJsonReplayDataCopyWithImpl;
@override @useResult
$Res call({
 ReplayDataType type, DateTime time, JsonType jsonType, String json
});




}
/// @nodoc
class __$KeviJsonReplayDataCopyWithImpl<$Res>
    implements _$KeviJsonReplayDataCopyWith<$Res> {
  __$KeviJsonReplayDataCopyWithImpl(this._self, this._then);

  final _KeviJsonReplayData _self;
  final $Res Function(_KeviJsonReplayData) _then;

/// Create a copy of KeviJsonReplayData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? time = null,Object? jsonType = null,Object? json = null,}) {
  return _then(_KeviJsonReplayData(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ReplayDataType,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as DateTime,jsonType: null == jsonType ? _self.jsonType : jsonType // ignore: cast_nullable_to_non_nullable
as JsonType,json: null == json ? _self.json : json // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$SnpLogEntryReplayData {

 ReplayDataType get type; DateTime get time; String get message;
/// Create a copy of SnpLogEntryReplayData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SnpLogEntryReplayDataCopyWith<SnpLogEntryReplayData> get copyWith => _$SnpLogEntryReplayDataCopyWithImpl<SnpLogEntryReplayData>(this as SnpLogEntryReplayData, _$identity);

  /// Serializes this SnpLogEntryReplayData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SnpLogEntryReplayData&&(identical(other.type, type) || other.type == type)&&(identical(other.time, time) || other.time == time)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,time,message);



}

/// @nodoc
abstract mixin class $SnpLogEntryReplayDataCopyWith<$Res>  {
  factory $SnpLogEntryReplayDataCopyWith(SnpLogEntryReplayData value, $Res Function(SnpLogEntryReplayData) _then) = _$SnpLogEntryReplayDataCopyWithImpl;
@useResult
$Res call({
 ReplayDataType type, DateTime time, String message
});




}
/// @nodoc
class _$SnpLogEntryReplayDataCopyWithImpl<$Res>
    implements $SnpLogEntryReplayDataCopyWith<$Res> {
  _$SnpLogEntryReplayDataCopyWithImpl(this._self, this._then);

  final SnpLogEntryReplayData _self;
  final $Res Function(SnpLogEntryReplayData) _then;

/// Create a copy of SnpLogEntryReplayData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? time = null,Object? message = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ReplayDataType,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as DateTime,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _SnpLogEntryReplayData extends SnpLogEntryReplayData {
  const _SnpLogEntryReplayData({required this.type, required this.time, required this.message}): super._();
  factory _SnpLogEntryReplayData.fromJson(Map<String, dynamic> json) => _$SnpLogEntryReplayDataFromJson(json);

@override final  ReplayDataType type;
@override final  DateTime time;
@override final  String message;

/// Create a copy of SnpLogEntryReplayData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SnpLogEntryReplayDataCopyWith<_SnpLogEntryReplayData> get copyWith => __$SnpLogEntryReplayDataCopyWithImpl<_SnpLogEntryReplayData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SnpLogEntryReplayDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SnpLogEntryReplayData&&(identical(other.type, type) || other.type == type)&&(identical(other.time, time) || other.time == time)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,time,message);



}

/// @nodoc
abstract mixin class _$SnpLogEntryReplayDataCopyWith<$Res> implements $SnpLogEntryReplayDataCopyWith<$Res> {
  factory _$SnpLogEntryReplayDataCopyWith(_SnpLogEntryReplayData value, $Res Function(_SnpLogEntryReplayData) _then) = __$SnpLogEntryReplayDataCopyWithImpl;
@override @useResult
$Res call({
 ReplayDataType type, DateTime time, String message
});




}
/// @nodoc
class __$SnpLogEntryReplayDataCopyWithImpl<$Res>
    implements _$SnpLogEntryReplayDataCopyWith<$Res> {
  __$SnpLogEntryReplayDataCopyWithImpl(this._self, this._then);

  final _SnpLogEntryReplayData _self;
  final $Res Function(_SnpLogEntryReplayData) _then;

/// Create a copy of SnpLogEntryReplayData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? time = null,Object? message = null,}) {
  return _then(_SnpLogEntryReplayData(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ReplayDataType,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as DateTime,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$AxisJsonReplayData {

 ReplayDataType get type; DateTime get time; String get json;
/// Create a copy of AxisJsonReplayData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AxisJsonReplayDataCopyWith<AxisJsonReplayData> get copyWith => _$AxisJsonReplayDataCopyWithImpl<AxisJsonReplayData>(this as AxisJsonReplayData, _$identity);

  /// Serializes this AxisJsonReplayData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AxisJsonReplayData&&(identical(other.type, type) || other.type == type)&&(identical(other.time, time) || other.time == time)&&(identical(other.json, json) || other.json == json));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,time,json);



}

/// @nodoc
abstract mixin class $AxisJsonReplayDataCopyWith<$Res>  {
  factory $AxisJsonReplayDataCopyWith(AxisJsonReplayData value, $Res Function(AxisJsonReplayData) _then) = _$AxisJsonReplayDataCopyWithImpl;
@useResult
$Res call({
 ReplayDataType type, DateTime time, String json
});




}
/// @nodoc
class _$AxisJsonReplayDataCopyWithImpl<$Res>
    implements $AxisJsonReplayDataCopyWith<$Res> {
  _$AxisJsonReplayDataCopyWithImpl(this._self, this._then);

  final AxisJsonReplayData _self;
  final $Res Function(AxisJsonReplayData) _then;

/// Create a copy of AxisJsonReplayData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? time = null,Object? json = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ReplayDataType,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as DateTime,json: null == json ? _self.json : json // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _AxisJsonReplayData extends AxisJsonReplayData {
  const _AxisJsonReplayData({required this.type, required this.time, required this.json}): super._();
  factory _AxisJsonReplayData.fromJson(Map<String, dynamic> json) => _$AxisJsonReplayDataFromJson(json);

@override final  ReplayDataType type;
@override final  DateTime time;
@override final  String json;

/// Create a copy of AxisJsonReplayData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AxisJsonReplayDataCopyWith<_AxisJsonReplayData> get copyWith => __$AxisJsonReplayDataCopyWithImpl<_AxisJsonReplayData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AxisJsonReplayDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AxisJsonReplayData&&(identical(other.type, type) || other.type == type)&&(identical(other.time, time) || other.time == time)&&(identical(other.json, json) || other.json == json));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,time,json);



}

/// @nodoc
abstract mixin class _$AxisJsonReplayDataCopyWith<$Res> implements $AxisJsonReplayDataCopyWith<$Res> {
  factory _$AxisJsonReplayDataCopyWith(_AxisJsonReplayData value, $Res Function(_AxisJsonReplayData) _then) = __$AxisJsonReplayDataCopyWithImpl;
@override @useResult
$Res call({
 ReplayDataType type, DateTime time, String json
});




}
/// @nodoc
class __$AxisJsonReplayDataCopyWithImpl<$Res>
    implements _$AxisJsonReplayDataCopyWith<$Res> {
  __$AxisJsonReplayDataCopyWithImpl(this._self, this._then);

  final _AxisJsonReplayData _self;
  final $Res Function(_AxisJsonReplayData) _then;

/// Create a copy of AxisJsonReplayData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? time = null,Object? json = null,}) {
  return _then(_AxisJsonReplayData(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ReplayDataType,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as DateTime,json: null == json ? _self.json : json // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
