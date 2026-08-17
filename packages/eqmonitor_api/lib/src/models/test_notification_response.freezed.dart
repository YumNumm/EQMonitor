// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_notification_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TestNotificationResponse {

 String get message; Framework get framework;
/// Create a copy of TestNotificationResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TestNotificationResponseCopyWith<TestNotificationResponse> get copyWith => _$TestNotificationResponseCopyWithImpl<TestNotificationResponse>(this as TestNotificationResponse, _$identity);

  /// Serializes this TestNotificationResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TestNotificationResponse&&(identical(other.message, message) || other.message == message)&&(identical(other.framework, framework) || other.framework == framework));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message,framework);

@override
String toString() {
  return 'TestNotificationResponse(message: $message, framework: $framework)';
}


}

/// @nodoc
abstract mixin class $TestNotificationResponseCopyWith<$Res>  {
  factory $TestNotificationResponseCopyWith(TestNotificationResponse value, $Res Function(TestNotificationResponse) _then) = _$TestNotificationResponseCopyWithImpl;
@useResult
$Res call({
 String message, Framework framework
});




}
/// @nodoc
class _$TestNotificationResponseCopyWithImpl<$Res>
    implements $TestNotificationResponseCopyWith<$Res> {
  _$TestNotificationResponseCopyWithImpl(this._self, this._then);

  final TestNotificationResponse _self;
  final $Res Function(TestNotificationResponse) _then;

/// Create a copy of TestNotificationResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = null,Object? framework = null,}) {
  return _then(TestNotificationResponse(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,framework: null == framework ? _self.framework : framework // ignore: cast_nullable_to_non_nullable
as Framework,
  ));
}

}


/// Adds pattern-matching-related methods to [TestNotificationResponse].
extension TestNotificationResponsePatterns on TestNotificationResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TestNotificationResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TestNotificationResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TestNotificationResponse value)  $default,){
final _that = this;
switch (_that) {
case _TestNotificationResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TestNotificationResponse value)?  $default,){
final _that = this;
switch (_that) {
case _TestNotificationResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String message,  Framework framework)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TestNotificationResponse() when $default != null:
return $default(_that.message,_that.framework);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String message,  Framework framework)  $default,) {final _that = this;
switch (_that) {
case _TestNotificationResponse():
return $default(_that.message,_that.framework);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String message,  Framework framework)?  $default,) {final _that = this;
switch (_that) {
case _TestNotificationResponse() when $default != null:
return $default(_that.message,_that.framework);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TestNotificationResponse implements TestNotificationResponse {
  const _TestNotificationResponse({required this.message, required this.framework});
  factory _TestNotificationResponse.fromJson(Map<String, dynamic> json) => _$TestNotificationResponseFromJson(json);

@override final  String message;
@override final  Framework framework;

/// Create a copy of TestNotificationResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TestNotificationResponseCopyWith<_TestNotificationResponse> get copyWith => __$TestNotificationResponseCopyWithImpl<_TestNotificationResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TestNotificationResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TestNotificationResponse&&(identical(other.message, message) || other.message == message)&&(identical(other.framework, framework) || other.framework == framework));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message,framework);

@override
String toString() {
  return 'TestNotificationResponse(message: $message, framework: $framework)';
}


}

/// @nodoc
abstract mixin class _$TestNotificationResponseCopyWith<$Res> implements $TestNotificationResponseCopyWith<$Res> {
  factory _$TestNotificationResponseCopyWith(_TestNotificationResponse value, $Res Function(_TestNotificationResponse) _then) = __$TestNotificationResponseCopyWithImpl;
@override @useResult
$Res call({
 String message, Framework framework
});




}
/// @nodoc
class __$TestNotificationResponseCopyWithImpl<$Res>
    implements _$TestNotificationResponseCopyWith<$Res> {
  __$TestNotificationResponseCopyWithImpl(this._self, this._then);

  final _TestNotificationResponse _self;
  final $Res Function(_TestNotificationResponse) _then;

/// Create a copy of TestNotificationResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? framework = null,}) {
  return _then(_TestNotificationResponse(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,framework: null == framework ? _self.framework : framework // ignore: cast_nullable_to_non_nullable
as Framework,
  ));
}


}

// dart format on
