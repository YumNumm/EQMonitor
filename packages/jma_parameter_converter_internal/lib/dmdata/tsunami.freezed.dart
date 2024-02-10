// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TsunamiParameter _$TsunamiParameterFromJson(Map<String, dynamic> json) {
  return _TsunamiParameter.fromJson(json);
}

/// @nodoc
mixin _$TsunamiParameter {
  String get responseId => throw _privateConstructorUsedError;
  DateTime get responseTime => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  DateTime get changeTime => throw _privateConstructorUsedError;
  String get version => throw _privateConstructorUsedError;
  List<TsunamiParameterItem> get items => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TsunamiParameterCopyWith<TsunamiParameter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TsunamiParameterCopyWith<$Res> {
  factory $TsunamiParameterCopyWith(
          TsunamiParameter value, $Res Function(TsunamiParameter) then) =
      _$TsunamiParameterCopyWithImpl<$Res, TsunamiParameter>;
  @useResult
  $Res call(
      {String responseId,
      DateTime responseTime,
      String status,
      DateTime changeTime,
      String version,
      List<TsunamiParameterItem> items});
}

/// @nodoc
class _$TsunamiParameterCopyWithImpl<$Res, $Val extends TsunamiParameter>
    implements $TsunamiParameterCopyWith<$Res> {
  _$TsunamiParameterCopyWithImpl(this._value, this._then);

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
              as List<TsunamiParameterItem>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TsunamiParameterImplCopyWith<$Res>
    implements $TsunamiParameterCopyWith<$Res> {
  factory _$$TsunamiParameterImplCopyWith(_$TsunamiParameterImpl value,
          $Res Function(_$TsunamiParameterImpl) then) =
      __$$TsunamiParameterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String responseId,
      DateTime responseTime,
      String status,
      DateTime changeTime,
      String version,
      List<TsunamiParameterItem> items});
}

/// @nodoc
class __$$TsunamiParameterImplCopyWithImpl<$Res>
    extends _$TsunamiParameterCopyWithImpl<$Res, _$TsunamiParameterImpl>
    implements _$$TsunamiParameterImplCopyWith<$Res> {
  __$$TsunamiParameterImplCopyWithImpl(_$TsunamiParameterImpl _value,
      $Res Function(_$TsunamiParameterImpl) _then)
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
    return _then(_$TsunamiParameterImpl(
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
              as List<TsunamiParameterItem>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TsunamiParameterImpl implements _TsunamiParameter {
  const _$TsunamiParameterImpl(
      {required this.responseId,
      required this.responseTime,
      required this.status,
      required this.changeTime,
      required this.version,
      required final List<TsunamiParameterItem> items})
      : _items = items;

  factory _$TsunamiParameterImpl.fromJson(Map<String, dynamic> json) =>
      _$$TsunamiParameterImplFromJson(json);

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
  final List<TsunamiParameterItem> _items;
  @override
  List<TsunamiParameterItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'TsunamiParameter(responseId: $responseId, responseTime: $responseTime, status: $status, changeTime: $changeTime, version: $version, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TsunamiParameterImpl &&
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
  _$$TsunamiParameterImplCopyWith<_$TsunamiParameterImpl> get copyWith =>
      __$$TsunamiParameterImplCopyWithImpl<_$TsunamiParameterImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TsunamiParameterImplToJson(
      this,
    );
  }
}

abstract class _TsunamiParameter implements TsunamiParameter {
  const factory _TsunamiParameter(
          {required final String responseId,
          required final DateTime responseTime,
          required final String status,
          required final DateTime changeTime,
          required final String version,
          required final List<TsunamiParameterItem> items}) =
      _$TsunamiParameterImpl;

  factory _TsunamiParameter.fromJson(Map<String, dynamic> json) =
      _$TsunamiParameterImpl.fromJson;

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
  List<TsunamiParameterItem> get items;
  @override
  @JsonKey(ignore: true)
  _$$TsunamiParameterImplCopyWith<_$TsunamiParameterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TsunamiParameterItem _$TsunamiParameterItemFromJson(Map<String, dynamic> json) {
  return _TsunamiParameterItem.fromJson(json);
}

/// @nodoc
mixin _$TsunamiParameterItem {
  String? get area => throw _privateConstructorUsedError;
  String get prefecture => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get kana => throw _privateConstructorUsedError;
  String get owner => throw _privateConstructorUsedError;
  @JsonKey(fromJson: doubleFromString, toJson: doubleToString)
  double get latitude => throw _privateConstructorUsedError;
  @JsonKey(fromJson: doubleFromString, toJson: doubleToString)
  double get longitude => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TsunamiParameterItemCopyWith<TsunamiParameterItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TsunamiParameterItemCopyWith<$Res> {
  factory $TsunamiParameterItemCopyWith(TsunamiParameterItem value,
          $Res Function(TsunamiParameterItem) then) =
      _$TsunamiParameterItemCopyWithImpl<$Res, TsunamiParameterItem>;
  @useResult
  $Res call(
      {String? area,
      String prefecture,
      String code,
      String name,
      String kana,
      String owner,
      @JsonKey(fromJson: doubleFromString, toJson: doubleToString)
      double latitude,
      @JsonKey(fromJson: doubleFromString, toJson: doubleToString)
      double longitude});
}

/// @nodoc
class _$TsunamiParameterItemCopyWithImpl<$Res,
        $Val extends TsunamiParameterItem>
    implements $TsunamiParameterItemCopyWith<$Res> {
  _$TsunamiParameterItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? area = freezed,
    Object? prefecture = null,
    Object? code = null,
    Object? name = null,
    Object? kana = null,
    Object? owner = null,
    Object? latitude = null,
    Object? longitude = null,
  }) {
    return _then(_value.copyWith(
      area: freezed == area
          ? _value.area
          : area // ignore: cast_nullable_to_non_nullable
              as String?,
      prefecture: null == prefecture
          ? _value.prefecture
          : prefecture // ignore: cast_nullable_to_non_nullable
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
}

/// @nodoc
abstract class _$$TsunamiParameterItemImplCopyWith<$Res>
    implements $TsunamiParameterItemCopyWith<$Res> {
  factory _$$TsunamiParameterItemImplCopyWith(_$TsunamiParameterItemImpl value,
          $Res Function(_$TsunamiParameterItemImpl) then) =
      __$$TsunamiParameterItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? area,
      String prefecture,
      String code,
      String name,
      String kana,
      String owner,
      @JsonKey(fromJson: doubleFromString, toJson: doubleToString)
      double latitude,
      @JsonKey(fromJson: doubleFromString, toJson: doubleToString)
      double longitude});
}

/// @nodoc
class __$$TsunamiParameterItemImplCopyWithImpl<$Res>
    extends _$TsunamiParameterItemCopyWithImpl<$Res, _$TsunamiParameterItemImpl>
    implements _$$TsunamiParameterItemImplCopyWith<$Res> {
  __$$TsunamiParameterItemImplCopyWithImpl(_$TsunamiParameterItemImpl _value,
      $Res Function(_$TsunamiParameterItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? area = freezed,
    Object? prefecture = null,
    Object? code = null,
    Object? name = null,
    Object? kana = null,
    Object? owner = null,
    Object? latitude = null,
    Object? longitude = null,
  }) {
    return _then(_$TsunamiParameterItemImpl(
      area: freezed == area
          ? _value.area
          : area // ignore: cast_nullable_to_non_nullable
              as String?,
      prefecture: null == prefecture
          ? _value.prefecture
          : prefecture // ignore: cast_nullable_to_non_nullable
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
class _$TsunamiParameterItemImpl implements _TsunamiParameterItem {
  const _$TsunamiParameterItemImpl(
      {required this.area,
      required this.prefecture,
      required this.code,
      required this.name,
      required this.kana,
      required this.owner,
      @JsonKey(fromJson: doubleFromString, toJson: doubleToString)
      required this.latitude,
      @JsonKey(fromJson: doubleFromString, toJson: doubleToString)
      required this.longitude});

  factory _$TsunamiParameterItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$TsunamiParameterItemImplFromJson(json);

  @override
  final String? area;
  @override
  final String prefecture;
  @override
  final String code;
  @override
  final String name;
  @override
  final String kana;
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
    return 'TsunamiParameterItem(area: $area, prefecture: $prefecture, code: $code, name: $name, kana: $kana, owner: $owner, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TsunamiParameterItemImpl &&
            (identical(other.area, area) || other.area == area) &&
            (identical(other.prefecture, prefecture) ||
                other.prefecture == prefecture) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.kana, kana) || other.kana == kana) &&
            (identical(other.owner, owner) || other.owner == owner) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, area, prefecture, code, name,
      kana, owner, latitude, longitude);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TsunamiParameterItemImplCopyWith<_$TsunamiParameterItemImpl>
      get copyWith =>
          __$$TsunamiParameterItemImplCopyWithImpl<_$TsunamiParameterItemImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TsunamiParameterItemImplToJson(
      this,
    );
  }
}

abstract class _TsunamiParameterItem implements TsunamiParameterItem {
  const factory _TsunamiParameterItem(
      {required final String? area,
      required final String prefecture,
      required final String code,
      required final String name,
      required final String kana,
      required final String owner,
      @JsonKey(fromJson: doubleFromString, toJson: doubleToString)
      required final double latitude,
      @JsonKey(fromJson: doubleFromString, toJson: doubleToString)
      required final double longitude}) = _$TsunamiParameterItemImpl;

  factory _TsunamiParameterItem.fromJson(Map<String, dynamic> json) =
      _$TsunamiParameterItemImpl.fromJson;

  @override
  String? get area;
  @override
  String get prefecture;
  @override
  String get code;
  @override
  String get name;
  @override
  String get kana;
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
  _$$TsunamiParameterItemImplCopyWith<_$TsunamiParameterItemImpl>
      get copyWith => throw _privateConstructorUsedError;
}
