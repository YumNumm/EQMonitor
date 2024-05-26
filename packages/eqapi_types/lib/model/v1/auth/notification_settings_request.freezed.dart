// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_settings_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NotificationSettingsRequest _$NotificationSettingsRequestFromJson(
    Map<String, dynamic> json) {
  return _NotificationSettingsRequest.fromJson(json);
}

/// @nodoc
mixin _$NotificationSettingsRequest {
  NotificationSettingsGlobal? get global => throw _privateConstructorUsedError;
  List<NotificationSettingsRegion>? get regions =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationSettingsRequestCopyWith<NotificationSettingsRequest>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationSettingsRequestCopyWith<$Res> {
  factory $NotificationSettingsRequestCopyWith(
          NotificationSettingsRequest value,
          $Res Function(NotificationSettingsRequest) then) =
      _$NotificationSettingsRequestCopyWithImpl<$Res,
          NotificationSettingsRequest>;
  @useResult
  $Res call(
      {NotificationSettingsGlobal? global,
      List<NotificationSettingsRegion>? regions});

  $NotificationSettingsGlobalCopyWith<$Res>? get global;
}

/// @nodoc
class _$NotificationSettingsRequestCopyWithImpl<$Res,
        $Val extends NotificationSettingsRequest>
    implements $NotificationSettingsRequestCopyWith<$Res> {
  _$NotificationSettingsRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? global = freezed,
    Object? regions = freezed,
  }) {
    return _then(_value.copyWith(
      global: freezed == global
          ? _value.global
          : global // ignore: cast_nullable_to_non_nullable
              as NotificationSettingsGlobal?,
      regions: freezed == regions
          ? _value.regions
          : regions // ignore: cast_nullable_to_non_nullable
              as List<NotificationSettingsRegion>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $NotificationSettingsGlobalCopyWith<$Res>? get global {
    if (_value.global == null) {
      return null;
    }

    return $NotificationSettingsGlobalCopyWith<$Res>(_value.global!, (value) {
      return _then(_value.copyWith(global: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NotificationSettingsRequestImplCopyWith<$Res>
    implements $NotificationSettingsRequestCopyWith<$Res> {
  factory _$$NotificationSettingsRequestImplCopyWith(
          _$NotificationSettingsRequestImpl value,
          $Res Function(_$NotificationSettingsRequestImpl) then) =
      __$$NotificationSettingsRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {NotificationSettingsGlobal? global,
      List<NotificationSettingsRegion>? regions});

  @override
  $NotificationSettingsGlobalCopyWith<$Res>? get global;
}

/// @nodoc
class __$$NotificationSettingsRequestImplCopyWithImpl<$Res>
    extends _$NotificationSettingsRequestCopyWithImpl<$Res,
        _$NotificationSettingsRequestImpl>
    implements _$$NotificationSettingsRequestImplCopyWith<$Res> {
  __$$NotificationSettingsRequestImplCopyWithImpl(
      _$NotificationSettingsRequestImpl _value,
      $Res Function(_$NotificationSettingsRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? global = freezed,
    Object? regions = freezed,
  }) {
    return _then(_$NotificationSettingsRequestImpl(
      global: freezed == global
          ? _value.global
          : global // ignore: cast_nullable_to_non_nullable
              as NotificationSettingsGlobal?,
      regions: freezed == regions
          ? _value._regions
          : regions // ignore: cast_nullable_to_non_nullable
              as List<NotificationSettingsRegion>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationSettingsRequestImpl
    implements _NotificationSettingsRequest {
  const _$NotificationSettingsRequestImpl(
      {this.global, final List<NotificationSettingsRegion>? regions})
      : _regions = regions;

  factory _$NotificationSettingsRequestImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$NotificationSettingsRequestImplFromJson(json);

  @override
  final NotificationSettingsGlobal? global;
  final List<NotificationSettingsRegion>? _regions;
  @override
  List<NotificationSettingsRegion>? get regions {
    final value = _regions;
    if (value == null) return null;
    if (_regions is EqualUnmodifiableListView) return _regions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'NotificationSettingsRequest(global: $global, regions: $regions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationSettingsRequestImpl &&
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
  _$$NotificationSettingsRequestImplCopyWith<_$NotificationSettingsRequestImpl>
      get copyWith => __$$NotificationSettingsRequestImplCopyWithImpl<
          _$NotificationSettingsRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationSettingsRequestImplToJson(
      this,
    );
  }
}

abstract class _NotificationSettingsRequest
    implements NotificationSettingsRequest {
  const factory _NotificationSettingsRequest(
          {final NotificationSettingsGlobal? global,
          final List<NotificationSettingsRegion>? regions}) =
      _$NotificationSettingsRequestImpl;

  factory _NotificationSettingsRequest.fromJson(Map<String, dynamic> json) =
      _$NotificationSettingsRequestImpl.fromJson;

  @override
  NotificationSettingsGlobal? get global;
  @override
  List<NotificationSettingsRegion>? get regions;
  @override
  @JsonKey(ignore: true)
  _$$NotificationSettingsRequestImplCopyWith<_$NotificationSettingsRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

NotificationSettingsGlobal _$NotificationSettingsGlobalFromJson(
    Map<String, dynamic> json) {
  return _NotificationSettingsGlobal.fromJson(json);
}

/// @nodoc
mixin _$NotificationSettingsGlobal {
  JmaForecastIntensity get minJmaIntensity =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationSettingsGlobalCopyWith<NotificationSettingsGlobal>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationSettingsGlobalCopyWith<$Res> {
  factory $NotificationSettingsGlobalCopyWith(NotificationSettingsGlobal value,
          $Res Function(NotificationSettingsGlobal) then) =
      _$NotificationSettingsGlobalCopyWithImpl<$Res,
          NotificationSettingsGlobal>;
  @useResult
  $Res call({JmaForecastIntensity minJmaIntensity});
}

/// @nodoc
class _$NotificationSettingsGlobalCopyWithImpl<$Res,
        $Val extends NotificationSettingsGlobal>
    implements $NotificationSettingsGlobalCopyWith<$Res> {
  _$NotificationSettingsGlobalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? minJmaIntensity = null,
  }) {
    return _then(_value.copyWith(
      minJmaIntensity: null == minJmaIntensity
          ? _value.minJmaIntensity
          : minJmaIntensity // ignore: cast_nullable_to_non_nullable
              as JmaForecastIntensity,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationSettingsGlobalImplCopyWith<$Res>
    implements $NotificationSettingsGlobalCopyWith<$Res> {
  factory _$$NotificationSettingsGlobalImplCopyWith(
          _$NotificationSettingsGlobalImpl value,
          $Res Function(_$NotificationSettingsGlobalImpl) then) =
      __$$NotificationSettingsGlobalImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({JmaForecastIntensity minJmaIntensity});
}

/// @nodoc
class __$$NotificationSettingsGlobalImplCopyWithImpl<$Res>
    extends _$NotificationSettingsGlobalCopyWithImpl<$Res,
        _$NotificationSettingsGlobalImpl>
    implements _$$NotificationSettingsGlobalImplCopyWith<$Res> {
  __$$NotificationSettingsGlobalImplCopyWithImpl(
      _$NotificationSettingsGlobalImpl _value,
      $Res Function(_$NotificationSettingsGlobalImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? minJmaIntensity = null,
  }) {
    return _then(_$NotificationSettingsGlobalImpl(
      minJmaIntensity: null == minJmaIntensity
          ? _value.minJmaIntensity
          : minJmaIntensity // ignore: cast_nullable_to_non_nullable
              as JmaForecastIntensity,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationSettingsGlobalImpl implements _NotificationSettingsGlobal {
  const _$NotificationSettingsGlobalImpl({required this.minJmaIntensity});

  factory _$NotificationSettingsGlobalImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$NotificationSettingsGlobalImplFromJson(json);

  @override
  final JmaForecastIntensity minJmaIntensity;

  @override
  String toString() {
    return 'NotificationSettingsGlobal(minJmaIntensity: $minJmaIntensity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationSettingsGlobalImpl &&
            (identical(other.minJmaIntensity, minJmaIntensity) ||
                other.minJmaIntensity == minJmaIntensity));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, minJmaIntensity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationSettingsGlobalImplCopyWith<_$NotificationSettingsGlobalImpl>
      get copyWith => __$$NotificationSettingsGlobalImplCopyWithImpl<
          _$NotificationSettingsGlobalImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationSettingsGlobalImplToJson(
      this,
    );
  }
}

abstract class _NotificationSettingsGlobal
    implements NotificationSettingsGlobal {
  const factory _NotificationSettingsGlobal(
          {required final JmaForecastIntensity minJmaIntensity}) =
      _$NotificationSettingsGlobalImpl;

  factory _NotificationSettingsGlobal.fromJson(Map<String, dynamic> json) =
      _$NotificationSettingsGlobalImpl.fromJson;

  @override
  JmaForecastIntensity get minJmaIntensity;
  @override
  @JsonKey(ignore: true)
  _$$NotificationSettingsGlobalImplCopyWith<_$NotificationSettingsGlobalImpl>
      get copyWith => throw _privateConstructorUsedError;
}

NotificationSettingsRegion _$NotificationSettingsRegionFromJson(
    Map<String, dynamic> json) {
  return _NotificationSettingsRegion.fromJson(json);
}

/// @nodoc
mixin _$NotificationSettingsRegion {
  int get code => throw _privateConstructorUsedError;
  JmaForecastIntensity get minIntensity => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationSettingsRegionCopyWith<NotificationSettingsRegion>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationSettingsRegionCopyWith<$Res> {
  factory $NotificationSettingsRegionCopyWith(NotificationSettingsRegion value,
          $Res Function(NotificationSettingsRegion) then) =
      _$NotificationSettingsRegionCopyWithImpl<$Res,
          NotificationSettingsRegion>;
  @useResult
  $Res call({int code, JmaForecastIntensity minIntensity});
}

/// @nodoc
class _$NotificationSettingsRegionCopyWithImpl<$Res,
        $Val extends NotificationSettingsRegion>
    implements $NotificationSettingsRegionCopyWith<$Res> {
  _$NotificationSettingsRegionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? minIntensity = null,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
      minIntensity: null == minIntensity
          ? _value.minIntensity
          : minIntensity // ignore: cast_nullable_to_non_nullable
              as JmaForecastIntensity,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationSettingsRegionImplCopyWith<$Res>
    implements $NotificationSettingsRegionCopyWith<$Res> {
  factory _$$NotificationSettingsRegionImplCopyWith(
          _$NotificationSettingsRegionImpl value,
          $Res Function(_$NotificationSettingsRegionImpl) then) =
      __$$NotificationSettingsRegionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int code, JmaForecastIntensity minIntensity});
}

/// @nodoc
class __$$NotificationSettingsRegionImplCopyWithImpl<$Res>
    extends _$NotificationSettingsRegionCopyWithImpl<$Res,
        _$NotificationSettingsRegionImpl>
    implements _$$NotificationSettingsRegionImplCopyWith<$Res> {
  __$$NotificationSettingsRegionImplCopyWithImpl(
      _$NotificationSettingsRegionImpl _value,
      $Res Function(_$NotificationSettingsRegionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? minIntensity = null,
  }) {
    return _then(_$NotificationSettingsRegionImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
      minIntensity: null == minIntensity
          ? _value.minIntensity
          : minIntensity // ignore: cast_nullable_to_non_nullable
              as JmaForecastIntensity,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationSettingsRegionImpl implements _NotificationSettingsRegion {
  const _$NotificationSettingsRegionImpl(
      {required this.code, required this.minIntensity});

  factory _$NotificationSettingsRegionImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$NotificationSettingsRegionImplFromJson(json);

  @override
  final int code;
  @override
  final JmaForecastIntensity minIntensity;

  @override
  String toString() {
    return 'NotificationSettingsRegion(code: $code, minIntensity: $minIntensity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationSettingsRegionImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.minIntensity, minIntensity) ||
                other.minIntensity == minIntensity));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code, minIntensity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationSettingsRegionImplCopyWith<_$NotificationSettingsRegionImpl>
      get copyWith => __$$NotificationSettingsRegionImplCopyWithImpl<
          _$NotificationSettingsRegionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationSettingsRegionImplToJson(
      this,
    );
  }
}

abstract class _NotificationSettingsRegion
    implements NotificationSettingsRegion {
  const factory _NotificationSettingsRegion(
          {required final int code,
          required final JmaForecastIntensity minIntensity}) =
      _$NotificationSettingsRegionImpl;

  factory _NotificationSettingsRegion.fromJson(Map<String, dynamic> json) =
      _$NotificationSettingsRegionImpl.fromJson;

  @override
  int get code;
  @override
  JmaForecastIntensity get minIntensity;
  @override
  @JsonKey(ignore: true)
  _$$NotificationSettingsRegionImplCopyWith<_$NotificationSettingsRegionImpl>
      get copyWith => throw _privateConstructorUsedError;
}
