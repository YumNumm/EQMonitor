// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_notification_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TestNotificationRequest {

 TestNotificationType get type;
/// Create a copy of TestNotificationRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TestNotificationRequestCopyWith<TestNotificationRequest> get copyWith => _$TestNotificationRequestCopyWithImpl<TestNotificationRequest>(this as TestNotificationRequest, _$identity);

  /// Serializes this TestNotificationRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TestNotificationRequest&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type);

@override
String toString() {
  return 'TestNotificationRequest(type: $type)';
}


}

/// @nodoc
abstract mixin class $TestNotificationRequestCopyWith<$Res>  {
  factory $TestNotificationRequestCopyWith(TestNotificationRequest value, $Res Function(TestNotificationRequest) _then) = _$TestNotificationRequestCopyWithImpl;
@useResult
$Res call({
 TestNotificationType type
});




}
/// @nodoc
class _$TestNotificationRequestCopyWithImpl<$Res>
    implements $TestNotificationRequestCopyWith<$Res> {
  _$TestNotificationRequestCopyWithImpl(this._self, this._then);

  final TestNotificationRequest _self;
  final $Res Function(TestNotificationRequest) _then;

/// Create a copy of TestNotificationRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,}) {
  return _then(TestNotificationRequest(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TestNotificationType,
  ));
}

}


/// Adds pattern-matching-related methods to [TestNotificationRequest].
extension TestNotificationRequestPatterns on TestNotificationRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TestNotificationRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TestNotificationRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TestNotificationRequest value)  $default,){
final _that = this;
switch (_that) {
case _TestNotificationRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TestNotificationRequest value)?  $default,){
final _that = this;
switch (_that) {
case _TestNotificationRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TestNotificationType type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TestNotificationRequest() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TestNotificationType type)  $default,) {final _that = this;
switch (_that) {
case _TestNotificationRequest():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TestNotificationType type)?  $default,) {final _that = this;
switch (_that) {
case _TestNotificationRequest() when $default != null:
return $default(_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TestNotificationRequest implements TestNotificationRequest {
  const _TestNotificationRequest({required this.type});
  factory _TestNotificationRequest.fromJson(Map<String, dynamic> json) => _$TestNotificationRequestFromJson(json);

@override final  TestNotificationType type;

/// Create a copy of TestNotificationRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TestNotificationRequestCopyWith<_TestNotificationRequest> get copyWith => __$TestNotificationRequestCopyWithImpl<_TestNotificationRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TestNotificationRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TestNotificationRequest&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type);

@override
String toString() {
  return 'TestNotificationRequest(type: $type)';
}


}

/// @nodoc
abstract mixin class _$TestNotificationRequestCopyWith<$Res> implements $TestNotificationRequestCopyWith<$Res> {
  factory _$TestNotificationRequestCopyWith(_TestNotificationRequest value, $Res Function(_TestNotificationRequest) _then) = __$TestNotificationRequestCopyWithImpl;
@override @useResult
$Res call({
 TestNotificationType type
});




}
/// @nodoc
class __$TestNotificationRequestCopyWithImpl<$Res>
    implements _$TestNotificationRequestCopyWith<$Res> {
  __$TestNotificationRequestCopyWithImpl(this._self, this._then);

  final _TestNotificationRequest _self;
  final $Res Function(_TestNotificationRequest) _then;

/// Create a copy of TestNotificationRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,}) {
  return _then(_TestNotificationRequest(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TestNotificationType,
  ));
}


}

// dart format on
