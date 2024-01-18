// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

EarthquakeParameter _$EarthquakeParameterFromJson(Map<String, dynamic> json) {
  return _EarthquakeParameter.fromJson(json);
}

/// @nodoc
mixin _$EarthquakeParameter {
  String get responseId => throw _privateConstructorUsedError;
  DateTime get responseTime => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  DateTime get changeTime => throw _privateConstructorUsedError;
  String get version => throw _privateConstructorUsedError;
  List<EarthquakeParmaeterItem> get items => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EarthquakeParameterCopyWith<EarthquakeParameter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EarthquakeParameterCopyWith<$Res> {
  factory $EarthquakeParameterCopyWith(
          EarthquakeParameter value, $Res Function(EarthquakeParameter) then) =
      _$EarthquakeParameterCopyWithImpl<$Res, EarthquakeParameter>;
  @useResult
  $Res call(
      {String responseId,
      DateTime responseTime,
      String status,
      DateTime changeTime,
      String version,
      List<EarthquakeParmaeterItem> items});
}

/// @nodoc
class _$EarthquakeParameterCopyWithImpl<$Res, $Val extends EarthquakeParameter>
    implements $EarthquakeParameterCopyWith<$Res> {
  _$EarthquakeParameterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? responseId = null,
    Object? responseTime = null,
    Object? status = null,
    Object? changeTime = null,
    Object? version = null,
    Object? items = null,
  }) {
    return _then(_value.copyWith(
      responseId: null == responseId
          ? _value.responseId
          : responseId // ignore: cast_nullable_to_non_nullable
              as String,
      responseTime: null == responseTime
          ? _value.responseTime
          : responseTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      changeTime: null == changeTime
          ? _value.changeTime
          : changeTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<EarthquakeParmaeterItem>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EarthquakeParameterImplCopyWith<$Res>
    implements $EarthquakeParameterCopyWith<$Res> {
  factory _$$EarthquakeParameterImplCopyWith(_$EarthquakeParameterImpl value,
          $Res Function(_$EarthquakeParameterImpl) then) =
      __$$EarthquakeParameterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String responseId,
      DateTime responseTime,
      String status,
      DateTime changeTime,
      String version,
      List<EarthquakeParmaeterItem> items});
}

/// @nodoc
class __$$EarthquakeParameterImplCopyWithImpl<$Res>
    extends _$EarthquakeParameterCopyWithImpl<$Res, _$EarthquakeParameterImpl>
    implements _$$EarthquakeParameterImplCopyWith<$Res> {
  __$$EarthquakeParameterImplCopyWithImpl(_$EarthquakeParameterImpl _value,
      $Res Function(_$EarthquakeParameterImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? responseId = null,
    Object? responseTime = null,
    Object? status = null,
    Object? changeTime = null,
    Object? version = null,
    Object? items = null,
  }) {
    return _then(_$EarthquakeParameterImpl(
      responseId: null == responseId
          ? _value.responseId
          : responseId // ignore: cast_nullable_to_non_nullable
              as String,
      responseTime: null == responseTime
          ? _value.responseTime
          : responseTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      changeTime: null == changeTime
          ? _value.changeTime
          : changeTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<EarthquakeParmaeterItem>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EarthquakeParameterImpl implements _EarthquakeParameter {
  const _$EarthquakeParameterImpl(
      {required this.responseId,
      required this.responseTime,
      required this.status,
      required this.changeTime,
      required this.version,
      required final List<EarthquakeParmaeterItem> items})
      : _items = items;

  factory _$EarthquakeParameterImpl.fromJson(Map<String, dynamic> json) =>
      _$$EarthquakeParameterImplFromJson(json);

  @override
  final String responseId;
  @override
  final DateTime responseTime;
  @override
  final String status;
  @override
  final DateTime changeTime;
  @override
  final String version;
  final List<EarthquakeParmaeterItem> _items;
  @override
  List<EarthquakeParmaeterItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'EarthquakeParameter(responseId: $responseId, responseTime: $responseTime, status: $status, changeTime: $changeTime, version: $version, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EarthquakeParameterImpl &&
            (identical(other.responseId, responseId) ||
                other.responseId == responseId) &&
            (identical(other.responseTime, responseTime) ||
                other.responseTime == responseTime) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.changeTime, changeTime) ||
                other.changeTime == changeTime) &&
            (identical(other.version, version) || other.version == version) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, responseId, responseTime, status,
      changeTime, version, const DeepCollectionEquality().hash(_items));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EarthquakeParameterImplCopyWith<_$EarthquakeParameterImpl> get copyWith =>
      __$$EarthquakeParameterImplCopyWithImpl<_$EarthquakeParameterImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EarthquakeParameterImplToJson(
      this,
    );
  }
}

abstract class _EarthquakeParameter implements EarthquakeParameter {
  const factory _EarthquakeParameter(
          {required final String responseId,
          required final DateTime responseTime,
          required final String status,
          required final DateTime changeTime,
          required final String version,
          required final List<EarthquakeParmaeterItem> items}) =
      _$EarthquakeParameterImpl;

  factory _EarthquakeParameter.fromJson(Map<String, dynamic> json) =
      _$EarthquakeParameterImpl.fromJson;

  @override
  String get responseId;
  @override
  DateTime get responseTime;
  @override
  String get status;
  @override
  DateTime get changeTime;
  @override
  String get version;
  @override
  List<EarthquakeParmaeterItem> get items;
  @override
  @JsonKey(ignore: true)
  _$$EarthquakeParameterImplCopyWith<_$EarthquakeParameterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EarthquakeParmaeterItem _$EarthquakeParmaeterItemFromJson(
    Map<String, dynamic> json) {
  return _EarthquakeParmaeterItem.fromJson(json);
}

/// @nodoc
mixin _$EarthquakeParmaeterItem {
  ParameterRegion get region => throw _privateConstructorUsedError;
  ParameterCity get city => throw _privateConstructorUsedError;
  String get noCode => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get kana => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get owner => throw _privateConstructorUsedError;
  @JsonKey(fromJson: doubleFromString, toJson: doubleToString)
  double get latitude => throw _privateConstructorUsedError;
  @JsonKey(fromJson: doubleFromString, toJson: doubleToString)
  double get longitude => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EarthquakeParmaeterItemCopyWith<EarthquakeParmaeterItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EarthquakeParmaeterItemCopyWith<$Res> {
  factory $EarthquakeParmaeterItemCopyWith(EarthquakeParmaeterItem value,
          $Res Function(EarthquakeParmaeterItem) then) =
      _$EarthquakeParmaeterItemCopyWithImpl<$Res, EarthquakeParmaeterItem>;
  @useResult
  $Res call(
      {ParameterRegion region,
      ParameterCity city,
      String noCode,
      String code,
      String name,
      String kana,
      String status,
      String owner,
      @JsonKey(fromJson: doubleFromString, toJson: doubleToString)
      double latitude,
      @JsonKey(fromJson: doubleFromString, toJson: doubleToString)
      double longitude});

  $ParameterRegionCopyWith<$Res> get region;
  $ParameterCityCopyWith<$Res> get city;
}

/// @nodoc
class _$EarthquakeParmaeterItemCopyWithImpl<$Res,
        $Val extends EarthquakeParmaeterItem>
    implements $EarthquakeParmaeterItemCopyWith<$Res> {
  _$EarthquakeParmaeterItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? region = null,
    Object? city = null,
    Object? noCode = null,
    Object? code = null,
    Object? name = null,
    Object? kana = null,
    Object? status = null,
    Object? owner = null,
    Object? latitude = null,
    Object? longitude = null,
  }) {
    return _then(_value.copyWith(
      region: null == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as ParameterRegion,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as ParameterCity,
      noCode: null == noCode
          ? _value.noCode
          : noCode // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      kana: null == kana
          ? _value.kana
          : kana // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      owner: null == owner
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ParameterRegionCopyWith<$Res> get region {
    return $ParameterRegionCopyWith<$Res>(_value.region, (value) {
      return _then(_value.copyWith(region: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ParameterCityCopyWith<$Res> get city {
    return $ParameterCityCopyWith<$Res>(_value.city, (value) {
      return _then(_value.copyWith(city: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EarthquakeParmaeterItemImplCopyWith<$Res>
    implements $EarthquakeParmaeterItemCopyWith<$Res> {
  factory _$$EarthquakeParmaeterItemImplCopyWith(
          _$EarthquakeParmaeterItemImpl value,
          $Res Function(_$EarthquakeParmaeterItemImpl) then) =
      __$$EarthquakeParmaeterItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ParameterRegion region,
      ParameterCity city,
      String noCode,
      String code,
      String name,
      String kana,
      String status,
      String owner,
      @JsonKey(fromJson: doubleFromString, toJson: doubleToString)
      double latitude,
      @JsonKey(fromJson: doubleFromString, toJson: doubleToString)
      double longitude});

  @override
  $ParameterRegionCopyWith<$Res> get region;
  @override
  $ParameterCityCopyWith<$Res> get city;
}

/// @nodoc
class __$$EarthquakeParmaeterItemImplCopyWithImpl<$Res>
    extends _$EarthquakeParmaeterItemCopyWithImpl<$Res,
        _$EarthquakeParmaeterItemImpl>
    implements _$$EarthquakeParmaeterItemImplCopyWith<$Res> {
  __$$EarthquakeParmaeterItemImplCopyWithImpl(
      _$EarthquakeParmaeterItemImpl _value,
      $Res Function(_$EarthquakeParmaeterItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? region = null,
    Object? city = null,
    Object? noCode = null,
    Object? code = null,
    Object? name = null,
    Object? kana = null,
    Object? status = null,
    Object? owner = null,
    Object? latitude = null,
    Object? longitude = null,
  }) {
    return _then(_$EarthquakeParmaeterItemImpl(
      region: null == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as ParameterRegion,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as ParameterCity,
      noCode: null == noCode
          ? _value.noCode
          : noCode // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      kana: null == kana
          ? _value.kana
          : kana // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      owner: null == owner
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EarthquakeParmaeterItemImpl implements _EarthquakeParmaeterItem {
  const _$EarthquakeParmaeterItemImpl(
      {required this.region,
      required this.city,
      required this.noCode,
      required this.code,
      required this.name,
      required this.kana,
      required this.status,
      required this.owner,
      @JsonKey(fromJson: doubleFromString, toJson: doubleToString)
      required this.latitude,
      @JsonKey(fromJson: doubleFromString, toJson: doubleToString)
      required this.longitude});

  factory _$EarthquakeParmaeterItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$EarthquakeParmaeterItemImplFromJson(json);

  @override
  final ParameterRegion region;
  @override
  final ParameterCity city;
  @override
  final String noCode;
  @override
  final String code;
  @override
  final String name;
  @override
  final String kana;
  @override
  final String status;
  @override
  final String owner;
  @override
  @JsonKey(fromJson: doubleFromString, toJson: doubleToString)
  final double latitude;
  @override
  @JsonKey(fromJson: doubleFromString, toJson: doubleToString)
  final double longitude;

  @override
  String toString() {
    return 'EarthquakeParmaeterItem(region: $region, city: $city, noCode: $noCode, code: $code, name: $name, kana: $kana, status: $status, owner: $owner, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EarthquakeParmaeterItemImpl &&
            (identical(other.region, region) || other.region == region) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.noCode, noCode) || other.noCode == noCode) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.kana, kana) || other.kana == kana) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.owner, owner) || other.owner == owner) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, region, city, noCode, code, name,
      kana, status, owner, latitude, longitude);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EarthquakeParmaeterItemImplCopyWith<_$EarthquakeParmaeterItemImpl>
      get copyWith => __$$EarthquakeParmaeterItemImplCopyWithImpl<
          _$EarthquakeParmaeterItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EarthquakeParmaeterItemImplToJson(
      this,
    );
  }
}

abstract class _EarthquakeParmaeterItem implements EarthquakeParmaeterItem {
  const factory _EarthquakeParmaeterItem(
      {required final ParameterRegion region,
      required final ParameterCity city,
      required final String noCode,
      required final String code,
      required final String name,
      required final String kana,
      required final String status,
      required final String owner,
      @JsonKey(fromJson: doubleFromString, toJson: doubleToString)
      required final double latitude,
      @JsonKey(fromJson: doubleFromString, toJson: doubleToString)
      required final double longitude}) = _$EarthquakeParmaeterItemImpl;

  factory _EarthquakeParmaeterItem.fromJson(Map<String, dynamic> json) =
      _$EarthquakeParmaeterItemImpl.fromJson;

  @override
  ParameterRegion get region;
  @override
  ParameterCity get city;
  @override
  String get noCode;
  @override
  String get code;
  @override
  String get name;
  @override
  String get kana;
  @override
  String get status;
  @override
  String get owner;
  @override
  @JsonKey(fromJson: doubleFromString, toJson: doubleToString)
  double get latitude;
  @override
  @JsonKey(fromJson: doubleFromString, toJson: doubleToString)
  double get longitude;
  @override
  @JsonKey(ignore: true)
  _$$EarthquakeParmaeterItemImplCopyWith<_$EarthquakeParmaeterItemImpl>
      get copyWith => throw _privateConstructorUsedError;
}
