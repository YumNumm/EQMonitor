// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comments3.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Comments3 {

@JsonKey(includeIfNull: false) String? get free;@JsonKey(includeIfNull: false) Warning? get warning;
/// Create a copy of Comments3
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$Comments3CopyWith<Comments3> get copyWith => _$Comments3CopyWithImpl<Comments3>(this as Comments3, _$identity);

  /// Serializes this Comments3 to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Comments3&&(identical(other.free, free) || other.free == free)&&(identical(other.warning, warning) || other.warning == warning));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,free,warning);

@override
String toString() {
  return 'Comments3(free: $free, warning: $warning)';
}


}

/// @nodoc
abstract mixin class $Comments3CopyWith<$Res>  {
  factory $Comments3CopyWith(Comments3 value, $Res Function(Comments3) _then) = _$Comments3CopyWithImpl;
@useResult
$Res call({
@JsonKey(includeIfNull: false) String? free,@JsonKey(includeIfNull: false) Warning? warning
});


$WarningCopyWith<$Res>? get warning;

}
/// @nodoc
class _$Comments3CopyWithImpl<$Res>
    implements $Comments3CopyWith<$Res> {
  _$Comments3CopyWithImpl(this._self, this._then);

  final Comments3 _self;
  final $Res Function(Comments3) _then;

/// Create a copy of Comments3
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? free = freezed,Object? warning = freezed,}) {
  return _then(_self.copyWith(
free: freezed == free ? _self.free : free // ignore: cast_nullable_to_non_nullable
as String?,warning: freezed == warning ? _self.warning : warning // ignore: cast_nullable_to_non_nullable
as Warning?,
  ));
}
/// Create a copy of Comments3
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WarningCopyWith<$Res>? get warning {
    if (_self.warning == null) {
    return null;
  }

  return $WarningCopyWith<$Res>(_self.warning!, (value) {
    return _then(_self.copyWith(warning: value));
  });
}
}


/// Adds pattern-matching-related methods to [Comments3].
extension Comments3Patterns on Comments3 {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Comments3 value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Comments3() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Comments3 value)  $default,){
final _that = this;
switch (_that) {
case _Comments3():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Comments3 value)?  $default,){
final _that = this;
switch (_that) {
case _Comments3() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false)  String? free, @JsonKey(includeIfNull: false)  Warning? warning)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Comments3() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false)  String? free, @JsonKey(includeIfNull: false)  Warning? warning)  $default,) {final _that = this;
switch (_that) {
case _Comments3():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeIfNull: false)  String? free, @JsonKey(includeIfNull: false)  Warning? warning)?  $default,) {final _that = this;
switch (_that) {
case _Comments3() when $default != null:
return $default(_that.free,_that.warning);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Comments3 implements Comments3 {
  const _Comments3({@JsonKey(includeIfNull: false) this.free, @JsonKey(includeIfNull: false) this.warning});
  factory _Comments3.fromJson(Map<String, dynamic> json) => _$Comments3FromJson(json);

@override@JsonKey(includeIfNull: false) final  String? free;
@override@JsonKey(includeIfNull: false) final  Warning? warning;

/// Create a copy of Comments3
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$Comments3CopyWith<_Comments3> get copyWith => __$Comments3CopyWithImpl<_Comments3>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$Comments3ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Comments3&&(identical(other.free, free) || other.free == free)&&(identical(other.warning, warning) || other.warning == warning));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,free,warning);

@override
String toString() {
  return 'Comments3(free: $free, warning: $warning)';
}


}

/// @nodoc
abstract mixin class _$Comments3CopyWith<$Res> implements $Comments3CopyWith<$Res> {
  factory _$Comments3CopyWith(_Comments3 value, $Res Function(_Comments3) _then) = __$Comments3CopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeIfNull: false) String? free,@JsonKey(includeIfNull: false) Warning? warning
});


@override $WarningCopyWith<$Res>? get warning;

}
/// @nodoc
class __$Comments3CopyWithImpl<$Res>
    implements _$Comments3CopyWith<$Res> {
  __$Comments3CopyWithImpl(this._self, this._then);

  final _Comments3 _self;
  final $Res Function(_Comments3) _then;

/// Create a copy of Comments3
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? free = freezed,Object? warning = freezed,}) {
  return _then(_Comments3(
free: freezed == free ? _self.free : free // ignore: cast_nullable_to_non_nullable
as String?,warning: freezed == warning ? _self.warning : warning // ignore: cast_nullable_to_non_nullable
as Warning?,
  ));
}

/// Create a copy of Comments3
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WarningCopyWith<$Res>? get warning {
    if (_self.warning == null) {
    return null;
  }

  return $WarningCopyWith<$Res>(_self.warning!, (value) {
    return _then(_self.copyWith(warning: value));
  });
}
}

// dart format on
