// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'replay_kyoshin_archive_window.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReplayKyoshinArchiveWindow {

 DateTime get startTime; DateTime get endTime; DateTime get originTime; bool get isOriginTimeApproximate;
/// Create a copy of ReplayKyoshinArchiveWindow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReplayKyoshinArchiveWindowCopyWith<ReplayKyoshinArchiveWindow> get copyWith => _$ReplayKyoshinArchiveWindowCopyWithImpl<ReplayKyoshinArchiveWindow>(this as ReplayKyoshinArchiveWindow, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReplayKyoshinArchiveWindow&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.isOriginTimeApproximate, isOriginTimeApproximate) || other.isOriginTimeApproximate == isOriginTimeApproximate));
}


@override
int get hashCode => Object.hash(runtimeType,startTime,endTime,originTime,isOriginTimeApproximate);

@override
String toString() {
  return 'ReplayKyoshinArchiveWindow(startTime: $startTime, endTime: $endTime, originTime: $originTime, isOriginTimeApproximate: $isOriginTimeApproximate)';
}


}

/// @nodoc
abstract mixin class $ReplayKyoshinArchiveWindowCopyWith<$Res>  {
  factory $ReplayKyoshinArchiveWindowCopyWith(ReplayKyoshinArchiveWindow value, $Res Function(ReplayKyoshinArchiveWindow) _then) = _$ReplayKyoshinArchiveWindowCopyWithImpl;
@useResult
$Res call({
 DateTime startTime, DateTime endTime, DateTime originTime, bool isOriginTimeApproximate
});




}
/// @nodoc
class _$ReplayKyoshinArchiveWindowCopyWithImpl<$Res>
    implements $ReplayKyoshinArchiveWindowCopyWith<$Res> {
  _$ReplayKyoshinArchiveWindowCopyWithImpl(this._self, this._then);

  final ReplayKyoshinArchiveWindow _self;
  final $Res Function(ReplayKyoshinArchiveWindow) _then;

/// Create a copy of ReplayKyoshinArchiveWindow
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? startTime = null,Object? endTime = null,Object? originTime = null,Object? isOriginTimeApproximate = null,}) {
  return _then(ReplayKyoshinArchiveWindow(
startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime,originTime: null == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime,isOriginTimeApproximate: null == isOriginTimeApproximate ? _self.isOriginTimeApproximate : isOriginTimeApproximate // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ReplayKyoshinArchiveWindow].
extension ReplayKyoshinArchiveWindowPatterns on ReplayKyoshinArchiveWindow {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReplayKyoshinArchiveWindow value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReplayKyoshinArchiveWindow() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReplayKyoshinArchiveWindow value)  $default,){
final _that = this;
switch (_that) {
case _ReplayKyoshinArchiveWindow():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReplayKyoshinArchiveWindow value)?  $default,){
final _that = this;
switch (_that) {
case _ReplayKyoshinArchiveWindow() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime startTime,  DateTime endTime,  DateTime originTime,  bool isOriginTimeApproximate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReplayKyoshinArchiveWindow() when $default != null:
return $default(_that.startTime,_that.endTime,_that.originTime,_that.isOriginTimeApproximate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime startTime,  DateTime endTime,  DateTime originTime,  bool isOriginTimeApproximate)  $default,) {final _that = this;
switch (_that) {
case _ReplayKyoshinArchiveWindow():
return $default(_that.startTime,_that.endTime,_that.originTime,_that.isOriginTimeApproximate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime startTime,  DateTime endTime,  DateTime originTime,  bool isOriginTimeApproximate)?  $default,) {final _that = this;
switch (_that) {
case _ReplayKyoshinArchiveWindow() when $default != null:
return $default(_that.startTime,_that.endTime,_that.originTime,_that.isOriginTimeApproximate);case _:
  return null;

}
}

}

/// @nodoc


class _ReplayKyoshinArchiveWindow implements ReplayKyoshinArchiveWindow {
  const _ReplayKyoshinArchiveWindow({required this.startTime, required this.endTime, required this.originTime, required this.isOriginTimeApproximate});
  

@override final  DateTime startTime;
@override final  DateTime endTime;
@override final  DateTime originTime;
@override final  bool isOriginTimeApproximate;

/// Create a copy of ReplayKyoshinArchiveWindow
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReplayKyoshinArchiveWindowCopyWith<_ReplayKyoshinArchiveWindow> get copyWith => __$ReplayKyoshinArchiveWindowCopyWithImpl<_ReplayKyoshinArchiveWindow>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReplayKyoshinArchiveWindow&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.isOriginTimeApproximate, isOriginTimeApproximate) || other.isOriginTimeApproximate == isOriginTimeApproximate));
}


@override
int get hashCode => Object.hash(runtimeType,startTime,endTime,originTime,isOriginTimeApproximate);

@override
String toString() {
  return 'ReplayKyoshinArchiveWindow(startTime: $startTime, endTime: $endTime, originTime: $originTime, isOriginTimeApproximate: $isOriginTimeApproximate)';
}


}

/// @nodoc
abstract mixin class _$ReplayKyoshinArchiveWindowCopyWith<$Res> implements $ReplayKyoshinArchiveWindowCopyWith<$Res> {
  factory _$ReplayKyoshinArchiveWindowCopyWith(_ReplayKyoshinArchiveWindow value, $Res Function(_ReplayKyoshinArchiveWindow) _then) = __$ReplayKyoshinArchiveWindowCopyWithImpl;
@override @useResult
$Res call({
 DateTime startTime, DateTime endTime, DateTime originTime, bool isOriginTimeApproximate
});




}
/// @nodoc
class __$ReplayKyoshinArchiveWindowCopyWithImpl<$Res>
    implements _$ReplayKyoshinArchiveWindowCopyWith<$Res> {
  __$ReplayKyoshinArchiveWindowCopyWithImpl(this._self, this._then);

  final _ReplayKyoshinArchiveWindow _self;
  final $Res Function(_ReplayKyoshinArchiveWindow) _then;

/// Create a copy of ReplayKyoshinArchiveWindow
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? startTime = null,Object? endTime = null,Object? originTime = null,Object? isOriginTimeApproximate = null,}) {
  return _then(_ReplayKyoshinArchiveWindow(
startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime,originTime: null == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime,isOriginTimeApproximate: null == isOriginTimeApproximate ? _self.isOriginTimeApproximate : isOriginTimeApproximate // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
