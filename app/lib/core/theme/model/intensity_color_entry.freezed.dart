// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'intensity_color_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IntensityColorEntry {

@ColorJsonConverter() Color get background; IntensityTextColor get foreground;
/// Create a copy of IntensityColorEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntensityColorEntryCopyWith<IntensityColorEntry> get copyWith => _$IntensityColorEntryCopyWithImpl<IntensityColorEntry>(this as IntensityColorEntry, _$identity);

  /// Serializes this IntensityColorEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntensityColorEntry&&(identical(other.background, background) || other.background == background)&&(identical(other.foreground, foreground) || other.foreground == foreground));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,background,foreground);

@override
String toString() {
  return 'IntensityColorEntry(background: $background, foreground: $foreground)';
}


}

/// @nodoc
abstract mixin class $IntensityColorEntryCopyWith<$Res>  {
  factory $IntensityColorEntryCopyWith(IntensityColorEntry value, $Res Function(IntensityColorEntry) _then) = _$IntensityColorEntryCopyWithImpl;
@useResult
$Res call({
@ColorJsonConverter() Color background, IntensityTextColor foreground
});


$IntensityTextColorCopyWith<$Res> get foreground;

}
/// @nodoc
class _$IntensityColorEntryCopyWithImpl<$Res>
    implements $IntensityColorEntryCopyWith<$Res> {
  _$IntensityColorEntryCopyWithImpl(this._self, this._then);

  final IntensityColorEntry _self;
  final $Res Function(IntensityColorEntry) _then;

/// Create a copy of IntensityColorEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? background = null,Object? foreground = null,}) {
  return _then(_self.copyWith(
background: null == background ? _self.background : background // ignore: cast_nullable_to_non_nullable
as Color,foreground: null == foreground ? _self.foreground : foreground // ignore: cast_nullable_to_non_nullable
as IntensityTextColor,
  ));
}
/// Create a copy of IntensityColorEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IntensityTextColorCopyWith<$Res> get foreground {
  
  return $IntensityTextColorCopyWith<$Res>(_self.foreground, (value) {
    return _then(_self.copyWith(foreground: value));
  });
}
}


/// Adds pattern-matching-related methods to [IntensityColorEntry].
extension IntensityColorEntryPatterns on IntensityColorEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IntensityColorEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IntensityColorEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IntensityColorEntry value)  $default,){
final _that = this;
switch (_that) {
case _IntensityColorEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IntensityColorEntry value)?  $default,){
final _that = this;
switch (_that) {
case _IntensityColorEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@ColorJsonConverter()  Color background,  IntensityTextColor foreground)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IntensityColorEntry() when $default != null:
return $default(_that.background,_that.foreground);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@ColorJsonConverter()  Color background,  IntensityTextColor foreground)  $default,) {final _that = this;
switch (_that) {
case _IntensityColorEntry():
return $default(_that.background,_that.foreground);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@ColorJsonConverter()  Color background,  IntensityTextColor foreground)?  $default,) {final _that = this;
switch (_that) {
case _IntensityColorEntry() when $default != null:
return $default(_that.background,_that.foreground);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IntensityColorEntry extends IntensityColorEntry {
  const _IntensityColorEntry({@ColorJsonConverter() required this.background, required this.foreground}): super._();
  factory _IntensityColorEntry.fromJson(Map<String, dynamic> json) => _$IntensityColorEntryFromJson(json);

@override@ColorJsonConverter() final  Color background;
@override final  IntensityTextColor foreground;

/// Create a copy of IntensityColorEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntensityColorEntryCopyWith<_IntensityColorEntry> get copyWith => __$IntensityColorEntryCopyWithImpl<_IntensityColorEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IntensityColorEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntensityColorEntry&&(identical(other.background, background) || other.background == background)&&(identical(other.foreground, foreground) || other.foreground == foreground));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,background,foreground);

@override
String toString() {
  return 'IntensityColorEntry(background: $background, foreground: $foreground)';
}


}

/// @nodoc
abstract mixin class _$IntensityColorEntryCopyWith<$Res> implements $IntensityColorEntryCopyWith<$Res> {
  factory _$IntensityColorEntryCopyWith(_IntensityColorEntry value, $Res Function(_IntensityColorEntry) _then) = __$IntensityColorEntryCopyWithImpl;
@override @useResult
$Res call({
@ColorJsonConverter() Color background, IntensityTextColor foreground
});


@override $IntensityTextColorCopyWith<$Res> get foreground;

}
/// @nodoc
class __$IntensityColorEntryCopyWithImpl<$Res>
    implements _$IntensityColorEntryCopyWith<$Res> {
  __$IntensityColorEntryCopyWithImpl(this._self, this._then);

  final _IntensityColorEntry _self;
  final $Res Function(_IntensityColorEntry) _then;

/// Create a copy of IntensityColorEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? background = null,Object? foreground = null,}) {
  return _then(_IntensityColorEntry(
background: null == background ? _self.background : background // ignore: cast_nullable_to_non_nullable
as Color,foreground: null == foreground ? _self.foreground : foreground // ignore: cast_nullable_to_non_nullable
as IntensityTextColor,
  ));
}

/// Create a copy of IntensityColorEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IntensityTextColorCopyWith<$Res> get foreground {
  
  return $IntensityTextColorCopyWith<$Res>(_self.foreground, (value) {
    return _then(_self.copyWith(foreground: value));
  });
}
}

// dart format on
