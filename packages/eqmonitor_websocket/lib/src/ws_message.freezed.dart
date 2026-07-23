// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ws_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
WsMessage _$WsMessageFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'realtime':
          return WsRealtimeMessage.fromJson(
            json
          );
                case 'ping':
          return WsPingMessage.fromJson(
            json
          );
                case 'ready':
          return WsReadyMessage.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'WsMessage',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$WsMessage {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WsMessage);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WsMessage()';
}


}

/// @nodoc
class $WsMessageCopyWith<$Res>  {
$WsMessageCopyWith(WsMessage _, $Res Function(WsMessage) __);
}


/// Adds pattern-matching-related methods to [WsMessage].
extension WsMessagePatterns on WsMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( WsRealtimeMessage value)?  realtime,TResult Function( WsPingMessage value)?  ping,TResult Function( WsReadyMessage value)?  ready,required TResult orElse(),}){
final _that = this;
switch (_that) {
case WsRealtimeMessage() when realtime != null:
return realtime(_that);case WsPingMessage() when ping != null:
return ping(_that);case WsReadyMessage() when ready != null:
return ready(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( WsRealtimeMessage value)  realtime,required TResult Function( WsPingMessage value)  ping,required TResult Function( WsReadyMessage value)  ready,}){
final _that = this;
switch (_that) {
case WsRealtimeMessage():
return realtime(_that);case WsPingMessage():
return ping(_that);case WsReadyMessage():
return ready(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( WsRealtimeMessage value)?  realtime,TResult? Function( WsPingMessage value)?  ping,TResult? Function( WsReadyMessage value)?  ready,}){
final _that = this;
switch (_that) {
case WsRealtimeMessage() when realtime != null:
return realtime(_that);case WsPingMessage() when ping != null:
return ping(_that);case WsReadyMessage() when ready != null:
return ready(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( RealtimeEventEnvelope data)?  realtime,TResult Function()?  ping,TResult Function()?  ready,required TResult orElse(),}) {final _that = this;
switch (_that) {
case WsRealtimeMessage() when realtime != null:
return realtime(_that.data);case WsPingMessage() when ping != null:
return ping();case WsReadyMessage() when ready != null:
return ready();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( RealtimeEventEnvelope data)  realtime,required TResult Function()  ping,required TResult Function()  ready,}) {final _that = this;
switch (_that) {
case WsRealtimeMessage():
return realtime(_that.data);case WsPingMessage():
return ping();case WsReadyMessage():
return ready();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( RealtimeEventEnvelope data)?  realtime,TResult? Function()?  ping,TResult? Function()?  ready,}) {final _that = this;
switch (_that) {
case WsRealtimeMessage() when realtime != null:
return realtime(_that.data);case WsPingMessage() when ping != null:
return ping();case WsReadyMessage() when ready != null:
return ready();case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class WsRealtimeMessage implements WsMessage {
  const WsRealtimeMessage({required this.data, final  String? $type}): $type = $type ?? 'realtime';
  factory WsRealtimeMessage.fromJson(Map<String, dynamic> json) => _$WsRealtimeMessageFromJson(json);

 final  RealtimeEventEnvelope data;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of WsMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WsRealtimeMessageCopyWith<WsRealtimeMessage> get copyWith => _$WsRealtimeMessageCopyWithImpl<WsRealtimeMessage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WsRealtimeMessage&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'WsMessage.realtime(data: $data)';
}


}

/// @nodoc
abstract mixin class $WsRealtimeMessageCopyWith<$Res> implements $WsMessageCopyWith<$Res> {
  factory $WsRealtimeMessageCopyWith(WsRealtimeMessage value, $Res Function(WsRealtimeMessage) _then) = _$WsRealtimeMessageCopyWithImpl;
@useResult
$Res call({
 RealtimeEventEnvelope data
});




}
/// @nodoc
class _$WsRealtimeMessageCopyWithImpl<$Res>
    implements $WsRealtimeMessageCopyWith<$Res> {
  _$WsRealtimeMessageCopyWithImpl(this._self, this._then);

  final WsRealtimeMessage _self;
  final $Res Function(WsRealtimeMessage) _then;

/// Create a copy of WsMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(WsRealtimeMessage(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as RealtimeEventEnvelope,
  ));
}


}

/// @nodoc
@JsonSerializable(createToJson: false)

class WsPingMessage implements WsMessage {
  const WsPingMessage({final  String? $type}): $type = $type ?? 'ping';
  factory WsPingMessage.fromJson(Map<String, dynamic> json) => _$WsPingMessageFromJson(json);



@JsonKey(name: 'type')
final String $type;





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WsPingMessage);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WsMessage.ping()';
}


}




/// @nodoc
@JsonSerializable(createToJson: false)

class WsReadyMessage implements WsMessage {
  const WsReadyMessage({final  String? $type}): $type = $type ?? 'ready';
  factory WsReadyMessage.fromJson(Map<String, dynamic> json) => _$WsReadyMessageFromJson(json);



@JsonKey(name: 'type')
final String $type;





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WsReadyMessage);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WsMessage.ready()';
}


}




// dart format on
