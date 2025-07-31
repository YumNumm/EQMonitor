// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_forecast.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TsunamiInfo {

/// 地域別津波情報
 List<TsunamiArea> get areas;/// 津波観測データ（VTSE51から）
 List<TsunamiObservation>? get observations;/// テキスト情報
 String? get text;/// コメント
 TsunamiComments? get comments;
/// Create a copy of TsunamiInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiInfoCopyWith<TsunamiInfo> get copyWith => _$TsunamiInfoCopyWithImpl<TsunamiInfo>(this as TsunamiInfo, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiInfo&&const DeepCollectionEquality().equals(other.areas, areas)&&const DeepCollectionEquality().equals(other.observations, observations)&&(identical(other.text, text) || other.text == text)&&(identical(other.comments, comments) || other.comments == comments));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(areas),const DeepCollectionEquality().hash(observations),text,comments);

@override
String toString() {
  return 'TsunamiInfo(areas: $areas, observations: $observations, text: $text, comments: $comments)';
}


}

/// @nodoc
abstract mixin class $TsunamiInfoCopyWith<$Res>  {
  factory $TsunamiInfoCopyWith(TsunamiInfo value, $Res Function(TsunamiInfo) _then) = _$TsunamiInfoCopyWithImpl;
@useResult
$Res call({
 List<TsunamiArea> areas, List<TsunamiObservation>? observations, String? text, TsunamiComments? comments
});


$TsunamiCommentsCopyWith<$Res>? get comments;

}
/// @nodoc
class _$TsunamiInfoCopyWithImpl<$Res>
    implements $TsunamiInfoCopyWith<$Res> {
  _$TsunamiInfoCopyWithImpl(this._self, this._then);

  final TsunamiInfo _self;
  final $Res Function(TsunamiInfo) _then;

/// Create a copy of TsunamiInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? areas = null,Object? observations = freezed,Object? text = freezed,Object? comments = freezed,}) {
  return _then(_self.copyWith(
areas: null == areas ? _self.areas : areas // ignore: cast_nullable_to_non_nullable
as List<TsunamiArea>,observations: freezed == observations ? _self.observations : observations // ignore: cast_nullable_to_non_nullable
as List<TsunamiObservation>?,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,comments: freezed == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as TsunamiComments?,
  ));
}
/// Create a copy of TsunamiInfo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiCommentsCopyWith<$Res>? get comments {
    if (_self.comments == null) {
    return null;
  }

  return $TsunamiCommentsCopyWith<$Res>(_self.comments!, (value) {
    return _then(_self.copyWith(comments: value));
  });
}
}


/// @nodoc


class _TsunamiInfo implements TsunamiInfo {
  const _TsunamiInfo({required final  List<TsunamiArea> areas, final  List<TsunamiObservation>? observations, this.text, this.comments}): _areas = areas,_observations = observations;
  

/// 地域別津波情報
 final  List<TsunamiArea> _areas;
/// 地域別津波情報
@override List<TsunamiArea> get areas {
  if (_areas is EqualUnmodifiableListView) return _areas;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_areas);
}

/// 津波観測データ（VTSE51から）
 final  List<TsunamiObservation>? _observations;
/// 津波観測データ（VTSE51から）
@override List<TsunamiObservation>? get observations {
  final value = _observations;
  if (value == null) return null;
  if (_observations is EqualUnmodifiableListView) return _observations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// テキスト情報
@override final  String? text;
/// コメント
@override final  TsunamiComments? comments;

/// Create a copy of TsunamiInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiInfoCopyWith<_TsunamiInfo> get copyWith => __$TsunamiInfoCopyWithImpl<_TsunamiInfo>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiInfo&&const DeepCollectionEquality().equals(other._areas, _areas)&&const DeepCollectionEquality().equals(other._observations, _observations)&&(identical(other.text, text) || other.text == text)&&(identical(other.comments, comments) || other.comments == comments));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_areas),const DeepCollectionEquality().hash(_observations),text,comments);

@override
String toString() {
  return 'TsunamiInfo(areas: $areas, observations: $observations, text: $text, comments: $comments)';
}


}

/// @nodoc
abstract mixin class _$TsunamiInfoCopyWith<$Res> implements $TsunamiInfoCopyWith<$Res> {
  factory _$TsunamiInfoCopyWith(_TsunamiInfo value, $Res Function(_TsunamiInfo) _then) = __$TsunamiInfoCopyWithImpl;
@override @useResult
$Res call({
 List<TsunamiArea> areas, List<TsunamiObservation>? observations, String? text, TsunamiComments? comments
});


@override $TsunamiCommentsCopyWith<$Res>? get comments;

}
/// @nodoc
class __$TsunamiInfoCopyWithImpl<$Res>
    implements _$TsunamiInfoCopyWith<$Res> {
  __$TsunamiInfoCopyWithImpl(this._self, this._then);

  final _TsunamiInfo _self;
  final $Res Function(_TsunamiInfo) _then;

/// Create a copy of TsunamiInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? areas = null,Object? observations = freezed,Object? text = freezed,Object? comments = freezed,}) {
  return _then(_TsunamiInfo(
areas: null == areas ? _self._areas : areas // ignore: cast_nullable_to_non_nullable
as List<TsunamiArea>,observations: freezed == observations ? _self._observations : observations // ignore: cast_nullable_to_non_nullable
as List<TsunamiObservation>?,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,comments: freezed == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as TsunamiComments?,
  ));
}

/// Create a copy of TsunamiInfo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiCommentsCopyWith<$Res>? get comments {
    if (_self.comments == null) {
    return null;
  }

  return $TsunamiCommentsCopyWith<$Res>(_self.comments!, (value) {
    return _then(_self.copyWith(comments: value));
  });
}
}

/// @nodoc
mixin _$TsunamiArea {

 String get code; String get name; TsunamiWarning? get warning; TsunamiWarning? get lastWarning; TsunamiHeight? get firstHeight; TsunamiHeight? get maxHeight; List<TsunamiAreaStation>? get stations;
/// Create a copy of TsunamiArea
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiAreaCopyWith<TsunamiArea> get copyWith => _$TsunamiAreaCopyWithImpl<TsunamiArea>(this as TsunamiArea, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiArea&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.warning, warning) || other.warning == warning)&&(identical(other.lastWarning, lastWarning) || other.lastWarning == lastWarning)&&(identical(other.firstHeight, firstHeight) || other.firstHeight == firstHeight)&&(identical(other.maxHeight, maxHeight) || other.maxHeight == maxHeight)&&const DeepCollectionEquality().equals(other.stations, stations));
}


@override
int get hashCode => Object.hash(runtimeType,code,name,warning,lastWarning,firstHeight,maxHeight,const DeepCollectionEquality().hash(stations));

@override
String toString() {
  return 'TsunamiArea(code: $code, name: $name, warning: $warning, lastWarning: $lastWarning, firstHeight: $firstHeight, maxHeight: $maxHeight, stations: $stations)';
}


}

/// @nodoc
abstract mixin class $TsunamiAreaCopyWith<$Res>  {
  factory $TsunamiAreaCopyWith(TsunamiArea value, $Res Function(TsunamiArea) _then) = _$TsunamiAreaCopyWithImpl;
@useResult
$Res call({
 String code, String name, TsunamiWarning? warning, TsunamiWarning? lastWarning, TsunamiHeight? firstHeight, TsunamiHeight? maxHeight, List<TsunamiAreaStation>? stations
});


$TsunamiHeightCopyWith<$Res>? get firstHeight;$TsunamiHeightCopyWith<$Res>? get maxHeight;

}
/// @nodoc
class _$TsunamiAreaCopyWithImpl<$Res>
    implements $TsunamiAreaCopyWith<$Res> {
  _$TsunamiAreaCopyWithImpl(this._self, this._then);

  final TsunamiArea _self;
  final $Res Function(TsunamiArea) _then;

/// Create a copy of TsunamiArea
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? warning = freezed,Object? lastWarning = freezed,Object? firstHeight = freezed,Object? maxHeight = freezed,Object? stations = freezed,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,warning: freezed == warning ? _self.warning : warning // ignore: cast_nullable_to_non_nullable
as TsunamiWarning?,lastWarning: freezed == lastWarning ? _self.lastWarning : lastWarning // ignore: cast_nullable_to_non_nullable
as TsunamiWarning?,firstHeight: freezed == firstHeight ? _self.firstHeight : firstHeight // ignore: cast_nullable_to_non_nullable
as TsunamiHeight?,maxHeight: freezed == maxHeight ? _self.maxHeight : maxHeight // ignore: cast_nullable_to_non_nullable
as TsunamiHeight?,stations: freezed == stations ? _self.stations : stations // ignore: cast_nullable_to_non_nullable
as List<TsunamiAreaStation>?,
  ));
}
/// Create a copy of TsunamiArea
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiHeightCopyWith<$Res>? get firstHeight {
    if (_self.firstHeight == null) {
    return null;
  }

  return $TsunamiHeightCopyWith<$Res>(_self.firstHeight!, (value) {
    return _then(_self.copyWith(firstHeight: value));
  });
}/// Create a copy of TsunamiArea
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiHeightCopyWith<$Res>? get maxHeight {
    if (_self.maxHeight == null) {
    return null;
  }

  return $TsunamiHeightCopyWith<$Res>(_self.maxHeight!, (value) {
    return _then(_self.copyWith(maxHeight: value));
  });
}
}


/// @nodoc


class _TsunamiArea implements TsunamiArea {
  const _TsunamiArea({required this.code, required this.name, this.warning, this.lastWarning, this.firstHeight, this.maxHeight, final  List<TsunamiAreaStation>? stations}): _stations = stations;
  

@override final  String code;
@override final  String name;
@override final  TsunamiWarning? warning;
@override final  TsunamiWarning? lastWarning;
@override final  TsunamiHeight? firstHeight;
@override final  TsunamiHeight? maxHeight;
 final  List<TsunamiAreaStation>? _stations;
@override List<TsunamiAreaStation>? get stations {
  final value = _stations;
  if (value == null) return null;
  if (_stations is EqualUnmodifiableListView) return _stations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of TsunamiArea
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiAreaCopyWith<_TsunamiArea> get copyWith => __$TsunamiAreaCopyWithImpl<_TsunamiArea>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiArea&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.warning, warning) || other.warning == warning)&&(identical(other.lastWarning, lastWarning) || other.lastWarning == lastWarning)&&(identical(other.firstHeight, firstHeight) || other.firstHeight == firstHeight)&&(identical(other.maxHeight, maxHeight) || other.maxHeight == maxHeight)&&const DeepCollectionEquality().equals(other._stations, _stations));
}


@override
int get hashCode => Object.hash(runtimeType,code,name,warning,lastWarning,firstHeight,maxHeight,const DeepCollectionEquality().hash(_stations));

@override
String toString() {
  return 'TsunamiArea(code: $code, name: $name, warning: $warning, lastWarning: $lastWarning, firstHeight: $firstHeight, maxHeight: $maxHeight, stations: $stations)';
}


}

/// @nodoc
abstract mixin class _$TsunamiAreaCopyWith<$Res> implements $TsunamiAreaCopyWith<$Res> {
  factory _$TsunamiAreaCopyWith(_TsunamiArea value, $Res Function(_TsunamiArea) _then) = __$TsunamiAreaCopyWithImpl;
@override @useResult
$Res call({
 String code, String name, TsunamiWarning? warning, TsunamiWarning? lastWarning, TsunamiHeight? firstHeight, TsunamiHeight? maxHeight, List<TsunamiAreaStation>? stations
});


@override $TsunamiHeightCopyWith<$Res>? get firstHeight;@override $TsunamiHeightCopyWith<$Res>? get maxHeight;

}
/// @nodoc
class __$TsunamiAreaCopyWithImpl<$Res>
    implements _$TsunamiAreaCopyWith<$Res> {
  __$TsunamiAreaCopyWithImpl(this._self, this._then);

  final _TsunamiArea _self;
  final $Res Function(_TsunamiArea) _then;

/// Create a copy of TsunamiArea
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? warning = freezed,Object? lastWarning = freezed,Object? firstHeight = freezed,Object? maxHeight = freezed,Object? stations = freezed,}) {
  return _then(_TsunamiArea(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,warning: freezed == warning ? _self.warning : warning // ignore: cast_nullable_to_non_nullable
as TsunamiWarning?,lastWarning: freezed == lastWarning ? _self.lastWarning : lastWarning // ignore: cast_nullable_to_non_nullable
as TsunamiWarning?,firstHeight: freezed == firstHeight ? _self.firstHeight : firstHeight // ignore: cast_nullable_to_non_nullable
as TsunamiHeight?,maxHeight: freezed == maxHeight ? _self.maxHeight : maxHeight // ignore: cast_nullable_to_non_nullable
as TsunamiHeight?,stations: freezed == stations ? _self._stations : stations // ignore: cast_nullable_to_non_nullable
as List<TsunamiAreaStation>?,
  ));
}

/// Create a copy of TsunamiArea
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiHeightCopyWith<$Res>? get firstHeight {
    if (_self.firstHeight == null) {
    return null;
  }

  return $TsunamiHeightCopyWith<$Res>(_self.firstHeight!, (value) {
    return _then(_self.copyWith(firstHeight: value));
  });
}/// Create a copy of TsunamiArea
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiHeightCopyWith<$Res>? get maxHeight {
    if (_self.maxHeight == null) {
    return null;
  }

  return $TsunamiHeightCopyWith<$Res>(_self.maxHeight!, (value) {
    return _then(_self.copyWith(maxHeight: value));
  });
}
}

/// @nodoc
mixin _$TsunamiAreaStation {

 String get code; String get name; DateTime? get highTideTime; DateTime? get firstHeightTime; String? get condition;
/// Create a copy of TsunamiAreaStation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiAreaStationCopyWith<TsunamiAreaStation> get copyWith => _$TsunamiAreaStationCopyWithImpl<TsunamiAreaStation>(this as TsunamiAreaStation, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiAreaStation&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.highTideTime, highTideTime) || other.highTideTime == highTideTime)&&(identical(other.firstHeightTime, firstHeightTime) || other.firstHeightTime == firstHeightTime)&&(identical(other.condition, condition) || other.condition == condition));
}


@override
int get hashCode => Object.hash(runtimeType,code,name,highTideTime,firstHeightTime,condition);

@override
String toString() {
  return 'TsunamiAreaStation(code: $code, name: $name, highTideTime: $highTideTime, firstHeightTime: $firstHeightTime, condition: $condition)';
}


}

/// @nodoc
abstract mixin class $TsunamiAreaStationCopyWith<$Res>  {
  factory $TsunamiAreaStationCopyWith(TsunamiAreaStation value, $Res Function(TsunamiAreaStation) _then) = _$TsunamiAreaStationCopyWithImpl;
@useResult
$Res call({
 String code, String name, DateTime? highTideTime, DateTime? firstHeightTime, String? condition
});




}
/// @nodoc
class _$TsunamiAreaStationCopyWithImpl<$Res>
    implements $TsunamiAreaStationCopyWith<$Res> {
  _$TsunamiAreaStationCopyWithImpl(this._self, this._then);

  final TsunamiAreaStation _self;
  final $Res Function(TsunamiAreaStation) _then;

/// Create a copy of TsunamiAreaStation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? highTideTime = freezed,Object? firstHeightTime = freezed,Object? condition = freezed,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,highTideTime: freezed == highTideTime ? _self.highTideTime : highTideTime // ignore: cast_nullable_to_non_nullable
as DateTime?,firstHeightTime: freezed == firstHeightTime ? _self.firstHeightTime : firstHeightTime // ignore: cast_nullable_to_non_nullable
as DateTime?,condition: freezed == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc


class _TsunamiAreaStation implements TsunamiAreaStation {
  const _TsunamiAreaStation({required this.code, required this.name, this.highTideTime, this.firstHeightTime, this.condition});
  

@override final  String code;
@override final  String name;
@override final  DateTime? highTideTime;
@override final  DateTime? firstHeightTime;
@override final  String? condition;

/// Create a copy of TsunamiAreaStation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiAreaStationCopyWith<_TsunamiAreaStation> get copyWith => __$TsunamiAreaStationCopyWithImpl<_TsunamiAreaStation>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiAreaStation&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.highTideTime, highTideTime) || other.highTideTime == highTideTime)&&(identical(other.firstHeightTime, firstHeightTime) || other.firstHeightTime == firstHeightTime)&&(identical(other.condition, condition) || other.condition == condition));
}


@override
int get hashCode => Object.hash(runtimeType,code,name,highTideTime,firstHeightTime,condition);

@override
String toString() {
  return 'TsunamiAreaStation(code: $code, name: $name, highTideTime: $highTideTime, firstHeightTime: $firstHeightTime, condition: $condition)';
}


}

/// @nodoc
abstract mixin class _$TsunamiAreaStationCopyWith<$Res> implements $TsunamiAreaStationCopyWith<$Res> {
  factory _$TsunamiAreaStationCopyWith(_TsunamiAreaStation value, $Res Function(_TsunamiAreaStation) _then) = __$TsunamiAreaStationCopyWithImpl;
@override @useResult
$Res call({
 String code, String name, DateTime? highTideTime, DateTime? firstHeightTime, String? condition
});




}
/// @nodoc
class __$TsunamiAreaStationCopyWithImpl<$Res>
    implements _$TsunamiAreaStationCopyWith<$Res> {
  __$TsunamiAreaStationCopyWithImpl(this._self, this._then);

  final _TsunamiAreaStation _self;
  final $Res Function(_TsunamiAreaStation) _then;

/// Create a copy of TsunamiAreaStation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? highTideTime = freezed,Object? firstHeightTime = freezed,Object? condition = freezed,}) {
  return _then(_TsunamiAreaStation(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,highTideTime: freezed == highTideTime ? _self.highTideTime : highTideTime // ignore: cast_nullable_to_non_nullable
as DateTime?,firstHeightTime: freezed == firstHeightTime ? _self.firstHeightTime : firstHeightTime // ignore: cast_nullable_to_non_nullable
as DateTime?,condition: freezed == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
