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
                  case 'snapshot':
          return WsSnapshotMessage.fromJson(
            json
          );
                case 'realtime':
          return WsRealtimeMessage.fromJson(
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

 Object get data;

  /// Serializes this WsMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WsMessage&&const DeepCollectionEquality().equals(other.data, data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'WsMessage(data: $data)';
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( WsSnapshotMessage value)?  snapshot,TResult Function( WsRealtimeMessage value)?  realtime,required TResult orElse(),}){
final _that = this;
switch (_that) {
case WsSnapshotMessage() when snapshot != null:
return snapshot(_that);case WsRealtimeMessage() when realtime != null:
return realtime(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( WsSnapshotMessage value)  snapshot,required TResult Function( WsRealtimeMessage value)  realtime,}){
final _that = this;
switch (_that) {
case WsSnapshotMessage():
return snapshot(_that);case WsRealtimeMessage():
return realtime(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( WsSnapshotMessage value)?  snapshot,TResult? Function( WsRealtimeMessage value)?  realtime,}){
final _that = this;
switch (_that) {
case WsSnapshotMessage() when snapshot != null:
return snapshot(_that);case WsRealtimeMessage() when realtime != null:
return realtime(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( WsSnapshotData data)?  snapshot,TResult Function( RealtimeEventEnvelope data)?  realtime,required TResult orElse(),}) {final _that = this;
switch (_that) {
case WsSnapshotMessage() when snapshot != null:
return snapshot(_that.data);case WsRealtimeMessage() when realtime != null:
return realtime(_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( WsSnapshotData data)  snapshot,required TResult Function( RealtimeEventEnvelope data)  realtime,}) {final _that = this;
switch (_that) {
case WsSnapshotMessage():
return snapshot(_that.data);case WsRealtimeMessage():
return realtime(_that.data);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( WsSnapshotData data)?  snapshot,TResult? Function( RealtimeEventEnvelope data)?  realtime,}) {final _that = this;
switch (_that) {
case WsSnapshotMessage() when snapshot != null:
return snapshot(_that.data);case WsRealtimeMessage() when realtime != null:
return realtime(_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class WsSnapshotMessage implements WsMessage {
  const WsSnapshotMessage({required this.data, final  String? $type}): $type = $type ?? 'snapshot';
  factory WsSnapshotMessage.fromJson(Map<String, dynamic> json) => _$WsSnapshotMessageFromJson(json);

@override final  WsSnapshotData data;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of WsMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WsSnapshotMessageCopyWith<WsSnapshotMessage> get copyWith => _$WsSnapshotMessageCopyWithImpl<WsSnapshotMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WsSnapshotMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WsSnapshotMessage&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'WsMessage.snapshot(data: $data)';
}


}

/// @nodoc
abstract mixin class $WsSnapshotMessageCopyWith<$Res> implements $WsMessageCopyWith<$Res> {
  factory $WsSnapshotMessageCopyWith(WsSnapshotMessage value, $Res Function(WsSnapshotMessage) _then) = _$WsSnapshotMessageCopyWithImpl;
@useResult
$Res call({
 WsSnapshotData data
});


$WsSnapshotDataCopyWith<$Res> get data;

}
/// @nodoc
class _$WsSnapshotMessageCopyWithImpl<$Res>
    implements $WsSnapshotMessageCopyWith<$Res> {
  _$WsSnapshotMessageCopyWithImpl(this._self, this._then);

  final WsSnapshotMessage _self;
  final $Res Function(WsSnapshotMessage) _then;

/// Create a copy of WsMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(WsSnapshotMessage(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as WsSnapshotData,
  ));
}

/// Create a copy of WsMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WsSnapshotDataCopyWith<$Res> get data {
  
  return $WsSnapshotDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class WsRealtimeMessage implements WsMessage {
  const WsRealtimeMessage({required this.data, final  String? $type}): $type = $type ?? 'realtime';
  factory WsRealtimeMessage.fromJson(Map<String, dynamic> json) => _$WsRealtimeMessageFromJson(json);

@override final  RealtimeEventEnvelope data;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of WsMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WsRealtimeMessageCopyWith<WsRealtimeMessage> get copyWith => _$WsRealtimeMessageCopyWithImpl<WsRealtimeMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WsRealtimeMessageToJson(this, );
}

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


$RealtimeEventEnvelopeCopyWith<$Res> get data;

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

/// Create a copy of WsMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RealtimeEventEnvelopeCopyWith<$Res> get data {
  
  return $RealtimeEventEnvelopeCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

// dart format on
