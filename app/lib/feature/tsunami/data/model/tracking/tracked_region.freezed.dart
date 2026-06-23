// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tracked_region.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TrackedRegion {

 String get code; String get name; Tracked<TsunamiWarningKind> get kind; Tracked<TsunamiWarningKind> get lastKind; Tracked<TsunamiForecastFirstHeight?> get forecastFirstHeight; Tracked<TsunamiForecastMaxHeight?> get forecastMaxHeight; Tracked<TsunamiEstimationFirstHeight?> get estimationFirstHeight; Tracked<TsunamiEstimationMaxHeight?> get estimationMaxHeight; List<TrackedRegionStation> get stations;
/// Create a copy of TrackedRegion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrackedRegionCopyWith<TrackedRegion> get copyWith => _$TrackedRegionCopyWithImpl<TrackedRegion>(this as TrackedRegion, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrackedRegion&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.kind, kind)&&const DeepCollectionEquality().equals(other.lastKind, lastKind)&&const DeepCollectionEquality().equals(other.forecastFirstHeight, forecastFirstHeight)&&const DeepCollectionEquality().equals(other.forecastMaxHeight, forecastMaxHeight)&&const DeepCollectionEquality().equals(other.estimationFirstHeight, estimationFirstHeight)&&const DeepCollectionEquality().equals(other.estimationMaxHeight, estimationMaxHeight)&&const DeepCollectionEquality().equals(other.stations, stations));
}


@override
int get hashCode => Object.hash(runtimeType,code,name,const DeepCollectionEquality().hash(kind),const DeepCollectionEquality().hash(lastKind),const DeepCollectionEquality().hash(forecastFirstHeight),const DeepCollectionEquality().hash(forecastMaxHeight),const DeepCollectionEquality().hash(estimationFirstHeight),const DeepCollectionEquality().hash(estimationMaxHeight),const DeepCollectionEquality().hash(stations));

@override
String toString() {
  return 'TrackedRegion(code: $code, name: $name, kind: $kind, lastKind: $lastKind, forecastFirstHeight: $forecastFirstHeight, forecastMaxHeight: $forecastMaxHeight, estimationFirstHeight: $estimationFirstHeight, estimationMaxHeight: $estimationMaxHeight, stations: $stations)';
}


}

/// @nodoc
abstract mixin class $TrackedRegionCopyWith<$Res>  {
  factory $TrackedRegionCopyWith(TrackedRegion value, $Res Function(TrackedRegion) _then) = _$TrackedRegionCopyWithImpl;
@useResult
$Res call({
 String code, String name, Tracked<TsunamiWarningKind> kind, Tracked<TsunamiWarningKind> lastKind, Tracked<TsunamiForecastFirstHeight?> forecastFirstHeight, Tracked<TsunamiForecastMaxHeight?> forecastMaxHeight, Tracked<TsunamiEstimationFirstHeight?> estimationFirstHeight, Tracked<TsunamiEstimationMaxHeight?> estimationMaxHeight, List<TrackedRegionStation> stations
});




}
/// @nodoc
class _$TrackedRegionCopyWithImpl<$Res>
    implements $TrackedRegionCopyWith<$Res> {
  _$TrackedRegionCopyWithImpl(this._self, this._then);

  final TrackedRegion _self;
  final $Res Function(TrackedRegion) _then;

/// Create a copy of TrackedRegion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? kind = null,Object? lastKind = null,Object? forecastFirstHeight = null,Object? forecastMaxHeight = null,Object? estimationFirstHeight = null,Object? estimationMaxHeight = null,Object? stations = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as Tracked<TsunamiWarningKind>,lastKind: null == lastKind ? _self.lastKind : lastKind // ignore: cast_nullable_to_non_nullable
as Tracked<TsunamiWarningKind>,forecastFirstHeight: null == forecastFirstHeight ? _self.forecastFirstHeight : forecastFirstHeight // ignore: cast_nullable_to_non_nullable
as Tracked<TsunamiForecastFirstHeight?>,forecastMaxHeight: null == forecastMaxHeight ? _self.forecastMaxHeight : forecastMaxHeight // ignore: cast_nullable_to_non_nullable
as Tracked<TsunamiForecastMaxHeight?>,estimationFirstHeight: null == estimationFirstHeight ? _self.estimationFirstHeight : estimationFirstHeight // ignore: cast_nullable_to_non_nullable
as Tracked<TsunamiEstimationFirstHeight?>,estimationMaxHeight: null == estimationMaxHeight ? _self.estimationMaxHeight : estimationMaxHeight // ignore: cast_nullable_to_non_nullable
as Tracked<TsunamiEstimationMaxHeight?>,stations: null == stations ? _self.stations : stations // ignore: cast_nullable_to_non_nullable
as List<TrackedRegionStation>,
  ));
}

}


/// Adds pattern-matching-related methods to [TrackedRegion].
extension TrackedRegionPatterns on TrackedRegion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrackedRegion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrackedRegion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrackedRegion value)  $default,){
final _that = this;
switch (_that) {
case _TrackedRegion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrackedRegion value)?  $default,){
final _that = this;
switch (_that) {
case _TrackedRegion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String name,  Tracked<TsunamiWarningKind> kind,  Tracked<TsunamiWarningKind> lastKind,  Tracked<TsunamiForecastFirstHeight?> forecastFirstHeight,  Tracked<TsunamiForecastMaxHeight?> forecastMaxHeight,  Tracked<TsunamiEstimationFirstHeight?> estimationFirstHeight,  Tracked<TsunamiEstimationMaxHeight?> estimationMaxHeight,  List<TrackedRegionStation> stations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrackedRegion() when $default != null:
return $default(_that.code,_that.name,_that.kind,_that.lastKind,_that.forecastFirstHeight,_that.forecastMaxHeight,_that.estimationFirstHeight,_that.estimationMaxHeight,_that.stations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String name,  Tracked<TsunamiWarningKind> kind,  Tracked<TsunamiWarningKind> lastKind,  Tracked<TsunamiForecastFirstHeight?> forecastFirstHeight,  Tracked<TsunamiForecastMaxHeight?> forecastMaxHeight,  Tracked<TsunamiEstimationFirstHeight?> estimationFirstHeight,  Tracked<TsunamiEstimationMaxHeight?> estimationMaxHeight,  List<TrackedRegionStation> stations)  $default,) {final _that = this;
switch (_that) {
case _TrackedRegion():
return $default(_that.code,_that.name,_that.kind,_that.lastKind,_that.forecastFirstHeight,_that.forecastMaxHeight,_that.estimationFirstHeight,_that.estimationMaxHeight,_that.stations);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String name,  Tracked<TsunamiWarningKind> kind,  Tracked<TsunamiWarningKind> lastKind,  Tracked<TsunamiForecastFirstHeight?> forecastFirstHeight,  Tracked<TsunamiForecastMaxHeight?> forecastMaxHeight,  Tracked<TsunamiEstimationFirstHeight?> estimationFirstHeight,  Tracked<TsunamiEstimationMaxHeight?> estimationMaxHeight,  List<TrackedRegionStation> stations)?  $default,) {final _that = this;
switch (_that) {
case _TrackedRegion() when $default != null:
return $default(_that.code,_that.name,_that.kind,_that.lastKind,_that.forecastFirstHeight,_that.forecastMaxHeight,_that.estimationFirstHeight,_that.estimationMaxHeight,_that.stations);case _:
  return null;

}
}

}

/// @nodoc


class _TrackedRegion implements TrackedRegion {
  const _TrackedRegion({required this.code, required this.name, required final  Tracked<TsunamiWarningKind> kind, required final  Tracked<TsunamiWarningKind> lastKind, required final  Tracked<TsunamiForecastFirstHeight?> forecastFirstHeight, required final  Tracked<TsunamiForecastMaxHeight?> forecastMaxHeight, required final  Tracked<TsunamiEstimationFirstHeight?> estimationFirstHeight, required final  Tracked<TsunamiEstimationMaxHeight?> estimationMaxHeight, required final  List<TrackedRegionStation> stations}): _kind = kind,_lastKind = lastKind,_forecastFirstHeight = forecastFirstHeight,_forecastMaxHeight = forecastMaxHeight,_estimationFirstHeight = estimationFirstHeight,_estimationMaxHeight = estimationMaxHeight,_stations = stations;
  

@override final  String code;
@override final  String name;
 final  Tracked<TsunamiWarningKind> _kind;
@override Tracked<TsunamiWarningKind> get kind {
  if (_kind is EqualUnmodifiableListView) return _kind;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_kind);
}

 final  Tracked<TsunamiWarningKind> _lastKind;
@override Tracked<TsunamiWarningKind> get lastKind {
  if (_lastKind is EqualUnmodifiableListView) return _lastKind;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lastKind);
}

 final  Tracked<TsunamiForecastFirstHeight?> _forecastFirstHeight;
@override Tracked<TsunamiForecastFirstHeight?> get forecastFirstHeight {
  if (_forecastFirstHeight is EqualUnmodifiableListView) return _forecastFirstHeight;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_forecastFirstHeight);
}

 final  Tracked<TsunamiForecastMaxHeight?> _forecastMaxHeight;
@override Tracked<TsunamiForecastMaxHeight?> get forecastMaxHeight {
  if (_forecastMaxHeight is EqualUnmodifiableListView) return _forecastMaxHeight;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_forecastMaxHeight);
}

 final  Tracked<TsunamiEstimationFirstHeight?> _estimationFirstHeight;
@override Tracked<TsunamiEstimationFirstHeight?> get estimationFirstHeight {
  if (_estimationFirstHeight is EqualUnmodifiableListView) return _estimationFirstHeight;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_estimationFirstHeight);
}

 final  Tracked<TsunamiEstimationMaxHeight?> _estimationMaxHeight;
@override Tracked<TsunamiEstimationMaxHeight?> get estimationMaxHeight {
  if (_estimationMaxHeight is EqualUnmodifiableListView) return _estimationMaxHeight;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_estimationMaxHeight);
}

 final  List<TrackedRegionStation> _stations;
@override List<TrackedRegionStation> get stations {
  if (_stations is EqualUnmodifiableListView) return _stations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stations);
}


/// Create a copy of TrackedRegion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrackedRegionCopyWith<_TrackedRegion> get copyWith => __$TrackedRegionCopyWithImpl<_TrackedRegion>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrackedRegion&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._kind, _kind)&&const DeepCollectionEquality().equals(other._lastKind, _lastKind)&&const DeepCollectionEquality().equals(other._forecastFirstHeight, _forecastFirstHeight)&&const DeepCollectionEquality().equals(other._forecastMaxHeight, _forecastMaxHeight)&&const DeepCollectionEquality().equals(other._estimationFirstHeight, _estimationFirstHeight)&&const DeepCollectionEquality().equals(other._estimationMaxHeight, _estimationMaxHeight)&&const DeepCollectionEquality().equals(other._stations, _stations));
}


@override
int get hashCode => Object.hash(runtimeType,code,name,const DeepCollectionEquality().hash(_kind),const DeepCollectionEquality().hash(_lastKind),const DeepCollectionEquality().hash(_forecastFirstHeight),const DeepCollectionEquality().hash(_forecastMaxHeight),const DeepCollectionEquality().hash(_estimationFirstHeight),const DeepCollectionEquality().hash(_estimationMaxHeight),const DeepCollectionEquality().hash(_stations));

@override
String toString() {
  return 'TrackedRegion(code: $code, name: $name, kind: $kind, lastKind: $lastKind, forecastFirstHeight: $forecastFirstHeight, forecastMaxHeight: $forecastMaxHeight, estimationFirstHeight: $estimationFirstHeight, estimationMaxHeight: $estimationMaxHeight, stations: $stations)';
}


}

/// @nodoc
abstract mixin class _$TrackedRegionCopyWith<$Res> implements $TrackedRegionCopyWith<$Res> {
  factory _$TrackedRegionCopyWith(_TrackedRegion value, $Res Function(_TrackedRegion) _then) = __$TrackedRegionCopyWithImpl;
@override @useResult
$Res call({
 String code, String name, Tracked<TsunamiWarningKind> kind, Tracked<TsunamiWarningKind> lastKind, Tracked<TsunamiForecastFirstHeight?> forecastFirstHeight, Tracked<TsunamiForecastMaxHeight?> forecastMaxHeight, Tracked<TsunamiEstimationFirstHeight?> estimationFirstHeight, Tracked<TsunamiEstimationMaxHeight?> estimationMaxHeight, List<TrackedRegionStation> stations
});




}
/// @nodoc
class __$TrackedRegionCopyWithImpl<$Res>
    implements _$TrackedRegionCopyWith<$Res> {
  __$TrackedRegionCopyWithImpl(this._self, this._then);

  final _TrackedRegion _self;
  final $Res Function(_TrackedRegion) _then;

/// Create a copy of TrackedRegion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? kind = null,Object? lastKind = null,Object? forecastFirstHeight = null,Object? forecastMaxHeight = null,Object? estimationFirstHeight = null,Object? estimationMaxHeight = null,Object? stations = null,}) {
  return _then(_TrackedRegion(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self._kind : kind // ignore: cast_nullable_to_non_nullable
as Tracked<TsunamiWarningKind>,lastKind: null == lastKind ? _self._lastKind : lastKind // ignore: cast_nullable_to_non_nullable
as Tracked<TsunamiWarningKind>,forecastFirstHeight: null == forecastFirstHeight ? _self._forecastFirstHeight : forecastFirstHeight // ignore: cast_nullable_to_non_nullable
as Tracked<TsunamiForecastFirstHeight?>,forecastMaxHeight: null == forecastMaxHeight ? _self._forecastMaxHeight : forecastMaxHeight // ignore: cast_nullable_to_non_nullable
as Tracked<TsunamiForecastMaxHeight?>,estimationFirstHeight: null == estimationFirstHeight ? _self._estimationFirstHeight : estimationFirstHeight // ignore: cast_nullable_to_non_nullable
as Tracked<TsunamiEstimationFirstHeight?>,estimationMaxHeight: null == estimationMaxHeight ? _self._estimationMaxHeight : estimationMaxHeight // ignore: cast_nullable_to_non_nullable
as Tracked<TsunamiEstimationMaxHeight?>,stations: null == stations ? _self._stations : stations // ignore: cast_nullable_to_non_nullable
as List<TrackedRegionStation>,
  ));
}


}

// dart format on
