// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Earthquake {

/// yyyyMMddHHmmss形式のイベントID
 String get eventId; TelegramStatus get status; DateTime? get originTime; DateTime? get arrivalTime; Hypocenter? get hypocenter; Intensity? get intensity; List<EarthquakeTelegramRef> get telegrams;
/// Create a copy of Earthquake
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeCopyWith<Earthquake> get copyWith => _$EarthquakeCopyWithImpl<Earthquake>(this as Earthquake, _$identity);

  /// Serializes this Earthquake to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Earthquake&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.status, status) || other.status == status)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.hypocenter, hypocenter) || other.hypocenter == hypocenter)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&const DeepCollectionEquality().equals(other.telegrams, telegrams));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,status,originTime,arrivalTime,hypocenter,intensity,const DeepCollectionEquality().hash(telegrams));

@override
String toString() {
  return 'Earthquake(eventId: $eventId, status: $status, originTime: $originTime, arrivalTime: $arrivalTime, hypocenter: $hypocenter, intensity: $intensity, telegrams: $telegrams)';
}


}

/// @nodoc
abstract mixin class $EarthquakeCopyWith<$Res>  {
  factory $EarthquakeCopyWith(Earthquake value, $Res Function(Earthquake) _then) = _$EarthquakeCopyWithImpl;
@useResult
$Res call({
 String eventId, TelegramStatus status, DateTime? originTime, DateTime? arrivalTime, Hypocenter? hypocenter, Intensity? intensity, List<EarthquakeTelegramRef> telegrams
});


$HypocenterCopyWith<$Res>? get hypocenter;$IntensityCopyWith<$Res>? get intensity;

}
/// @nodoc
class _$EarthquakeCopyWithImpl<$Res>
    implements $EarthquakeCopyWith<$Res> {
  _$EarthquakeCopyWithImpl(this._self, this._then);

  final Earthquake _self;
  final $Res Function(Earthquake) _then;

/// Create a copy of Earthquake
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? status = null,Object? originTime = freezed,Object? arrivalTime = freezed,Object? hypocenter = freezed,Object? intensity = freezed,Object? telegrams = null,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TelegramStatus,originTime: freezed == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime?,arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,hypocenter: freezed == hypocenter ? _self.hypocenter : hypocenter // ignore: cast_nullable_to_non_nullable
as Hypocenter?,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as Intensity?,telegrams: null == telegrams ? _self.telegrams : telegrams // ignore: cast_nullable_to_non_nullable
as List<EarthquakeTelegramRef>,
  ));
}
/// Create a copy of Earthquake
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HypocenterCopyWith<$Res>? get hypocenter {
    if (_self.hypocenter == null) {
    return null;
  }

  return $HypocenterCopyWith<$Res>(_self.hypocenter!, (value) {
    return _then(_self.copyWith(hypocenter: value));
  });
}/// Create a copy of Earthquake
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IntensityCopyWith<$Res>? get intensity {
    if (_self.intensity == null) {
    return null;
  }

  return $IntensityCopyWith<$Res>(_self.intensity!, (value) {
    return _then(_self.copyWith(intensity: value));
  });
}
}


/// Adds pattern-matching-related methods to [Earthquake].
extension EarthquakePatterns on Earthquake {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Earthquake value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Earthquake() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Earthquake value)  $default,){
final _that = this;
switch (_that) {
case _Earthquake():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Earthquake value)?  $default,){
final _that = this;
switch (_that) {
case _Earthquake() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String eventId,  TelegramStatus status,  DateTime? originTime,  DateTime? arrivalTime,  Hypocenter? hypocenter,  Intensity? intensity,  List<EarthquakeTelegramRef> telegrams)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Earthquake() when $default != null:
return $default(_that.eventId,_that.status,_that.originTime,_that.arrivalTime,_that.hypocenter,_that.intensity,_that.telegrams);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String eventId,  TelegramStatus status,  DateTime? originTime,  DateTime? arrivalTime,  Hypocenter? hypocenter,  Intensity? intensity,  List<EarthquakeTelegramRef> telegrams)  $default,) {final _that = this;
switch (_that) {
case _Earthquake():
return $default(_that.eventId,_that.status,_that.originTime,_that.arrivalTime,_that.hypocenter,_that.intensity,_that.telegrams);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String eventId,  TelegramStatus status,  DateTime? originTime,  DateTime? arrivalTime,  Hypocenter? hypocenter,  Intensity? intensity,  List<EarthquakeTelegramRef> telegrams)?  $default,) {final _that = this;
switch (_that) {
case _Earthquake() when $default != null:
return $default(_that.eventId,_that.status,_that.originTime,_that.arrivalTime,_that.hypocenter,_that.intensity,_that.telegrams);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Earthquake implements Earthquake {
  const _Earthquake({required this.eventId, required this.status, this.originTime, this.arrivalTime, this.hypocenter, this.intensity, required final  List<EarthquakeTelegramRef> telegrams}): _telegrams = telegrams;
  factory _Earthquake.fromJson(Map<String, dynamic> json) => _$EarthquakeFromJson(json);

/// yyyyMMddHHmmss形式のイベントID
@override final  String eventId;
@override final  TelegramStatus status;
@override final  DateTime? originTime;
@override final  DateTime? arrivalTime;
@override final  Hypocenter? hypocenter;
@override final  Intensity? intensity;
 final  List<EarthquakeTelegramRef> _telegrams;
@override List<EarthquakeTelegramRef> get telegrams {
  if (_telegrams is EqualUnmodifiableListView) return _telegrams;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_telegrams);
}


/// Create a copy of Earthquake
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeCopyWith<_Earthquake> get copyWith => __$EarthquakeCopyWithImpl<_Earthquake>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Earthquake&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.status, status) || other.status == status)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.hypocenter, hypocenter) || other.hypocenter == hypocenter)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&const DeepCollectionEquality().equals(other._telegrams, _telegrams));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,status,originTime,arrivalTime,hypocenter,intensity,const DeepCollectionEquality().hash(_telegrams));

@override
String toString() {
  return 'Earthquake(eventId: $eventId, status: $status, originTime: $originTime, arrivalTime: $arrivalTime, hypocenter: $hypocenter, intensity: $intensity, telegrams: $telegrams)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeCopyWith<$Res> implements $EarthquakeCopyWith<$Res> {
  factory _$EarthquakeCopyWith(_Earthquake value, $Res Function(_Earthquake) _then) = __$EarthquakeCopyWithImpl;
@override @useResult
$Res call({
 String eventId, TelegramStatus status, DateTime? originTime, DateTime? arrivalTime, Hypocenter? hypocenter, Intensity? intensity, List<EarthquakeTelegramRef> telegrams
});


@override $HypocenterCopyWith<$Res>? get hypocenter;@override $IntensityCopyWith<$Res>? get intensity;

}
/// @nodoc
class __$EarthquakeCopyWithImpl<$Res>
    implements _$EarthquakeCopyWith<$Res> {
  __$EarthquakeCopyWithImpl(this._self, this._then);

  final _Earthquake _self;
  final $Res Function(_Earthquake) _then;

/// Create a copy of Earthquake
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? status = null,Object? originTime = freezed,Object? arrivalTime = freezed,Object? hypocenter = freezed,Object? intensity = freezed,Object? telegrams = null,}) {
  return _then(_Earthquake(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TelegramStatus,originTime: freezed == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime?,arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,hypocenter: freezed == hypocenter ? _self.hypocenter : hypocenter // ignore: cast_nullable_to_non_nullable
as Hypocenter?,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as Intensity?,telegrams: null == telegrams ? _self._telegrams : telegrams // ignore: cast_nullable_to_non_nullable
as List<EarthquakeTelegramRef>,
  ));
}

/// Create a copy of Earthquake
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HypocenterCopyWith<$Res>? get hypocenter {
    if (_self.hypocenter == null) {
    return null;
  }

  return $HypocenterCopyWith<$Res>(_self.hypocenter!, (value) {
    return _then(_self.copyWith(hypocenter: value));
  });
}/// Create a copy of Earthquake
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IntensityCopyWith<$Res>? get intensity {
    if (_self.intensity == null) {
    return null;
  }

  return $IntensityCopyWith<$Res>(_self.intensity!, (value) {
    return _then(_self.copyWith(intensity: value));
  });
}
}


/// @nodoc
mixin _$EarthquakePartial {

/// yyyyMMddHHmmss形式のイベントID
 String get eventId; TelegramStatus get status; DateTime? get originTime; DateTime? get arrivalTime; Hypocenter? get hypocenter; IntensityPartial? get intensity;
/// Create a copy of EarthquakePartial
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakePartialCopyWith<EarthquakePartial> get copyWith => _$EarthquakePartialCopyWithImpl<EarthquakePartial>(this as EarthquakePartial, _$identity);

  /// Serializes this EarthquakePartial to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakePartial&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.status, status) || other.status == status)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.hypocenter, hypocenter) || other.hypocenter == hypocenter)&&(identical(other.intensity, intensity) || other.intensity == intensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,status,originTime,arrivalTime,hypocenter,intensity);

@override
String toString() {
  return 'EarthquakePartial(eventId: $eventId, status: $status, originTime: $originTime, arrivalTime: $arrivalTime, hypocenter: $hypocenter, intensity: $intensity)';
}


}

/// @nodoc
abstract mixin class $EarthquakePartialCopyWith<$Res>  {
  factory $EarthquakePartialCopyWith(EarthquakePartial value, $Res Function(EarthquakePartial) _then) = _$EarthquakePartialCopyWithImpl;
@useResult
$Res call({
 String eventId, TelegramStatus status, DateTime? originTime, DateTime? arrivalTime, Hypocenter? hypocenter, IntensityPartial? intensity
});


$HypocenterCopyWith<$Res>? get hypocenter;$IntensityPartialCopyWith<$Res>? get intensity;

}
/// @nodoc
class _$EarthquakePartialCopyWithImpl<$Res>
    implements $EarthquakePartialCopyWith<$Res> {
  _$EarthquakePartialCopyWithImpl(this._self, this._then);

  final EarthquakePartial _self;
  final $Res Function(EarthquakePartial) _then;

/// Create a copy of EarthquakePartial
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? status = null,Object? originTime = freezed,Object? arrivalTime = freezed,Object? hypocenter = freezed,Object? intensity = freezed,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TelegramStatus,originTime: freezed == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime?,arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,hypocenter: freezed == hypocenter ? _self.hypocenter : hypocenter // ignore: cast_nullable_to_non_nullable
as Hypocenter?,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as IntensityPartial?,
  ));
}
/// Create a copy of EarthquakePartial
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HypocenterCopyWith<$Res>? get hypocenter {
    if (_self.hypocenter == null) {
    return null;
  }

  return $HypocenterCopyWith<$Res>(_self.hypocenter!, (value) {
    return _then(_self.copyWith(hypocenter: value));
  });
}/// Create a copy of EarthquakePartial
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IntensityPartialCopyWith<$Res>? get intensity {
    if (_self.intensity == null) {
    return null;
  }

  return $IntensityPartialCopyWith<$Res>(_self.intensity!, (value) {
    return _then(_self.copyWith(intensity: value));
  });
}
}


/// Adds pattern-matching-related methods to [EarthquakePartial].
extension EarthquakePartialPatterns on EarthquakePartial {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakePartial value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakePartial() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakePartial value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakePartial():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakePartial value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakePartial() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String eventId,  TelegramStatus status,  DateTime? originTime,  DateTime? arrivalTime,  Hypocenter? hypocenter,  IntensityPartial? intensity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakePartial() when $default != null:
return $default(_that.eventId,_that.status,_that.originTime,_that.arrivalTime,_that.hypocenter,_that.intensity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String eventId,  TelegramStatus status,  DateTime? originTime,  DateTime? arrivalTime,  Hypocenter? hypocenter,  IntensityPartial? intensity)  $default,) {final _that = this;
switch (_that) {
case _EarthquakePartial():
return $default(_that.eventId,_that.status,_that.originTime,_that.arrivalTime,_that.hypocenter,_that.intensity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String eventId,  TelegramStatus status,  DateTime? originTime,  DateTime? arrivalTime,  Hypocenter? hypocenter,  IntensityPartial? intensity)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakePartial() when $default != null:
return $default(_that.eventId,_that.status,_that.originTime,_that.arrivalTime,_that.hypocenter,_that.intensity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarthquakePartial implements EarthquakePartial {
  const _EarthquakePartial({required this.eventId, required this.status, this.originTime, this.arrivalTime, this.hypocenter, this.intensity});
  factory _EarthquakePartial.fromJson(Map<String, dynamic> json) => _$EarthquakePartialFromJson(json);

/// yyyyMMddHHmmss形式のイベントID
@override final  String eventId;
@override final  TelegramStatus status;
@override final  DateTime? originTime;
@override final  DateTime? arrivalTime;
@override final  Hypocenter? hypocenter;
@override final  IntensityPartial? intensity;

/// Create a copy of EarthquakePartial
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakePartialCopyWith<_EarthquakePartial> get copyWith => __$EarthquakePartialCopyWithImpl<_EarthquakePartial>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakePartialToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakePartial&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.status, status) || other.status == status)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.hypocenter, hypocenter) || other.hypocenter == hypocenter)&&(identical(other.intensity, intensity) || other.intensity == intensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,status,originTime,arrivalTime,hypocenter,intensity);

@override
String toString() {
  return 'EarthquakePartial(eventId: $eventId, status: $status, originTime: $originTime, arrivalTime: $arrivalTime, hypocenter: $hypocenter, intensity: $intensity)';
}


}

/// @nodoc
abstract mixin class _$EarthquakePartialCopyWith<$Res> implements $EarthquakePartialCopyWith<$Res> {
  factory _$EarthquakePartialCopyWith(_EarthquakePartial value, $Res Function(_EarthquakePartial) _then) = __$EarthquakePartialCopyWithImpl;
@override @useResult
$Res call({
 String eventId, TelegramStatus status, DateTime? originTime, DateTime? arrivalTime, Hypocenter? hypocenter, IntensityPartial? intensity
});


@override $HypocenterCopyWith<$Res>? get hypocenter;@override $IntensityPartialCopyWith<$Res>? get intensity;

}
/// @nodoc
class __$EarthquakePartialCopyWithImpl<$Res>
    implements _$EarthquakePartialCopyWith<$Res> {
  __$EarthquakePartialCopyWithImpl(this._self, this._then);

  final _EarthquakePartial _self;
  final $Res Function(_EarthquakePartial) _then;

/// Create a copy of EarthquakePartial
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? status = null,Object? originTime = freezed,Object? arrivalTime = freezed,Object? hypocenter = freezed,Object? intensity = freezed,}) {
  return _then(_EarthquakePartial(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TelegramStatus,originTime: freezed == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime?,arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,hypocenter: freezed == hypocenter ? _self.hypocenter : hypocenter // ignore: cast_nullable_to_non_nullable
as Hypocenter?,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as IntensityPartial?,
  ));
}

/// Create a copy of EarthquakePartial
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HypocenterCopyWith<$Res>? get hypocenter {
    if (_self.hypocenter == null) {
    return null;
  }

  return $HypocenterCopyWith<$Res>(_self.hypocenter!, (value) {
    return _then(_self.copyWith(hypocenter: value));
  });
}/// Create a copy of EarthquakePartial
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IntensityPartialCopyWith<$Res>? get intensity {
    if (_self.intensity == null) {
    return null;
  }

  return $IntensityPartialCopyWith<$Res>(_self.intensity!, (value) {
    return _then(_self.copyWith(intensity: value));
  });
}
}

// dart format on
