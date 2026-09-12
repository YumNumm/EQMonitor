// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'unified_earthquake.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UnifiedEarthquakeLocation {

 String get regionName; JmaIntensity? get maxIntensity;
/// Create a copy of UnifiedEarthquakeLocation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnifiedEarthquakeLocationCopyWith<UnifiedEarthquakeLocation> get copyWith => _$UnifiedEarthquakeLocationCopyWithImpl<UnifiedEarthquakeLocation>(this as UnifiedEarthquakeLocation, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnifiedEarthquakeLocation&&(identical(other.regionName, regionName) || other.regionName == regionName)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity));
}


@override
int get hashCode => Object.hash(runtimeType,regionName,maxIntensity);

@override
String toString() {
  return 'UnifiedEarthquakeLocation(regionName: $regionName, maxIntensity: $maxIntensity)';
}


}

/// @nodoc
abstract mixin class $UnifiedEarthquakeLocationCopyWith<$Res>  {
  factory $UnifiedEarthquakeLocationCopyWith(UnifiedEarthquakeLocation value, $Res Function(UnifiedEarthquakeLocation) _then) = _$UnifiedEarthquakeLocationCopyWithImpl;
@useResult
$Res call({
 String regionName, JmaIntensity? maxIntensity
});




}
/// @nodoc
class _$UnifiedEarthquakeLocationCopyWithImpl<$Res>
    implements $UnifiedEarthquakeLocationCopyWith<$Res> {
  _$UnifiedEarthquakeLocationCopyWithImpl(this._self, this._then);

  final UnifiedEarthquakeLocation _self;
  final $Res Function(UnifiedEarthquakeLocation) _then;

/// Create a copy of UnifiedEarthquakeLocation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? regionName = null,Object? maxIntensity = freezed,}) {
  return _then(UnifiedEarthquakeLocation(
regionName: null == regionName ? _self.regionName : regionName // ignore: cast_nullable_to_non_nullable
as String,maxIntensity: freezed == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,
  ));
}

}


/// Adds pattern-matching-related methods to [UnifiedEarthquakeLocation].
extension UnifiedEarthquakeLocationPatterns on UnifiedEarthquakeLocation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UnifiedEarthquakeLocation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UnifiedEarthquakeLocation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UnifiedEarthquakeLocation value)  $default,){
final _that = this;
switch (_that) {
case _UnifiedEarthquakeLocation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UnifiedEarthquakeLocation value)?  $default,){
final _that = this;
switch (_that) {
case _UnifiedEarthquakeLocation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String regionName,  JmaIntensity? maxIntensity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UnifiedEarthquakeLocation() when $default != null:
return $default(_that.regionName,_that.maxIntensity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String regionName,  JmaIntensity? maxIntensity)  $default,) {final _that = this;
switch (_that) {
case _UnifiedEarthquakeLocation():
return $default(_that.regionName,_that.maxIntensity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String regionName,  JmaIntensity? maxIntensity)?  $default,) {final _that = this;
switch (_that) {
case _UnifiedEarthquakeLocation() when $default != null:
return $default(_that.regionName,_that.maxIntensity);case _:
  return null;

}
}

}

/// @nodoc


class _UnifiedEarthquakeLocation extends UnifiedEarthquakeLocation {
  const _UnifiedEarthquakeLocation({required this.regionName, required this.maxIntensity}): super._();
  

@override final  String regionName;
@override final  JmaIntensity? maxIntensity;

/// Create a copy of UnifiedEarthquakeLocation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UnifiedEarthquakeLocationCopyWith<_UnifiedEarthquakeLocation> get copyWith => __$UnifiedEarthquakeLocationCopyWithImpl<_UnifiedEarthquakeLocation>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UnifiedEarthquakeLocation&&(identical(other.regionName, regionName) || other.regionName == regionName)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity));
}


@override
int get hashCode => Object.hash(runtimeType,regionName,maxIntensity);

@override
String toString() {
  return 'UnifiedEarthquakeLocation(regionName: $regionName, maxIntensity: $maxIntensity)';
}


}

/// @nodoc
abstract mixin class _$UnifiedEarthquakeLocationCopyWith<$Res> implements $UnifiedEarthquakeLocationCopyWith<$Res> {
  factory _$UnifiedEarthquakeLocationCopyWith(_UnifiedEarthquakeLocation value, $Res Function(_UnifiedEarthquakeLocation) _then) = __$UnifiedEarthquakeLocationCopyWithImpl;
@override @useResult
$Res call({
 String regionName, JmaIntensity? maxIntensity
});




}
/// @nodoc
class __$UnifiedEarthquakeLocationCopyWithImpl<$Res>
    implements _$UnifiedEarthquakeLocationCopyWith<$Res> {
  __$UnifiedEarthquakeLocationCopyWithImpl(this._self, this._then);

  final _UnifiedEarthquakeLocation _self;
  final $Res Function(_UnifiedEarthquakeLocation) _then;

/// Create a copy of UnifiedEarthquakeLocation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? regionName = null,Object? maxIntensity = freezed,}) {
  return _then(_UnifiedEarthquakeLocation(
regionName: null == regionName ? _self.regionName : regionName // ignore: cast_nullable_to_non_nullable
as String,maxIntensity: freezed == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,
  ));
}


}

/// @nodoc
mixin _$UnifiedEarthquake {

 String get eventId; String get headline; List<UnifiedLiveActivityInformationType> get informationType; DateTime get issuedAt; bool get isCanceled; String? get hypocenterName; EarthquakeMagnitude? get magnitude; double? get depth; DateTime? get originTime; JmaIntensity? get maxIntensity; UnifiedEarthquakeLocation? get location;
/// Create a copy of UnifiedEarthquake
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnifiedEarthquakeCopyWith<UnifiedEarthquake> get copyWith => _$UnifiedEarthquakeCopyWithImpl<UnifiedEarthquake>(this as UnifiedEarthquake, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnifiedEarthquake&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.headline, headline) || other.headline == headline)&&const DeepCollectionEquality().equals(other.informationType, informationType)&&(identical(other.issuedAt, issuedAt) || other.issuedAt == issuedAt)&&(identical(other.isCanceled, isCanceled) || other.isCanceled == isCanceled)&&(identical(other.hypocenterName, hypocenterName) || other.hypocenterName == hypocenterName)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&(identical(other.location, location) || other.location == location));
}


@override
int get hashCode => Object.hash(runtimeType,eventId,headline,const DeepCollectionEquality().hash(informationType),issuedAt,isCanceled,hypocenterName,magnitude,depth,originTime,maxIntensity,location);

@override
String toString() {
  return 'UnifiedEarthquake(eventId: $eventId, headline: $headline, informationType: $informationType, issuedAt: $issuedAt, isCanceled: $isCanceled, hypocenterName: $hypocenterName, magnitude: $magnitude, depth: $depth, originTime: $originTime, maxIntensity: $maxIntensity, location: $location)';
}


}

/// @nodoc
abstract mixin class $UnifiedEarthquakeCopyWith<$Res>  {
  factory $UnifiedEarthquakeCopyWith(UnifiedEarthquake value, $Res Function(UnifiedEarthquake) _then) = _$UnifiedEarthquakeCopyWithImpl;
@useResult
$Res call({
 String eventId, String headline, List<UnifiedLiveActivityInformationType> informationType, DateTime issuedAt, bool isCanceled, String? hypocenterName, EarthquakeMagnitude? magnitude, double? depth, DateTime? originTime, JmaIntensity? maxIntensity, UnifiedEarthquakeLocation? location
});


$EarthquakeMagnitudeCopyWith<$Res>? get magnitude;$UnifiedEarthquakeLocationCopyWith<$Res>? get location;

}
/// @nodoc
class _$UnifiedEarthquakeCopyWithImpl<$Res>
    implements $UnifiedEarthquakeCopyWith<$Res> {
  _$UnifiedEarthquakeCopyWithImpl(this._self, this._then);

  final UnifiedEarthquake _self;
  final $Res Function(UnifiedEarthquake) _then;

/// Create a copy of UnifiedEarthquake
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? headline = null,Object? informationType = null,Object? issuedAt = null,Object? isCanceled = null,Object? hypocenterName = freezed,Object? magnitude = freezed,Object? depth = freezed,Object? originTime = freezed,Object? maxIntensity = freezed,Object? location = freezed,}) {
  return _then(UnifiedEarthquake(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,headline: null == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String,informationType: null == informationType ? _self.informationType : informationType // ignore: cast_nullable_to_non_nullable
as List<UnifiedLiveActivityInformationType>,issuedAt: null == issuedAt ? _self.issuedAt : issuedAt // ignore: cast_nullable_to_non_nullable
as DateTime,isCanceled: null == isCanceled ? _self.isCanceled : isCanceled // ignore: cast_nullable_to_non_nullable
as bool,hypocenterName: freezed == hypocenterName ? _self.hypocenterName : hypocenterName // ignore: cast_nullable_to_non_nullable
as String?,magnitude: freezed == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as EarthquakeMagnitude?,depth: freezed == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as double?,originTime: freezed == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime?,maxIntensity: freezed == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as UnifiedEarthquakeLocation?,
  ));
}
/// Create a copy of UnifiedEarthquake
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeMagnitudeCopyWith<$Res>? get magnitude {
    if (_self.magnitude == null) {
    return null;
  }

  return $EarthquakeMagnitudeCopyWith<$Res>(_self.magnitude!, (value) {
    return _then(_self.copyWith(magnitude: value));
  });
}/// Create a copy of UnifiedEarthquake
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UnifiedEarthquakeLocationCopyWith<$Res>? get location {
    if (_self.location == null) {
    return null;
  }

  return $UnifiedEarthquakeLocationCopyWith<$Res>(_self.location!, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}


/// Adds pattern-matching-related methods to [UnifiedEarthquake].
extension UnifiedEarthquakePatterns on UnifiedEarthquake {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UnifiedEarthquake value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UnifiedEarthquake() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UnifiedEarthquake value)  $default,){
final _that = this;
switch (_that) {
case _UnifiedEarthquake():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UnifiedEarthquake value)?  $default,){
final _that = this;
switch (_that) {
case _UnifiedEarthquake() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String eventId,  String headline,  List<UnifiedLiveActivityInformationType> informationType,  DateTime issuedAt,  bool isCanceled,  String? hypocenterName,  EarthquakeMagnitude? magnitude,  double? depth,  DateTime? originTime,  JmaIntensity? maxIntensity,  UnifiedEarthquakeLocation? location)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UnifiedEarthquake() when $default != null:
return $default(_that.eventId,_that.headline,_that.informationType,_that.issuedAt,_that.isCanceled,_that.hypocenterName,_that.magnitude,_that.depth,_that.originTime,_that.maxIntensity,_that.location);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String eventId,  String headline,  List<UnifiedLiveActivityInformationType> informationType,  DateTime issuedAt,  bool isCanceled,  String? hypocenterName,  EarthquakeMagnitude? magnitude,  double? depth,  DateTime? originTime,  JmaIntensity? maxIntensity,  UnifiedEarthquakeLocation? location)  $default,) {final _that = this;
switch (_that) {
case _UnifiedEarthquake():
return $default(_that.eventId,_that.headline,_that.informationType,_that.issuedAt,_that.isCanceled,_that.hypocenterName,_that.magnitude,_that.depth,_that.originTime,_that.maxIntensity,_that.location);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String eventId,  String headline,  List<UnifiedLiveActivityInformationType> informationType,  DateTime issuedAt,  bool isCanceled,  String? hypocenterName,  EarthquakeMagnitude? magnitude,  double? depth,  DateTime? originTime,  JmaIntensity? maxIntensity,  UnifiedEarthquakeLocation? location)?  $default,) {final _that = this;
switch (_that) {
case _UnifiedEarthquake() when $default != null:
return $default(_that.eventId,_that.headline,_that.informationType,_that.issuedAt,_that.isCanceled,_that.hypocenterName,_that.magnitude,_that.depth,_that.originTime,_that.maxIntensity,_that.location);case _:
  return null;

}
}

}

/// @nodoc


class _UnifiedEarthquake extends UnifiedEarthquake {
  const _UnifiedEarthquake({required this.eventId, required this.headline, required  List<UnifiedLiveActivityInformationType> informationType, required this.issuedAt, required this.isCanceled, required this.hypocenterName, required this.magnitude, required this.depth, required this.originTime, required this.maxIntensity, required this.location}): _informationType = informationType,super._();
  

@override final  String eventId;
@override final  String headline;
 final  List<UnifiedLiveActivityInformationType> _informationType;
@override List<UnifiedLiveActivityInformationType> get informationType {
  if (_informationType is EqualUnmodifiableListView) return _informationType;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_informationType);
}

@override final  DateTime issuedAt;
@override final  bool isCanceled;
@override final  String? hypocenterName;
@override final  EarthquakeMagnitude? magnitude;
@override final  double? depth;
@override final  DateTime? originTime;
@override final  JmaIntensity? maxIntensity;
@override final  UnifiedEarthquakeLocation? location;

/// Create a copy of UnifiedEarthquake
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UnifiedEarthquakeCopyWith<_UnifiedEarthquake> get copyWith => __$UnifiedEarthquakeCopyWithImpl<_UnifiedEarthquake>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UnifiedEarthquake&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.headline, headline) || other.headline == headline)&&const DeepCollectionEquality().equals(other._informationType, _informationType)&&(identical(other.issuedAt, issuedAt) || other.issuedAt == issuedAt)&&(identical(other.isCanceled, isCanceled) || other.isCanceled == isCanceled)&&(identical(other.hypocenterName, hypocenterName) || other.hypocenterName == hypocenterName)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&(identical(other.location, location) || other.location == location));
}


@override
int get hashCode => Object.hash(runtimeType,eventId,headline,const DeepCollectionEquality().hash(_informationType),issuedAt,isCanceled,hypocenterName,magnitude,depth,originTime,maxIntensity,location);

@override
String toString() {
  return 'UnifiedEarthquake(eventId: $eventId, headline: $headline, informationType: $informationType, issuedAt: $issuedAt, isCanceled: $isCanceled, hypocenterName: $hypocenterName, magnitude: $magnitude, depth: $depth, originTime: $originTime, maxIntensity: $maxIntensity, location: $location)';
}


}

/// @nodoc
abstract mixin class _$UnifiedEarthquakeCopyWith<$Res> implements $UnifiedEarthquakeCopyWith<$Res> {
  factory _$UnifiedEarthquakeCopyWith(_UnifiedEarthquake value, $Res Function(_UnifiedEarthquake) _then) = __$UnifiedEarthquakeCopyWithImpl;
@override @useResult
$Res call({
 String eventId, String headline, List<UnifiedLiveActivityInformationType> informationType, DateTime issuedAt, bool isCanceled, String? hypocenterName, EarthquakeMagnitude? magnitude, double? depth, DateTime? originTime, JmaIntensity? maxIntensity, UnifiedEarthquakeLocation? location
});


@override $EarthquakeMagnitudeCopyWith<$Res>? get magnitude;@override $UnifiedEarthquakeLocationCopyWith<$Res>? get location;

}
/// @nodoc
class __$UnifiedEarthquakeCopyWithImpl<$Res>
    implements _$UnifiedEarthquakeCopyWith<$Res> {
  __$UnifiedEarthquakeCopyWithImpl(this._self, this._then);

  final _UnifiedEarthquake _self;
  final $Res Function(_UnifiedEarthquake) _then;

/// Create a copy of UnifiedEarthquake
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? headline = null,Object? informationType = null,Object? issuedAt = null,Object? isCanceled = null,Object? hypocenterName = freezed,Object? magnitude = freezed,Object? depth = freezed,Object? originTime = freezed,Object? maxIntensity = freezed,Object? location = freezed,}) {
  return _then(_UnifiedEarthquake(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,headline: null == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String,informationType: null == informationType ? _self._informationType : informationType // ignore: cast_nullable_to_non_nullable
as List<UnifiedLiveActivityInformationType>,issuedAt: null == issuedAt ? _self.issuedAt : issuedAt // ignore: cast_nullable_to_non_nullable
as DateTime,isCanceled: null == isCanceled ? _self.isCanceled : isCanceled // ignore: cast_nullable_to_non_nullable
as bool,hypocenterName: freezed == hypocenterName ? _self.hypocenterName : hypocenterName // ignore: cast_nullable_to_non_nullable
as String?,magnitude: freezed == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as EarthquakeMagnitude?,depth: freezed == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as double?,originTime: freezed == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime?,maxIntensity: freezed == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as UnifiedEarthquakeLocation?,
  ));
}

/// Create a copy of UnifiedEarthquake
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeMagnitudeCopyWith<$Res>? get magnitude {
    if (_self.magnitude == null) {
    return null;
  }

  return $EarthquakeMagnitudeCopyWith<$Res>(_self.magnitude!, (value) {
    return _then(_self.copyWith(magnitude: value));
  });
}/// Create a copy of UnifiedEarthquake
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UnifiedEarthquakeLocationCopyWith<$Res>? get location {
    if (_self.location == null) {
    return null;
  }

  return $UnifiedEarthquakeLocationCopyWith<$Res>(_self.location!, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}

// dart format on
