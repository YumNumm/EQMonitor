// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seismicity_daily_bin.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SeismicityDailyBin {

/// UTC 日付(00:00 に正規化)
 DateTime get date; int get count; int get cumulativeCount;
/// Create a copy of SeismicityDailyBin
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeismicityDailyBinCopyWith<SeismicityDailyBin> get copyWith => _$SeismicityDailyBinCopyWithImpl<SeismicityDailyBin>(this as SeismicityDailyBin, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeismicityDailyBin&&(identical(other.date, date) || other.date == date)&&(identical(other.count, count) || other.count == count)&&(identical(other.cumulativeCount, cumulativeCount) || other.cumulativeCount == cumulativeCount));
}


@override
int get hashCode => Object.hash(runtimeType,date,count,cumulativeCount);

@override
String toString() {
  return 'SeismicityDailyBin(date: $date, count: $count, cumulativeCount: $cumulativeCount)';
}


}

/// @nodoc
abstract mixin class $SeismicityDailyBinCopyWith<$Res>  {
  factory $SeismicityDailyBinCopyWith(SeismicityDailyBin value, $Res Function(SeismicityDailyBin) _then) = _$SeismicityDailyBinCopyWithImpl;
@useResult
$Res call({
 DateTime date, int count, int cumulativeCount
});




}
/// @nodoc
class _$SeismicityDailyBinCopyWithImpl<$Res>
    implements $SeismicityDailyBinCopyWith<$Res> {
  _$SeismicityDailyBinCopyWithImpl(this._self, this._then);

  final SeismicityDailyBin _self;
  final $Res Function(SeismicityDailyBin) _then;

/// Create a copy of SeismicityDailyBin
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? count = null,Object? cumulativeCount = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,cumulativeCount: null == cumulativeCount ? _self.cumulativeCount : cumulativeCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SeismicityDailyBin].
extension SeismicityDailyBinPatterns on SeismicityDailyBin {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SeismicityDailyBin value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SeismicityDailyBin() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SeismicityDailyBin value)  $default,){
final _that = this;
switch (_that) {
case _SeismicityDailyBin():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SeismicityDailyBin value)?  $default,){
final _that = this;
switch (_that) {
case _SeismicityDailyBin() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime date,  int count,  int cumulativeCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SeismicityDailyBin() when $default != null:
return $default(_that.date,_that.count,_that.cumulativeCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime date,  int count,  int cumulativeCount)  $default,) {final _that = this;
switch (_that) {
case _SeismicityDailyBin():
return $default(_that.date,_that.count,_that.cumulativeCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime date,  int count,  int cumulativeCount)?  $default,) {final _that = this;
switch (_that) {
case _SeismicityDailyBin() when $default != null:
return $default(_that.date,_that.count,_that.cumulativeCount);case _:
  return null;

}
}

}

/// @nodoc


class _SeismicityDailyBin implements SeismicityDailyBin {
  const _SeismicityDailyBin({required this.date, required this.count, required this.cumulativeCount});
  

/// UTC 日付(00:00 に正規化)
@override final  DateTime date;
@override final  int count;
@override final  int cumulativeCount;

/// Create a copy of SeismicityDailyBin
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SeismicityDailyBinCopyWith<_SeismicityDailyBin> get copyWith => __$SeismicityDailyBinCopyWithImpl<_SeismicityDailyBin>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SeismicityDailyBin&&(identical(other.date, date) || other.date == date)&&(identical(other.count, count) || other.count == count)&&(identical(other.cumulativeCount, cumulativeCount) || other.cumulativeCount == cumulativeCount));
}


@override
int get hashCode => Object.hash(runtimeType,date,count,cumulativeCount);

@override
String toString() {
  return 'SeismicityDailyBin(date: $date, count: $count, cumulativeCount: $cumulativeCount)';
}


}

/// @nodoc
abstract mixin class _$SeismicityDailyBinCopyWith<$Res> implements $SeismicityDailyBinCopyWith<$Res> {
  factory _$SeismicityDailyBinCopyWith(_SeismicityDailyBin value, $Res Function(_SeismicityDailyBin) _then) = __$SeismicityDailyBinCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, int count, int cumulativeCount
});




}
/// @nodoc
class __$SeismicityDailyBinCopyWithImpl<$Res>
    implements _$SeismicityDailyBinCopyWith<$Res> {
  __$SeismicityDailyBinCopyWithImpl(this._self, this._then);

  final _SeismicityDailyBin _self;
  final $Res Function(_SeismicityDailyBin) _then;

/// Create a copy of SeismicityDailyBin
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? count = null,Object? cumulativeCount = null,}) {
  return _then(_SeismicityDailyBin(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,cumulativeCount: null == cumulativeCount ? _self.cumulativeCount : cumulativeCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
