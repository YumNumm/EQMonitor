// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_remote_settings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NotificationRemoteSettingsState _$NotificationRemoteSettingsStateFromJson(
    Map<String, dynamic> json) {
  return _NotificationRemoteSettingsState.fromJson(json);
}

/// @nodoc
mixin _$NotificationRemoteSettingsState {
  NotificationRemoteSettingsEew get eew => throw _privateConstructorUsedError;
  NotificationRemoteSettingsEarthquake get earthquake =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationRemoteSettingsStateCopyWith<NotificationRemoteSettingsState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationRemoteSettingsStateCopyWith<$Res> {
  factory $NotificationRemoteSettingsStateCopyWith(
          NotificationRemoteSettingsState value,
          $Res Function(NotificationRemoteSettingsState) then) =
      _$NotificationRemoteSettingsStateCopyWithImpl<$Res,
          NotificationRemoteSettingsState>;
  @useResult
  $Res call(
      {NotificationRemoteSettingsEew eew,
      NotificationRemoteSettingsEarthquake earthquake});

  $NotificationRemoteSettingsEewCopyWith<$Res> get eew;
  $NotificationRemoteSettingsEarthquakeCopyWith<$Res> get earthquake;
}

/// @nodoc
class _$NotificationRemoteSettingsStateCopyWithImpl<$Res,
        $Val extends NotificationRemoteSettingsState>
    implements $NotificationRemoteSettingsStateCopyWith<$Res> {
  _$NotificationRemoteSettingsStateCopyWithImpl(this._value, this._then);

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
              as NotificationRemoteSettingsEew,
      earthquake: null == earthquake
          ? _value.earthquake
          : earthquake // ignore: cast_nullable_to_non_nullable
              as NotificationRemoteSettingsEarthquake,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $NotificationRemoteSettingsEewCopyWith<$Res> get eew {
    return $NotificationRemoteSettingsEewCopyWith<$Res>(_value.eew, (value) {
      return _then(_value.copyWith(eew: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $NotificationRemoteSettingsEarthquakeCopyWith<$Res> get earthquake {
    return $NotificationRemoteSettingsEarthquakeCopyWith<$Res>(
        _value.earthquake, (value) {
      return _then(_value.copyWith(earthquake: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NotificationRemoteSettingsStateImplCopyWith<$Res>
    implements $NotificationRemoteSettingsStateCopyWith<$Res> {
  factory _$$NotificationRemoteSettingsStateImplCopyWith(
          _$NotificationRemoteSettingsStateImpl value,
          $Res Function(_$NotificationRemoteSettingsStateImpl) then) =
      __$$NotificationRemoteSettingsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {NotificationRemoteSettingsEew eew,
      NotificationRemoteSettingsEarthquake earthquake});

  @override
  $NotificationRemoteSettingsEewCopyWith<$Res> get eew;
  @override
  $NotificationRemoteSettingsEarthquakeCopyWith<$Res> get earthquake;
}

/// @nodoc
class __$$NotificationRemoteSettingsStateImplCopyWithImpl<$Res>
    extends _$NotificationRemoteSettingsStateCopyWithImpl<$Res,
        _$NotificationRemoteSettingsStateImpl>
    implements _$$NotificationRemoteSettingsStateImplCopyWith<$Res> {
  __$$NotificationRemoteSettingsStateImplCopyWithImpl(
      _$NotificationRemoteSettingsStateImpl _value,
      $Res Function(_$NotificationRemoteSettingsStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eew = null,
    Object? earthquake = null,
  }) {
    return _then(_$NotificationRemoteSettingsStateImpl(
      eew: null == eew
          ? _value.eew
          : eew // ignore: cast_nullable_to_non_nullable
              as NotificationRemoteSettingsEew,
      earthquake: null == earthquake
          ? _value.earthquake
          : earthquake // ignore: cast_nullable_to_non_nullable
              as NotificationRemoteSettingsEarthquake,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationRemoteSettingsStateImpl
    implements _NotificationRemoteSettingsState {
  const _$NotificationRemoteSettingsStateImpl(
      {required this.eew, required this.earthquake});

  factory _$NotificationRemoteSettingsStateImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$NotificationRemoteSettingsStateImplFromJson(json);

  @override
  final NotificationRemoteSettingsEew eew;
  @override
  final NotificationRemoteSettingsEarthquake earthquake;

  @override
  String toString() {
    return 'NotificationRemoteSettingsState(eew: $eew, earthquake: $earthquake)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationRemoteSettingsStateImpl &&
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
  _$$NotificationRemoteSettingsStateImplCopyWith<
          _$NotificationRemoteSettingsStateImpl>
      get copyWith => __$$NotificationRemoteSettingsStateImplCopyWithImpl<
          _$NotificationRemoteSettingsStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationRemoteSettingsStateImplToJson(
      this,
    );
  }
}

abstract class _NotificationRemoteSettingsState
    implements NotificationRemoteSettingsState {
  const factory _NotificationRemoteSettingsState(
          {required final NotificationRemoteSettingsEew eew,
          required final NotificationRemoteSettingsEarthquake earthquake}) =
      _$NotificationRemoteSettingsStateImpl;

  factory _NotificationRemoteSettingsState.fromJson(Map<String, dynamic> json) =
      _$NotificationRemoteSettingsStateImpl.fromJson;

  @override
  NotificationRemoteSettingsEew get eew;
  @override
  NotificationRemoteSettingsEarthquake get earthquake;
  @override
  @JsonKey(ignore: true)
  _$$NotificationRemoteSettingsStateImplCopyWith<
          _$NotificationRemoteSettingsStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

NotificationRemoteSettingsEew _$NotificationRemoteSettingsEewFromJson(
    Map<String, dynamic> json) {
  return _NotificationRemoteSettingsEew.fromJson(json);
}

/// @nodoc
mixin _$NotificationRemoteSettingsEew {
  JmaForecastIntensity? get global => throw _privateConstructorUsedError;
  List<NotificationRemoteSettingsEewRegion> get regions =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationRemoteSettingsEewCopyWith<NotificationRemoteSettingsEew>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationRemoteSettingsEewCopyWith<$Res> {
  factory $NotificationRemoteSettingsEewCopyWith(
          NotificationRemoteSettingsEew value,
          $Res Function(NotificationRemoteSettingsEew) then) =
      _$NotificationRemoteSettingsEewCopyWithImpl<$Res,
          NotificationRemoteSettingsEew>;
  @useResult
  $Res call(
      {JmaForecastIntensity? global,
      List<NotificationRemoteSettingsEewRegion> regions});
}

/// @nodoc
class _$NotificationRemoteSettingsEewCopyWithImpl<$Res,
        $Val extends NotificationRemoteSettingsEew>
    implements $NotificationRemoteSettingsEewCopyWith<$Res> {
  _$NotificationRemoteSettingsEewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? global = freezed,
    Object? regions = null,
  }) {
    return _then(_value.copyWith(
      global: freezed == global
          ? _value.global
          : global // ignore: cast_nullable_to_non_nullable
              as JmaForecastIntensity?,
      regions: null == regions
          ? _value.regions
          : regions // ignore: cast_nullable_to_non_nullable
              as List<NotificationRemoteSettingsEewRegion>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationRemoteSettingsEewImplCopyWith<$Res>
    implements $NotificationRemoteSettingsEewCopyWith<$Res> {
  factory _$$NotificationRemoteSettingsEewImplCopyWith(
          _$NotificationRemoteSettingsEewImpl value,
          $Res Function(_$NotificationRemoteSettingsEewImpl) then) =
      __$$NotificationRemoteSettingsEewImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {JmaForecastIntensity? global,
      List<NotificationRemoteSettingsEewRegion> regions});
}

/// @nodoc
class __$$NotificationRemoteSettingsEewImplCopyWithImpl<$Res>
    extends _$NotificationRemoteSettingsEewCopyWithImpl<$Res,
        _$NotificationRemoteSettingsEewImpl>
    implements _$$NotificationRemoteSettingsEewImplCopyWith<$Res> {
  __$$NotificationRemoteSettingsEewImplCopyWithImpl(
      _$NotificationRemoteSettingsEewImpl _value,
      $Res Function(_$NotificationRemoteSettingsEewImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? global = freezed,
    Object? regions = null,
  }) {
    return _then(_$NotificationRemoteSettingsEewImpl(
      global: freezed == global
          ? _value.global
          : global // ignore: cast_nullable_to_non_nullable
              as JmaForecastIntensity?,
      regions: null == regions
          ? _value._regions
          : regions // ignore: cast_nullable_to_non_nullable
              as List<NotificationRemoteSettingsEewRegion>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationRemoteSettingsEewImpl
    implements _NotificationRemoteSettingsEew {
  const _$NotificationRemoteSettingsEewImpl(
      {required this.global,
      required final List<NotificationRemoteSettingsEewRegion> regions})
      : _regions = regions;

  factory _$NotificationRemoteSettingsEewImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$NotificationRemoteSettingsEewImplFromJson(json);

  @override
  final JmaForecastIntensity? global;
  final List<NotificationRemoteSettingsEewRegion> _regions;
  @override
  List<NotificationRemoteSettingsEewRegion> get regions {
    if (_regions is EqualUnmodifiableListView) return _regions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_regions);
  }

  @override
  String toString() {
    return 'NotificationRemoteSettingsEew(global: $global, regions: $regions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationRemoteSettingsEewImpl &&
            (identical(other.global, global) || other.global == global) &&
            const DeepCollectionEquality().equals(other._regions, _regions));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, global, const DeepCollectionEquality().hash(_regions));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationRemoteSettingsEewImplCopyWith<
          _$NotificationRemoteSettingsEewImpl>
      get copyWith => __$$NotificationRemoteSettingsEewImplCopyWithImpl<
          _$NotificationRemoteSettingsEewImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationRemoteSettingsEewImplToJson(
      this,
    );
  }
}

abstract class _NotificationRemoteSettingsEew
    implements NotificationRemoteSettingsEew {
  const factory _NotificationRemoteSettingsEew(
          {required final JmaForecastIntensity? global,
          required final List<NotificationRemoteSettingsEewRegion> regions}) =
      _$NotificationRemoteSettingsEewImpl;

  factory _NotificationRemoteSettingsEew.fromJson(Map<String, dynamic> json) =
      _$NotificationRemoteSettingsEewImpl.fromJson;

  @override
  JmaForecastIntensity? get global;
  @override
  List<NotificationRemoteSettingsEewRegion> get regions;
  @override
  @JsonKey(ignore: true)
  _$$NotificationRemoteSettingsEewImplCopyWith<
          _$NotificationRemoteSettingsEewImpl>
      get copyWith => throw _privateConstructorUsedError;
}

NotificationRemoteSettingsEewRegion
    _$NotificationRemoteSettingsEewRegionFromJson(Map<String, dynamic> json) {
  return _NotificationRemoteSettingsEewRegion.fromJson(json);
}

/// @nodoc
mixin _$NotificationRemoteSettingsEewRegion {
  int get regionId => throw _privateConstructorUsedError;
  JmaForecastIntensity get minJmaIntensity =>
      throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationRemoteSettingsEewRegionCopyWith<
          NotificationRemoteSettingsEewRegion>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationRemoteSettingsEewRegionCopyWith<$Res> {
  factory $NotificationRemoteSettingsEewRegionCopyWith(
          NotificationRemoteSettingsEewRegion value,
          $Res Function(NotificationRemoteSettingsEewRegion) then) =
      _$NotificationRemoteSettingsEewRegionCopyWithImpl<$Res,
          NotificationRemoteSettingsEewRegion>;
  @useResult
  $Res call({int regionId, JmaForecastIntensity minJmaIntensity, String name});
}

/// @nodoc
class _$NotificationRemoteSettingsEewRegionCopyWithImpl<$Res,
        $Val extends NotificationRemoteSettingsEewRegion>
    implements $NotificationRemoteSettingsEewRegionCopyWith<$Res> {
  _$NotificationRemoteSettingsEewRegionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? regionId = null,
    Object? minJmaIntensity = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      regionId: null == regionId
          ? _value.regionId
          : regionId // ignore: cast_nullable_to_non_nullable
              as int,
      minJmaIntensity: null == minJmaIntensity
          ? _value.minJmaIntensity
          : minJmaIntensity // ignore: cast_nullable_to_non_nullable
              as JmaForecastIntensity,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationRemoteSettingsEewRegionImplCopyWith<$Res>
    implements $NotificationRemoteSettingsEewRegionCopyWith<$Res> {
  factory _$$NotificationRemoteSettingsEewRegionImplCopyWith(
          _$NotificationRemoteSettingsEewRegionImpl value,
          $Res Function(_$NotificationRemoteSettingsEewRegionImpl) then) =
      __$$NotificationRemoteSettingsEewRegionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int regionId, JmaForecastIntensity minJmaIntensity, String name});
}

/// @nodoc
class __$$NotificationRemoteSettingsEewRegionImplCopyWithImpl<$Res>
    extends _$NotificationRemoteSettingsEewRegionCopyWithImpl<$Res,
        _$NotificationRemoteSettingsEewRegionImpl>
    implements _$$NotificationRemoteSettingsEewRegionImplCopyWith<$Res> {
  __$$NotificationRemoteSettingsEewRegionImplCopyWithImpl(
      _$NotificationRemoteSettingsEewRegionImpl _value,
      $Res Function(_$NotificationRemoteSettingsEewRegionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? regionId = null,
    Object? minJmaIntensity = null,
    Object? name = null,
  }) {
    return _then(_$NotificationRemoteSettingsEewRegionImpl(
      regionId: null == regionId
          ? _value.regionId
          : regionId // ignore: cast_nullable_to_non_nullable
              as int,
      minJmaIntensity: null == minJmaIntensity
          ? _value.minJmaIntensity
          : minJmaIntensity // ignore: cast_nullable_to_non_nullable
              as JmaForecastIntensity,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationRemoteSettingsEewRegionImpl
    implements _NotificationRemoteSettingsEewRegion {
  const _$NotificationRemoteSettingsEewRegionImpl(
      {required this.regionId,
      required this.minJmaIntensity,
      required this.name});

  factory _$NotificationRemoteSettingsEewRegionImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$NotificationRemoteSettingsEewRegionImplFromJson(json);

  @override
  final int regionId;
  @override
  final JmaForecastIntensity minJmaIntensity;
  @override
  final String name;

  @override
  String toString() {
    return 'NotificationRemoteSettingsEewRegion(regionId: $regionId, minJmaIntensity: $minJmaIntensity, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationRemoteSettingsEewRegionImpl &&
            (identical(other.regionId, regionId) ||
                other.regionId == regionId) &&
            (identical(other.minJmaIntensity, minJmaIntensity) ||
                other.minJmaIntensity == minJmaIntensity) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, regionId, minJmaIntensity, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationRemoteSettingsEewRegionImplCopyWith<
          _$NotificationRemoteSettingsEewRegionImpl>
      get copyWith => __$$NotificationRemoteSettingsEewRegionImplCopyWithImpl<
          _$NotificationRemoteSettingsEewRegionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationRemoteSettingsEewRegionImplToJson(
      this,
    );
  }
}

abstract class _NotificationRemoteSettingsEewRegion
    implements NotificationRemoteSettingsEewRegion {
  const factory _NotificationRemoteSettingsEewRegion(
      {required final int regionId,
      required final JmaForecastIntensity minJmaIntensity,
      required final String name}) = _$NotificationRemoteSettingsEewRegionImpl;

  factory _NotificationRemoteSettingsEewRegion.fromJson(
          Map<String, dynamic> json) =
      _$NotificationRemoteSettingsEewRegionImpl.fromJson;

  @override
  int get regionId;
  @override
  JmaForecastIntensity get minJmaIntensity;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$NotificationRemoteSettingsEewRegionImplCopyWith<
          _$NotificationRemoteSettingsEewRegionImpl>
      get copyWith => throw _privateConstructorUsedError;
}

NotificationRemoteSettingsEarthquake
    _$NotificationRemoteSettingsEarthquakeFromJson(Map<String, dynamic> json) {
  return _NotificationRemoteSettingsEarthquake.fromJson(json);
}

/// @nodoc
mixin _$NotificationRemoteSettingsEarthquake {
  JmaForecastIntensity? get global => throw _privateConstructorUsedError;
  List<NotificationRemoteSettingsEarthquakeRegion> get regions =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationRemoteSettingsEarthquakeCopyWith<
          NotificationRemoteSettingsEarthquake>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationRemoteSettingsEarthquakeCopyWith<$Res> {
  factory $NotificationRemoteSettingsEarthquakeCopyWith(
          NotificationRemoteSettingsEarthquake value,
          $Res Function(NotificationRemoteSettingsEarthquake) then) =
      _$NotificationRemoteSettingsEarthquakeCopyWithImpl<$Res,
          NotificationRemoteSettingsEarthquake>;
  @useResult
  $Res call(
      {JmaForecastIntensity? global,
      List<NotificationRemoteSettingsEarthquakeRegion> regions});
}

/// @nodoc
class _$NotificationRemoteSettingsEarthquakeCopyWithImpl<$Res,
        $Val extends NotificationRemoteSettingsEarthquake>
    implements $NotificationRemoteSettingsEarthquakeCopyWith<$Res> {
  _$NotificationRemoteSettingsEarthquakeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? global = freezed,
    Object? regions = null,
  }) {
    return _then(_value.copyWith(
      global: freezed == global
          ? _value.global
          : global // ignore: cast_nullable_to_non_nullable
              as JmaForecastIntensity?,
      regions: null == regions
          ? _value.regions
          : regions // ignore: cast_nullable_to_non_nullable
              as List<NotificationRemoteSettingsEarthquakeRegion>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationRemoteSettingsEarthquakeImplCopyWith<$Res>
    implements $NotificationRemoteSettingsEarthquakeCopyWith<$Res> {
  factory _$$NotificationRemoteSettingsEarthquakeImplCopyWith(
          _$NotificationRemoteSettingsEarthquakeImpl value,
          $Res Function(_$NotificationRemoteSettingsEarthquakeImpl) then) =
      __$$NotificationRemoteSettingsEarthquakeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {JmaForecastIntensity? global,
      List<NotificationRemoteSettingsEarthquakeRegion> regions});
}

/// @nodoc
class __$$NotificationRemoteSettingsEarthquakeImplCopyWithImpl<$Res>
    extends _$NotificationRemoteSettingsEarthquakeCopyWithImpl<$Res,
        _$NotificationRemoteSettingsEarthquakeImpl>
    implements _$$NotificationRemoteSettingsEarthquakeImplCopyWith<$Res> {
  __$$NotificationRemoteSettingsEarthquakeImplCopyWithImpl(
      _$NotificationRemoteSettingsEarthquakeImpl _value,
      $Res Function(_$NotificationRemoteSettingsEarthquakeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? global = freezed,
    Object? regions = null,
  }) {
    return _then(_$NotificationRemoteSettingsEarthquakeImpl(
      global: freezed == global
          ? _value.global
          : global // ignore: cast_nullable_to_non_nullable
              as JmaForecastIntensity?,
      regions: null == regions
          ? _value._regions
          : regions // ignore: cast_nullable_to_non_nullable
              as List<NotificationRemoteSettingsEarthquakeRegion>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationRemoteSettingsEarthquakeImpl
    implements _NotificationRemoteSettingsEarthquake {
  const _$NotificationRemoteSettingsEarthquakeImpl(
      {required this.global,
      required final List<NotificationRemoteSettingsEarthquakeRegion> regions})
      : _regions = regions;

  factory _$NotificationRemoteSettingsEarthquakeImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$NotificationRemoteSettingsEarthquakeImplFromJson(json);

  @override
  final JmaForecastIntensity? global;
  final List<NotificationRemoteSettingsEarthquakeRegion> _regions;
  @override
  List<NotificationRemoteSettingsEarthquakeRegion> get regions {
    if (_regions is EqualUnmodifiableListView) return _regions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_regions);
  }

  @override
  String toString() {
    return 'NotificationRemoteSettingsEarthquake(global: $global, regions: $regions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationRemoteSettingsEarthquakeImpl &&
            (identical(other.global, global) || other.global == global) &&
            const DeepCollectionEquality().equals(other._regions, _regions));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, global, const DeepCollectionEquality().hash(_regions));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationRemoteSettingsEarthquakeImplCopyWith<
          _$NotificationRemoteSettingsEarthquakeImpl>
      get copyWith => __$$NotificationRemoteSettingsEarthquakeImplCopyWithImpl<
          _$NotificationRemoteSettingsEarthquakeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationRemoteSettingsEarthquakeImplToJson(
      this,
    );
  }
}

abstract class _NotificationRemoteSettingsEarthquake
    implements NotificationRemoteSettingsEarthquake {
  const factory _NotificationRemoteSettingsEarthquake(
      {required final JmaForecastIntensity? global,
      required final List<NotificationRemoteSettingsEarthquakeRegion>
          regions}) = _$NotificationRemoteSettingsEarthquakeImpl;

  factory _NotificationRemoteSettingsEarthquake.fromJson(
          Map<String, dynamic> json) =
      _$NotificationRemoteSettingsEarthquakeImpl.fromJson;

  @override
  JmaForecastIntensity? get global;
  @override
  List<NotificationRemoteSettingsEarthquakeRegion> get regions;
  @override
  @JsonKey(ignore: true)
  _$$NotificationRemoteSettingsEarthquakeImplCopyWith<
          _$NotificationRemoteSettingsEarthquakeImpl>
      get copyWith => throw _privateConstructorUsedError;
}

NotificationRemoteSettingsEarthquakeRegion
    _$NotificationRemoteSettingsEarthquakeRegionFromJson(
        Map<String, dynamic> json) {
  return _NotificationRemoteSettingsEarthquakeRegion.fromJson(json);
}

/// @nodoc
mixin _$NotificationRemoteSettingsEarthquakeRegion {
  int get regionId => throw _privateConstructorUsedError;
  JmaForecastIntensity get minJmaIntensity =>
      throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationRemoteSettingsEarthquakeRegionCopyWith<
          NotificationRemoteSettingsEarthquakeRegion>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationRemoteSettingsEarthquakeRegionCopyWith<$Res> {
  factory $NotificationRemoteSettingsEarthquakeRegionCopyWith(
          NotificationRemoteSettingsEarthquakeRegion value,
          $Res Function(NotificationRemoteSettingsEarthquakeRegion) then) =
      _$NotificationRemoteSettingsEarthquakeRegionCopyWithImpl<$Res,
          NotificationRemoteSettingsEarthquakeRegion>;
  @useResult
  $Res call({int regionId, JmaForecastIntensity minJmaIntensity, String name});
}

/// @nodoc
class _$NotificationRemoteSettingsEarthquakeRegionCopyWithImpl<$Res,
        $Val extends NotificationRemoteSettingsEarthquakeRegion>
    implements $NotificationRemoteSettingsEarthquakeRegionCopyWith<$Res> {
  _$NotificationRemoteSettingsEarthquakeRegionCopyWithImpl(
      this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? regionId = null,
    Object? minJmaIntensity = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      regionId: null == regionId
          ? _value.regionId
          : regionId // ignore: cast_nullable_to_non_nullable
              as int,
      minJmaIntensity: null == minJmaIntensity
          ? _value.minJmaIntensity
          : minJmaIntensity // ignore: cast_nullable_to_non_nullable
              as JmaForecastIntensity,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationRemoteSettingsEarthquakeRegionImplCopyWith<$Res>
    implements $NotificationRemoteSettingsEarthquakeRegionCopyWith<$Res> {
  factory _$$NotificationRemoteSettingsEarthquakeRegionImplCopyWith(
          _$NotificationRemoteSettingsEarthquakeRegionImpl value,
          $Res Function(_$NotificationRemoteSettingsEarthquakeRegionImpl)
              then) =
      __$$NotificationRemoteSettingsEarthquakeRegionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int regionId, JmaForecastIntensity minJmaIntensity, String name});
}

/// @nodoc
class __$$NotificationRemoteSettingsEarthquakeRegionImplCopyWithImpl<$Res>
    extends _$NotificationRemoteSettingsEarthquakeRegionCopyWithImpl<$Res,
        _$NotificationRemoteSettingsEarthquakeRegionImpl>
    implements _$$NotificationRemoteSettingsEarthquakeRegionImplCopyWith<$Res> {
  __$$NotificationRemoteSettingsEarthquakeRegionImplCopyWithImpl(
      _$NotificationRemoteSettingsEarthquakeRegionImpl _value,
      $Res Function(_$NotificationRemoteSettingsEarthquakeRegionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? regionId = null,
    Object? minJmaIntensity = null,
    Object? name = null,
  }) {
    return _then(_$NotificationRemoteSettingsEarthquakeRegionImpl(
      regionId: null == regionId
          ? _value.regionId
          : regionId // ignore: cast_nullable_to_non_nullable
              as int,
      minJmaIntensity: null == minJmaIntensity
          ? _value.minJmaIntensity
          : minJmaIntensity // ignore: cast_nullable_to_non_nullable
              as JmaForecastIntensity,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationRemoteSettingsEarthquakeRegionImpl
    implements _NotificationRemoteSettingsEarthquakeRegion {
  const _$NotificationRemoteSettingsEarthquakeRegionImpl(
      {required this.regionId,
      required this.minJmaIntensity,
      required this.name});

  factory _$NotificationRemoteSettingsEarthquakeRegionImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$NotificationRemoteSettingsEarthquakeRegionImplFromJson(json);

  @override
  final int regionId;
  @override
  final JmaForecastIntensity minJmaIntensity;
  @override
  final String name;

  @override
  String toString() {
    return 'NotificationRemoteSettingsEarthquakeRegion(regionId: $regionId, minJmaIntensity: $minJmaIntensity, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationRemoteSettingsEarthquakeRegionImpl &&
            (identical(other.regionId, regionId) ||
                other.regionId == regionId) &&
            (identical(other.minJmaIntensity, minJmaIntensity) ||
                other.minJmaIntensity == minJmaIntensity) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, regionId, minJmaIntensity, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationRemoteSettingsEarthquakeRegionImplCopyWith<
          _$NotificationRemoteSettingsEarthquakeRegionImpl>
      get copyWith =>
          __$$NotificationRemoteSettingsEarthquakeRegionImplCopyWithImpl<
                  _$NotificationRemoteSettingsEarthquakeRegionImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationRemoteSettingsEarthquakeRegionImplToJson(
      this,
    );
  }
}

abstract class _NotificationRemoteSettingsEarthquakeRegion
    implements NotificationRemoteSettingsEarthquakeRegion {
  const factory _NotificationRemoteSettingsEarthquakeRegion(
          {required final int regionId,
          required final JmaForecastIntensity minJmaIntensity,
          required final String name}) =
      _$NotificationRemoteSettingsEarthquakeRegionImpl;

  factory _NotificationRemoteSettingsEarthquakeRegion.fromJson(
          Map<String, dynamic> json) =
      _$NotificationRemoteSettingsEarthquakeRegionImpl.fromJson;

  @override
  int get regionId;
  @override
  JmaForecastIntensity get minJmaIntensity;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$NotificationRemoteSettingsEarthquakeRegionImplCopyWith<
          _$NotificationRemoteSettingsEarthquakeRegionImpl>
      get copyWith => throw _privateConstructorUsedError;
}
