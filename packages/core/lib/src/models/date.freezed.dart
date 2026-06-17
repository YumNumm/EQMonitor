// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'date.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Date {

 int get year; int get month; int get day;
/// Create a copy of Date
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DateCopyWith<Date> get copyWith => _$DateCopyWithImpl<Date>(this as Date, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Date&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.day, day) || other.day == day));
}


@override
int get hashCode => Object.hash(runtimeType,year,month,day);



}

/// @nodoc
abstract mixin class $DateCopyWith<$Res>  {
  factory $DateCopyWith(Date value, $Res Function(Date) _then) = _$DateCopyWithImpl;
@useResult
$Res call({
 int year, int month, int day
});




}
/// @nodoc
class _$DateCopyWithImpl<$Res>
    implements $DateCopyWith<$Res> {
  _$DateCopyWithImpl(this._self, this._then);

  final Date _self;
  final $Res Function(Date) _then;

/// Create a copy of Date
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? year = null,Object? month = null,Object? day = null,}) {
  return _then(_self.copyWith(
year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Date].
extension DatePatterns on Date {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Date value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Date() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Date value)  $default,){
final _that = this;
switch (_that) {
case _Date():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Date value)?  $default,){
final _that = this;
switch (_that) {
case _Date() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int year,  int month,  int day)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Date() when $default != null:
return $default(_that.year,_that.month,_that.day);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int year,  int month,  int day)  $default,) {final _that = this;
switch (_that) {
case _Date():
return $default(_that.year,_that.month,_that.day);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int year,  int month,  int day)?  $default,) {final _that = this;
switch (_that) {
case _Date() when $default != null:
return $default(_that.year,_that.month,_that.day);case _:
  return null;

}
}

}

/// @nodoc


class _Date extends Date {
  const _Date({required this.year, required this.month, required this.day}): super._();
  

@override final  int year;
@override final  int month;
@override final  int day;

/// Create a copy of Date
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DateCopyWith<_Date> get copyWith => __$DateCopyWithImpl<_Date>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Date&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.day, day) || other.day == day));
}


@override
int get hashCode => Object.hash(runtimeType,year,month,day);



}

/// @nodoc
abstract mixin class _$DateCopyWith<$Res> implements $DateCopyWith<$Res> {
  factory _$DateCopyWith(_Date value, $Res Function(_Date) _then) = __$DateCopyWithImpl;
@override @useResult
$Res call({
 int year, int month, int day
});




}
/// @nodoc
class __$DateCopyWithImpl<$Res>
    implements _$DateCopyWith<$Res> {
  __$DateCopyWithImpl(this._self, this._then);

  final _Date _self;
  final $Res Function(_Date) _then;

/// Create a copy of Date
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? year = null,Object? month = null,Object? day = null,}) {
  return _then(_Date(
year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
