// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Test {

 String get targetDeviceId;
/// Create a copy of Test
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TestCopyWith<Test> get copyWith => _$TestCopyWithImpl<Test>(this as Test, _$identity);

  /// Serializes this Test to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Test&&(identical(other.targetDeviceId, targetDeviceId) || other.targetDeviceId == targetDeviceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,targetDeviceId);

@override
String toString() {
  return 'Test(targetDeviceId: $targetDeviceId)';
}


}

/// @nodoc
abstract mixin class $TestCopyWith<$Res>  {
  factory $TestCopyWith(Test value, $Res Function(Test) _then) = _$TestCopyWithImpl;
@useResult
$Res call({
 String targetDeviceId
});




}
/// @nodoc
class _$TestCopyWithImpl<$Res>
    implements $TestCopyWith<$Res> {
  _$TestCopyWithImpl(this._self, this._then);

  final Test _self;
  final $Res Function(Test) _then;

/// Create a copy of Test
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? targetDeviceId = null,}) {
  return _then(Test(
targetDeviceId: null == targetDeviceId ? _self.targetDeviceId : targetDeviceId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Test].
extension TestPatterns on Test {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Test value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Test() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Test value)  $default,){
final _that = this;
switch (_that) {
case _Test():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Test value)?  $default,){
final _that = this;
switch (_that) {
case _Test() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String targetDeviceId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Test() when $default != null:
return $default(_that.targetDeviceId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String targetDeviceId)  $default,) {final _that = this;
switch (_that) {
case _Test():
return $default(_that.targetDeviceId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String targetDeviceId)?  $default,) {final _that = this;
switch (_that) {
case _Test() when $default != null:
return $default(_that.targetDeviceId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Test implements Test {
  const _Test({required this.targetDeviceId});
  factory _Test.fromJson(Map<String, dynamic> json) => _$TestFromJson(json);

@override final  String targetDeviceId;

/// Create a copy of Test
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TestCopyWith<_Test> get copyWith => __$TestCopyWithImpl<_Test>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Test&&(identical(other.targetDeviceId, targetDeviceId) || other.targetDeviceId == targetDeviceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,targetDeviceId);

@override
String toString() {
  return 'Test(targetDeviceId: $targetDeviceId)';
}


}

/// @nodoc
abstract mixin class _$TestCopyWith<$Res> implements $TestCopyWith<$Res> {
  factory _$TestCopyWith(_Test value, $Res Function(_Test) _then) = __$TestCopyWithImpl;
@override @useResult
$Res call({
 String targetDeviceId
});




}
/// @nodoc
class __$TestCopyWithImpl<$Res>
    implements _$TestCopyWith<$Res> {
  __$TestCopyWithImpl(this._self, this._then);

  final _Test _self;
  final $Res Function(_Test) _then;

/// Create a copy of Test
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? targetDeviceId = null,}) {
  return _then(_Test(
targetDeviceId: null == targetDeviceId ? _self.targetDeviceId : targetDeviceId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
