// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'site_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SiteList {

/// 観測点一覧
 List<Site>? get items;/// セキュリティ情報
 Security? get security;/// 時間
 String? get dataTime;/// リザルト
 Result? get result;/// シリアル番号
 String? get serialNo;
/// Create a copy of SiteList
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SiteListCopyWith<SiteList> get copyWith => _$SiteListCopyWithImpl<SiteList>(this as SiteList, _$identity);

  /// Serializes this SiteList to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SiteList&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.security, security) || other.security == security)&&(identical(other.dataTime, dataTime) || other.dataTime == dataTime)&&(identical(other.result, result) || other.result == result)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),security,dataTime,result,serialNo);

@override
String toString() {
  return 'SiteList(items: $items, security: $security, dataTime: $dataTime, result: $result, serialNo: $serialNo)';
}


}

/// @nodoc
abstract mixin class $SiteListCopyWith<$Res>  {
  factory $SiteListCopyWith(SiteList value, $Res Function(SiteList) _then) = _$SiteListCopyWithImpl;
@useResult
$Res call({
 List<Site>? items, Security? security, String? dataTime, Result? result, String? serialNo
});


$SecurityCopyWith<$Res>? get security;$ResultCopyWith<$Res>? get result;

}
/// @nodoc
class _$SiteListCopyWithImpl<$Res>
    implements $SiteListCopyWith<$Res> {
  _$SiteListCopyWithImpl(this._self, this._then);

  final SiteList _self;
  final $Res Function(SiteList) _then;

/// Create a copy of SiteList
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = freezed,Object? security = freezed,Object? dataTime = freezed,Object? result = freezed,Object? serialNo = freezed,}) {
  return _then(_self.copyWith(
items: freezed == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<Site>?,security: freezed == security ? _self.security : security // ignore: cast_nullable_to_non_nullable
as Security?,dataTime: freezed == dataTime ? _self.dataTime : dataTime // ignore: cast_nullable_to_non_nullable
as String?,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as Result?,serialNo: freezed == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of SiteList
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SecurityCopyWith<$Res>? get security {
    if (_self.security == null) {
    return null;
  }

  return $SecurityCopyWith<$Res>(_self.security!, (value) {
    return _then(_self.copyWith(security: value));
  });
}/// Create a copy of SiteList
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResultCopyWith<$Res>? get result {
    if (_self.result == null) {
    return null;
  }

  return $ResultCopyWith<$Res>(_self.result!, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _SiteList implements SiteList {
  const _SiteList({final  List<Site>? items, this.security, this.dataTime, this.result, this.serialNo}): _items = items;
  factory _SiteList.fromJson(Map<String, dynamic> json) => _$SiteListFromJson(json);

/// 観測点一覧
 final  List<Site>? _items;
/// 観測点一覧
@override List<Site>? get items {
  final value = _items;
  if (value == null) return null;
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// セキュリティ情報
@override final  Security? security;
/// 時間
@override final  String? dataTime;
/// リザルト
@override final  Result? result;
/// シリアル番号
@override final  String? serialNo;

/// Create a copy of SiteList
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SiteListCopyWith<_SiteList> get copyWith => __$SiteListCopyWithImpl<_SiteList>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SiteListToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SiteList&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.security, security) || other.security == security)&&(identical(other.dataTime, dataTime) || other.dataTime == dataTime)&&(identical(other.result, result) || other.result == result)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),security,dataTime,result,serialNo);

@override
String toString() {
  return 'SiteList(items: $items, security: $security, dataTime: $dataTime, result: $result, serialNo: $serialNo)';
}


}

/// @nodoc
abstract mixin class _$SiteListCopyWith<$Res> implements $SiteListCopyWith<$Res> {
  factory _$SiteListCopyWith(_SiteList value, $Res Function(_SiteList) _then) = __$SiteListCopyWithImpl;
@override @useResult
$Res call({
 List<Site>? items, Security? security, String? dataTime, Result? result, String? serialNo
});


@override $SecurityCopyWith<$Res>? get security;@override $ResultCopyWith<$Res>? get result;

}
/// @nodoc
class __$SiteListCopyWithImpl<$Res>
    implements _$SiteListCopyWith<$Res> {
  __$SiteListCopyWithImpl(this._self, this._then);

  final _SiteList _self;
  final $Res Function(_SiteList) _then;

/// Create a copy of SiteList
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = freezed,Object? security = freezed,Object? dataTime = freezed,Object? result = freezed,Object? serialNo = freezed,}) {
  return _then(_SiteList(
items: freezed == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<Site>?,security: freezed == security ? _self.security : security // ignore: cast_nullable_to_non_nullable
as Security?,dataTime: freezed == dataTime ? _self.dataTime : dataTime // ignore: cast_nullable_to_non_nullable
as String?,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as Result?,serialNo: freezed == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of SiteList
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SecurityCopyWith<$Res>? get security {
    if (_self.security == null) {
    return null;
  }

  return $SecurityCopyWith<$Res>(_self.security!, (value) {
    return _then(_self.copyWith(security: value));
  });
}/// Create a copy of SiteList
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResultCopyWith<$Res>? get result {
    if (_self.result == null) {
    return null;
  }

  return $ResultCopyWith<$Res>(_self.result!, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}


/// @nodoc
mixin _$Site {

/// 不明(内部ID?)
 int? get muni;/// RealtimeDataでのインデックス
 int? get siteidx;/// 都道府県ID
@JsonKey(name: 'pref') int? get prefectureId;/// ID
@JsonKey(name: 'siteid') String? get siteId;/// 緯度
 double? get lat;/// 経度
 double? get lng;
/// Create a copy of Site
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SiteCopyWith<Site> get copyWith => _$SiteCopyWithImpl<Site>(this as Site, _$identity);

  /// Serializes this Site to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Site&&(identical(other.muni, muni) || other.muni == muni)&&(identical(other.siteidx, siteidx) || other.siteidx == siteidx)&&(identical(other.prefectureId, prefectureId) || other.prefectureId == prefectureId)&&(identical(other.siteId, siteId) || other.siteId == siteId)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,muni,siteidx,prefectureId,siteId,lat,lng);

@override
String toString() {
  return 'Site(muni: $muni, siteidx: $siteidx, prefectureId: $prefectureId, siteId: $siteId, lat: $lat, lng: $lng)';
}


}

/// @nodoc
abstract mixin class $SiteCopyWith<$Res>  {
  factory $SiteCopyWith(Site value, $Res Function(Site) _then) = _$SiteCopyWithImpl;
@useResult
$Res call({
 int? muni, int? siteidx,@JsonKey(name: 'pref') int? prefectureId,@JsonKey(name: 'siteid') String? siteId, double? lat, double? lng
});




}
/// @nodoc
class _$SiteCopyWithImpl<$Res>
    implements $SiteCopyWith<$Res> {
  _$SiteCopyWithImpl(this._self, this._then);

  final Site _self;
  final $Res Function(Site) _then;

/// Create a copy of Site
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? muni = freezed,Object? siteidx = freezed,Object? prefectureId = freezed,Object? siteId = freezed,Object? lat = freezed,Object? lng = freezed,}) {
  return _then(_self.copyWith(
muni: freezed == muni ? _self.muni : muni // ignore: cast_nullable_to_non_nullable
as int?,siteidx: freezed == siteidx ? _self.siteidx : siteidx // ignore: cast_nullable_to_non_nullable
as int?,prefectureId: freezed == prefectureId ? _self.prefectureId : prefectureId // ignore: cast_nullable_to_non_nullable
as int?,siteId: freezed == siteId ? _self.siteId : siteId // ignore: cast_nullable_to_non_nullable
as String?,lat: freezed == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double?,lng: freezed == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Site extends Site {
  const _Site({this.muni, this.siteidx, @JsonKey(name: 'pref') this.prefectureId, @JsonKey(name: 'siteid') this.siteId, this.lat, this.lng}): super._();
  factory _Site.fromJson(Map<String, dynamic> json) => _$SiteFromJson(json);

/// 不明(内部ID?)
@override final  int? muni;
/// RealtimeDataでのインデックス
@override final  int? siteidx;
/// 都道府県ID
@override@JsonKey(name: 'pref') final  int? prefectureId;
/// ID
@override@JsonKey(name: 'siteid') final  String? siteId;
/// 緯度
@override final  double? lat;
/// 経度
@override final  double? lng;

/// Create a copy of Site
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SiteCopyWith<_Site> get copyWith => __$SiteCopyWithImpl<_Site>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SiteToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Site&&(identical(other.muni, muni) || other.muni == muni)&&(identical(other.siteidx, siteidx) || other.siteidx == siteidx)&&(identical(other.prefectureId, prefectureId) || other.prefectureId == prefectureId)&&(identical(other.siteId, siteId) || other.siteId == siteId)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,muni,siteidx,prefectureId,siteId,lat,lng);

@override
String toString() {
  return 'Site(muni: $muni, siteidx: $siteidx, prefectureId: $prefectureId, siteId: $siteId, lat: $lat, lng: $lng)';
}


}

/// @nodoc
abstract mixin class _$SiteCopyWith<$Res> implements $SiteCopyWith<$Res> {
  factory _$SiteCopyWith(_Site value, $Res Function(_Site) _then) = __$SiteCopyWithImpl;
@override @useResult
$Res call({
 int? muni, int? siteidx,@JsonKey(name: 'pref') int? prefectureId,@JsonKey(name: 'siteid') String? siteId, double? lat, double? lng
});




}
/// @nodoc
class __$SiteCopyWithImpl<$Res>
    implements _$SiteCopyWith<$Res> {
  __$SiteCopyWithImpl(this._self, this._then);

  final _Site _self;
  final $Res Function(_Site) _then;

/// Create a copy of Site
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? muni = freezed,Object? siteidx = freezed,Object? prefectureId = freezed,Object? siteId = freezed,Object? lat = freezed,Object? lng = freezed,}) {
  return _then(_Site(
muni: freezed == muni ? _self.muni : muni // ignore: cast_nullable_to_non_nullable
as int?,siteidx: freezed == siteidx ? _self.siteidx : siteidx // ignore: cast_nullable_to_non_nullable
as int?,prefectureId: freezed == prefectureId ? _self.prefectureId : prefectureId // ignore: cast_nullable_to_non_nullable
as int?,siteId: freezed == siteId ? _self.siteId : siteId // ignore: cast_nullable_to_non_nullable
as String?,lat: freezed == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double?,lng: freezed == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
