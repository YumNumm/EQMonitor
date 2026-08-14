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

// dart format on
