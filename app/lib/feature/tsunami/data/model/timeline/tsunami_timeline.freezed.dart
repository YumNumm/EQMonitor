// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_timeline.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TsunamiTimeline {

 List<TsunamiTelegramMeta> get telegrams; List<RegionTimeline> get regions; List<OffshoreStationTimeline> get offshoreStations;
/// Create a copy of TsunamiTimeline
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiTimelineCopyWith<TsunamiTimeline> get copyWith => _$TsunamiTimelineCopyWithImpl<TsunamiTimeline>(this as TsunamiTimeline, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiTimeline&&const DeepCollectionEquality().equals(other.telegrams, telegrams)&&const DeepCollectionEquality().equals(other.regions, regions)&&const DeepCollectionEquality().equals(other.offshoreStations, offshoreStations));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(telegrams),const DeepCollectionEquality().hash(regions),const DeepCollectionEquality().hash(offshoreStations));

@override
String toString() {
  return 'TsunamiTimeline(telegrams: $telegrams, regions: $regions, offshoreStations: $offshoreStations)';
}


}

/// @nodoc
abstract mixin class $TsunamiTimelineCopyWith<$Res>  {
  factory $TsunamiTimelineCopyWith(TsunamiTimeline value, $Res Function(TsunamiTimeline) _then) = _$TsunamiTimelineCopyWithImpl;
@useResult
$Res call({
 List<TsunamiTelegramMeta> telegrams, List<RegionTimeline> regions, List<OffshoreStationTimeline> offshoreStations
});




}
/// @nodoc
class _$TsunamiTimelineCopyWithImpl<$Res>
    implements $TsunamiTimelineCopyWith<$Res> {
  _$TsunamiTimelineCopyWithImpl(this._self, this._then);

  final TsunamiTimeline _self;
  final $Res Function(TsunamiTimeline) _then;

/// Create a copy of TsunamiTimeline
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? telegrams = null,Object? regions = null,Object? offshoreStations = null,}) {
  return _then(TsunamiTimeline(
telegrams: null == telegrams ? _self.telegrams : telegrams // ignore: cast_nullable_to_non_nullable
as List<TsunamiTelegramMeta>,regions: null == regions ? _self.regions : regions // ignore: cast_nullable_to_non_nullable
as List<RegionTimeline>,offshoreStations: null == offshoreStations ? _self.offshoreStations : offshoreStations // ignore: cast_nullable_to_non_nullable
as List<OffshoreStationTimeline>,
  ));
}

}


/// Adds pattern-matching-related methods to [TsunamiTimeline].
extension TsunamiTimelinePatterns on TsunamiTimeline {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiTimeline value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiTimeline() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiTimeline value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiTimeline():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiTimeline value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiTimeline() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<TsunamiTelegramMeta> telegrams,  List<RegionTimeline> regions,  List<OffshoreStationTimeline> offshoreStations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiTimeline() when $default != null:
return $default(_that.telegrams,_that.regions,_that.offshoreStations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<TsunamiTelegramMeta> telegrams,  List<RegionTimeline> regions,  List<OffshoreStationTimeline> offshoreStations)  $default,) {final _that = this;
switch (_that) {
case _TsunamiTimeline():
return $default(_that.telegrams,_that.regions,_that.offshoreStations);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<TsunamiTelegramMeta> telegrams,  List<RegionTimeline> regions,  List<OffshoreStationTimeline> offshoreStations)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiTimeline() when $default != null:
return $default(_that.telegrams,_that.regions,_that.offshoreStations);case _:
  return null;

}
}

}

/// @nodoc


class _TsunamiTimeline implements TsunamiTimeline {
  const _TsunamiTimeline({required  List<TsunamiTelegramMeta> telegrams, required  List<RegionTimeline> regions, required  List<OffshoreStationTimeline> offshoreStations}): _telegrams = telegrams,_regions = regions,_offshoreStations = offshoreStations;
  

 final  List<TsunamiTelegramMeta> _telegrams;
@override List<TsunamiTelegramMeta> get telegrams {
  if (_telegrams is EqualUnmodifiableListView) return _telegrams;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_telegrams);
}

 final  List<RegionTimeline> _regions;
@override List<RegionTimeline> get regions {
  if (_regions is EqualUnmodifiableListView) return _regions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_regions);
}

 final  List<OffshoreStationTimeline> _offshoreStations;
@override List<OffshoreStationTimeline> get offshoreStations {
  if (_offshoreStations is EqualUnmodifiableListView) return _offshoreStations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_offshoreStations);
}


/// Create a copy of TsunamiTimeline
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiTimelineCopyWith<_TsunamiTimeline> get copyWith => __$TsunamiTimelineCopyWithImpl<_TsunamiTimeline>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiTimeline&&const DeepCollectionEquality().equals(other._telegrams, _telegrams)&&const DeepCollectionEquality().equals(other._regions, _regions)&&const DeepCollectionEquality().equals(other._offshoreStations, _offshoreStations));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_telegrams),const DeepCollectionEquality().hash(_regions),const DeepCollectionEquality().hash(_offshoreStations));

@override
String toString() {
  return 'TsunamiTimeline(telegrams: $telegrams, regions: $regions, offshoreStations: $offshoreStations)';
}


}

/// @nodoc
abstract mixin class _$TsunamiTimelineCopyWith<$Res> implements $TsunamiTimelineCopyWith<$Res> {
  factory _$TsunamiTimelineCopyWith(_TsunamiTimeline value, $Res Function(_TsunamiTimeline) _then) = __$TsunamiTimelineCopyWithImpl;
@override @useResult
$Res call({
 List<TsunamiTelegramMeta> telegrams, List<RegionTimeline> regions, List<OffshoreStationTimeline> offshoreStations
});




}
/// @nodoc
class __$TsunamiTimelineCopyWithImpl<$Res>
    implements _$TsunamiTimelineCopyWith<$Res> {
  __$TsunamiTimelineCopyWithImpl(this._self, this._then);

  final _TsunamiTimeline _self;
  final $Res Function(_TsunamiTimeline) _then;

/// Create a copy of TsunamiTimeline
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? telegrams = null,Object? regions = null,Object? offshoreStations = null,}) {
  return _then(_TsunamiTimeline(
telegrams: null == telegrams ? _self._telegrams : telegrams // ignore: cast_nullable_to_non_nullable
as List<TsunamiTelegramMeta>,regions: null == regions ? _self._regions : regions // ignore: cast_nullable_to_non_nullable
as List<RegionTimeline>,offshoreStations: null == offshoreStations ? _self._offshoreStations : offshoreStations // ignore: cast_nullable_to_non_nullable
as List<OffshoreStationTimeline>,
  ));
}


}

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

/// @nodoc
mixin _$StationTimeline {

 String get code; String get name; StationForecastTimeline get forecast; StationObservationTimeline get observation;
/// Create a copy of StationTimeline
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StationTimelineCopyWith<StationTimeline> get copyWith => _$StationTimelineCopyWithImpl<StationTimeline>(this as StationTimeline, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StationTimeline&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.forecast, forecast)&&const DeepCollectionEquality().equals(other.observation, observation));
}


@override
int get hashCode => Object.hash(runtimeType,code,name,const DeepCollectionEquality().hash(forecast),const DeepCollectionEquality().hash(observation));

@override
String toString() {
  return 'StationTimeline(code: $code, name: $name, forecast: $forecast, observation: $observation)';
}


}

/// @nodoc
abstract mixin class $StationTimelineCopyWith<$Res>  {
  factory $StationTimelineCopyWith(StationTimeline value, $Res Function(StationTimeline) _then) = _$StationTimelineCopyWithImpl;
@useResult
$Res call({
 String code, String name, StationForecastTimeline forecast, StationObservationTimeline observation
});




}
/// @nodoc
class _$StationTimelineCopyWithImpl<$Res>
    implements $StationTimelineCopyWith<$Res> {
  _$StationTimelineCopyWithImpl(this._self, this._then);

  final StationTimeline _self;
  final $Res Function(StationTimeline) _then;

/// Create a copy of StationTimeline
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? forecast = null,Object? observation = null,}) {
  return _then(StationTimeline(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,forecast: null == forecast ? _self.forecast : forecast // ignore: cast_nullable_to_non_nullable
as StationForecastTimeline,observation: null == observation ? _self.observation : observation // ignore: cast_nullable_to_non_nullable
as StationObservationTimeline,
  ));
}

}


/// Adds pattern-matching-related methods to [StationTimeline].
extension StationTimelinePatterns on StationTimeline {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StationTimeline value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StationTimeline() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StationTimeline value)  $default,){
final _that = this;
switch (_that) {
case _StationTimeline():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StationTimeline value)?  $default,){
final _that = this;
switch (_that) {
case _StationTimeline() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String name,  StationForecastTimeline forecast,  StationObservationTimeline observation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StationTimeline() when $default != null:
return $default(_that.code,_that.name,_that.forecast,_that.observation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String name,  StationForecastTimeline forecast,  StationObservationTimeline observation)  $default,) {final _that = this;
switch (_that) {
case _StationTimeline():
return $default(_that.code,_that.name,_that.forecast,_that.observation);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String name,  StationForecastTimeline forecast,  StationObservationTimeline observation)?  $default,) {final _that = this;
switch (_that) {
case _StationTimeline() when $default != null:
return $default(_that.code,_that.name,_that.forecast,_that.observation);case _:
  return null;

}
}

}

/// @nodoc


class _StationTimeline implements StationTimeline {
  const _StationTimeline({required this.code, required this.name, required  StationForecastTimeline forecast, required  StationObservationTimeline observation}): _forecast = forecast,_observation = observation;
  

@override final  String code;
@override final  String name;
 final  StationForecastTimeline _forecast;
@override StationForecastTimeline get forecast {
  if (_forecast is EqualUnmodifiableListView) return _forecast;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_forecast);
}

 final  StationObservationTimeline _observation;
@override StationObservationTimeline get observation {
  if (_observation is EqualUnmodifiableListView) return _observation;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_observation);
}


/// Create a copy of StationTimeline
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StationTimelineCopyWith<_StationTimeline> get copyWith => __$StationTimelineCopyWithImpl<_StationTimeline>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StationTimeline&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._forecast, _forecast)&&const DeepCollectionEquality().equals(other._observation, _observation));
}


@override
int get hashCode => Object.hash(runtimeType,code,name,const DeepCollectionEquality().hash(_forecast),const DeepCollectionEquality().hash(_observation));

@override
String toString() {
  return 'StationTimeline(code: $code, name: $name, forecast: $forecast, observation: $observation)';
}


}

/// @nodoc
abstract mixin class _$StationTimelineCopyWith<$Res> implements $StationTimelineCopyWith<$Res> {
  factory _$StationTimelineCopyWith(_StationTimeline value, $Res Function(_StationTimeline) _then) = __$StationTimelineCopyWithImpl;
@override @useResult
$Res call({
 String code, String name, StationForecastTimeline forecast, StationObservationTimeline observation
});




}
/// @nodoc
class __$StationTimelineCopyWithImpl<$Res>
    implements _$StationTimelineCopyWith<$Res> {
  __$StationTimelineCopyWithImpl(this._self, this._then);

  final _StationTimeline _self;
  final $Res Function(_StationTimeline) _then;

/// Create a copy of StationTimeline
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? forecast = null,Object? observation = null,}) {
  return _then(_StationTimeline(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,forecast: null == forecast ? _self._forecast : forecast // ignore: cast_nullable_to_non_nullable
as StationForecastTimeline,observation: null == observation ? _self._observation : observation // ignore: cast_nullable_to_non_nullable
as StationObservationTimeline,
  ));
}


}

/// @nodoc
mixin _$OffshoreStationTimeline {

 String get code; String get name; ObservationFirstHeightTimeline get firstHeight; ObservationMaxHeightTimeline get maxHeight;
/// Create a copy of OffshoreStationTimeline
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OffshoreStationTimelineCopyWith<OffshoreStationTimeline> get copyWith => _$OffshoreStationTimelineCopyWithImpl<OffshoreStationTimeline>(this as OffshoreStationTimeline, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OffshoreStationTimeline&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.firstHeight, firstHeight)&&const DeepCollectionEquality().equals(other.maxHeight, maxHeight));
}


@override
int get hashCode => Object.hash(runtimeType,code,name,const DeepCollectionEquality().hash(firstHeight),const DeepCollectionEquality().hash(maxHeight));

@override
String toString() {
  return 'OffshoreStationTimeline(code: $code, name: $name, firstHeight: $firstHeight, maxHeight: $maxHeight)';
}


}

/// @nodoc
abstract mixin class $OffshoreStationTimelineCopyWith<$Res>  {
  factory $OffshoreStationTimelineCopyWith(OffshoreStationTimeline value, $Res Function(OffshoreStationTimeline) _then) = _$OffshoreStationTimelineCopyWithImpl;
@useResult
$Res call({
 String code, String name, ObservationFirstHeightTimeline firstHeight, ObservationMaxHeightTimeline maxHeight
});




}
/// @nodoc
class _$OffshoreStationTimelineCopyWithImpl<$Res>
    implements $OffshoreStationTimelineCopyWith<$Res> {
  _$OffshoreStationTimelineCopyWithImpl(this._self, this._then);

  final OffshoreStationTimeline _self;
  final $Res Function(OffshoreStationTimeline) _then;

/// Create a copy of OffshoreStationTimeline
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? firstHeight = null,Object? maxHeight = null,}) {
  return _then(OffshoreStationTimeline(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,firstHeight: null == firstHeight ? _self.firstHeight : firstHeight // ignore: cast_nullable_to_non_nullable
as ObservationFirstHeightTimeline,maxHeight: null == maxHeight ? _self.maxHeight : maxHeight // ignore: cast_nullable_to_non_nullable
as ObservationMaxHeightTimeline,
  ));
}

}


/// Adds pattern-matching-related methods to [OffshoreStationTimeline].
extension OffshoreStationTimelinePatterns on OffshoreStationTimeline {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OffshoreStationTimeline value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OffshoreStationTimeline() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OffshoreStationTimeline value)  $default,){
final _that = this;
switch (_that) {
case _OffshoreStationTimeline():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OffshoreStationTimeline value)?  $default,){
final _that = this;
switch (_that) {
case _OffshoreStationTimeline() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String name,  ObservationFirstHeightTimeline firstHeight,  ObservationMaxHeightTimeline maxHeight)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OffshoreStationTimeline() when $default != null:
return $default(_that.code,_that.name,_that.firstHeight,_that.maxHeight);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String name,  ObservationFirstHeightTimeline firstHeight,  ObservationMaxHeightTimeline maxHeight)  $default,) {final _that = this;
switch (_that) {
case _OffshoreStationTimeline():
return $default(_that.code,_that.name,_that.firstHeight,_that.maxHeight);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String name,  ObservationFirstHeightTimeline firstHeight,  ObservationMaxHeightTimeline maxHeight)?  $default,) {final _that = this;
switch (_that) {
case _OffshoreStationTimeline() when $default != null:
return $default(_that.code,_that.name,_that.firstHeight,_that.maxHeight);case _:
  return null;

}
}

}

/// @nodoc


class _OffshoreStationTimeline implements OffshoreStationTimeline {
  const _OffshoreStationTimeline({required this.code, required this.name, required  ObservationFirstHeightTimeline firstHeight, required  ObservationMaxHeightTimeline maxHeight}): _firstHeight = firstHeight,_maxHeight = maxHeight;
  

@override final  String code;
@override final  String name;
 final  ObservationFirstHeightTimeline _firstHeight;
@override ObservationFirstHeightTimeline get firstHeight {
  if (_firstHeight is EqualUnmodifiableListView) return _firstHeight;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_firstHeight);
}

 final  ObservationMaxHeightTimeline _maxHeight;
@override ObservationMaxHeightTimeline get maxHeight {
  if (_maxHeight is EqualUnmodifiableListView) return _maxHeight;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_maxHeight);
}


/// Create a copy of OffshoreStationTimeline
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OffshoreStationTimelineCopyWith<_OffshoreStationTimeline> get copyWith => __$OffshoreStationTimelineCopyWithImpl<_OffshoreStationTimeline>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OffshoreStationTimeline&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._firstHeight, _firstHeight)&&const DeepCollectionEquality().equals(other._maxHeight, _maxHeight));
}


@override
int get hashCode => Object.hash(runtimeType,code,name,const DeepCollectionEquality().hash(_firstHeight),const DeepCollectionEquality().hash(_maxHeight));

@override
String toString() {
  return 'OffshoreStationTimeline(code: $code, name: $name, firstHeight: $firstHeight, maxHeight: $maxHeight)';
}


}

/// @nodoc
abstract mixin class _$OffshoreStationTimelineCopyWith<$Res> implements $OffshoreStationTimelineCopyWith<$Res> {
  factory _$OffshoreStationTimelineCopyWith(_OffshoreStationTimeline value, $Res Function(_OffshoreStationTimeline) _then) = __$OffshoreStationTimelineCopyWithImpl;
@override @useResult
$Res call({
 String code, String name, ObservationFirstHeightTimeline firstHeight, ObservationMaxHeightTimeline maxHeight
});




}
/// @nodoc
class __$OffshoreStationTimelineCopyWithImpl<$Res>
    implements _$OffshoreStationTimelineCopyWith<$Res> {
  __$OffshoreStationTimelineCopyWithImpl(this._self, this._then);

  final _OffshoreStationTimeline _self;
  final $Res Function(_OffshoreStationTimeline) _then;

/// Create a copy of OffshoreStationTimeline
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? firstHeight = null,Object? maxHeight = null,}) {
  return _then(_OffshoreStationTimeline(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,firstHeight: null == firstHeight ? _self._firstHeight : firstHeight // ignore: cast_nullable_to_non_nullable
as ObservationFirstHeightTimeline,maxHeight: null == maxHeight ? _self._maxHeight : maxHeight // ignore: cast_nullable_to_non_nullable
as ObservationMaxHeightTimeline,
  ));
}


}

// dart format on
