// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ws_client_pong_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WsClientPongMessage {

 String get type;
/// Create a copy of WsClientPongMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WsClientPongMessageCopyWith<WsClientPongMessage> get copyWith => _$WsClientPongMessageCopyWithImpl<WsClientPongMessage>(this as WsClientPongMessage, _$identity);

  /// Serializes this WsClientPongMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WsClientPongMessage&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type);

@override
String toString() {
  return 'WsClientPongMessage(type: $type)';
}


}

/// @nodoc
abstract mixin class $WsClientPongMessageCopyWith<$Res>  {
  factory $WsClientPongMessageCopyWith(WsClientPongMessage value, $Res Function(WsClientPongMessage) _then) = _$WsClientPongMessageCopyWithImpl;
@useResult
$Res call({
 String type
});




}
/// @nodoc
class _$WsClientPongMessageCopyWithImpl<$Res>
    implements $WsClientPongMessageCopyWith<$Res> {
  _$WsClientPongMessageCopyWithImpl(this._self, this._then);

  final WsClientPongMessage _self;
  final $Res Function(WsClientPongMessage) _then;

/// Create a copy of WsClientPongMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,}) {
  return _then(WsClientPongMessage(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [WsClientPongMessage].
extension WsClientPongMessagePatterns on WsClientPongMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WsClientPongMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WsClientPongMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WsClientPongMessage value)  $default,){
final _that = this;
switch (_that) {
case _WsClientPongMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WsClientPongMessage value)?  $default,){
final _that = this;
switch (_that) {
case _WsClientPongMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WsClientPongMessage() when $default != null:
return $default(_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type)  $default,) {final _that = this;
switch (_that) {
case _WsClientPongMessage():
return $default(_that.type);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type)?  $default,) {final _that = this;
switch (_that) {
case _WsClientPongMessage() when $default != null:
return $default(_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WsClientPongMessage implements WsClientPongMessage {
  const _WsClientPongMessage({this.type = 'pong'});
  factory _WsClientPongMessage.fromJson(Map<String, dynamic> json) => _$WsClientPongMessageFromJson(json);

@override@JsonKey() final  String type;

/// Create a copy of WsClientPongMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WsClientPongMessageCopyWith<_WsClientPongMessage> get copyWith => __$WsClientPongMessageCopyWithImpl<_WsClientPongMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WsClientPongMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WsClientPongMessage&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type);

@override
String toString() {
  return 'WsClientPongMessage(type: $type)';
}


}

/// @nodoc
abstract mixin class _$WsClientPongMessageCopyWith<$Res> implements $WsClientPongMessageCopyWith<$Res> {
  factory _$WsClientPongMessageCopyWith(_WsClientPongMessage value, $Res Function(_WsClientPongMessage) _then) = __$WsClientPongMessageCopyWithImpl;
@override @useResult
$Res call({
 String type
});




}
/// @nodoc
class __$WsClientPongMessageCopyWithImpl<$Res>
    implements _$WsClientPongMessageCopyWith<$Res> {
  __$WsClientPongMessageCopyWithImpl(this._self, this._then);

  final _WsClientPongMessage _self;
  final $Res Function(_WsClientPongMessage) _then;

/// Create a copy of WsClientPongMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,}) {
  return _then(_WsClientPongMessage(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
