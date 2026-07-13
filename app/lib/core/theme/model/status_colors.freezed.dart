// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'status_colors.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StatusColors {

@ColorJsonConverter() Color get success;@ColorJsonConverter() Color get warning;
/// Create a copy of StatusColors
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StatusColorsCopyWith<StatusColors> get copyWith => _$StatusColorsCopyWithImpl<StatusColors>(this as StatusColors, _$identity);

  /// Serializes this StatusColors to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatusColors&&(identical(other.success, success) || other.success == success)&&(identical(other.warning, warning) || other.warning == warning));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,warning);

@override
String toString() {
  return 'StatusColors(success: $success, warning: $warning)';
}


}

/// @nodoc
abstract mixin class $StatusColorsCopyWith<$Res>  {
  factory $StatusColorsCopyWith(StatusColors value, $Res Function(StatusColors) _then) = _$StatusColorsCopyWithImpl;
@useResult
$Res call({
@ColorJsonConverter() Color success,@ColorJsonConverter() Color warning
});




}
/// @nodoc
class _$StatusColorsCopyWithImpl<$Res>
    implements $StatusColorsCopyWith<$Res> {
  _$StatusColorsCopyWithImpl(this._self, this._then);

  final StatusColors _self;
  final $Res Function(StatusColors) _then;

/// Create a copy of StatusColors
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? warning = null,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as Color,warning: null == warning ? _self.warning : warning // ignore: cast_nullable_to_non_nullable
as Color,
  ));
}

}


/// Adds pattern-matching-related methods to [StatusColors].
extension StatusColorsPatterns on StatusColors {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StatusColors value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StatusColors() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StatusColors value)  $default,){
final _that = this;
switch (_that) {
case _StatusColors():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StatusColors value)?  $default,){
final _that = this;
switch (_that) {
case _StatusColors() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@ColorJsonConverter()  Color success, @ColorJsonConverter()  Color warning)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StatusColors() when $default != null:
return $default(_that.success,_that.warning);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@ColorJsonConverter()  Color success, @ColorJsonConverter()  Color warning)  $default,) {final _that = this;
switch (_that) {
case _StatusColors():
return $default(_that.success,_that.warning);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@ColorJsonConverter()  Color success, @ColorJsonConverter()  Color warning)?  $default,) {final _that = this;
switch (_that) {
case _StatusColors() when $default != null:
return $default(_that.success,_that.warning);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StatusColors implements StatusColors {
  const _StatusColors({@ColorJsonConverter() required this.success, @ColorJsonConverter() required this.warning});
  factory _StatusColors.fromJson(Map<String, dynamic> json) => _$StatusColorsFromJson(json);

@override@ColorJsonConverter() final  Color success;
@override@ColorJsonConverter() final  Color warning;

/// Create a copy of StatusColors
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StatusColorsCopyWith<_StatusColors> get copyWith => __$StatusColorsCopyWithImpl<_StatusColors>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StatusColorsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StatusColors&&(identical(other.success, success) || other.success == success)&&(identical(other.warning, warning) || other.warning == warning));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,warning);

@override
String toString() {
  return 'StatusColors(success: $success, warning: $warning)';
}


}

/// @nodoc
abstract mixin class _$StatusColorsCopyWith<$Res> implements $StatusColorsCopyWith<$Res> {
  factory _$StatusColorsCopyWith(_StatusColors value, $Res Function(_StatusColors) _then) = __$StatusColorsCopyWithImpl;
@override @useResult
$Res call({
@ColorJsonConverter() Color success,@ColorJsonConverter() Color warning
});




}
/// @nodoc
class __$StatusColorsCopyWithImpl<$Res>
    implements _$StatusColorsCopyWith<$Res> {
  __$StatusColorsCopyWithImpl(this._self, this._then);

  final _StatusColors _self;
  final $Res Function(_StatusColors) _then;

/// Create a copy of StatusColors
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? warning = null,}) {
  return _then(_StatusColors(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as Color,warning: null == warning ? _self.warning : warning // ignore: cast_nullable_to_non_nullable
as Color,
  ));
}


}

// dart format on
