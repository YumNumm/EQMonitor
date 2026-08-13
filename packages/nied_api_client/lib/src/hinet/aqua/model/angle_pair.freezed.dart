// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'angle_pair.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AnglePair {

 double get first; double get second;
/// Create a copy of AnglePair
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnglePairCopyWith<AnglePair> get copyWith => _$AnglePairCopyWithImpl<AnglePair>(this as AnglePair, _$identity);

  /// Serializes this AnglePair to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnglePair&&(identical(other.first, first) || other.first == first)&&(identical(other.second, second) || other.second == second));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,first,second);

@override
String toString() {
  return 'AnglePair(first: $first, second: $second)';
}


}

/// @nodoc
abstract mixin class $AnglePairCopyWith<$Res>  {
  factory $AnglePairCopyWith(AnglePair value, $Res Function(AnglePair) _then) = _$AnglePairCopyWithImpl;
@useResult
$Res call({
 double first, double second
});




}
/// @nodoc
class _$AnglePairCopyWithImpl<$Res>
    implements $AnglePairCopyWith<$Res> {
  _$AnglePairCopyWithImpl(this._self, this._then);

  final AnglePair _self;
  final $Res Function(AnglePair) _then;

/// Create a copy of AnglePair
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? first = null,Object? second = null,}) {
  return _then(AnglePair(
first: null == first ? _self.first : first // ignore: cast_nullable_to_non_nullable
as double,second: null == second ? _self.second : second // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [AnglePair].
extension AnglePairPatterns on AnglePair {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AnglePair value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AnglePair() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AnglePair value)  $default,){
final _that = this;
switch (_that) {
case _AnglePair():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AnglePair value)?  $default,){
final _that = this;
switch (_that) {
case _AnglePair() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double first,  double second)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AnglePair() when $default != null:
return $default(_that.first,_that.second);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double first,  double second)  $default,) {final _that = this;
switch (_that) {
case _AnglePair():
return $default(_that.first,_that.second);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double first,  double second)?  $default,) {final _that = this;
switch (_that) {
case _AnglePair() when $default != null:
return $default(_that.first,_that.second);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AnglePair implements AnglePair {
  const _AnglePair({required this.first, required this.second});
  factory _AnglePair.fromJson(Map<String, dynamic> json) => _$AnglePairFromJson(json);

@override final  double first;
@override final  double second;

/// Create a copy of AnglePair
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnglePairCopyWith<_AnglePair> get copyWith => __$AnglePairCopyWithImpl<_AnglePair>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnglePairToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AnglePair&&(identical(other.first, first) || other.first == first)&&(identical(other.second, second) || other.second == second));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,first,second);

@override
String toString() {
  return 'AnglePair(first: $first, second: $second)';
}


}

/// @nodoc
abstract mixin class _$AnglePairCopyWith<$Res> implements $AnglePairCopyWith<$Res> {
  factory _$AnglePairCopyWith(_AnglePair value, $Res Function(_AnglePair) _then) = __$AnglePairCopyWithImpl;
@override @useResult
$Res call({
 double first, double second
});




}
/// @nodoc
class __$AnglePairCopyWithImpl<$Res>
    implements _$AnglePairCopyWith<$Res> {
  __$AnglePairCopyWithImpl(this._self, this._then);

  final _AnglePair _self;
  final $Res Function(_AnglePair) _then;

/// Create a copy of AnglePair
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? first = null,Object? second = null,}) {
  return _then(_AnglePair(
first: null == first ? _self.first : first // ignore: cast_nullable_to_non_nullable
as double,second: null == second ? _self.second : second // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
