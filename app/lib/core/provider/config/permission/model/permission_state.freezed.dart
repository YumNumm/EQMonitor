// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'permission_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PermissionStateModel _$PermissionStateModelFromJson(Map<String, dynamic> json) {
  return _PermissionStateModel.fromJson(json);
}

/// @nodoc
mixin _$PermissionStateModel {
  bool get notification => throw _privateConstructorUsedError;
  bool get criticalAlert => throw _privateConstructorUsedError;
  bool get location => throw _privateConstructorUsedError;
  bool get backgroundLocation => throw _privateConstructorUsedError;

  /// Serializes this PermissionStateModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PermissionStateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PermissionStateModelCopyWith<PermissionStateModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PermissionStateModelCopyWith<$Res> {
  factory $PermissionStateModelCopyWith(PermissionStateModel value,
          $Res Function(PermissionStateModel) then) =
      _$PermissionStateModelCopyWithImpl<$Res, PermissionStateModel>;
  @useResult
  $Res call(
      {bool notification,
      bool criticalAlert,
      bool location,
      bool backgroundLocation});
}

/// @nodoc
class _$PermissionStateModelCopyWithImpl<$Res,
        $Val extends PermissionStateModel>
    implements $PermissionStateModelCopyWith<$Res> {
  _$PermissionStateModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PermissionStateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notification = null,
    Object? criticalAlert = null,
    Object? location = null,
    Object? backgroundLocation = null,
  }) {
    return _then(_value.copyWith(
      notification: null == notification
          ? _value.notification
          : notification // ignore: cast_nullable_to_non_nullable
              as bool,
      criticalAlert: null == criticalAlert
          ? _value.criticalAlert
          : criticalAlert // ignore: cast_nullable_to_non_nullable
              as bool,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as bool,
      backgroundLocation: null == backgroundLocation
          ? _value.backgroundLocation
          : backgroundLocation // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PermissionStateModelImplCopyWith<$Res>
    implements $PermissionStateModelCopyWith<$Res> {
  factory _$$PermissionStateModelImplCopyWith(_$PermissionStateModelImpl value,
          $Res Function(_$PermissionStateModelImpl) then) =
      __$$PermissionStateModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool notification,
      bool criticalAlert,
      bool location,
      bool backgroundLocation});
}

/// @nodoc
class __$$PermissionStateModelImplCopyWithImpl<$Res>
    extends _$PermissionStateModelCopyWithImpl<$Res, _$PermissionStateModelImpl>
    implements _$$PermissionStateModelImplCopyWith<$Res> {
  __$$PermissionStateModelImplCopyWithImpl(_$PermissionStateModelImpl _value,
      $Res Function(_$PermissionStateModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PermissionStateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notification = null,
    Object? criticalAlert = null,
    Object? location = null,
    Object? backgroundLocation = null,
  }) {
    return _then(_$PermissionStateModelImpl(
      notification: null == notification
          ? _value.notification
          : notification // ignore: cast_nullable_to_non_nullable
              as bool,
      criticalAlert: null == criticalAlert
          ? _value.criticalAlert
          : criticalAlert // ignore: cast_nullable_to_non_nullable
              as bool,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as bool,
      backgroundLocation: null == backgroundLocation
          ? _value.backgroundLocation
          : backgroundLocation // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PermissionStateModelImpl implements _PermissionStateModel {
  const _$PermissionStateModelImpl(
      {this.notification = false,
      this.criticalAlert = false,
      this.location = false,
      this.backgroundLocation = false});

  factory _$PermissionStateModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PermissionStateModelImplFromJson(json);

  @override
  @JsonKey()
  final bool notification;
  @override
  @JsonKey()
  final bool criticalAlert;
  @override
  @JsonKey()
  final bool location;
  @override
  @JsonKey()
  final bool backgroundLocation;

  @override
  String toString() {
    return 'PermissionStateModel(notification: $notification, criticalAlert: $criticalAlert, location: $location, backgroundLocation: $backgroundLocation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PermissionStateModelImpl &&
            (identical(other.notification, notification) ||
                other.notification == notification) &&
            (identical(other.criticalAlert, criticalAlert) ||
                other.criticalAlert == criticalAlert) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.backgroundLocation, backgroundLocation) ||
                other.backgroundLocation == backgroundLocation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, notification, criticalAlert, location, backgroundLocation);

  /// Create a copy of PermissionStateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PermissionStateModelImplCopyWith<_$PermissionStateModelImpl>
      get copyWith =>
          __$$PermissionStateModelImplCopyWithImpl<_$PermissionStateModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PermissionStateModelImplToJson(
      this,
    );
  }
}

abstract class _PermissionStateModel implements PermissionStateModel {
  const factory _PermissionStateModel(
      {final bool notification,
      final bool criticalAlert,
      final bool location,
      final bool backgroundLocation}) = _$PermissionStateModelImpl;

  factory _PermissionStateModel.fromJson(Map<String, dynamic> json) =
      _$PermissionStateModelImpl.fromJson;

  @override
  bool get notification;
  @override
  bool get criticalAlert;
  @override
  bool get location;
  @override
  bool get backgroundLocation;

  /// Create a copy of PermissionStateModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PermissionStateModelImplCopyWith<_$PermissionStateModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
