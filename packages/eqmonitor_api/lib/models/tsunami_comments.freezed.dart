// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_comments.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TsunamiComments {

 String get free; Warning get warning;
/// Create a copy of TsunamiComments
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiCommentsCopyWith<TsunamiComments> get copyWith => _$TsunamiCommentsCopyWithImpl<TsunamiComments>(this as TsunamiComments, _$identity);

  /// Serializes this TsunamiComments to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiComments&&(identical(other.free, free) || other.free == free)&&(identical(other.warning, warning) || other.warning == warning));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,free,warning);

@override
String toString() {
  return 'TsunamiComments(free: $free, warning: $warning)';
}


}

/// @nodoc
abstract mixin class $TsunamiCommentsCopyWith<$Res>  {
  factory $TsunamiCommentsCopyWith(TsunamiComments value, $Res Function(TsunamiComments) _then) = _$TsunamiCommentsCopyWithImpl;
@useResult
$Res call({
 String free, Warning warning
});


$WarningCopyWith<$Res> get warning;

}
/// @nodoc
class _$TsunamiCommentsCopyWithImpl<$Res>
    implements $TsunamiCommentsCopyWith<$Res> {
  _$TsunamiCommentsCopyWithImpl(this._self, this._then);

  final TsunamiComments _self;
  final $Res Function(TsunamiComments) _then;

/// Create a copy of TsunamiComments
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? free = null,Object? warning = null,}) {
  return _then(_self.copyWith(
free: null == free ? _self.free : free // ignore: cast_nullable_to_non_nullable
as String,warning: null == warning ? _self.warning : warning // ignore: cast_nullable_to_non_nullable
as Warning,
  ));
}
/// Create a copy of TsunamiComments
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WarningCopyWith<$Res> get warning {
  
  return $WarningCopyWith<$Res>(_self.warning, (value) {
    return _then(_self.copyWith(warning: value));
  });
}
}


/// Adds pattern-matching-related methods to [TsunamiComments].
extension TsunamiCommentsPatterns on TsunamiComments {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiComments value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiComments() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiComments value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiComments():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiComments value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiComments() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String free,  Warning warning)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiComments() when $default != null:
return $default(_that.free,_that.warning);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String free,  Warning warning)  $default,) {final _that = this;
switch (_that) {
case _TsunamiComments():
return $default(_that.free,_that.warning);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String free,  Warning warning)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiComments() when $default != null:
return $default(_that.free,_that.warning);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TsunamiComments implements TsunamiComments {
  const _TsunamiComments({required this.free, required this.warning});
  factory _TsunamiComments.fromJson(Map<String, dynamic> json) => _$TsunamiCommentsFromJson(json);

@override final  String free;
@override final  Warning warning;

/// Create a copy of TsunamiComments
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiCommentsCopyWith<_TsunamiComments> get copyWith => __$TsunamiCommentsCopyWithImpl<_TsunamiComments>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiCommentsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiComments&&(identical(other.free, free) || other.free == free)&&(identical(other.warning, warning) || other.warning == warning));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,free,warning);

@override
String toString() {
  return 'TsunamiComments(free: $free, warning: $warning)';
}


}

/// @nodoc
abstract mixin class _$TsunamiCommentsCopyWith<$Res> implements $TsunamiCommentsCopyWith<$Res> {
  factory _$TsunamiCommentsCopyWith(_TsunamiComments value, $Res Function(_TsunamiComments) _then) = __$TsunamiCommentsCopyWithImpl;
@override @useResult
$Res call({
 String free, Warning warning
});


@override $WarningCopyWith<$Res> get warning;

}
/// @nodoc
class __$TsunamiCommentsCopyWithImpl<$Res>
    implements _$TsunamiCommentsCopyWith<$Res> {
  __$TsunamiCommentsCopyWithImpl(this._self, this._then);

  final _TsunamiComments _self;
  final $Res Function(_TsunamiComments) _then;

/// Create a copy of TsunamiComments
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? free = null,Object? warning = null,}) {
  return _then(_TsunamiComments(
free: null == free ? _self.free : free // ignore: cast_nullable_to_non_nullable
as String,warning: null == warning ? _self.warning : warning // ignore: cast_nullable_to_non_nullable
as Warning,
  ));
}

/// Create a copy of TsunamiComments
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WarningCopyWith<$Res> get warning {
  
  return $WarningCopyWith<$Res>(_self.warning, (value) {
    return _then(_self.copyWith(warning: value));
  });
}
}

// dart format on
