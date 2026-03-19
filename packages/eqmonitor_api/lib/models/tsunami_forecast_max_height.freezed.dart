// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_forecast_max_height.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TsunamiForecastMaxHeight {

 num get value; bool get over; QualitativeHeight get qualitative;@JsonKey(name: 'is_important') bool get isImportant;
/// Create a copy of TsunamiForecastMaxHeight
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiForecastMaxHeightCopyWith<TsunamiForecastMaxHeight> get copyWith => _$TsunamiForecastMaxHeightCopyWithImpl<TsunamiForecastMaxHeight>(this as TsunamiForecastMaxHeight, _$identity);

  /// Serializes this TsunamiForecastMaxHeight to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiForecastMaxHeight&&(identical(other.value, value) || other.value == value)&&(identical(other.over, over) || other.over == over)&&(identical(other.qualitative, qualitative) || other.qualitative == qualitative)&&(identical(other.isImportant, isImportant) || other.isImportant == isImportant));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,over,qualitative,isImportant);

@override
String toString() {
  return 'TsunamiForecastMaxHeight(value: $value, over: $over, qualitative: $qualitative, isImportant: $isImportant)';
}


}

/// @nodoc
abstract mixin class $TsunamiForecastMaxHeightCopyWith<$Res>  {
  factory $TsunamiForecastMaxHeightCopyWith(TsunamiForecastMaxHeight value, $Res Function(TsunamiForecastMaxHeight) _then) = _$TsunamiForecastMaxHeightCopyWithImpl;
@useResult
$Res call({
 num value, bool over, QualitativeHeight qualitative,@JsonKey(name: 'is_important') bool isImportant
});




}
/// @nodoc
class _$TsunamiForecastMaxHeightCopyWithImpl<$Res>
    implements $TsunamiForecastMaxHeightCopyWith<$Res> {
  _$TsunamiForecastMaxHeightCopyWithImpl(this._self, this._then);

  final TsunamiForecastMaxHeight _self;
  final $Res Function(TsunamiForecastMaxHeight) _then;

/// Create a copy of TsunamiForecastMaxHeight
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,Object? over = null,Object? qualitative = null,Object? isImportant = null,}) {
  return _then(_self.copyWith(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as num,over: null == over ? _self.over : over // ignore: cast_nullable_to_non_nullable
as bool,qualitative: null == qualitative ? _self.qualitative : qualitative // ignore: cast_nullable_to_non_nullable
as QualitativeHeight,isImportant: null == isImportant ? _self.isImportant : isImportant // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TsunamiForecastMaxHeight].
extension TsunamiForecastMaxHeightPatterns on TsunamiForecastMaxHeight {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiForecastMaxHeight value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiForecastMaxHeight() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiForecastMaxHeight value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiForecastMaxHeight():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiForecastMaxHeight value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiForecastMaxHeight() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( num value,  bool over,  QualitativeHeight qualitative, @JsonKey(name: 'is_important')  bool isImportant)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiForecastMaxHeight() when $default != null:
return $default(_that.value,_that.over,_that.qualitative,_that.isImportant);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( num value,  bool over,  QualitativeHeight qualitative, @JsonKey(name: 'is_important')  bool isImportant)  $default,) {final _that = this;
switch (_that) {
case _TsunamiForecastMaxHeight():
return $default(_that.value,_that.over,_that.qualitative,_that.isImportant);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( num value,  bool over,  QualitativeHeight qualitative, @JsonKey(name: 'is_important')  bool isImportant)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiForecastMaxHeight() when $default != null:
return $default(_that.value,_that.over,_that.qualitative,_that.isImportant);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TsunamiForecastMaxHeight implements TsunamiForecastMaxHeight {
  const _TsunamiForecastMaxHeight({required this.value, required this.over, required this.qualitative, @JsonKey(name: 'is_important') required this.isImportant});
  factory _TsunamiForecastMaxHeight.fromJson(Map<String, dynamic> json) => _$TsunamiForecastMaxHeightFromJson(json);

@override final  num value;
@override final  bool over;
@override final  QualitativeHeight qualitative;
@override@JsonKey(name: 'is_important') final  bool isImportant;

/// Create a copy of TsunamiForecastMaxHeight
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiForecastMaxHeightCopyWith<_TsunamiForecastMaxHeight> get copyWith => __$TsunamiForecastMaxHeightCopyWithImpl<_TsunamiForecastMaxHeight>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiForecastMaxHeightToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiForecastMaxHeight&&(identical(other.value, value) || other.value == value)&&(identical(other.over, over) || other.over == over)&&(identical(other.qualitative, qualitative) || other.qualitative == qualitative)&&(identical(other.isImportant, isImportant) || other.isImportant == isImportant));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,over,qualitative,isImportant);

@override
String toString() {
  return 'TsunamiForecastMaxHeight(value: $value, over: $over, qualitative: $qualitative, isImportant: $isImportant)';
}


}

/// @nodoc
abstract mixin class _$TsunamiForecastMaxHeightCopyWith<$Res> implements $TsunamiForecastMaxHeightCopyWith<$Res> {
  factory _$TsunamiForecastMaxHeightCopyWith(_TsunamiForecastMaxHeight value, $Res Function(_TsunamiForecastMaxHeight) _then) = __$TsunamiForecastMaxHeightCopyWithImpl;
@override @useResult
$Res call({
 num value, bool over, QualitativeHeight qualitative,@JsonKey(name: 'is_important') bool isImportant
});




}
/// @nodoc
class __$TsunamiForecastMaxHeightCopyWithImpl<$Res>
    implements _$TsunamiForecastMaxHeightCopyWith<$Res> {
  __$TsunamiForecastMaxHeightCopyWithImpl(this._self, this._then);

  final _TsunamiForecastMaxHeight _self;
  final $Res Function(_TsunamiForecastMaxHeight) _then;

/// Create a copy of TsunamiForecastMaxHeight
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,Object? over = null,Object? qualitative = null,Object? isImportant = null,}) {
  return _then(_TsunamiForecastMaxHeight(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as num,over: null == over ? _self.over : over // ignore: cast_nullable_to_non_nullable
as bool,qualitative: null == qualitative ? _self.qualitative : qualitative // ignore: cast_nullable_to_non_nullable
as QualitativeHeight,isImportant: null == isImportant ? _self.isImportant : isImportant // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
