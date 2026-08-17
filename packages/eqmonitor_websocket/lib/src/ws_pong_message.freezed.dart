// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ws_pong_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WsPongMessage {

 String get type;
/// Create a copy of WsPongMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WsPongMessageCopyWith<WsPongMessage> get copyWith => _$WsPongMessageCopyWithImpl<WsPongMessage>(this as WsPongMessage, _$identity);

  /// Serializes this WsPongMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WsPongMessage&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type);

@override
String toString() {
  return 'WsPongMessage(type: $type)';
}


}

/// @nodoc
abstract mixin class $WsPongMessageCopyWith<$Res>  {
  factory $WsPongMessageCopyWith(WsPongMessage value, $Res Function(WsPongMessage) _then) = _$WsPongMessageCopyWithImpl;
@useResult
$Res call({
 String type
});




}
/// @nodoc
class _$WsPongMessageCopyWithImpl<$Res>
    implements $WsPongMessageCopyWith<$Res> {
  _$WsPongMessageCopyWithImpl(this._self, this._then);

  final WsPongMessage _self;
  final $Res Function(WsPongMessage) _then;

/// Create a copy of WsPongMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,}) {
  return _then(WsPongMessage(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [WsPongMessage].
extension WsPongMessagePatterns on WsPongMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WsPongMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WsPongMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WsPongMessage value)  $default,){
final _that = this;
switch (_that) {
case _WsPongMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WsPongMessage value)?  $default,){
final _that = this;
switch (_that) {
case _WsPongMessage() when $default != null:
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
case _WsPongMessage() when $default != null:
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
case _WsPongMessage():
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
case _WsPongMessage() when $default != null:
return $default(_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WsPongMessage implements WsPongMessage {
  const _WsPongMessage({this.type = 'pong'});
  factory _WsPongMessage.fromJson(Map<String, dynamic> json) => _$WsPongMessageFromJson(json);

@override@JsonKey() final  String type;

/// Create a copy of WsPongMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WsPongMessageCopyWith<_WsPongMessage> get copyWith => __$WsPongMessageCopyWithImpl<_WsPongMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WsPongMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WsPongMessage&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type);

@override
String toString() {
  return 'WsPongMessage(type: $type)';
}


}

/// @nodoc
abstract mixin class _$WsPongMessageCopyWith<$Res> implements $WsPongMessageCopyWith<$Res> {
  factory _$WsPongMessageCopyWith(_WsPongMessage value, $Res Function(_WsPongMessage) _then) = __$WsPongMessageCopyWithImpl;
@override @useResult
$Res call({
 String type
});




}
/// @nodoc
class __$WsPongMessageCopyWithImpl<$Res>
    implements _$WsPongMessageCopyWith<$Res> {
  __$WsPongMessageCopyWithImpl(this._self, this._then);

  final _WsPongMessage _self;
  final $Res Function(_WsPongMessage) _then;

/// Create a copy of WsPongMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,}) {
  return _then(_WsPongMessage(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
