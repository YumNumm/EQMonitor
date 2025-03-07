// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'site_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SiteList _$SiteListFromJson(Map<String, dynamic> json) {
  return _SiteList.fromJson(json);
}

/// @nodoc
mixin _$SiteList {
  /// 観測点一覧
  @JsonKey(name: 'items')
  List<Site>? get sites => throw _privateConstructorUsedError;

  /// セキュリティ情報
  Security? get security => throw _privateConstructorUsedError;

  /// 時間
  String? get dataTime => throw _privateConstructorUsedError;

  /// リザルト
  Result? get result => throw _privateConstructorUsedError;

  /// シリアル番号
  String? get serialNo => throw _privateConstructorUsedError;

  /// Serializes this SiteList to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SiteList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SiteListCopyWith<SiteList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SiteListCopyWith<$Res> {
  factory $SiteListCopyWith(SiteList value, $Res Function(SiteList) then) =
      _$SiteListCopyWithImpl<$Res, SiteList>;
  @useResult
  $Res call({
    @JsonKey(name: 'items') List<Site>? sites,
    Security? security,
    String? dataTime,
    Result? result,
    String? serialNo,
  });

  $SecurityCopyWith<$Res>? get security;
  $ResultCopyWith<$Res>? get result;
}

/// @nodoc
class _$SiteListCopyWithImpl<$Res, $Val extends SiteList>
    implements $SiteListCopyWith<$Res> {
  _$SiteListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SiteList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sites = freezed,
    Object? security = freezed,
    Object? dataTime = freezed,
    Object? result = freezed,
    Object? serialNo = freezed,
  }) {
    return _then(
      _value.copyWith(
            sites:
                freezed == sites
                    ? _value.sites
                    : sites // ignore: cast_nullable_to_non_nullable
                        as List<Site>?,
            security:
                freezed == security
                    ? _value.security
                    : security // ignore: cast_nullable_to_non_nullable
                        as Security?,
            dataTime:
                freezed == dataTime
                    ? _value.dataTime
                    : dataTime // ignore: cast_nullable_to_non_nullable
                        as String?,
            result:
                freezed == result
                    ? _value.result
                    : result // ignore: cast_nullable_to_non_nullable
                        as Result?,
            serialNo:
                freezed == serialNo
                    ? _value.serialNo
                    : serialNo // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of SiteList
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SecurityCopyWith<$Res>? get security {
    if (_value.security == null) {
      return null;
    }

    return $SecurityCopyWith<$Res>(_value.security!, (value) {
      return _then(_value.copyWith(security: value) as $Val);
    });
  }

  /// Create a copy of SiteList
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ResultCopyWith<$Res>? get result {
    if (_value.result == null) {
      return null;
    }

    return $ResultCopyWith<$Res>(_value.result!, (value) {
      return _then(_value.copyWith(result: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SiteListImplCopyWith<$Res>
    implements $SiteListCopyWith<$Res> {
  factory _$$SiteListImplCopyWith(
    _$SiteListImpl value,
    $Res Function(_$SiteListImpl) then,
  ) = __$$SiteListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'items') List<Site>? sites,
    Security? security,
    String? dataTime,
    Result? result,
    String? serialNo,
  });

  @override
  $SecurityCopyWith<$Res>? get security;
  @override
  $ResultCopyWith<$Res>? get result;
}

/// @nodoc
class __$$SiteListImplCopyWithImpl<$Res>
    extends _$SiteListCopyWithImpl<$Res, _$SiteListImpl>
    implements _$$SiteListImplCopyWith<$Res> {
  __$$SiteListImplCopyWithImpl(
    _$SiteListImpl _value,
    $Res Function(_$SiteListImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SiteList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sites = freezed,
    Object? security = freezed,
    Object? dataTime = freezed,
    Object? result = freezed,
    Object? serialNo = freezed,
  }) {
    return _then(
      _$SiteListImpl(
        sites:
            freezed == sites
                ? _value._sites
                : sites // ignore: cast_nullable_to_non_nullable
                    as List<Site>?,
        security:
            freezed == security
                ? _value.security
                : security // ignore: cast_nullable_to_non_nullable
                    as Security?,
        dataTime:
            freezed == dataTime
                ? _value.dataTime
                : dataTime // ignore: cast_nullable_to_non_nullable
                    as String?,
        result:
            freezed == result
                ? _value.result
                : result // ignore: cast_nullable_to_non_nullable
                    as Result?,
        serialNo:
            freezed == serialNo
                ? _value.serialNo
                : serialNo // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SiteListImpl implements _SiteList {
  const _$SiteListImpl({
    @JsonKey(name: 'items') final List<Site>? sites,
    this.security,
    this.dataTime,
    this.result,
    this.serialNo,
  }) : _sites = sites;

  factory _$SiteListImpl.fromJson(Map<String, dynamic> json) =>
      _$$SiteListImplFromJson(json);

  /// 観測点一覧
  final List<Site>? _sites;

  /// 観測点一覧
  @override
  @JsonKey(name: 'items')
  List<Site>? get sites {
    final value = _sites;
    if (value == null) return null;
    if (_sites is EqualUnmodifiableListView) return _sites;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// セキュリティ情報
  @override
  final Security? security;

  /// 時間
  @override
  final String? dataTime;

  /// リザルト
  @override
  final Result? result;

  /// シリアル番号
  @override
  final String? serialNo;

  @override
  String toString() {
    return 'SiteList(sites: $sites, security: $security, dataTime: $dataTime, result: $result, serialNo: $serialNo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SiteListImpl &&
            const DeepCollectionEquality().equals(other._sites, _sites) &&
            (identical(other.security, security) ||
                other.security == security) &&
            (identical(other.dataTime, dataTime) ||
                other.dataTime == dataTime) &&
            (identical(other.result, result) || other.result == result) &&
            (identical(other.serialNo, serialNo) ||
                other.serialNo == serialNo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_sites),
    security,
    dataTime,
    result,
    serialNo,
  );

  /// Create a copy of SiteList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SiteListImplCopyWith<_$SiteListImpl> get copyWith =>
      __$$SiteListImplCopyWithImpl<_$SiteListImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SiteListImplToJson(this);
  }
}

abstract class _SiteList implements SiteList {
  const factory _SiteList({
    @JsonKey(name: 'items') final List<Site>? sites,
    final Security? security,
    final String? dataTime,
    final Result? result,
    final String? serialNo,
  }) = _$SiteListImpl;

  factory _SiteList.fromJson(Map<String, dynamic> json) =
      _$SiteListImpl.fromJson;

  /// 観測点一覧
  @override
  @JsonKey(name: 'items')
  List<Site>? get sites;

  /// セキュリティ情報
  @override
  Security? get security;

  /// 時間
  @override
  String? get dataTime;

  /// リザルト
  @override
  Result? get result;

  /// シリアル番号
  @override
  String? get serialNo;

  /// Create a copy of SiteList
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SiteListImplCopyWith<_$SiteListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Site _$SiteFromJson(Map<String, dynamic> json) {
  return _Site.fromJson(json);
}

/// @nodoc
mixin _$Site {
  /// 不明(内部ID?)
  int? get muni => throw _privateConstructorUsedError;

  /// RealtimeDataでのインデックス
  int? get siteidx => throw _privateConstructorUsedError;

  /// 都道府県ID
  @JsonKey(name: 'pref')
  int? get prefectureId => throw _privateConstructorUsedError;

  /// ID
  @JsonKey(name: 'siteid')
  String? get siteId => throw _privateConstructorUsedError;

  /// 緯度
  double? get lat => throw _privateConstructorUsedError;

  /// 経度
  double? get lng => throw _privateConstructorUsedError;

  /// Serializes this Site to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Site
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SiteCopyWith<Site> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SiteCopyWith<$Res> {
  factory $SiteCopyWith(Site value, $Res Function(Site) then) =
      _$SiteCopyWithImpl<$Res, Site>;
  @useResult
  $Res call({
    int? muni,
    int? siteidx,
    @JsonKey(name: 'pref') int? prefectureId,
    @JsonKey(name: 'siteid') String? siteId,
    double? lat,
    double? lng,
  });
}

/// @nodoc
class _$SiteCopyWithImpl<$Res, $Val extends Site>
    implements $SiteCopyWith<$Res> {
  _$SiteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Site
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? muni = freezed,
    Object? siteidx = freezed,
    Object? prefectureId = freezed,
    Object? siteId = freezed,
    Object? lat = freezed,
    Object? lng = freezed,
  }) {
    return _then(
      _value.copyWith(
            muni:
                freezed == muni
                    ? _value.muni
                    : muni // ignore: cast_nullable_to_non_nullable
                        as int?,
            siteidx:
                freezed == siteidx
                    ? _value.siteidx
                    : siteidx // ignore: cast_nullable_to_non_nullable
                        as int?,
            prefectureId:
                freezed == prefectureId
                    ? _value.prefectureId
                    : prefectureId // ignore: cast_nullable_to_non_nullable
                        as int?,
            siteId:
                freezed == siteId
                    ? _value.siteId
                    : siteId // ignore: cast_nullable_to_non_nullable
                        as String?,
            lat:
                freezed == lat
                    ? _value.lat
                    : lat // ignore: cast_nullable_to_non_nullable
                        as double?,
            lng:
                freezed == lng
                    ? _value.lng
                    : lng // ignore: cast_nullable_to_non_nullable
                        as double?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SiteImplCopyWith<$Res> implements $SiteCopyWith<$Res> {
  factory _$$SiteImplCopyWith(
    _$SiteImpl value,
    $Res Function(_$SiteImpl) then,
  ) = __$$SiteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int? muni,
    int? siteidx,
    @JsonKey(name: 'pref') int? prefectureId,
    @JsonKey(name: 'siteid') String? siteId,
    double? lat,
    double? lng,
  });
}

/// @nodoc
class __$$SiteImplCopyWithImpl<$Res>
    extends _$SiteCopyWithImpl<$Res, _$SiteImpl>
    implements _$$SiteImplCopyWith<$Res> {
  __$$SiteImplCopyWithImpl(_$SiteImpl _value, $Res Function(_$SiteImpl) _then)
    : super(_value, _then);

  /// Create a copy of Site
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? muni = freezed,
    Object? siteidx = freezed,
    Object? prefectureId = freezed,
    Object? siteId = freezed,
    Object? lat = freezed,
    Object? lng = freezed,
  }) {
    return _then(
      _$SiteImpl(
        muni:
            freezed == muni
                ? _value.muni
                : muni // ignore: cast_nullable_to_non_nullable
                    as int?,
        siteidx:
            freezed == siteidx
                ? _value.siteidx
                : siteidx // ignore: cast_nullable_to_non_nullable
                    as int?,
        prefectureId:
            freezed == prefectureId
                ? _value.prefectureId
                : prefectureId // ignore: cast_nullable_to_non_nullable
                    as int?,
        siteId:
            freezed == siteId
                ? _value.siteId
                : siteId // ignore: cast_nullable_to_non_nullable
                    as String?,
        lat:
            freezed == lat
                ? _value.lat
                : lat // ignore: cast_nullable_to_non_nullable
                    as double?,
        lng:
            freezed == lng
                ? _value.lng
                : lng // ignore: cast_nullable_to_non_nullable
                    as double?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SiteImpl extends _Site {
  const _$SiteImpl({
    this.muni,
    this.siteidx,
    @JsonKey(name: 'pref') this.prefectureId,
    @JsonKey(name: 'siteid') this.siteId,
    this.lat,
    this.lng,
  }) : super._();

  factory _$SiteImpl.fromJson(Map<String, dynamic> json) =>
      _$$SiteImplFromJson(json);

  /// 不明(内部ID?)
  @override
  final int? muni;

  /// RealtimeDataでのインデックス
  @override
  final int? siteidx;

  /// 都道府県ID
  @override
  @JsonKey(name: 'pref')
  final int? prefectureId;

  /// ID
  @override
  @JsonKey(name: 'siteid')
  final String? siteId;

  /// 緯度
  @override
  final double? lat;

  /// 経度
  @override
  final double? lng;

  @override
  String toString() {
    return 'Site(muni: $muni, siteidx: $siteidx, prefectureId: $prefectureId, siteId: $siteId, lat: $lat, lng: $lng)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SiteImpl &&
            (identical(other.muni, muni) || other.muni == muni) &&
            (identical(other.siteidx, siteidx) || other.siteidx == siteidx) &&
            (identical(other.prefectureId, prefectureId) ||
                other.prefectureId == prefectureId) &&
            (identical(other.siteId, siteId) || other.siteId == siteId) &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lng, lng) || other.lng == lng));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, muni, siteidx, prefectureId, siteId, lat, lng);

  /// Create a copy of Site
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SiteImplCopyWith<_$SiteImpl> get copyWith =>
      __$$SiteImplCopyWithImpl<_$SiteImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SiteImplToJson(this);
  }
}

abstract class _Site extends Site {
  const factory _Site({
    final int? muni,
    final int? siteidx,
    @JsonKey(name: 'pref') final int? prefectureId,
    @JsonKey(name: 'siteid') final String? siteId,
    final double? lat,
    final double? lng,
  }) = _$SiteImpl;
  const _Site._() : super._();

  factory _Site.fromJson(Map<String, dynamic> json) = _$SiteImpl.fromJson;

  /// 不明(内部ID?)
  @override
  int? get muni;

  /// RealtimeDataでのインデックス
  @override
  int? get siteidx;

  /// 都道府県ID
  @override
  @JsonKey(name: 'pref')
  int? get prefectureId;

  /// ID
  @override
  @JsonKey(name: 'siteid')
  String? get siteId;

  /// 緯度
  @override
  double? get lat;

  /// 経度
  @override
  double? get lng;

  /// Create a copy of Site
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SiteImplCopyWith<_$SiteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
