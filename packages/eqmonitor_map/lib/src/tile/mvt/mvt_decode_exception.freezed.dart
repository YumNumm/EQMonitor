// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mvt_decode_exception.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MvtDecodeException {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MvtDecodeException);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MvtDecodeException()';
}


}

/// @nodoc
class $MvtDecodeExceptionCopyWith<$Res>  {
$MvtDecodeExceptionCopyWith(MvtDecodeException _, $Res Function(MvtDecodeException) __);
}


/// Adds pattern-matching-related methods to [MvtDecodeException].
extension MvtDecodeExceptionPatterns on MvtDecodeException {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( MvtMalformedProtobufException value)?  malformedProtobuf,TResult Function( MvtUnsupportedLayerVersionException value)?  unsupportedLayerVersion,TResult Function( MvtInvalidGeometryCommandException value)?  invalidGeometryCommand,TResult Function( MvtLimitExceededException value)?  limitExceeded,required TResult orElse(),}){
final _that = this;
switch (_that) {
case MvtMalformedProtobufException() when malformedProtobuf != null:
return malformedProtobuf(_that);case MvtUnsupportedLayerVersionException() when unsupportedLayerVersion != null:
return unsupportedLayerVersion(_that);case MvtInvalidGeometryCommandException() when invalidGeometryCommand != null:
return invalidGeometryCommand(_that);case MvtLimitExceededException() when limitExceeded != null:
return limitExceeded(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( MvtMalformedProtobufException value)  malformedProtobuf,required TResult Function( MvtUnsupportedLayerVersionException value)  unsupportedLayerVersion,required TResult Function( MvtInvalidGeometryCommandException value)  invalidGeometryCommand,required TResult Function( MvtLimitExceededException value)  limitExceeded,}){
final _that = this;
switch (_that) {
case MvtMalformedProtobufException():
return malformedProtobuf(_that);case MvtUnsupportedLayerVersionException():
return unsupportedLayerVersion(_that);case MvtInvalidGeometryCommandException():
return invalidGeometryCommand(_that);case MvtLimitExceededException():
return limitExceeded(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( MvtMalformedProtobufException value)?  malformedProtobuf,TResult? Function( MvtUnsupportedLayerVersionException value)?  unsupportedLayerVersion,TResult? Function( MvtInvalidGeometryCommandException value)?  invalidGeometryCommand,TResult? Function( MvtLimitExceededException value)?  limitExceeded,}){
final _that = this;
switch (_that) {
case MvtMalformedProtobufException() when malformedProtobuf != null:
return malformedProtobuf(_that);case MvtUnsupportedLayerVersionException() when unsupportedLayerVersion != null:
return unsupportedLayerVersion(_that);case MvtInvalidGeometryCommandException() when invalidGeometryCommand != null:
return invalidGeometryCommand(_that);case MvtLimitExceededException() when limitExceeded != null:
return limitExceeded(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String reason)?  malformedProtobuf,TResult Function( int version)?  unsupportedLayerVersion,TResult Function( String reason)?  invalidGeometryCommand,TResult Function( String reason)?  limitExceeded,required TResult orElse(),}) {final _that = this;
switch (_that) {
case MvtMalformedProtobufException() when malformedProtobuf != null:
return malformedProtobuf(_that.reason);case MvtUnsupportedLayerVersionException() when unsupportedLayerVersion != null:
return unsupportedLayerVersion(_that.version);case MvtInvalidGeometryCommandException() when invalidGeometryCommand != null:
return invalidGeometryCommand(_that.reason);case MvtLimitExceededException() when limitExceeded != null:
return limitExceeded(_that.reason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String reason)  malformedProtobuf,required TResult Function( int version)  unsupportedLayerVersion,required TResult Function( String reason)  invalidGeometryCommand,required TResult Function( String reason)  limitExceeded,}) {final _that = this;
switch (_that) {
case MvtMalformedProtobufException():
return malformedProtobuf(_that.reason);case MvtUnsupportedLayerVersionException():
return unsupportedLayerVersion(_that.version);case MvtInvalidGeometryCommandException():
return invalidGeometryCommand(_that.reason);case MvtLimitExceededException():
return limitExceeded(_that.reason);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String reason)?  malformedProtobuf,TResult? Function( int version)?  unsupportedLayerVersion,TResult? Function( String reason)?  invalidGeometryCommand,TResult? Function( String reason)?  limitExceeded,}) {final _that = this;
switch (_that) {
case MvtMalformedProtobufException() when malformedProtobuf != null:
return malformedProtobuf(_that.reason);case MvtUnsupportedLayerVersionException() when unsupportedLayerVersion != null:
return unsupportedLayerVersion(_that.version);case MvtInvalidGeometryCommandException() when invalidGeometryCommand != null:
return invalidGeometryCommand(_that.reason);case MvtLimitExceededException() when limitExceeded != null:
return limitExceeded(_that.reason);case _:
  return null;

}
}

}

/// @nodoc


class MvtMalformedProtobufException implements MvtDecodeException {
  const MvtMalformedProtobufException({required this.reason});
  

 final  String reason;

/// Create a copy of MvtDecodeException
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MvtMalformedProtobufExceptionCopyWith<MvtMalformedProtobufException> get copyWith => _$MvtMalformedProtobufExceptionCopyWithImpl<MvtMalformedProtobufException>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MvtMalformedProtobufException&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,reason);

@override
String toString() {
  return 'MvtDecodeException.malformedProtobuf(reason: $reason)';
}


}

/// @nodoc
abstract mixin class $MvtMalformedProtobufExceptionCopyWith<$Res> implements $MvtDecodeExceptionCopyWith<$Res> {
  factory $MvtMalformedProtobufExceptionCopyWith(MvtMalformedProtobufException value, $Res Function(MvtMalformedProtobufException) _then) = _$MvtMalformedProtobufExceptionCopyWithImpl;
@useResult
$Res call({
 String reason
});




}
/// @nodoc
class _$MvtMalformedProtobufExceptionCopyWithImpl<$Res>
    implements $MvtMalformedProtobufExceptionCopyWith<$Res> {
  _$MvtMalformedProtobufExceptionCopyWithImpl(this._self, this._then);

  final MvtMalformedProtobufException _self;
  final $Res Function(MvtMalformedProtobufException) _then;

/// Create a copy of MvtDecodeException
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reason = null,}) {
  return _then(MvtMalformedProtobufException(
reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class MvtUnsupportedLayerVersionException implements MvtDecodeException {
  const MvtUnsupportedLayerVersionException({required this.version});
  

 final  int version;

/// Create a copy of MvtDecodeException
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MvtUnsupportedLayerVersionExceptionCopyWith<MvtUnsupportedLayerVersionException> get copyWith => _$MvtUnsupportedLayerVersionExceptionCopyWithImpl<MvtUnsupportedLayerVersionException>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MvtUnsupportedLayerVersionException&&(identical(other.version, version) || other.version == version));
}


@override
int get hashCode => Object.hash(runtimeType,version);

@override
String toString() {
  return 'MvtDecodeException.unsupportedLayerVersion(version: $version)';
}


}

/// @nodoc
abstract mixin class $MvtUnsupportedLayerVersionExceptionCopyWith<$Res> implements $MvtDecodeExceptionCopyWith<$Res> {
  factory $MvtUnsupportedLayerVersionExceptionCopyWith(MvtUnsupportedLayerVersionException value, $Res Function(MvtUnsupportedLayerVersionException) _then) = _$MvtUnsupportedLayerVersionExceptionCopyWithImpl;
@useResult
$Res call({
 int version
});




}
/// @nodoc
class _$MvtUnsupportedLayerVersionExceptionCopyWithImpl<$Res>
    implements $MvtUnsupportedLayerVersionExceptionCopyWith<$Res> {
  _$MvtUnsupportedLayerVersionExceptionCopyWithImpl(this._self, this._then);

  final MvtUnsupportedLayerVersionException _self;
  final $Res Function(MvtUnsupportedLayerVersionException) _then;

/// Create a copy of MvtDecodeException
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? version = null,}) {
  return _then(MvtUnsupportedLayerVersionException(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class MvtInvalidGeometryCommandException implements MvtDecodeException {
  const MvtInvalidGeometryCommandException({required this.reason});
  

 final  String reason;

/// Create a copy of MvtDecodeException
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MvtInvalidGeometryCommandExceptionCopyWith<MvtInvalidGeometryCommandException> get copyWith => _$MvtInvalidGeometryCommandExceptionCopyWithImpl<MvtInvalidGeometryCommandException>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MvtInvalidGeometryCommandException&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,reason);

@override
String toString() {
  return 'MvtDecodeException.invalidGeometryCommand(reason: $reason)';
}


}

/// @nodoc
abstract mixin class $MvtInvalidGeometryCommandExceptionCopyWith<$Res> implements $MvtDecodeExceptionCopyWith<$Res> {
  factory $MvtInvalidGeometryCommandExceptionCopyWith(MvtInvalidGeometryCommandException value, $Res Function(MvtInvalidGeometryCommandException) _then) = _$MvtInvalidGeometryCommandExceptionCopyWithImpl;
@useResult
$Res call({
 String reason
});




}
/// @nodoc
class _$MvtInvalidGeometryCommandExceptionCopyWithImpl<$Res>
    implements $MvtInvalidGeometryCommandExceptionCopyWith<$Res> {
  _$MvtInvalidGeometryCommandExceptionCopyWithImpl(this._self, this._then);

  final MvtInvalidGeometryCommandException _self;
  final $Res Function(MvtInvalidGeometryCommandException) _then;

/// Create a copy of MvtDecodeException
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reason = null,}) {
  return _then(MvtInvalidGeometryCommandException(
reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class MvtLimitExceededException implements MvtDecodeException {
  const MvtLimitExceededException({required this.reason});
  

 final  String reason;

/// Create a copy of MvtDecodeException
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MvtLimitExceededExceptionCopyWith<MvtLimitExceededException> get copyWith => _$MvtLimitExceededExceptionCopyWithImpl<MvtLimitExceededException>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MvtLimitExceededException&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,reason);

@override
String toString() {
  return 'MvtDecodeException.limitExceeded(reason: $reason)';
}


}

/// @nodoc
abstract mixin class $MvtLimitExceededExceptionCopyWith<$Res> implements $MvtDecodeExceptionCopyWith<$Res> {
  factory $MvtLimitExceededExceptionCopyWith(MvtLimitExceededException value, $Res Function(MvtLimitExceededException) _then) = _$MvtLimitExceededExceptionCopyWithImpl;
@useResult
$Res call({
 String reason
});




}
/// @nodoc
class _$MvtLimitExceededExceptionCopyWithImpl<$Res>
    implements $MvtLimitExceededExceptionCopyWith<$Res> {
  _$MvtLimitExceededExceptionCopyWithImpl(this._self, this._then);

  final MvtLimitExceededException _self;
  final $Res Function(MvtLimitExceededException) _then;

/// Create a copy of MvtDecodeException
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reason = null,}) {
  return _then(MvtLimitExceededException(
reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
