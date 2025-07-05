// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'maintenance_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MaintenanceMessage {

 String? get message; Security? get security; MaintenanceMessageType? get type;@JsonKey(fromJson: dateTimeFromString, toJson: dateTimeToString) DateTime get requestTime; Result? get result;
/// Create a copy of MaintenanceMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MaintenanceMessageCopyWith<MaintenanceMessage> get copyWith => _$MaintenanceMessageCopyWithImpl<MaintenanceMessage>(this as MaintenanceMessage, _$identity);

  /// Serializes this MaintenanceMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MaintenanceMessage&&(identical(other.message, message) || other.message == message)&&(identical(other.security, security) || other.security == security)&&(identical(other.type, type) || other.type == type)&&(identical(other.requestTime, requestTime) || other.requestTime == requestTime)&&(identical(other.result, result) || other.result == result));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message,security,type,requestTime,result);

@override
String toString() {
  return 'MaintenanceMessage(message: $message, security: $security, type: $type, requestTime: $requestTime, result: $result)';
}


}

/// @nodoc
abstract mixin class $MaintenanceMessageCopyWith<$Res>  {
  factory $MaintenanceMessageCopyWith(MaintenanceMessage value, $Res Function(MaintenanceMessage) _then) = _$MaintenanceMessageCopyWithImpl;
@useResult
$Res call({
 String? message, Security? security, MaintenanceMessageType? type,@JsonKey(fromJson: dateTimeFromString, toJson: dateTimeToString) DateTime requestTime, Result? result
});


$SecurityCopyWith<$Res>? get security;$ResultCopyWith<$Res>? get result;

}
/// @nodoc
class _$MaintenanceMessageCopyWithImpl<$Res>
    implements $MaintenanceMessageCopyWith<$Res> {
  _$MaintenanceMessageCopyWithImpl(this._self, this._then);

  final MaintenanceMessage _self;
  final $Res Function(MaintenanceMessage) _then;

/// Create a copy of MaintenanceMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = freezed,Object? security = freezed,Object? type = freezed,Object? requestTime = null,Object? result = freezed,}) {
  return _then(_self.copyWith(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,security: freezed == security ? _self.security : security // ignore: cast_nullable_to_non_nullable
as Security?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MaintenanceMessageType?,requestTime: null == requestTime ? _self.requestTime : requestTime // ignore: cast_nullable_to_non_nullable
as DateTime,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as Result?,
  ));
}
/// Create a copy of MaintenanceMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SecurityCopyWith<$Res>? get security {
    if (_self.security == null) {
    return null;
  }

  return $SecurityCopyWith<$Res>(_self.security!, (value) {
    return _then(_self.copyWith(security: value));
  });
}/// Create a copy of MaintenanceMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResultCopyWith<$Res>? get result {
    if (_self.result == null) {
    return null;
  }

  return $ResultCopyWith<$Res>(_self.result!, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _MaintenanceMessage implements MaintenanceMessage {
  const _MaintenanceMessage({required this.message, required this.security, required this.type, @JsonKey(fromJson: dateTimeFromString, toJson: dateTimeToString) required this.requestTime, required this.result});
  factory _MaintenanceMessage.fromJson(Map<String, dynamic> json) => _$MaintenanceMessageFromJson(json);

@override final  String? message;
@override final  Security? security;
@override final  MaintenanceMessageType? type;
@override@JsonKey(fromJson: dateTimeFromString, toJson: dateTimeToString) final  DateTime requestTime;
@override final  Result? result;

/// Create a copy of MaintenanceMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MaintenanceMessageCopyWith<_MaintenanceMessage> get copyWith => __$MaintenanceMessageCopyWithImpl<_MaintenanceMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MaintenanceMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MaintenanceMessage&&(identical(other.message, message) || other.message == message)&&(identical(other.security, security) || other.security == security)&&(identical(other.type, type) || other.type == type)&&(identical(other.requestTime, requestTime) || other.requestTime == requestTime)&&(identical(other.result, result) || other.result == result));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message,security,type,requestTime,result);

@override
String toString() {
  return 'MaintenanceMessage(message: $message, security: $security, type: $type, requestTime: $requestTime, result: $result)';
}


}

/// @nodoc
abstract mixin class _$MaintenanceMessageCopyWith<$Res> implements $MaintenanceMessageCopyWith<$Res> {
  factory _$MaintenanceMessageCopyWith(_MaintenanceMessage value, $Res Function(_MaintenanceMessage) _then) = __$MaintenanceMessageCopyWithImpl;
@override @useResult
$Res call({
 String? message, Security? security, MaintenanceMessageType? type,@JsonKey(fromJson: dateTimeFromString, toJson: dateTimeToString) DateTime requestTime, Result? result
});


@override $SecurityCopyWith<$Res>? get security;@override $ResultCopyWith<$Res>? get result;

}
/// @nodoc
class __$MaintenanceMessageCopyWithImpl<$Res>
    implements _$MaintenanceMessageCopyWith<$Res> {
  __$MaintenanceMessageCopyWithImpl(this._self, this._then);

  final _MaintenanceMessage _self;
  final $Res Function(_MaintenanceMessage) _then;

/// Create a copy of MaintenanceMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = freezed,Object? security = freezed,Object? type = freezed,Object? requestTime = null,Object? result = freezed,}) {
  return _then(_MaintenanceMessage(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,security: freezed == security ? _self.security : security // ignore: cast_nullable_to_non_nullable
as Security?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MaintenanceMessageType?,requestTime: null == requestTime ? _self.requestTime : requestTime // ignore: cast_nullable_to_non_nullable
as DateTime,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as Result?,
  ));
}

/// Create a copy of MaintenanceMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SecurityCopyWith<$Res>? get security {
    if (_self.security == null) {
    return null;
  }

  return $SecurityCopyWith<$Res>(_self.security!, (value) {
    return _then(_self.copyWith(security: value));
  });
}/// Create a copy of MaintenanceMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResultCopyWith<$Res>? get result {
    if (_self.result == null) {
    return null;
  }

  return $ResultCopyWith<$Res>(_self.result!, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}

// dart format on
