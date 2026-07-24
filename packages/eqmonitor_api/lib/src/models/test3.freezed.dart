// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test3.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Test3 {

 String get targetDeviceId;
/// Create a copy of Test3
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$Test3CopyWith<Test3> get copyWith => _$Test3CopyWithImpl<Test3>(this as Test3, _$identity);

  /// Serializes this Test3 to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Test3&&(identical(other.targetDeviceId, targetDeviceId) || other.targetDeviceId == targetDeviceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,targetDeviceId);

@override
String toString() {
  return 'Test3(targetDeviceId: $targetDeviceId)';
}


}

/// @nodoc
abstract mixin class $Test3CopyWith<$Res>  {
  factory $Test3CopyWith(Test3 value, $Res Function(Test3) _then) = _$Test3CopyWithImpl;
@useResult
$Res call({
 String targetDeviceId
});




}
/// @nodoc
class _$Test3CopyWithImpl<$Res>
    implements $Test3CopyWith<$Res> {
  _$Test3CopyWithImpl(this._self, this._then);

  final Test3 _self;
  final $Res Function(Test3) _then;

/// Create a copy of Test3
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? targetDeviceId = null,}) {
  return _then(_self.copyWith(
targetDeviceId: null == targetDeviceId ? _self.targetDeviceId : targetDeviceId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Test3].
extension Test3Patterns on Test3 {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Test3 value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Test3() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Test3 value)  $default,){
final _that = this;
switch (_that) {
case _Test3():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Test3 value)?  $default,){
final _that = this;
switch (_that) {
case _Test3() when $default != null:
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
case _Test3() when $default != null:
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
case _Test3():
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
case _Test3() when $default != null:
return $default(_that.targetDeviceId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Test3 implements Test3 {
  const _Test3({required this.targetDeviceId});
  factory _Test3.fromJson(Map<String, dynamic> json) => _$Test3FromJson(json);

@override final  String targetDeviceId;

/// Create a copy of Test3
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$Test3CopyWith<_Test3> get copyWith => __$Test3CopyWithImpl<_Test3>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$Test3ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Test3&&(identical(other.targetDeviceId, targetDeviceId) || other.targetDeviceId == targetDeviceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,targetDeviceId);

@override
String toString() {
  return 'Test3(targetDeviceId: $targetDeviceId)';
}


}

/// @nodoc
abstract mixin class _$Test3CopyWith<$Res> implements $Test3CopyWith<$Res> {
  factory _$Test3CopyWith(_Test3 value, $Res Function(_Test3) _then) = __$Test3CopyWithImpl;
@override @useResult
$Res call({
 String targetDeviceId
});




}
/// @nodoc
class __$Test3CopyWithImpl<$Res>
    implements _$Test3CopyWith<$Res> {
  __$Test3CopyWithImpl(this._self, this._then);

  final _Test3 _self;
  final $Res Function(_Test3) _then;

/// Create a copy of Test3
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? targetDeviceId = null,}) {
  return _then(_Test3(
targetDeviceId: null == targetDeviceId ? _self.targetDeviceId : targetDeviceId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
