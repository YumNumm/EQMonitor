// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_notification_delivery_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TestNotificationDeliveryResult {

 String get message; TestNotificationFramework get framework;
/// Create a copy of TestNotificationDeliveryResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TestNotificationDeliveryResultCopyWith<TestNotificationDeliveryResult> get copyWith => _$TestNotificationDeliveryResultCopyWithImpl<TestNotificationDeliveryResult>(this as TestNotificationDeliveryResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TestNotificationDeliveryResult&&(identical(other.message, message) || other.message == message)&&(identical(other.framework, framework) || other.framework == framework));
}


@override
int get hashCode => Object.hash(runtimeType,message,framework);

@override
String toString() {
  return 'TestNotificationDeliveryResult(message: $message, framework: $framework)';
}


}

/// @nodoc
abstract mixin class $TestNotificationDeliveryResultCopyWith<$Res>  {
  factory $TestNotificationDeliveryResultCopyWith(TestNotificationDeliveryResult value, $Res Function(TestNotificationDeliveryResult) _then) = _$TestNotificationDeliveryResultCopyWithImpl;
@useResult
$Res call({
 String message, TestNotificationFramework framework
});




}
/// @nodoc
class _$TestNotificationDeliveryResultCopyWithImpl<$Res>
    implements $TestNotificationDeliveryResultCopyWith<$Res> {
  _$TestNotificationDeliveryResultCopyWithImpl(this._self, this._then);

  final TestNotificationDeliveryResult _self;
  final $Res Function(TestNotificationDeliveryResult) _then;

/// Create a copy of TestNotificationDeliveryResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = null,Object? framework = null,}) {
  return _then(TestNotificationDeliveryResult(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,framework: null == framework ? _self.framework : framework // ignore: cast_nullable_to_non_nullable
as TestNotificationFramework,
  ));
}

}


/// Adds pattern-matching-related methods to [TestNotificationDeliveryResult].
extension TestNotificationDeliveryResultPatterns on TestNotificationDeliveryResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TestNotificationDeliveryResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TestNotificationDeliveryResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TestNotificationDeliveryResult value)  $default,){
final _that = this;
switch (_that) {
case _TestNotificationDeliveryResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TestNotificationDeliveryResult value)?  $default,){
final _that = this;
switch (_that) {
case _TestNotificationDeliveryResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String message,  TestNotificationFramework framework)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TestNotificationDeliveryResult() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String message,  TestNotificationFramework framework)  $default,) {final _that = this;
switch (_that) {
case _TestNotificationDeliveryResult():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String message,  TestNotificationFramework framework)?  $default,) {final _that = this;
switch (_that) {
case _TestNotificationDeliveryResult() when $default != null:
return $default(_that.message,_that.framework);case _:
  return null;

}
}

}

/// @nodoc


class _TestNotificationDeliveryResult implements TestNotificationDeliveryResult {
  const _TestNotificationDeliveryResult({required this.message, required this.framework});
  

@override final  String message;
@override final  TestNotificationFramework framework;

/// Create a copy of TestNotificationDeliveryResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TestNotificationDeliveryResultCopyWith<_TestNotificationDeliveryResult> get copyWith => __$TestNotificationDeliveryResultCopyWithImpl<_TestNotificationDeliveryResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TestNotificationDeliveryResult&&(identical(other.message, message) || other.message == message)&&(identical(other.framework, framework) || other.framework == framework));
}


@override
int get hashCode => Object.hash(runtimeType,message,framework);

@override
String toString() {
  return 'TestNotificationDeliveryResult(message: $message, framework: $framework)';
}


}

/// @nodoc
abstract mixin class _$TestNotificationDeliveryResultCopyWith<$Res> implements $TestNotificationDeliveryResultCopyWith<$Res> {
  factory _$TestNotificationDeliveryResultCopyWith(_TestNotificationDeliveryResult value, $Res Function(_TestNotificationDeliveryResult) _then) = __$TestNotificationDeliveryResultCopyWithImpl;
@override @useResult
$Res call({
 String message, TestNotificationFramework framework
});




}
/// @nodoc
class __$TestNotificationDeliveryResultCopyWithImpl<$Res>
    implements _$TestNotificationDeliveryResultCopyWith<$Res> {
  __$TestNotificationDeliveryResultCopyWithImpl(this._self, this._then);

  final _TestNotificationDeliveryResult _self;
  final $Res Function(_TestNotificationDeliveryResult) _then;

/// Create a copy of TestNotificationDeliveryResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? framework = null,}) {
  return _then(_TestNotificationDeliveryResult(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,framework: null == framework ? _self.framework : framework // ignore: cast_nullable_to_non_nullable
as TestNotificationFramework,
  ));
}


}

// dart format on
