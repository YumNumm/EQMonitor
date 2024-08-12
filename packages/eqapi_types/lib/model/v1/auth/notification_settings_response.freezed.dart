// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_settings_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NotificationSettingsResponse _$NotificationSettingsResponseFromJson(
    Map<String, dynamic> json) {
  return _NotificationSettingsResponse.fromJson(json);
}

/// @nodoc
mixin _$NotificationSettingsResponse {
  List<DevicesEarthquakeSettings> get earthquake =>
      throw _privateConstructorUsedError;
  List<DevicesEewSettings> get eew => throw _privateConstructorUsedError;

  /// Serializes this NotificationSettingsResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NotificationSettingsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationSettingsResponseCopyWith<NotificationSettingsResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationSettingsResponseCopyWith<$Res> {
  factory $NotificationSettingsResponseCopyWith(
          NotificationSettingsResponse value,
          $Res Function(NotificationSettingsResponse) then) =
      _$NotificationSettingsResponseCopyWithImpl<$Res,
          NotificationSettingsResponse>;
  @useResult
  $Res call(
      {List<DevicesEarthquakeSettings> earthquake,
      List<DevicesEewSettings> eew});
}

/// @nodoc
class _$NotificationSettingsResponseCopyWithImpl<$Res,
        $Val extends NotificationSettingsResponse>
    implements $NotificationSettingsResponseCopyWith<$Res> {
  _$NotificationSettingsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationSettingsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? earthquake = null,
    Object? eew = null,
  }) {
    return _then(_value.copyWith(
      earthquake: null == earthquake
          ? _value.earthquake
          : earthquake // ignore: cast_nullable_to_non_nullable
              as List<DevicesEarthquakeSettings>,
      eew: null == eew
          ? _value.eew
          : eew // ignore: cast_nullable_to_non_nullable
              as List<DevicesEewSettings>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationSettingsResponseImplCopyWith<$Res>
    implements $NotificationSettingsResponseCopyWith<$Res> {
  factory _$$NotificationSettingsResponseImplCopyWith(
          _$NotificationSettingsResponseImpl value,
          $Res Function(_$NotificationSettingsResponseImpl) then) =
      __$$NotificationSettingsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<DevicesEarthquakeSettings> earthquake,
      List<DevicesEewSettings> eew});
}

/// @nodoc
class __$$NotificationSettingsResponseImplCopyWithImpl<$Res>
    extends _$NotificationSettingsResponseCopyWithImpl<$Res,
        _$NotificationSettingsResponseImpl>
    implements _$$NotificationSettingsResponseImplCopyWith<$Res> {
  __$$NotificationSettingsResponseImplCopyWithImpl(
      _$NotificationSettingsResponseImpl _value,
      $Res Function(_$NotificationSettingsResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of NotificationSettingsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? earthquake = null,
    Object? eew = null,
  }) {
    return _then(_$NotificationSettingsResponseImpl(
      earthquake: null == earthquake
          ? _value._earthquake
          : earthquake // ignore: cast_nullable_to_non_nullable
              as List<DevicesEarthquakeSettings>,
      eew: null == eew
          ? _value._eew
          : eew // ignore: cast_nullable_to_non_nullable
              as List<DevicesEewSettings>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationSettingsResponseImpl
    implements _NotificationSettingsResponse {
  const _$NotificationSettingsResponseImpl(
      {required final List<DevicesEarthquakeSettings> earthquake,
      required final List<DevicesEewSettings> eew})
      : _earthquake = earthquake,
        _eew = eew;

  factory _$NotificationSettingsResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$NotificationSettingsResponseImplFromJson(json);

  final List<DevicesEarthquakeSettings> _earthquake;
  @override
  List<DevicesEarthquakeSettings> get earthquake {
    if (_earthquake is EqualUnmodifiableListView) return _earthquake;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_earthquake);
  }

  final List<DevicesEewSettings> _eew;
  @override
  List<DevicesEewSettings> get eew {
    if (_eew is EqualUnmodifiableListView) return _eew;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_eew);
  }

  @override
  String toString() {
    return 'NotificationSettingsResponse(earthquake: $earthquake, eew: $eew)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationSettingsResponseImpl &&
            const DeepCollectionEquality()
                .equals(other._earthquake, _earthquake) &&
            const DeepCollectionEquality().equals(other._eew, _eew));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_earthquake),
      const DeepCollectionEquality().hash(_eew));

  /// Create a copy of NotificationSettingsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationSettingsResponseImplCopyWith<
          _$NotificationSettingsResponseImpl>
      get copyWith => __$$NotificationSettingsResponseImplCopyWithImpl<
          _$NotificationSettingsResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationSettingsResponseImplToJson(
      this,
    );
  }
}

abstract class _NotificationSettingsResponse
    implements NotificationSettingsResponse {
  const factory _NotificationSettingsResponse(
          {required final List<DevicesEarthquakeSettings> earthquake,
          required final List<DevicesEewSettings> eew}) =
      _$NotificationSettingsResponseImpl;

  factory _NotificationSettingsResponse.fromJson(Map<String, dynamic> json) =
      _$NotificationSettingsResponseImpl.fromJson;

  @override
  List<DevicesEarthquakeSettings> get earthquake;
  @override
  List<DevicesEewSettings> get eew;

  /// Create a copy of NotificationSettingsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationSettingsResponseImplCopyWith<
          _$NotificationSettingsResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
