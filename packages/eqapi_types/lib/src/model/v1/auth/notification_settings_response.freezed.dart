// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_settings_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationSettingsResponse {

 List<DevicesEarthquakeSettings> get earthquake; List<DevicesEewSettings> get eew;
/// Create a copy of NotificationSettingsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationSettingsResponseCopyWith<NotificationSettingsResponse> get copyWith => _$NotificationSettingsResponseCopyWithImpl<NotificationSettingsResponse>(this as NotificationSettingsResponse, _$identity);

  /// Serializes this NotificationSettingsResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationSettingsResponse&&const DeepCollectionEquality().equals(other.earthquake, earthquake)&&const DeepCollectionEquality().equals(other.eew, eew));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(earthquake),const DeepCollectionEquality().hash(eew));

@override
String toString() {
  return 'NotificationSettingsResponse(earthquake: $earthquake, eew: $eew)';
}


}

/// @nodoc
abstract mixin class $NotificationSettingsResponseCopyWith<$Res>  {
  factory $NotificationSettingsResponseCopyWith(NotificationSettingsResponse value, $Res Function(NotificationSettingsResponse) _then) = _$NotificationSettingsResponseCopyWithImpl;
@useResult
$Res call({
 List<DevicesEarthquakeSettings> earthquake, List<DevicesEewSettings> eew
});




}
/// @nodoc
class _$NotificationSettingsResponseCopyWithImpl<$Res>
    implements $NotificationSettingsResponseCopyWith<$Res> {
  _$NotificationSettingsResponseCopyWithImpl(this._self, this._then);

  final NotificationSettingsResponse _self;
  final $Res Function(NotificationSettingsResponse) _then;

/// Create a copy of NotificationSettingsResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? earthquake = null,Object? eew = null,}) {
  return _then(_self.copyWith(
earthquake: null == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as List<DevicesEarthquakeSettings>,eew: null == eew ? _self.eew : eew // ignore: cast_nullable_to_non_nullable
as List<DevicesEewSettings>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _NotificationSettingsResponse implements NotificationSettingsResponse {
  const _NotificationSettingsResponse({required final  List<DevicesEarthquakeSettings> earthquake, required final  List<DevicesEewSettings> eew}): _earthquake = earthquake,_eew = eew;
  factory _NotificationSettingsResponse.fromJson(Map<String, dynamic> json) => _$NotificationSettingsResponseFromJson(json);

 final  List<DevicesEarthquakeSettings> _earthquake;
@override List<DevicesEarthquakeSettings> get earthquake {
  if (_earthquake is EqualUnmodifiableListView) return _earthquake;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_earthquake);
}

 final  List<DevicesEewSettings> _eew;
@override List<DevicesEewSettings> get eew {
  if (_eew is EqualUnmodifiableListView) return _eew;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_eew);
}


/// Create a copy of NotificationSettingsResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationSettingsResponseCopyWith<_NotificationSettingsResponse> get copyWith => __$NotificationSettingsResponseCopyWithImpl<_NotificationSettingsResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationSettingsResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationSettingsResponse&&const DeepCollectionEquality().equals(other._earthquake, _earthquake)&&const DeepCollectionEquality().equals(other._eew, _eew));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_earthquake),const DeepCollectionEquality().hash(_eew));

@override
String toString() {
  return 'NotificationSettingsResponse(earthquake: $earthquake, eew: $eew)';
}


}

/// @nodoc
abstract mixin class _$NotificationSettingsResponseCopyWith<$Res> implements $NotificationSettingsResponseCopyWith<$Res> {
  factory _$NotificationSettingsResponseCopyWith(_NotificationSettingsResponse value, $Res Function(_NotificationSettingsResponse) _then) = __$NotificationSettingsResponseCopyWithImpl;
@override @useResult
$Res call({
 List<DevicesEarthquakeSettings> earthquake, List<DevicesEewSettings> eew
});




}
/// @nodoc
class __$NotificationSettingsResponseCopyWithImpl<$Res>
    implements _$NotificationSettingsResponseCopyWith<$Res> {
  __$NotificationSettingsResponseCopyWithImpl(this._self, this._then);

  final _NotificationSettingsResponse _self;
  final $Res Function(_NotificationSettingsResponse) _then;

/// Create a copy of NotificationSettingsResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? earthquake = null,Object? eew = null,}) {
  return _then(_NotificationSettingsResponse(
earthquake: null == earthquake ? _self._earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as List<DevicesEarthquakeSettings>,eew: null == eew ? _self._eew : eew // ignore: cast_nullable_to_non_nullable
as List<DevicesEewSettings>,
  ));
}


}

// dart format on
