// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ws_client_ping_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WsClientPingMessage {

 String get pingId; String get type;
/// Create a copy of WsClientPingMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WsClientPingMessageCopyWith<WsClientPingMessage> get copyWith => _$WsClientPingMessageCopyWithImpl<WsClientPingMessage>(this as WsClientPingMessage, _$identity);

  /// Serializes this WsClientPingMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WsClientPingMessage&&(identical(other.pingId, pingId) || other.pingId == pingId)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pingId,type);

@override
String toString() {
  return 'WsClientPingMessage(pingId: $pingId, type: $type)';
}


}

/// @nodoc
abstract mixin class $WsClientPingMessageCopyWith<$Res>  {
  factory $WsClientPingMessageCopyWith(WsClientPingMessage value, $Res Function(WsClientPingMessage) _then) = _$WsClientPingMessageCopyWithImpl;
@useResult
$Res call({
 String pingId, String type
});




}
/// @nodoc
class _$WsClientPingMessageCopyWithImpl<$Res>
    implements $WsClientPingMessageCopyWith<$Res> {
  _$WsClientPingMessageCopyWithImpl(this._self, this._then);

  final WsClientPingMessage _self;
  final $Res Function(WsClientPingMessage) _then;

/// Create a copy of WsClientPingMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pingId = null,Object? type = null,}) {
  return _then(WsClientPingMessage(
pingId: null == pingId ? _self.pingId : pingId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [WsClientPingMessage].
extension WsClientPingMessagePatterns on WsClientPingMessage {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WsClientPingMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WsClientPingMessage() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WsClientPingMessage value)  $default,){
final _that = this;
switch (_that) {
case _WsClientPingMessage():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WsClientPingMessage value)?  $default,){
final _that = this;
switch (_that) {
case _WsClientPingMessage() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String pingId,  String type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WsClientPingMessage() when $default != null:
return $default(_that.pingId,_that.type);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String pingId,  String type)  $default,) {final _that = this;
switch (_that) {
case _WsClientPingMessage():
return $default(_that.pingId,_that.type);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String pingId,  String type)?  $default,) {final _that = this;
switch (_that) {
case _WsClientPingMessage() when $default != null:
return $default(_that.pingId,_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WsClientPingMessage implements WsClientPingMessage {
  const _WsClientPingMessage({required this.pingId, this.type = 'ping'});
  factory _WsClientPingMessage.fromJson(Map<String, dynamic> json) => _$WsClientPingMessageFromJson(json);

@override final  String pingId;
@override@JsonKey() final  String type;

/// Create a copy of WsClientPingMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WsClientPingMessageCopyWith<_WsClientPingMessage> get copyWith => __$WsClientPingMessageCopyWithImpl<_WsClientPingMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WsClientPingMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WsClientPingMessage&&(identical(other.pingId, pingId) || other.pingId == pingId)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pingId,type);

@override
String toString() {
  return 'WsClientPingMessage(pingId: $pingId, type: $type)';
}


}

/// @nodoc
abstract mixin class _$WsClientPingMessageCopyWith<$Res> implements $WsClientPingMessageCopyWith<$Res> {
  factory _$WsClientPingMessageCopyWith(_WsClientPingMessage value, $Res Function(_WsClientPingMessage) _then) = __$WsClientPingMessageCopyWithImpl;
@override @useResult
$Res call({
 String pingId, String type
});




}
/// @nodoc
class __$WsClientPingMessageCopyWithImpl<$Res>
    implements _$WsClientPingMessageCopyWith<$Res> {
  __$WsClientPingMessageCopyWithImpl(this._self, this._then);

  final _WsClientPingMessage _self;
  final $Res Function(_WsClientPingMessage) _then;

/// Create a copy of WsClientPingMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pingId = null,Object? type = null,}) {
  return _then(_WsClientPingMessage(
pingId: null == pingId ? _self.pingId : pingId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
