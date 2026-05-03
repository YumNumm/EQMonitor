// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comments2.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Comments2 {

 String get free;
/// Create a copy of Comments2
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$Comments2CopyWith<Comments2> get copyWith => _$Comments2CopyWithImpl<Comments2>(this as Comments2, _$identity);

  /// Serializes this Comments2 to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Comments2&&(identical(other.free, free) || other.free == free));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,free);

@override
String toString() {
  return 'Comments2(free: $free)';
}


}

/// @nodoc
abstract mixin class $Comments2CopyWith<$Res>  {
  factory $Comments2CopyWith(Comments2 value, $Res Function(Comments2) _then) = _$Comments2CopyWithImpl;
@useResult
$Res call({
 String free
});




}
/// @nodoc
class _$Comments2CopyWithImpl<$Res>
    implements $Comments2CopyWith<$Res> {
  _$Comments2CopyWithImpl(this._self, this._then);

  final Comments2 _self;
  final $Res Function(Comments2) _then;

/// Create a copy of Comments2
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? free = null,}) {
  return _then(_self.copyWith(
free: null == free ? _self.free : free // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Comments2].
extension Comments2Patterns on Comments2 {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Comments2 value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Comments2() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Comments2 value)  $default,){
final _that = this;
switch (_that) {
case _Comments2():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Comments2 value)?  $default,){
final _that = this;
switch (_that) {
case _Comments2() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String free)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Comments2() when $default != null:
return $default(_that.free);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String free)  $default,) {final _that = this;
switch (_that) {
case _Comments2():
return $default(_that.free);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String free)?  $default,) {final _that = this;
switch (_that) {
case _Comments2() when $default != null:
return $default(_that.free);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Comments2 implements Comments2 {
  const _Comments2({required this.free});
  factory _Comments2.fromJson(Map<String, dynamic> json) => _$Comments2FromJson(json);

@override final  String free;

/// Create a copy of Comments2
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$Comments2CopyWith<_Comments2> get copyWith => __$Comments2CopyWithImpl<_Comments2>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$Comments2ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Comments2&&(identical(other.free, free) || other.free == free));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,free);

@override
String toString() {
  return 'Comments2(free: $free)';
}


}

/// @nodoc
abstract mixin class _$Comments2CopyWith<$Res> implements $Comments2CopyWith<$Res> {
  factory _$Comments2CopyWith(_Comments2 value, $Res Function(_Comments2) _then) = __$Comments2CopyWithImpl;
@override @useResult
$Res call({
 String free
});




}
/// @nodoc
class __$Comments2CopyWithImpl<$Res>
    implements _$Comments2CopyWith<$Res> {
  __$Comments2CopyWithImpl(this._self, this._then);

  final _Comments2 _self;
  final $Res Function(_Comments2) _then;

/// Create a copy of Comments2
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? free = null,}) {
  return _then(_Comments2(
free: null == free ? _self.free : free // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
