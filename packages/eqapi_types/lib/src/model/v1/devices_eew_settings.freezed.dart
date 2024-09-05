// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'devices_eew_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DevicesEewSettings _$DevicesEewSettingsFromJson(Map<String, dynamic> json) {
  return _DevicesEewSettings.fromJson(json);
}

/// @nodoc
mixin _$DevicesEewSettings {
  String get id => throw _privateConstructorUsedError;
  JmaForecastIntensity get minJmaIntensity =>
      throw _privateConstructorUsedError;
  int get regionId => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this DevicesEewSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DevicesEewSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DevicesEewSettingsCopyWith<DevicesEewSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DevicesEewSettingsCopyWith<$Res> {
  factory $DevicesEewSettingsCopyWith(
          DevicesEewSettings value, $Res Function(DevicesEewSettings) then) =
      _$DevicesEewSettingsCopyWithImpl<$Res, DevicesEewSettings>;
  @useResult
  $Res call(
      {String id,
      JmaForecastIntensity minJmaIntensity,
      int regionId,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$DevicesEewSettingsCopyWithImpl<$Res, $Val extends DevicesEewSettings>
    implements $DevicesEewSettingsCopyWith<$Res> {
  _$DevicesEewSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DevicesEewSettings
  /// with the given fields replaced by the non-null parameter values.
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
abstract class _$$DevicesEewSettingsImplCopyWith<$Res>
    implements $DevicesEewSettingsCopyWith<$Res> {
  factory _$$DevicesEewSettingsImplCopyWith(_$DevicesEewSettingsImpl value,
          $Res Function(_$DevicesEewSettingsImpl) then) =
      __$$DevicesEewSettingsImplCopyWithImpl<$Res>;
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
class __$$DevicesEewSettingsImplCopyWithImpl<$Res>
    extends _$DevicesEewSettingsCopyWithImpl<$Res, _$DevicesEewSettingsImpl>
    implements _$$DevicesEewSettingsImplCopyWith<$Res> {
  __$$DevicesEewSettingsImplCopyWithImpl(_$DevicesEewSettingsImpl _value,
      $Res Function(_$DevicesEewSettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of DevicesEewSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? minJmaIntensity = null,
    Object? regionId = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$DevicesEewSettingsImpl(
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
class _$DevicesEewSettingsImpl implements _DevicesEewSettings {
  const _$DevicesEewSettingsImpl(
      {required this.id,
      required this.minJmaIntensity,
      required this.regionId,
      required this.createdAt,
      required this.updatedAt});

  factory _$DevicesEewSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$DevicesEewSettingsImplFromJson(json);

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
    return 'DevicesEewSettings(id: $id, minJmaIntensity: $minJmaIntensity, regionId: $regionId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DevicesEewSettingsImpl &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, minJmaIntensity, regionId, createdAt, updatedAt);

  /// Create a copy of DevicesEewSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DevicesEewSettingsImplCopyWith<_$DevicesEewSettingsImpl> get copyWith =>
      __$$DevicesEewSettingsImplCopyWithImpl<_$DevicesEewSettingsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DevicesEewSettingsImplToJson(
      this,
    );
  }
}

abstract class _DevicesEewSettings implements DevicesEewSettings {
  const factory _DevicesEewSettings(
      {required final String id,
      required final JmaForecastIntensity minJmaIntensity,
      required final int regionId,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$DevicesEewSettingsImpl;

  factory _DevicesEewSettings.fromJson(Map<String, dynamic> json) =
      _$DevicesEewSettingsImpl.fromJson;

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

  /// Create a copy of DevicesEewSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DevicesEewSettingsImplCopyWith<_$DevicesEewSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
