// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'websocket_ticket_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WebsocketTicketResponse {

 String get ticket;@JsonKey(name: 'expires_at') DateTime get expiresAt;
/// Create a copy of WebsocketTicketResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WebsocketTicketResponseCopyWith<WebsocketTicketResponse> get copyWith => _$WebsocketTicketResponseCopyWithImpl<WebsocketTicketResponse>(this as WebsocketTicketResponse, _$identity);

  /// Serializes this WebsocketTicketResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WebsocketTicketResponse&&(identical(other.ticket, ticket) || other.ticket == ticket)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ticket,expiresAt);

@override
String toString() {
  return 'WebsocketTicketResponse(ticket: $ticket, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class $WebsocketTicketResponseCopyWith<$Res>  {
  factory $WebsocketTicketResponseCopyWith(WebsocketTicketResponse value, $Res Function(WebsocketTicketResponse) _then) = _$WebsocketTicketResponseCopyWithImpl;
@useResult
$Res call({
 String ticket,@JsonKey(name: 'expires_at') DateTime expiresAt
});




}
/// @nodoc
class _$WebsocketTicketResponseCopyWithImpl<$Res>
    implements $WebsocketTicketResponseCopyWith<$Res> {
  _$WebsocketTicketResponseCopyWithImpl(this._self, this._then);

  final WebsocketTicketResponse _self;
  final $Res Function(WebsocketTicketResponse) _then;

/// Create a copy of WebsocketTicketResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ticket = null,Object? expiresAt = null,}) {
  return _then(_self.copyWith(
ticket: null == ticket ? _self.ticket : ticket // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [WebsocketTicketResponse].
extension WebsocketTicketResponsePatterns on WebsocketTicketResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WebsocketTicketResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WebsocketTicketResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WebsocketTicketResponse value)  $default,){
final _that = this;
switch (_that) {
case _WebsocketTicketResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WebsocketTicketResponse value)?  $default,){
final _that = this;
switch (_that) {
case _WebsocketTicketResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String ticket, @JsonKey(name: 'expires_at')  DateTime expiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WebsocketTicketResponse() when $default != null:
return $default(_that.ticket,_that.expiresAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String ticket, @JsonKey(name: 'expires_at')  DateTime expiresAt)  $default,) {final _that = this;
switch (_that) {
case _WebsocketTicketResponse():
return $default(_that.ticket,_that.expiresAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String ticket, @JsonKey(name: 'expires_at')  DateTime expiresAt)?  $default,) {final _that = this;
switch (_that) {
case _WebsocketTicketResponse() when $default != null:
return $default(_that.ticket,_that.expiresAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WebsocketTicketResponse implements WebsocketTicketResponse {
  const _WebsocketTicketResponse({required this.ticket, @JsonKey(name: 'expires_at') required this.expiresAt});
  factory _WebsocketTicketResponse.fromJson(Map<String, dynamic> json) => _$WebsocketTicketResponseFromJson(json);

@override final  String ticket;
@override@JsonKey(name: 'expires_at') final  DateTime expiresAt;

/// Create a copy of WebsocketTicketResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WebsocketTicketResponseCopyWith<_WebsocketTicketResponse> get copyWith => __$WebsocketTicketResponseCopyWithImpl<_WebsocketTicketResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WebsocketTicketResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WebsocketTicketResponse&&(identical(other.ticket, ticket) || other.ticket == ticket)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ticket,expiresAt);

@override
String toString() {
  return 'WebsocketTicketResponse(ticket: $ticket, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class _$WebsocketTicketResponseCopyWith<$Res> implements $WebsocketTicketResponseCopyWith<$Res> {
  factory _$WebsocketTicketResponseCopyWith(_WebsocketTicketResponse value, $Res Function(_WebsocketTicketResponse) _then) = __$WebsocketTicketResponseCopyWithImpl;
@override @useResult
$Res call({
 String ticket,@JsonKey(name: 'expires_at') DateTime expiresAt
});




}
/// @nodoc
class __$WebsocketTicketResponseCopyWithImpl<$Res>
    implements _$WebsocketTicketResponseCopyWith<$Res> {
  __$WebsocketTicketResponseCopyWithImpl(this._self, this._then);

  final _WebsocketTicketResponse _self;
  final $Res Function(_WebsocketTicketResponse) _then;

/// Create a copy of WebsocketTicketResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ticket = null,Object? expiresAt = null,}) {
  return _then(_WebsocketTicketResponse(
ticket: null == ticket ? _self.ticket : ticket // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
