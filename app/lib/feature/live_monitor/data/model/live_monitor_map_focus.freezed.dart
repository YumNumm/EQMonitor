// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'live_monitor_map_focus.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LiveMonitorGeoBounds {

 double get minLat; double get maxLat; double get minLng; double get maxLng;
/// Create a copy of LiveMonitorGeoBounds
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveMonitorGeoBoundsCopyWith<LiveMonitorGeoBounds> get copyWith => _$LiveMonitorGeoBoundsCopyWithImpl<LiveMonitorGeoBounds>(this as LiveMonitorGeoBounds, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveMonitorGeoBounds&&(identical(other.minLat, minLat) || other.minLat == minLat)&&(identical(other.maxLat, maxLat) || other.maxLat == maxLat)&&(identical(other.minLng, minLng) || other.minLng == minLng)&&(identical(other.maxLng, maxLng) || other.maxLng == maxLng));
}


@override
int get hashCode => Object.hash(runtimeType,minLat,maxLat,minLng,maxLng);

@override
String toString() {
  return 'LiveMonitorGeoBounds(minLat: $minLat, maxLat: $maxLat, minLng: $minLng, maxLng: $maxLng)';
}


}

/// @nodoc
abstract mixin class $LiveMonitorGeoBoundsCopyWith<$Res>  {
  factory $LiveMonitorGeoBoundsCopyWith(LiveMonitorGeoBounds value, $Res Function(LiveMonitorGeoBounds) _then) = _$LiveMonitorGeoBoundsCopyWithImpl;
@useResult
$Res call({
 double minLat, double maxLat, double minLng, double maxLng
});




}
/// @nodoc
class _$LiveMonitorGeoBoundsCopyWithImpl<$Res>
    implements $LiveMonitorGeoBoundsCopyWith<$Res> {
  _$LiveMonitorGeoBoundsCopyWithImpl(this._self, this._then);

  final LiveMonitorGeoBounds _self;
  final $Res Function(LiveMonitorGeoBounds) _then;

/// Create a copy of LiveMonitorGeoBounds
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? minLat = null,Object? maxLat = null,Object? minLng = null,Object? maxLng = null,}) {
  return _then(_self.copyWith(
minLat: null == minLat ? _self.minLat : minLat // ignore: cast_nullable_to_non_nullable
as double,maxLat: null == maxLat ? _self.maxLat : maxLat // ignore: cast_nullable_to_non_nullable
as double,minLng: null == minLng ? _self.minLng : minLng // ignore: cast_nullable_to_non_nullable
as double,maxLng: null == maxLng ? _self.maxLng : maxLng // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [LiveMonitorGeoBounds].
extension LiveMonitorGeoBoundsPatterns on LiveMonitorGeoBounds {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveMonitorGeoBounds value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveMonitorGeoBounds() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveMonitorGeoBounds value)  $default,){
final _that = this;
switch (_that) {
case _LiveMonitorGeoBounds():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveMonitorGeoBounds value)?  $default,){
final _that = this;
switch (_that) {
case _LiveMonitorGeoBounds() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double minLat,  double maxLat,  double minLng,  double maxLng)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveMonitorGeoBounds() when $default != null:
return $default(_that.minLat,_that.maxLat,_that.minLng,_that.maxLng);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double minLat,  double maxLat,  double minLng,  double maxLng)  $default,) {final _that = this;
switch (_that) {
case _LiveMonitorGeoBounds():
return $default(_that.minLat,_that.maxLat,_that.minLng,_that.maxLng);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double minLat,  double maxLat,  double minLng,  double maxLng)?  $default,) {final _that = this;
switch (_that) {
case _LiveMonitorGeoBounds() when $default != null:
return $default(_that.minLat,_that.maxLat,_that.minLng,_that.maxLng);case _:
  return null;

}
}

}

/// @nodoc


class _LiveMonitorGeoBounds implements LiveMonitorGeoBounds {
  const _LiveMonitorGeoBounds({required this.minLat, required this.maxLat, required this.minLng, required this.maxLng});
  

@override final  double minLat;
@override final  double maxLat;
@override final  double minLng;
@override final  double maxLng;

/// Create a copy of LiveMonitorGeoBounds
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveMonitorGeoBoundsCopyWith<_LiveMonitorGeoBounds> get copyWith => __$LiveMonitorGeoBoundsCopyWithImpl<_LiveMonitorGeoBounds>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveMonitorGeoBounds&&(identical(other.minLat, minLat) || other.minLat == minLat)&&(identical(other.maxLat, maxLat) || other.maxLat == maxLat)&&(identical(other.minLng, minLng) || other.minLng == minLng)&&(identical(other.maxLng, maxLng) || other.maxLng == maxLng));
}


@override
int get hashCode => Object.hash(runtimeType,minLat,maxLat,minLng,maxLng);

@override
String toString() {
  return 'LiveMonitorGeoBounds(minLat: $minLat, maxLat: $maxLat, minLng: $minLng, maxLng: $maxLng)';
}


}

/// @nodoc
abstract mixin class _$LiveMonitorGeoBoundsCopyWith<$Res> implements $LiveMonitorGeoBoundsCopyWith<$Res> {
  factory _$LiveMonitorGeoBoundsCopyWith(_LiveMonitorGeoBounds value, $Res Function(_LiveMonitorGeoBounds) _then) = __$LiveMonitorGeoBoundsCopyWithImpl;
@override @useResult
$Res call({
 double minLat, double maxLat, double minLng, double maxLng
});




}
/// @nodoc
class __$LiveMonitorGeoBoundsCopyWithImpl<$Res>
    implements _$LiveMonitorGeoBoundsCopyWith<$Res> {
  __$LiveMonitorGeoBoundsCopyWithImpl(this._self, this._then);

  final _LiveMonitorGeoBounds _self;
  final $Res Function(_LiveMonitorGeoBounds) _then;

/// Create a copy of LiveMonitorGeoBounds
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? minLat = null,Object? maxLat = null,Object? minLng = null,Object? maxLng = null,}) {
  return _then(_LiveMonitorGeoBounds(
minLat: null == minLat ? _self.minLat : minLat // ignore: cast_nullable_to_non_nullable
as double,maxLat: null == maxLat ? _self.maxLat : maxLat // ignore: cast_nullable_to_non_nullable
as double,minLng: null == minLng ? _self.minLng : minLng // ignore: cast_nullable_to_non_nullable
as double,maxLng: null == maxLng ? _self.maxLng : maxLng // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$LiveMonitorMapPadding {

 double get top; double get right; double get bottom; double get left;
/// Create a copy of LiveMonitorMapPadding
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveMonitorMapPaddingCopyWith<LiveMonitorMapPadding> get copyWith => _$LiveMonitorMapPaddingCopyWithImpl<LiveMonitorMapPadding>(this as LiveMonitorMapPadding, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveMonitorMapPadding&&(identical(other.top, top) || other.top == top)&&(identical(other.right, right) || other.right == right)&&(identical(other.bottom, bottom) || other.bottom == bottom)&&(identical(other.left, left) || other.left == left));
}


@override
int get hashCode => Object.hash(runtimeType,top,right,bottom,left);

@override
String toString() {
  return 'LiveMonitorMapPadding(top: $top, right: $right, bottom: $bottom, left: $left)';
}


}

/// @nodoc
abstract mixin class $LiveMonitorMapPaddingCopyWith<$Res>  {
  factory $LiveMonitorMapPaddingCopyWith(LiveMonitorMapPadding value, $Res Function(LiveMonitorMapPadding) _then) = _$LiveMonitorMapPaddingCopyWithImpl;
@useResult
$Res call({
 double top, double right, double bottom, double left
});




}
/// @nodoc
class _$LiveMonitorMapPaddingCopyWithImpl<$Res>
    implements $LiveMonitorMapPaddingCopyWith<$Res> {
  _$LiveMonitorMapPaddingCopyWithImpl(this._self, this._then);

  final LiveMonitorMapPadding _self;
  final $Res Function(LiveMonitorMapPadding) _then;

/// Create a copy of LiveMonitorMapPadding
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? top = null,Object? right = null,Object? bottom = null,Object? left = null,}) {
  return _then(_self.copyWith(
top: null == top ? _self.top : top // ignore: cast_nullable_to_non_nullable
as double,right: null == right ? _self.right : right // ignore: cast_nullable_to_non_nullable
as double,bottom: null == bottom ? _self.bottom : bottom // ignore: cast_nullable_to_non_nullable
as double,left: null == left ? _self.left : left // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [LiveMonitorMapPadding].
extension LiveMonitorMapPaddingPatterns on LiveMonitorMapPadding {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveMonitorMapPadding value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveMonitorMapPadding() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveMonitorMapPadding value)  $default,){
final _that = this;
switch (_that) {
case _LiveMonitorMapPadding():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveMonitorMapPadding value)?  $default,){
final _that = this;
switch (_that) {
case _LiveMonitorMapPadding() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double top,  double right,  double bottom,  double left)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveMonitorMapPadding() when $default != null:
return $default(_that.top,_that.right,_that.bottom,_that.left);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double top,  double right,  double bottom,  double left)  $default,) {final _that = this;
switch (_that) {
case _LiveMonitorMapPadding():
return $default(_that.top,_that.right,_that.bottom,_that.left);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double top,  double right,  double bottom,  double left)?  $default,) {final _that = this;
switch (_that) {
case _LiveMonitorMapPadding() when $default != null:
return $default(_that.top,_that.right,_that.bottom,_that.left);case _:
  return null;

}
}

}

/// @nodoc


class _LiveMonitorMapPadding implements LiveMonitorMapPadding {
  const _LiveMonitorMapPadding({this.top = 8, this.right = 8, this.bottom = 8, this.left = 8});
  

@override@JsonKey() final  double top;
@override@JsonKey() final  double right;
@override@JsonKey() final  double bottom;
@override@JsonKey() final  double left;

/// Create a copy of LiveMonitorMapPadding
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveMonitorMapPaddingCopyWith<_LiveMonitorMapPadding> get copyWith => __$LiveMonitorMapPaddingCopyWithImpl<_LiveMonitorMapPadding>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveMonitorMapPadding&&(identical(other.top, top) || other.top == top)&&(identical(other.right, right) || other.right == right)&&(identical(other.bottom, bottom) || other.bottom == bottom)&&(identical(other.left, left) || other.left == left));
}


@override
int get hashCode => Object.hash(runtimeType,top,right,bottom,left);

@override
String toString() {
  return 'LiveMonitorMapPadding(top: $top, right: $right, bottom: $bottom, left: $left)';
}


}

/// @nodoc
abstract mixin class _$LiveMonitorMapPaddingCopyWith<$Res> implements $LiveMonitorMapPaddingCopyWith<$Res> {
  factory _$LiveMonitorMapPaddingCopyWith(_LiveMonitorMapPadding value, $Res Function(_LiveMonitorMapPadding) _then) = __$LiveMonitorMapPaddingCopyWithImpl;
@override @useResult
$Res call({
 double top, double right, double bottom, double left
});




}
/// @nodoc
class __$LiveMonitorMapPaddingCopyWithImpl<$Res>
    implements _$LiveMonitorMapPaddingCopyWith<$Res> {
  __$LiveMonitorMapPaddingCopyWithImpl(this._self, this._then);

  final _LiveMonitorMapPadding _self;
  final $Res Function(_LiveMonitorMapPadding) _then;

/// Create a copy of LiveMonitorMapPadding
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? top = null,Object? right = null,Object? bottom = null,Object? left = null,}) {
  return _then(_LiveMonitorMapPadding(
top: null == top ? _self.top : top // ignore: cast_nullable_to_non_nullable
as double,right: null == right ? _self.right : right // ignore: cast_nullable_to_non_nullable
as double,bottom: null == bottom ? _self.bottom : bottom // ignore: cast_nullable_to_non_nullable
as double,left: null == left ? _self.left : left // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$LiveMonitorMapFocus {

 LiveMonitorGeoBounds get bounds; LiveMonitorMapPadding get padding;
/// Create a copy of LiveMonitorMapFocus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveMonitorMapFocusCopyWith<LiveMonitorMapFocus> get copyWith => _$LiveMonitorMapFocusCopyWithImpl<LiveMonitorMapFocus>(this as LiveMonitorMapFocus, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveMonitorMapFocus&&(identical(other.bounds, bounds) || other.bounds == bounds)&&(identical(other.padding, padding) || other.padding == padding));
}


@override
int get hashCode => Object.hash(runtimeType,bounds,padding);

@override
String toString() {
  return 'LiveMonitorMapFocus(bounds: $bounds, padding: $padding)';
}


}

/// @nodoc
abstract mixin class $LiveMonitorMapFocusCopyWith<$Res>  {
  factory $LiveMonitorMapFocusCopyWith(LiveMonitorMapFocus value, $Res Function(LiveMonitorMapFocus) _then) = _$LiveMonitorMapFocusCopyWithImpl;
@useResult
$Res call({
 LiveMonitorGeoBounds bounds, LiveMonitorMapPadding padding
});


$LiveMonitorGeoBoundsCopyWith<$Res> get bounds;$LiveMonitorMapPaddingCopyWith<$Res> get padding;

}
/// @nodoc
class _$LiveMonitorMapFocusCopyWithImpl<$Res>
    implements $LiveMonitorMapFocusCopyWith<$Res> {
  _$LiveMonitorMapFocusCopyWithImpl(this._self, this._then);

  final LiveMonitorMapFocus _self;
  final $Res Function(LiveMonitorMapFocus) _then;

/// Create a copy of LiveMonitorMapFocus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bounds = null,Object? padding = null,}) {
  return _then(_self.copyWith(
bounds: null == bounds ? _self.bounds : bounds // ignore: cast_nullable_to_non_nullable
as LiveMonitorGeoBounds,padding: null == padding ? _self.padding : padding // ignore: cast_nullable_to_non_nullable
as LiveMonitorMapPadding,
  ));
}
/// Create a copy of LiveMonitorMapFocus
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveMonitorGeoBoundsCopyWith<$Res> get bounds {
  
  return $LiveMonitorGeoBoundsCopyWith<$Res>(_self.bounds, (value) {
    return _then(_self.copyWith(bounds: value));
  });
}/// Create a copy of LiveMonitorMapFocus
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveMonitorMapPaddingCopyWith<$Res> get padding {
  
  return $LiveMonitorMapPaddingCopyWith<$Res>(_self.padding, (value) {
    return _then(_self.copyWith(padding: value));
  });
}
}


/// Adds pattern-matching-related methods to [LiveMonitorMapFocus].
extension LiveMonitorMapFocusPatterns on LiveMonitorMapFocus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveMonitorMapFocus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveMonitorMapFocus() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveMonitorMapFocus value)  $default,){
final _that = this;
switch (_that) {
case _LiveMonitorMapFocus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveMonitorMapFocus value)?  $default,){
final _that = this;
switch (_that) {
case _LiveMonitorMapFocus() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LiveMonitorGeoBounds bounds,  LiveMonitorMapPadding padding)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveMonitorMapFocus() when $default != null:
return $default(_that.bounds,_that.padding);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LiveMonitorGeoBounds bounds,  LiveMonitorMapPadding padding)  $default,) {final _that = this;
switch (_that) {
case _LiveMonitorMapFocus():
return $default(_that.bounds,_that.padding);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LiveMonitorGeoBounds bounds,  LiveMonitorMapPadding padding)?  $default,) {final _that = this;
switch (_that) {
case _LiveMonitorMapFocus() when $default != null:
return $default(_that.bounds,_that.padding);case _:
  return null;

}
}

}

/// @nodoc


class _LiveMonitorMapFocus implements LiveMonitorMapFocus {
  const _LiveMonitorMapFocus({required this.bounds, required this.padding});
  

@override final  LiveMonitorGeoBounds bounds;
@override final  LiveMonitorMapPadding padding;

/// Create a copy of LiveMonitorMapFocus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveMonitorMapFocusCopyWith<_LiveMonitorMapFocus> get copyWith => __$LiveMonitorMapFocusCopyWithImpl<_LiveMonitorMapFocus>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveMonitorMapFocus&&(identical(other.bounds, bounds) || other.bounds == bounds)&&(identical(other.padding, padding) || other.padding == padding));
}


@override
int get hashCode => Object.hash(runtimeType,bounds,padding);

@override
String toString() {
  return 'LiveMonitorMapFocus(bounds: $bounds, padding: $padding)';
}


}

/// @nodoc
abstract mixin class _$LiveMonitorMapFocusCopyWith<$Res> implements $LiveMonitorMapFocusCopyWith<$Res> {
  factory _$LiveMonitorMapFocusCopyWith(_LiveMonitorMapFocus value, $Res Function(_LiveMonitorMapFocus) _then) = __$LiveMonitorMapFocusCopyWithImpl;
@override @useResult
$Res call({
 LiveMonitorGeoBounds bounds, LiveMonitorMapPadding padding
});


@override $LiveMonitorGeoBoundsCopyWith<$Res> get bounds;@override $LiveMonitorMapPaddingCopyWith<$Res> get padding;

}
/// @nodoc
class __$LiveMonitorMapFocusCopyWithImpl<$Res>
    implements _$LiveMonitorMapFocusCopyWith<$Res> {
  __$LiveMonitorMapFocusCopyWithImpl(this._self, this._then);

  final _LiveMonitorMapFocus _self;
  final $Res Function(_LiveMonitorMapFocus) _then;

/// Create a copy of LiveMonitorMapFocus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bounds = null,Object? padding = null,}) {
  return _then(_LiveMonitorMapFocus(
bounds: null == bounds ? _self.bounds : bounds // ignore: cast_nullable_to_non_nullable
as LiveMonitorGeoBounds,padding: null == padding ? _self.padding : padding // ignore: cast_nullable_to_non_nullable
as LiveMonitorMapPadding,
  ));
}

/// Create a copy of LiveMonitorMapFocus
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveMonitorGeoBoundsCopyWith<$Res> get bounds {
  
  return $LiveMonitorGeoBoundsCopyWith<$Res>(_self.bounds, (value) {
    return _then(_self.copyWith(bounds: value));
  });
}/// Create a copy of LiveMonitorMapFocus
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveMonitorMapPaddingCopyWith<$Res> get padding {
  
  return $LiveMonitorMapPaddingCopyWith<$Res>(_self.padding, (value) {
    return _then(_self.copyWith(padding: value));
  });
}
}

// dart format on
