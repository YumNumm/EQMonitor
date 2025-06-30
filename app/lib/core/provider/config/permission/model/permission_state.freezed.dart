// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'permission_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PermissionStateModel {

 bool get notification; bool get criticalAlert; bool get location; bool get backgroundLocation;
/// Create a copy of PermissionStateModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PermissionStateModelCopyWith<PermissionStateModel> get copyWith => _$PermissionStateModelCopyWithImpl<PermissionStateModel>(this as PermissionStateModel, _$identity);

  /// Serializes this PermissionStateModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PermissionStateModel&&(identical(other.notification, notification) || other.notification == notification)&&(identical(other.criticalAlert, criticalAlert) || other.criticalAlert == criticalAlert)&&(identical(other.location, location) || other.location == location)&&(identical(other.backgroundLocation, backgroundLocation) || other.backgroundLocation == backgroundLocation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,notification,criticalAlert,location,backgroundLocation);

@override
String toString() {
  return 'PermissionStateModel(notification: $notification, criticalAlert: $criticalAlert, location: $location, backgroundLocation: $backgroundLocation)';
}


}

/// @nodoc
abstract mixin class $PermissionStateModelCopyWith<$Res>  {
  factory $PermissionStateModelCopyWith(PermissionStateModel value, $Res Function(PermissionStateModel) _then) = _$PermissionStateModelCopyWithImpl;
@useResult
$Res call({
 bool notification, bool criticalAlert, bool location, bool backgroundLocation
});




}
/// @nodoc
class _$PermissionStateModelCopyWithImpl<$Res>
    implements $PermissionStateModelCopyWith<$Res> {
  _$PermissionStateModelCopyWithImpl(this._self, this._then);

  final PermissionStateModel _self;
  final $Res Function(PermissionStateModel) _then;

/// Create a copy of PermissionStateModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? notification = null,Object? criticalAlert = null,Object? location = null,Object? backgroundLocation = null,}) {
  return _then(_self.copyWith(
notification: null == notification ? _self.notification : notification // ignore: cast_nullable_to_non_nullable
as bool,criticalAlert: null == criticalAlert ? _self.criticalAlert : criticalAlert // ignore: cast_nullable_to_non_nullable
as bool,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as bool,backgroundLocation: null == backgroundLocation ? _self.backgroundLocation : backgroundLocation // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _PermissionStateModel implements PermissionStateModel {
  const _PermissionStateModel({this.notification = false, this.criticalAlert = false, this.location = false, this.backgroundLocation = false});
  factory _PermissionStateModel.fromJson(Map<String, dynamic> json) => _$PermissionStateModelFromJson(json);

@override@JsonKey() final  bool notification;
@override@JsonKey() final  bool criticalAlert;
@override@JsonKey() final  bool location;
@override@JsonKey() final  bool backgroundLocation;

/// Create a copy of PermissionStateModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PermissionStateModelCopyWith<_PermissionStateModel> get copyWith => __$PermissionStateModelCopyWithImpl<_PermissionStateModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PermissionStateModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PermissionStateModel&&(identical(other.notification, notification) || other.notification == notification)&&(identical(other.criticalAlert, criticalAlert) || other.criticalAlert == criticalAlert)&&(identical(other.location, location) || other.location == location)&&(identical(other.backgroundLocation, backgroundLocation) || other.backgroundLocation == backgroundLocation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,notification,criticalAlert,location,backgroundLocation);

@override
String toString() {
  return 'PermissionStateModel(notification: $notification, criticalAlert: $criticalAlert, location: $location, backgroundLocation: $backgroundLocation)';
}


}

/// @nodoc
abstract mixin class _$PermissionStateModelCopyWith<$Res> implements $PermissionStateModelCopyWith<$Res> {
  factory _$PermissionStateModelCopyWith(_PermissionStateModel value, $Res Function(_PermissionStateModel) _then) = __$PermissionStateModelCopyWithImpl;
@override @useResult
$Res call({
 bool notification, bool criticalAlert, bool location, bool backgroundLocation
});




}
/// @nodoc
class __$PermissionStateModelCopyWithImpl<$Res>
    implements _$PermissionStateModelCopyWith<$Res> {
  __$PermissionStateModelCopyWithImpl(this._self, this._then);

  final _PermissionStateModel _self;
  final $Res Function(_PermissionStateModel) _then;

/// Create a copy of PermissionStateModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? notification = null,Object? criticalAlert = null,Object? location = null,Object? backgroundLocation = null,}) {
  return _then(_PermissionStateModel(
notification: null == notification ? _self.notification : notification // ignore: cast_nullable_to_non_nullable
as bool,criticalAlert: null == criticalAlert ? _self.criticalAlert : criticalAlert // ignore: cast_nullable_to_non_nullable
as bool,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as bool,backgroundLocation: null == backgroundLocation ? _self.backgroundLocation : backgroundLocation // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
