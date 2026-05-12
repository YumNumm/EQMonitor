// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'realtime_ticket_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RealtimeTicketResponse {

 String get url; DateTime get expiresAt; DateTime get issuedAt;
/// Create a copy of RealtimeTicketResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RealtimeTicketResponseCopyWith<RealtimeTicketResponse> get copyWith => _$RealtimeTicketResponseCopyWithImpl<RealtimeTicketResponse>(this as RealtimeTicketResponse, _$identity);

  /// Serializes this RealtimeTicketResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RealtimeTicketResponse&&(identical(other.url, url) || other.url == url)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.issuedAt, issuedAt) || other.issuedAt == issuedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,expiresAt,issuedAt);

@override
String toString() {
  return 'RealtimeTicketResponse(url: $url, expiresAt: $expiresAt, issuedAt: $issuedAt)';
}


}

/// @nodoc
abstract mixin class $RealtimeTicketResponseCopyWith<$Res>  {
  factory $RealtimeTicketResponseCopyWith(RealtimeTicketResponse value, $Res Function(RealtimeTicketResponse) _then) = _$RealtimeTicketResponseCopyWithImpl;
@useResult
$Res call({
 String url, DateTime expiresAt, DateTime issuedAt
});




}
/// @nodoc
class _$RealtimeTicketResponseCopyWithImpl<$Res>
    implements $RealtimeTicketResponseCopyWith<$Res> {
  _$RealtimeTicketResponseCopyWithImpl(this._self, this._then);

  final RealtimeTicketResponse _self;
  final $Res Function(RealtimeTicketResponse) _then;

/// Create a copy of RealtimeTicketResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,Object? expiresAt = null,Object? issuedAt = null,}) {
  return _then(_self.copyWith(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,issuedAt: null == issuedAt ? _self.issuedAt : issuedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [RealtimeTicketResponse].
extension RealtimeTicketResponsePatterns on RealtimeTicketResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RealtimeTicketResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RealtimeTicketResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RealtimeTicketResponse value)  $default,){
final _that = this;
switch (_that) {
case _RealtimeTicketResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RealtimeTicketResponse value)?  $default,){
final _that = this;
switch (_that) {
case _RealtimeTicketResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String url,  DateTime expiresAt,  DateTime issuedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RealtimeTicketResponse() when $default != null:
return $default(_that.url,_that.expiresAt,_that.issuedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String url,  DateTime expiresAt,  DateTime issuedAt)  $default,) {final _that = this;
switch (_that) {
case _RealtimeTicketResponse():
return $default(_that.url,_that.expiresAt,_that.issuedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String url,  DateTime expiresAt,  DateTime issuedAt)?  $default,) {final _that = this;
switch (_that) {
case _RealtimeTicketResponse() when $default != null:
return $default(_that.url,_that.expiresAt,_that.issuedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RealtimeTicketResponse implements RealtimeTicketResponse {
  const _RealtimeTicketResponse({required this.url, required this.expiresAt, required this.issuedAt});
  factory _RealtimeTicketResponse.fromJson(Map<String, dynamic> json) => _$RealtimeTicketResponseFromJson(json);

@override final  String url;
@override final  DateTime expiresAt;
@override final  DateTime issuedAt;

/// Create a copy of RealtimeTicketResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RealtimeTicketResponseCopyWith<_RealtimeTicketResponse> get copyWith => __$RealtimeTicketResponseCopyWithImpl<_RealtimeTicketResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RealtimeTicketResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RealtimeTicketResponse&&(identical(other.url, url) || other.url == url)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.issuedAt, issuedAt) || other.issuedAt == issuedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,expiresAt,issuedAt);

@override
String toString() {
  return 'RealtimeTicketResponse(url: $url, expiresAt: $expiresAt, issuedAt: $issuedAt)';
}


}

/// @nodoc
abstract mixin class _$RealtimeTicketResponseCopyWith<$Res> implements $RealtimeTicketResponseCopyWith<$Res> {
  factory _$RealtimeTicketResponseCopyWith(_RealtimeTicketResponse value, $Res Function(_RealtimeTicketResponse) _then) = __$RealtimeTicketResponseCopyWithImpl;
@override @useResult
$Res call({
 String url, DateTime expiresAt, DateTime issuedAt
});




}
/// @nodoc
class __$RealtimeTicketResponseCopyWithImpl<$Res>
    implements _$RealtimeTicketResponseCopyWith<$Res> {
  __$RealtimeTicketResponseCopyWithImpl(this._self, this._then);

  final _RealtimeTicketResponse _self;
  final $Res Function(_RealtimeTicketResponse) _then;

/// Create a copy of RealtimeTicketResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = null,Object? expiresAt = null,Object? issuedAt = null,}) {
  return _then(_RealtimeTicketResponse(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,issuedAt: null == issuedAt ? _self.issuedAt : issuedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
