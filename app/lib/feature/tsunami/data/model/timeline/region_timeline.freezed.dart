// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'region_timeline.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RegionTimeline {

 String get code; String get name; KindTimeline get kind; KindTimeline get lastKind; FirstHeightTimeline get forecastFirstHeight; MaxHeightTimeline get forecastMaxHeight; EstimationFirstHeightTimeline get estimationFirstHeight; EstimationMaxHeightTimeline get estimationMaxHeight; List<StationTimeline> get stations;
/// Create a copy of RegionTimeline
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegionTimelineCopyWith<RegionTimeline> get copyWith => _$RegionTimelineCopyWithImpl<RegionTimeline>(this as RegionTimeline, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegionTimeline&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.kind, kind)&&const DeepCollectionEquality().equals(other.lastKind, lastKind)&&const DeepCollectionEquality().equals(other.forecastFirstHeight, forecastFirstHeight)&&const DeepCollectionEquality().equals(other.forecastMaxHeight, forecastMaxHeight)&&const DeepCollectionEquality().equals(other.estimationFirstHeight, estimationFirstHeight)&&const DeepCollectionEquality().equals(other.estimationMaxHeight, estimationMaxHeight)&&const DeepCollectionEquality().equals(other.stations, stations));
}


@override
int get hashCode => Object.hash(runtimeType,code,name,const DeepCollectionEquality().hash(kind),const DeepCollectionEquality().hash(lastKind),const DeepCollectionEquality().hash(forecastFirstHeight),const DeepCollectionEquality().hash(forecastMaxHeight),const DeepCollectionEquality().hash(estimationFirstHeight),const DeepCollectionEquality().hash(estimationMaxHeight),const DeepCollectionEquality().hash(stations));

@override
String toString() {
  return 'RegionTimeline(code: $code, name: $name, kind: $kind, lastKind: $lastKind, forecastFirstHeight: $forecastFirstHeight, forecastMaxHeight: $forecastMaxHeight, estimationFirstHeight: $estimationFirstHeight, estimationMaxHeight: $estimationMaxHeight, stations: $stations)';
}


}

/// @nodoc
abstract mixin class $RegionTimelineCopyWith<$Res>  {
  factory $RegionTimelineCopyWith(RegionTimeline value, $Res Function(RegionTimeline) _then) = _$RegionTimelineCopyWithImpl;
@useResult
$Res call({
 String code, String name, KindTimeline kind, KindTimeline lastKind, FirstHeightTimeline forecastFirstHeight, MaxHeightTimeline forecastMaxHeight, EstimationFirstHeightTimeline estimationFirstHeight, EstimationMaxHeightTimeline estimationMaxHeight, List<StationTimeline> stations
});




}
/// @nodoc
class _$RegionTimelineCopyWithImpl<$Res>
    implements $RegionTimelineCopyWith<$Res> {
  _$RegionTimelineCopyWithImpl(this._self, this._then);

  final RegionTimeline _self;
  final $Res Function(RegionTimeline) _then;

/// Create a copy of RegionTimeline
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? kind = null,Object? lastKind = null,Object? forecastFirstHeight = null,Object? forecastMaxHeight = null,Object? estimationFirstHeight = null,Object? estimationMaxHeight = null,Object? stations = null,}) {
  return _then(RegionTimeline(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as KindTimeline,lastKind: null == lastKind ? _self.lastKind : lastKind // ignore: cast_nullable_to_non_nullable
as KindTimeline,forecastFirstHeight: null == forecastFirstHeight ? _self.forecastFirstHeight : forecastFirstHeight // ignore: cast_nullable_to_non_nullable
as FirstHeightTimeline,forecastMaxHeight: null == forecastMaxHeight ? _self.forecastMaxHeight : forecastMaxHeight // ignore: cast_nullable_to_non_nullable
as MaxHeightTimeline,estimationFirstHeight: null == estimationFirstHeight ? _self.estimationFirstHeight : estimationFirstHeight // ignore: cast_nullable_to_non_nullable
as EstimationFirstHeightTimeline,estimationMaxHeight: null == estimationMaxHeight ? _self.estimationMaxHeight : estimationMaxHeight // ignore: cast_nullable_to_non_nullable
as EstimationMaxHeightTimeline,stations: null == stations ? _self.stations : stations // ignore: cast_nullable_to_non_nullable
as List<StationTimeline>,
  ));
}

}


/// Adds pattern-matching-related methods to [RegionTimeline].
extension RegionTimelinePatterns on RegionTimeline {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegionTimeline value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegionTimeline() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegionTimeline value)  $default,){
final _that = this;
switch (_that) {
case _RegionTimeline():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegionTimeline value)?  $default,){
final _that = this;
switch (_that) {
case _RegionTimeline() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String name,  KindTimeline kind,  KindTimeline lastKind,  FirstHeightTimeline forecastFirstHeight,  MaxHeightTimeline forecastMaxHeight,  EstimationFirstHeightTimeline estimationFirstHeight,  EstimationMaxHeightTimeline estimationMaxHeight,  List<StationTimeline> stations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegionTimeline() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String name,  KindTimeline kind,  KindTimeline lastKind,  FirstHeightTimeline forecastFirstHeight,  MaxHeightTimeline forecastMaxHeight,  EstimationFirstHeightTimeline estimationFirstHeight,  EstimationMaxHeightTimeline estimationMaxHeight,  List<StationTimeline> stations)  $default,) {final _that = this;
switch (_that) {
case _RegionTimeline():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String name,  KindTimeline kind,  KindTimeline lastKind,  FirstHeightTimeline forecastFirstHeight,  MaxHeightTimeline forecastMaxHeight,  EstimationFirstHeightTimeline estimationFirstHeight,  EstimationMaxHeightTimeline estimationMaxHeight,  List<StationTimeline> stations)?  $default,) {final _that = this;
switch (_that) {
case _RegionTimeline() when $default != null:
return $default(_that.code,_that.name,_that.kind,_that.lastKind,_that.forecastFirstHeight,_that.forecastMaxHeight,_that.estimationFirstHeight,_that.estimationMaxHeight,_that.stations);case _:
  return null;

}
}

}

/// @nodoc


class _RegionTimeline implements RegionTimeline {
  const _RegionTimeline({required this.code, required this.name, required  KindTimeline kind, required  KindTimeline lastKind, required  FirstHeightTimeline forecastFirstHeight, required  MaxHeightTimeline forecastMaxHeight, required  EstimationFirstHeightTimeline estimationFirstHeight, required  EstimationMaxHeightTimeline estimationMaxHeight, required  List<StationTimeline> stations}): _kind = kind,_lastKind = lastKind,_forecastFirstHeight = forecastFirstHeight,_forecastMaxHeight = forecastMaxHeight,_estimationFirstHeight = estimationFirstHeight,_estimationMaxHeight = estimationMaxHeight,_stations = stations;
  

@override final  String code;
@override final  String name;
 final  KindTimeline _kind;
@override KindTimeline get kind {
  if (_kind is EqualUnmodifiableListView) return _kind;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_kind);
}

 final  KindTimeline _lastKind;
@override KindTimeline get lastKind {
  if (_lastKind is EqualUnmodifiableListView) return _lastKind;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lastKind);
}

 final  FirstHeightTimeline _forecastFirstHeight;
@override FirstHeightTimeline get forecastFirstHeight {
  if (_forecastFirstHeight is EqualUnmodifiableListView) return _forecastFirstHeight;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_forecastFirstHeight);
}

 final  MaxHeightTimeline _forecastMaxHeight;
@override MaxHeightTimeline get forecastMaxHeight {
  if (_forecastMaxHeight is EqualUnmodifiableListView) return _forecastMaxHeight;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_forecastMaxHeight);
}

 final  EstimationFirstHeightTimeline _estimationFirstHeight;
@override EstimationFirstHeightTimeline get estimationFirstHeight {
  if (_estimationFirstHeight is EqualUnmodifiableListView) return _estimationFirstHeight;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_estimationFirstHeight);
}

 final  EstimationMaxHeightTimeline _estimationMaxHeight;
@override EstimationMaxHeightTimeline get estimationMaxHeight {
  if (_estimationMaxHeight is EqualUnmodifiableListView) return _estimationMaxHeight;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_estimationMaxHeight);
}

 final  List<StationTimeline> _stations;
@override List<StationTimeline> get stations {
  if (_stations is EqualUnmodifiableListView) return _stations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stations);
}


/// Create a copy of RegionTimeline
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegionTimelineCopyWith<_RegionTimeline> get copyWith => __$RegionTimelineCopyWithImpl<_RegionTimeline>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegionTimeline&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._kind, _kind)&&const DeepCollectionEquality().equals(other._lastKind, _lastKind)&&const DeepCollectionEquality().equals(other._forecastFirstHeight, _forecastFirstHeight)&&const DeepCollectionEquality().equals(other._forecastMaxHeight, _forecastMaxHeight)&&const DeepCollectionEquality().equals(other._estimationFirstHeight, _estimationFirstHeight)&&const DeepCollectionEquality().equals(other._estimationMaxHeight, _estimationMaxHeight)&&const DeepCollectionEquality().equals(other._stations, _stations));
}


@override
int get hashCode => Object.hash(runtimeType,code,name,const DeepCollectionEquality().hash(_kind),const DeepCollectionEquality().hash(_lastKind),const DeepCollectionEquality().hash(_forecastFirstHeight),const DeepCollectionEquality().hash(_forecastMaxHeight),const DeepCollectionEquality().hash(_estimationFirstHeight),const DeepCollectionEquality().hash(_estimationMaxHeight),const DeepCollectionEquality().hash(_stations));

@override
String toString() {
  return 'RegionTimeline(code: $code, name: $name, kind: $kind, lastKind: $lastKind, forecastFirstHeight: $forecastFirstHeight, forecastMaxHeight: $forecastMaxHeight, estimationFirstHeight: $estimationFirstHeight, estimationMaxHeight: $estimationMaxHeight, stations: $stations)';
}


}

/// @nodoc
abstract mixin class _$RegionTimelineCopyWith<$Res> implements $RegionTimelineCopyWith<$Res> {
  factory _$RegionTimelineCopyWith(_RegionTimeline value, $Res Function(_RegionTimeline) _then) = __$RegionTimelineCopyWithImpl;
@override @useResult
$Res call({
 String code, String name, KindTimeline kind, KindTimeline lastKind, FirstHeightTimeline forecastFirstHeight, MaxHeightTimeline forecastMaxHeight, EstimationFirstHeightTimeline estimationFirstHeight, EstimationMaxHeightTimeline estimationMaxHeight, List<StationTimeline> stations
});




}
/// @nodoc
class __$RegionTimelineCopyWithImpl<$Res>
    implements _$RegionTimelineCopyWith<$Res> {
  __$RegionTimelineCopyWithImpl(this._self, this._then);

  final _RegionTimeline _self;
  final $Res Function(_RegionTimeline) _then;

/// Create a copy of RegionTimeline
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? kind = null,Object? lastKind = null,Object? forecastFirstHeight = null,Object? forecastMaxHeight = null,Object? estimationFirstHeight = null,Object? estimationMaxHeight = null,Object? stations = null,}) {
  return _then(_RegionTimeline(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self._kind : kind // ignore: cast_nullable_to_non_nullable
as KindTimeline,lastKind: null == lastKind ? _self._lastKind : lastKind // ignore: cast_nullable_to_non_nullable
as KindTimeline,forecastFirstHeight: null == forecastFirstHeight ? _self._forecastFirstHeight : forecastFirstHeight // ignore: cast_nullable_to_non_nullable
as FirstHeightTimeline,forecastMaxHeight: null == forecastMaxHeight ? _self._forecastMaxHeight : forecastMaxHeight // ignore: cast_nullable_to_non_nullable
as MaxHeightTimeline,estimationFirstHeight: null == estimationFirstHeight ? _self._estimationFirstHeight : estimationFirstHeight // ignore: cast_nullable_to_non_nullable
as EstimationFirstHeightTimeline,estimationMaxHeight: null == estimationMaxHeight ? _self._estimationMaxHeight : estimationMaxHeight // ignore: cast_nullable_to_non_nullable
as EstimationMaxHeightTimeline,stations: null == stations ? _self._stations : stations // ignore: cast_nullable_to_non_nullable
as List<StationTimeline>,
  ));
}


}

// dart format on
