// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tracked_tsunami_timeline.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TrackedTsunamiTimeline {

 List<TsunamiTelegramMeta> get telegrams; List<TrackedRegion> get regions; List<TrackedOffshoreStation> get offshoreStations;
/// Create a copy of TrackedTsunamiTimeline
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrackedTsunamiTimelineCopyWith<TrackedTsunamiTimeline> get copyWith => _$TrackedTsunamiTimelineCopyWithImpl<TrackedTsunamiTimeline>(this as TrackedTsunamiTimeline, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrackedTsunamiTimeline&&const DeepCollectionEquality().equals(other.telegrams, telegrams)&&const DeepCollectionEquality().equals(other.regions, regions)&&const DeepCollectionEquality().equals(other.offshoreStations, offshoreStations));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(telegrams),const DeepCollectionEquality().hash(regions),const DeepCollectionEquality().hash(offshoreStations));

@override
String toString() {
  return 'TrackedTsunamiTimeline(telegrams: $telegrams, regions: $regions, offshoreStations: $offshoreStations)';
}


}

/// @nodoc
abstract mixin class $TrackedTsunamiTimelineCopyWith<$Res>  {
  factory $TrackedTsunamiTimelineCopyWith(TrackedTsunamiTimeline value, $Res Function(TrackedTsunamiTimeline) _then) = _$TrackedTsunamiTimelineCopyWithImpl;
@useResult
$Res call({
 List<TsunamiTelegramMeta> telegrams, List<TrackedRegion> regions, List<TrackedOffshoreStation> offshoreStations
});




}
/// @nodoc
class _$TrackedTsunamiTimelineCopyWithImpl<$Res>
    implements $TrackedTsunamiTimelineCopyWith<$Res> {
  _$TrackedTsunamiTimelineCopyWithImpl(this._self, this._then);

  final TrackedTsunamiTimeline _self;
  final $Res Function(TrackedTsunamiTimeline) _then;

/// Create a copy of TrackedTsunamiTimeline
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? telegrams = null,Object? regions = null,Object? offshoreStations = null,}) {
  return _then(TrackedTsunamiTimeline(
telegrams: null == telegrams ? _self.telegrams : telegrams // ignore: cast_nullable_to_non_nullable
as List<TsunamiTelegramMeta>,regions: null == regions ? _self.regions : regions // ignore: cast_nullable_to_non_nullable
as List<TrackedRegion>,offshoreStations: null == offshoreStations ? _self.offshoreStations : offshoreStations // ignore: cast_nullable_to_non_nullable
as List<TrackedOffshoreStation>,
  ));
}

}


/// Adds pattern-matching-related methods to [TrackedTsunamiTimeline].
extension TrackedTsunamiTimelinePatterns on TrackedTsunamiTimeline {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrackedTsunamiTimeline value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrackedTsunamiTimeline() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrackedTsunamiTimeline value)  $default,){
final _that = this;
switch (_that) {
case _TrackedTsunamiTimeline():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrackedTsunamiTimeline value)?  $default,){
final _that = this;
switch (_that) {
case _TrackedTsunamiTimeline() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<TsunamiTelegramMeta> telegrams,  List<TrackedRegion> regions,  List<TrackedOffshoreStation> offshoreStations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrackedTsunamiTimeline() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<TsunamiTelegramMeta> telegrams,  List<TrackedRegion> regions,  List<TrackedOffshoreStation> offshoreStations)  $default,) {final _that = this;
switch (_that) {
case _TrackedTsunamiTimeline():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<TsunamiTelegramMeta> telegrams,  List<TrackedRegion> regions,  List<TrackedOffshoreStation> offshoreStations)?  $default,) {final _that = this;
switch (_that) {
case _TrackedTsunamiTimeline() when $default != null:
return $default(_that.telegrams,_that.regions,_that.offshoreStations);case _:
  return null;

}
}

}

/// @nodoc


class _TrackedTsunamiTimeline implements TrackedTsunamiTimeline {
  const _TrackedTsunamiTimeline({required  List<TsunamiTelegramMeta> telegrams, required  List<TrackedRegion> regions, required  List<TrackedOffshoreStation> offshoreStations}): _telegrams = telegrams,_regions = regions,_offshoreStations = offshoreStations;
  

 final  List<TsunamiTelegramMeta> _telegrams;
@override List<TsunamiTelegramMeta> get telegrams {
  if (_telegrams is EqualUnmodifiableListView) return _telegrams;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_telegrams);
}

 final  List<TrackedRegion> _regions;
@override List<TrackedRegion> get regions {
  if (_regions is EqualUnmodifiableListView) return _regions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_regions);
}

 final  List<TrackedOffshoreStation> _offshoreStations;
@override List<TrackedOffshoreStation> get offshoreStations {
  if (_offshoreStations is EqualUnmodifiableListView) return _offshoreStations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_offshoreStations);
}


/// Create a copy of TrackedTsunamiTimeline
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrackedTsunamiTimelineCopyWith<_TrackedTsunamiTimeline> get copyWith => __$TrackedTsunamiTimelineCopyWithImpl<_TrackedTsunamiTimeline>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrackedTsunamiTimeline&&const DeepCollectionEquality().equals(other._telegrams, _telegrams)&&const DeepCollectionEquality().equals(other._regions, _regions)&&const DeepCollectionEquality().equals(other._offshoreStations, _offshoreStations));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_telegrams),const DeepCollectionEquality().hash(_regions),const DeepCollectionEquality().hash(_offshoreStations));

@override
String toString() {
  return 'TrackedTsunamiTimeline(telegrams: $telegrams, regions: $regions, offshoreStations: $offshoreStations)';
}


}

/// @nodoc
abstract mixin class _$TrackedTsunamiTimelineCopyWith<$Res> implements $TrackedTsunamiTimelineCopyWith<$Res> {
  factory _$TrackedTsunamiTimelineCopyWith(_TrackedTsunamiTimeline value, $Res Function(_TrackedTsunamiTimeline) _then) = __$TrackedTsunamiTimelineCopyWithImpl;
@override @useResult
$Res call({
 List<TsunamiTelegramMeta> telegrams, List<TrackedRegion> regions, List<TrackedOffshoreStation> offshoreStations
});




}
/// @nodoc
class __$TrackedTsunamiTimelineCopyWithImpl<$Res>
    implements _$TrackedTsunamiTimelineCopyWith<$Res> {
  __$TrackedTsunamiTimelineCopyWithImpl(this._self, this._then);

  final _TrackedTsunamiTimeline _self;
  final $Res Function(_TrackedTsunamiTimeline) _then;

/// Create a copy of TrackedTsunamiTimeline
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? telegrams = null,Object? regions = null,Object? offshoreStations = null,}) {
  return _then(_TrackedTsunamiTimeline(
telegrams: null == telegrams ? _self._telegrams : telegrams // ignore: cast_nullable_to_non_nullable
as List<TsunamiTelegramMeta>,regions: null == regions ? _self._regions : regions // ignore: cast_nullable_to_non_nullable
as List<TrackedRegion>,offshoreStations: null == offshoreStations ? _self._offshoreStations : offshoreStations // ignore: cast_nullable_to_non_nullable
as List<TrackedOffshoreStation>,
  ));
}


}

// dart format on
