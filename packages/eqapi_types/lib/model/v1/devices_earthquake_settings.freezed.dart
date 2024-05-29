// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'devices_earthquake_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DevicesEarthquakeSettings _$DevicesEarthquakeSettingsFromJson(
    Map<String, dynamic> json) {
  return _DevicesEarthquakeSettings.fromJson(json);
}

/// @nodoc
mixin _$DevicesEarthquakeSettings {
  String get id => throw _privateConstructorUsedError;
  JmaForecastIntensity get minJmaIntensity =>
      throw _privateConstructorUsedError;
  int get regionId => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DevicesEarthquakeSettingsCopyWith<DevicesEarthquakeSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DevicesEarthquakeSettingsCopyWith<$Res> {
  factory $DevicesEarthquakeSettingsCopyWith(DevicesEarthquakeSettings value,
          $Res Function(DevicesEarthquakeSettings) then) =
      _$DevicesEarthquakeSettingsCopyWithImpl<$Res, DevicesEarthquakeSettings>;
  @useResult
  $Res call(
      {String id,
      JmaForecastIntensity minJmaIntensity,
      int regionId,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$DevicesEarthquakeSettingsCopyWithImpl<$Res,
        $Val extends DevicesEarthquakeSettings>
    implements $DevicesEarthquakeSettingsCopyWith<$Res> {
  _$DevicesEarthquakeSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? minJmaIntensity = null,
    Object? regionId = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      minJmaIntensity: null == minJmaIntensity
          ? _value.minJmaIntensity
          : minJmaIntensity // ignore: cast_nullable_to_non_nullable
              as JmaForecastIntensity,
      regionId: null == regionId
          ? _value.regionId
          : regionId // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DevicesEarthquakeSettingsImplCopyWith<$Res>
    implements $DevicesEarthquakeSettingsCopyWith<$Res> {
  factory _$$DevicesEarthquakeSettingsImplCopyWith(
          _$DevicesEarthquakeSettingsImpl value,
          $Res Function(_$DevicesEarthquakeSettingsImpl) then) =
      __$$DevicesEarthquakeSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      JmaForecastIntensity minJmaIntensity,
      int regionId,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$DevicesEarthquakeSettingsImplCopyWithImpl<$Res>
    extends _$DevicesEarthquakeSettingsCopyWithImpl<$Res,
        _$DevicesEarthquakeSettingsImpl>
    implements _$$DevicesEarthquakeSettingsImplCopyWith<$Res> {
  __$$DevicesEarthquakeSettingsImplCopyWithImpl(
      _$DevicesEarthquakeSettingsImpl _value,
      $Res Function(_$DevicesEarthquakeSettingsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? minJmaIntensity = null,
    Object? regionId = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$DevicesEarthquakeSettingsImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      minJmaIntensity: null == minJmaIntensity
          ? _value.minJmaIntensity
          : minJmaIntensity // ignore: cast_nullable_to_non_nullable
              as JmaForecastIntensity,
      regionId: null == regionId
          ? _value.regionId
          : regionId // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DevicesEarthquakeSettingsImpl implements _DevicesEarthquakeSettings {
  const _$DevicesEarthquakeSettingsImpl(
      {required this.id,
      required this.minJmaIntensity,
      required this.regionId,
      required this.createdAt,
      required this.updatedAt});

  factory _$DevicesEarthquakeSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$DevicesEarthquakeSettingsImplFromJson(json);

  @override
  final String id;
  @override
  final JmaForecastIntensity minJmaIntensity;
  @override
  final int regionId;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'DevicesEarthquakeSettings(id: $id, minJmaIntensity: $minJmaIntensity, regionId: $regionId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DevicesEarthquakeSettingsImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.minJmaIntensity, minJmaIntensity) ||
                other.minJmaIntensity == minJmaIntensity) &&
            (identical(other.regionId, regionId) ||
                other.regionId == regionId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, minJmaIntensity, regionId, createdAt, updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DevicesEarthquakeSettingsImplCopyWith<_$DevicesEarthquakeSettingsImpl>
      get copyWith => __$$DevicesEarthquakeSettingsImplCopyWithImpl<
          _$DevicesEarthquakeSettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DevicesEarthquakeSettingsImplToJson(
      this,
    );
  }
}

abstract class _DevicesEarthquakeSettings implements DevicesEarthquakeSettings {
  const factory _DevicesEarthquakeSettings(
      {required final String id,
      required final JmaForecastIntensity minJmaIntensity,
      required final int regionId,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$DevicesEarthquakeSettingsImpl;

  factory _DevicesEarthquakeSettings.fromJson(Map<String, dynamic> json) =
      _$DevicesEarthquakeSettingsImpl.fromJson;

  @override
  String get id;
  @override
  JmaForecastIntensity get minJmaIntensity;
  @override
  int get regionId;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$DevicesEarthquakeSettingsImplCopyWith<_$DevicesEarthquakeSettingsImpl>
      get copyWith => throw _privateConstructorUsedError;
}
