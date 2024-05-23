// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_settings_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NotificationSettingsModel _$NotificationSettingsModelFromJson(
    Map<String, dynamic> json) {
  return _NotificationSettingsModel.fromJson(json);
}

/// @nodoc
mixin _$NotificationSettingsModel {
  EewSettings get eew => throw _privateConstructorUsedError;
  EarthquakeSettings get earthquake => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationSettingsModelCopyWith<NotificationSettingsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationSettingsModelCopyWith<$Res> {
  factory $NotificationSettingsModelCopyWith(NotificationSettingsModel value,
          $Res Function(NotificationSettingsModel) then) =
      _$NotificationSettingsModelCopyWithImpl<$Res, NotificationSettingsModel>;
  @useResult
  $Res call({EewSettings eew, EarthquakeSettings earthquake});

  $EewSettingsCopyWith<$Res> get eew;
  $EarthquakeSettingsCopyWith<$Res> get earthquake;
}

/// @nodoc
class _$NotificationSettingsModelCopyWithImpl<$Res,
        $Val extends NotificationSettingsModel>
    implements $NotificationSettingsModelCopyWith<$Res> {
  _$NotificationSettingsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eew = null,
    Object? earthquake = null,
  }) {
    return _then(_value.copyWith(
      eew: null == eew
          ? _value.eew
          : eew // ignore: cast_nullable_to_non_nullable
              as EewSettings,
      earthquake: null == earthquake
          ? _value.earthquake
          : earthquake // ignore: cast_nullable_to_non_nullable
              as EarthquakeSettings,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $EewSettingsCopyWith<$Res> get eew {
    return $EewSettingsCopyWith<$Res>(_value.eew, (value) {
      return _then(_value.copyWith(eew: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $EarthquakeSettingsCopyWith<$Res> get earthquake {
    return $EarthquakeSettingsCopyWith<$Res>(_value.earthquake, (value) {
      return _then(_value.copyWith(earthquake: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NotificationSettingsModelImplCopyWith<$Res>
    implements $NotificationSettingsModelCopyWith<$Res> {
  factory _$$NotificationSettingsModelImplCopyWith(
          _$NotificationSettingsModelImpl value,
          $Res Function(_$NotificationSettingsModelImpl) then) =
      __$$NotificationSettingsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({EewSettings eew, EarthquakeSettings earthquake});

  @override
  $EewSettingsCopyWith<$Res> get eew;
  @override
  $EarthquakeSettingsCopyWith<$Res> get earthquake;
}

/// @nodoc
class __$$NotificationSettingsModelImplCopyWithImpl<$Res>
    extends _$NotificationSettingsModelCopyWithImpl<$Res,
        _$NotificationSettingsModelImpl>
    implements _$$NotificationSettingsModelImplCopyWith<$Res> {
  __$$NotificationSettingsModelImplCopyWithImpl(
      _$NotificationSettingsModelImpl _value,
      $Res Function(_$NotificationSettingsModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eew = null,
    Object? earthquake = null,
  }) {
    return _then(_$NotificationSettingsModelImpl(
      eew: null == eew
          ? _value.eew
          : eew // ignore: cast_nullable_to_non_nullable
              as EewSettings,
      earthquake: null == earthquake
          ? _value.earthquake
          : earthquake // ignore: cast_nullable_to_non_nullable
              as EarthquakeSettings,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationSettingsModelImpl implements _NotificationSettingsModel {
  const _$NotificationSettingsModelImpl(
      {this.eew = const EewSettings(),
      this.earthquake = const EarthquakeSettings()});

  factory _$NotificationSettingsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationSettingsModelImplFromJson(json);

  @override
  @JsonKey()
  final EewSettings eew;
  @override
  @JsonKey()
  final EarthquakeSettings earthquake;

  @override
  String toString() {
    return 'NotificationSettingsModel(eew: $eew, earthquake: $earthquake)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationSettingsModelImpl &&
            (identical(other.eew, eew) || other.eew == eew) &&
            (identical(other.earthquake, earthquake) ||
                other.earthquake == earthquake));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, eew, earthquake);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationSettingsModelImplCopyWith<_$NotificationSettingsModelImpl>
      get copyWith => __$$NotificationSettingsModelImplCopyWithImpl<
          _$NotificationSettingsModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationSettingsModelImplToJson(
      this,
    );
  }
}

abstract class _NotificationSettingsModel implements NotificationSettingsModel {
  const factory _NotificationSettingsModel(
      {final EewSettings eew,
      final EarthquakeSettings earthquake}) = _$NotificationSettingsModelImpl;

  factory _NotificationSettingsModel.fromJson(Map<String, dynamic> json) =
      _$NotificationSettingsModelImpl.fromJson;

  @override
  EewSettings get eew;
  @override
  EarthquakeSettings get earthquake;
  @override
  @JsonKey(ignore: true)
  _$$NotificationSettingsModelImplCopyWith<_$NotificationSettingsModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

EewSettings _$EewSettingsFromJson(Map<String, dynamic> json) {
  return _EewSettings.fromJson(json);
}

/// @nodoc
mixin _$EewSettings {
  JmaForecastIntensity? get emergencyIntensity =>
      throw _privateConstructorUsedError;
  JmaForecastIntensity? get silentIntensity =>
      throw _privateConstructorUsedError;
  List<Region> get regions => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EewSettingsCopyWith<EewSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EewSettingsCopyWith<$Res> {
  factory $EewSettingsCopyWith(
          EewSettings value, $Res Function(EewSettings) then) =
      _$EewSettingsCopyWithImpl<$Res, EewSettings>;
  @useResult
  $Res call(
      {JmaForecastIntensity? emergencyIntensity,
      JmaForecastIntensity? silentIntensity,
      List<Region> regions});
}

/// @nodoc
class _$EewSettingsCopyWithImpl<$Res, $Val extends EewSettings>
    implements $EewSettingsCopyWith<$Res> {
  _$EewSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? emergencyIntensity = freezed,
    Object? silentIntensity = freezed,
    Object? regions = null,
  }) {
    return _then(_value.copyWith(
      emergencyIntensity: freezed == emergencyIntensity
          ? _value.emergencyIntensity
          : emergencyIntensity // ignore: cast_nullable_to_non_nullable
              as JmaForecastIntensity?,
      silentIntensity: freezed == silentIntensity
          ? _value.silentIntensity
          : silentIntensity // ignore: cast_nullable_to_non_nullable
              as JmaForecastIntensity?,
      regions: null == regions
          ? _value.regions
          : regions // ignore: cast_nullable_to_non_nullable
              as List<Region>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EewSettingsImplCopyWith<$Res>
    implements $EewSettingsCopyWith<$Res> {
  factory _$$EewSettingsImplCopyWith(
          _$EewSettingsImpl value, $Res Function(_$EewSettingsImpl) then) =
      __$$EewSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {JmaForecastIntensity? emergencyIntensity,
      JmaForecastIntensity? silentIntensity,
      List<Region> regions});
}

/// @nodoc
class __$$EewSettingsImplCopyWithImpl<$Res>
    extends _$EewSettingsCopyWithImpl<$Res, _$EewSettingsImpl>
    implements _$$EewSettingsImplCopyWith<$Res> {
  __$$EewSettingsImplCopyWithImpl(
      _$EewSettingsImpl _value, $Res Function(_$EewSettingsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? emergencyIntensity = freezed,
    Object? silentIntensity = freezed,
    Object? regions = null,
  }) {
    return _then(_$EewSettingsImpl(
      emergencyIntensity: freezed == emergencyIntensity
          ? _value.emergencyIntensity
          : emergencyIntensity // ignore: cast_nullable_to_non_nullable
              as JmaForecastIntensity?,
      silentIntensity: freezed == silentIntensity
          ? _value.silentIntensity
          : silentIntensity // ignore: cast_nullable_to_non_nullable
              as JmaForecastIntensity?,
      regions: null == regions
          ? _value._regions
          : regions // ignore: cast_nullable_to_non_nullable
              as List<Region>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EewSettingsImpl implements _EewSettings {
  const _$EewSettingsImpl(
      {this.emergencyIntensity = null,
      this.silentIntensity = null,
      final List<Region> regions = const []})
      : _regions = regions;

  factory _$EewSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$EewSettingsImplFromJson(json);

  @override
  @JsonKey()
  final JmaForecastIntensity? emergencyIntensity;
  @override
  @JsonKey()
  final JmaForecastIntensity? silentIntensity;
  final List<Region> _regions;
  @override
  @JsonKey()
  List<Region> get regions {
    if (_regions is EqualUnmodifiableListView) return _regions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_regions);
  }

  @override
  String toString() {
    return 'EewSettings(emergencyIntensity: $emergencyIntensity, silentIntensity: $silentIntensity, regions: $regions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EewSettingsImpl &&
            (identical(other.emergencyIntensity, emergencyIntensity) ||
                other.emergencyIntensity == emergencyIntensity) &&
            (identical(other.silentIntensity, silentIntensity) ||
                other.silentIntensity == silentIntensity) &&
            const DeepCollectionEquality().equals(other._regions, _regions));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, emergencyIntensity,
      silentIntensity, const DeepCollectionEquality().hash(_regions));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EewSettingsImplCopyWith<_$EewSettingsImpl> get copyWith =>
      __$$EewSettingsImplCopyWithImpl<_$EewSettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EewSettingsImplToJson(
      this,
    );
  }
}

abstract class _EewSettings implements EewSettings {
  const factory _EewSettings(
      {final JmaForecastIntensity? emergencyIntensity,
      final JmaForecastIntensity? silentIntensity,
      final List<Region> regions}) = _$EewSettingsImpl;

  factory _EewSettings.fromJson(Map<String, dynamic> json) =
      _$EewSettingsImpl.fromJson;

  @override
  JmaForecastIntensity? get emergencyIntensity;
  @override
  JmaForecastIntensity? get silentIntensity;
  @override
  List<Region> get regions;
  @override
  @JsonKey(ignore: true)
  _$$EewSettingsImplCopyWith<_$EewSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EarthquakeSettings _$EarthquakeSettingsFromJson(Map<String, dynamic> json) {
  return _EarthquakeSettings.fromJson(json);
}

/// @nodoc
mixin _$EarthquakeSettings {
  JmaForecastIntensity? get emergencyIntensity =>
      throw _privateConstructorUsedError;
  JmaForecastIntensity? get silentIntensity =>
      throw _privateConstructorUsedError;
  List<Region> get regions => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EarthquakeSettingsCopyWith<EarthquakeSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EarthquakeSettingsCopyWith<$Res> {
  factory $EarthquakeSettingsCopyWith(
          EarthquakeSettings value, $Res Function(EarthquakeSettings) then) =
      _$EarthquakeSettingsCopyWithImpl<$Res, EarthquakeSettings>;
  @useResult
  $Res call(
      {JmaForecastIntensity? emergencyIntensity,
      JmaForecastIntensity? silentIntensity,
      List<Region> regions});
}

/// @nodoc
class _$EarthquakeSettingsCopyWithImpl<$Res, $Val extends EarthquakeSettings>
    implements $EarthquakeSettingsCopyWith<$Res> {
  _$EarthquakeSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? emergencyIntensity = freezed,
    Object? silentIntensity = freezed,
    Object? regions = null,
  }) {
    return _then(_value.copyWith(
      emergencyIntensity: freezed == emergencyIntensity
          ? _value.emergencyIntensity
          : emergencyIntensity // ignore: cast_nullable_to_non_nullable
              as JmaForecastIntensity?,
      silentIntensity: freezed == silentIntensity
          ? _value.silentIntensity
          : silentIntensity // ignore: cast_nullable_to_non_nullable
              as JmaForecastIntensity?,
      regions: null == regions
          ? _value.regions
          : regions // ignore: cast_nullable_to_non_nullable
              as List<Region>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EarthquakeSettingsImplCopyWith<$Res>
    implements $EarthquakeSettingsCopyWith<$Res> {
  factory _$$EarthquakeSettingsImplCopyWith(_$EarthquakeSettingsImpl value,
          $Res Function(_$EarthquakeSettingsImpl) then) =
      __$$EarthquakeSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {JmaForecastIntensity? emergencyIntensity,
      JmaForecastIntensity? silentIntensity,
      List<Region> regions});
}

/// @nodoc
class __$$EarthquakeSettingsImplCopyWithImpl<$Res>
    extends _$EarthquakeSettingsCopyWithImpl<$Res, _$EarthquakeSettingsImpl>
    implements _$$EarthquakeSettingsImplCopyWith<$Res> {
  __$$EarthquakeSettingsImplCopyWithImpl(_$EarthquakeSettingsImpl _value,
      $Res Function(_$EarthquakeSettingsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? emergencyIntensity = freezed,
    Object? silentIntensity = freezed,
    Object? regions = null,
  }) {
    return _then(_$EarthquakeSettingsImpl(
      emergencyIntensity: freezed == emergencyIntensity
          ? _value.emergencyIntensity
          : emergencyIntensity // ignore: cast_nullable_to_non_nullable
              as JmaForecastIntensity?,
      silentIntensity: freezed == silentIntensity
          ? _value.silentIntensity
          : silentIntensity // ignore: cast_nullable_to_non_nullable
              as JmaForecastIntensity?,
      regions: null == regions
          ? _value._regions
          : regions // ignore: cast_nullable_to_non_nullable
              as List<Region>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EarthquakeSettingsImpl implements _EarthquakeSettings {
  const _$EarthquakeSettingsImpl(
      {this.emergencyIntensity = null,
      this.silentIntensity = null,
      final List<Region> regions = const []})
      : _regions = regions;

  factory _$EarthquakeSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$EarthquakeSettingsImplFromJson(json);

  @override
  @JsonKey()
  final JmaForecastIntensity? emergencyIntensity;
  @override
  @JsonKey()
  final JmaForecastIntensity? silentIntensity;
  final List<Region> _regions;
  @override
  @JsonKey()
  List<Region> get regions {
    if (_regions is EqualUnmodifiableListView) return _regions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_regions);
  }

  @override
  String toString() {
    return 'EarthquakeSettings(emergencyIntensity: $emergencyIntensity, silentIntensity: $silentIntensity, regions: $regions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EarthquakeSettingsImpl &&
            (identical(other.emergencyIntensity, emergencyIntensity) ||
                other.emergencyIntensity == emergencyIntensity) &&
            (identical(other.silentIntensity, silentIntensity) ||
                other.silentIntensity == silentIntensity) &&
            const DeepCollectionEquality().equals(other._regions, _regions));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, emergencyIntensity,
      silentIntensity, const DeepCollectionEquality().hash(_regions));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EarthquakeSettingsImplCopyWith<_$EarthquakeSettingsImpl> get copyWith =>
      __$$EarthquakeSettingsImplCopyWithImpl<_$EarthquakeSettingsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EarthquakeSettingsImplToJson(
      this,
    );
  }
}

abstract class _EarthquakeSettings implements EarthquakeSettings {
  const factory _EarthquakeSettings(
      {final JmaForecastIntensity? emergencyIntensity,
      final JmaForecastIntensity? silentIntensity,
      final List<Region> regions}) = _$EarthquakeSettingsImpl;

  factory _EarthquakeSettings.fromJson(Map<String, dynamic> json) =
      _$EarthquakeSettingsImpl.fromJson;

  @override
  JmaForecastIntensity? get emergencyIntensity;
  @override
  JmaForecastIntensity? get silentIntensity;
  @override
  List<Region> get regions;
  @override
  @JsonKey(ignore: true)
  _$$EarthquakeSettingsImplCopyWith<_$EarthquakeSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Region _$RegionFromJson(Map<String, dynamic> json) {
  return _Region.fromJson(json);
}

/// @nodoc
mixin _$Region {
  String get code => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  JmaForecastIntensity get emergencyIntensity =>
      throw _privateConstructorUsedError;
  JmaForecastIntensity get silentIntensity =>
      throw _privateConstructorUsedError;
  bool get isMain => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RegionCopyWith<Region> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegionCopyWith<$Res> {
  factory $RegionCopyWith(Region value, $Res Function(Region) then) =
      _$RegionCopyWithImpl<$Res, Region>;
  @useResult
  $Res call(
      {String code,
      String name,
      JmaForecastIntensity emergencyIntensity,
      JmaForecastIntensity silentIntensity,
      bool isMain});
}

/// @nodoc
class _$RegionCopyWithImpl<$Res, $Val extends Region>
    implements $RegionCopyWith<$Res> {
  _$RegionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
    Object? emergencyIntensity = null,
    Object? silentIntensity = null,
    Object? isMain = null,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      emergencyIntensity: null == emergencyIntensity
          ? _value.emergencyIntensity
          : emergencyIntensity // ignore: cast_nullable_to_non_nullable
              as JmaForecastIntensity,
      silentIntensity: null == silentIntensity
          ? _value.silentIntensity
          : silentIntensity // ignore: cast_nullable_to_non_nullable
              as JmaForecastIntensity,
      isMain: null == isMain
          ? _value.isMain
          : isMain // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RegionImplCopyWith<$Res> implements $RegionCopyWith<$Res> {
  factory _$$RegionImplCopyWith(
          _$RegionImpl value, $Res Function(_$RegionImpl) then) =
      __$$RegionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String code,
      String name,
      JmaForecastIntensity emergencyIntensity,
      JmaForecastIntensity silentIntensity,
      bool isMain});
}

/// @nodoc
class __$$RegionImplCopyWithImpl<$Res>
    extends _$RegionCopyWithImpl<$Res, _$RegionImpl>
    implements _$$RegionImplCopyWith<$Res> {
  __$$RegionImplCopyWithImpl(
      _$RegionImpl _value, $Res Function(_$RegionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
    Object? emergencyIntensity = null,
    Object? silentIntensity = null,
    Object? isMain = null,
  }) {
    return _then(_$RegionImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      emergencyIntensity: null == emergencyIntensity
          ? _value.emergencyIntensity
          : emergencyIntensity // ignore: cast_nullable_to_non_nullable
              as JmaForecastIntensity,
      silentIntensity: null == silentIntensity
          ? _value.silentIntensity
          : silentIntensity // ignore: cast_nullable_to_non_nullable
              as JmaForecastIntensity,
      isMain: null == isMain
          ? _value.isMain
          : isMain // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RegionImpl implements _Region {
  const _$RegionImpl(
      {required this.code,
      required this.name,
      required this.emergencyIntensity,
      required this.silentIntensity,
      required this.isMain});

  factory _$RegionImpl.fromJson(Map<String, dynamic> json) =>
      _$$RegionImplFromJson(json);

  @override
  final String code;
  @override
  final String name;
  @override
  final JmaForecastIntensity emergencyIntensity;
  @override
  final JmaForecastIntensity silentIntensity;
  @override
  final bool isMain;

  @override
  String toString() {
    return 'Region(code: $code, name: $name, emergencyIntensity: $emergencyIntensity, silentIntensity: $silentIntensity, isMain: $isMain)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegionImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.emergencyIntensity, emergencyIntensity) ||
                other.emergencyIntensity == emergencyIntensity) &&
            (identical(other.silentIntensity, silentIntensity) ||
                other.silentIntensity == silentIntensity) &&
            (identical(other.isMain, isMain) || other.isMain == isMain));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, code, name, emergencyIntensity, silentIntensity, isMain);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RegionImplCopyWith<_$RegionImpl> get copyWith =>
      __$$RegionImplCopyWithImpl<_$RegionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RegionImplToJson(
      this,
    );
  }
}

abstract class _Region implements Region {
  const factory _Region(
      {required final String code,
      required final String name,
      required final JmaForecastIntensity emergencyIntensity,
      required final JmaForecastIntensity silentIntensity,
      required final bool isMain}) = _$RegionImpl;

  factory _Region.fromJson(Map<String, dynamic> json) = _$RegionImpl.fromJson;

  @override
  String get code;
  @override
  String get name;
  @override
  JmaForecastIntensity get emergencyIntensity;
  @override
  JmaForecastIntensity get silentIntensity;
  @override
  bool get isMain;
  @override
  @JsonKey(ignore: true)
  _$$RegionImplCopyWith<_$RegionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
