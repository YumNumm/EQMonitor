// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fcm_token_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FcmTokenRequest {

 String get fcmToken;
/// Create a copy of FcmTokenRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FcmTokenRequestCopyWith<FcmTokenRequest> get copyWith => _$FcmTokenRequestCopyWithImpl<FcmTokenRequest>(this as FcmTokenRequest, _$identity);

  /// Serializes this FcmTokenRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FcmTokenRequest&&(identical(other.fcmToken, fcmToken) || other.fcmToken == fcmToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fcmToken);

@override
String toString() {
  return 'FcmTokenRequest(fcmToken: $fcmToken)';
}


}

/// @nodoc
abstract mixin class $FcmTokenRequestCopyWith<$Res>  {
  factory $FcmTokenRequestCopyWith(FcmTokenRequest value, $Res Function(FcmTokenRequest) _then) = _$FcmTokenRequestCopyWithImpl;
@useResult
$Res call({
 String fcmToken
});




}
/// @nodoc
class _$FcmTokenRequestCopyWithImpl<$Res>
    implements $FcmTokenRequestCopyWith<$Res> {
  _$FcmTokenRequestCopyWithImpl(this._self, this._then);

  final FcmTokenRequest _self;
  final $Res Function(FcmTokenRequest) _then;

/// Create a copy of FcmTokenRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fcmToken = null,}) {
  return _then(_self.copyWith(
fcmToken: null == fcmToken ? _self.fcmToken : fcmToken // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _FcmTokenRequest implements FcmTokenRequest {
  const _FcmTokenRequest({required this.fcmToken});
  factory _FcmTokenRequest.fromJson(Map<String, dynamic> json) => _$FcmTokenRequestFromJson(json);

@override final  String fcmToken;

/// Create a copy of FcmTokenRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FcmTokenRequestCopyWith<_FcmTokenRequest> get copyWith => __$FcmTokenRequestCopyWithImpl<_FcmTokenRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FcmTokenRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FcmTokenRequest&&(identical(other.fcmToken, fcmToken) || other.fcmToken == fcmToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fcmToken);

@override
String toString() {
  return 'FcmTokenRequest(fcmToken: $fcmToken)';
}


}

/// @nodoc
abstract mixin class _$FcmTokenRequestCopyWith<$Res> implements $FcmTokenRequestCopyWith<$Res> {
  factory _$FcmTokenRequestCopyWith(_FcmTokenRequest value, $Res Function(_FcmTokenRequest) _then) = __$FcmTokenRequestCopyWithImpl;
@override @useResult
$Res call({
 String fcmToken
});




}
/// @nodoc
class __$FcmTokenRequestCopyWithImpl<$Res>
    implements _$FcmTokenRequestCopyWith<$Res> {
  __$FcmTokenRequestCopyWithImpl(this._self, this._then);

  final _FcmTokenRequest _self;
  final $Res Function(_FcmTokenRequest) _then;

/// Create a copy of FcmTokenRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fcmToken = null,}) {
  return _then(_FcmTokenRequest(
fcmToken: null == fcmToken ? _self.fcmToken : fcmToken // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
