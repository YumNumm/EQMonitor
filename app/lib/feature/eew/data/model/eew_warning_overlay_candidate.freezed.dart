// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eew_warning_overlay_candidate.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EewWarningOverlayCandidate {

 EewTelegramItem get event; String get warningAreaCode; String get warningAreaName; String? get forecastAreaName; EewForecastRegionInfo? get localForecastRegion;
/// Create a copy of EewWarningOverlayCandidate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewWarningOverlayCandidateCopyWith<EewWarningOverlayCandidate> get copyWith => _$EewWarningOverlayCandidateCopyWithImpl<EewWarningOverlayCandidate>(this as EewWarningOverlayCandidate, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewWarningOverlayCandidate&&(identical(other.event, event) || other.event == event)&&(identical(other.warningAreaCode, warningAreaCode) || other.warningAreaCode == warningAreaCode)&&(identical(other.warningAreaName, warningAreaName) || other.warningAreaName == warningAreaName)&&(identical(other.forecastAreaName, forecastAreaName) || other.forecastAreaName == forecastAreaName)&&(identical(other.localForecastRegion, localForecastRegion) || other.localForecastRegion == localForecastRegion));
}


@override
int get hashCode => Object.hash(runtimeType,event,warningAreaCode,warningAreaName,forecastAreaName,localForecastRegion);

@override
String toString() {
  return 'EewWarningOverlayCandidate(event: $event, warningAreaCode: $warningAreaCode, warningAreaName: $warningAreaName, forecastAreaName: $forecastAreaName, localForecastRegion: $localForecastRegion)';
}


}

/// @nodoc
abstract mixin class $EewWarningOverlayCandidateCopyWith<$Res>  {
  factory $EewWarningOverlayCandidateCopyWith(EewWarningOverlayCandidate value, $Res Function(EewWarningOverlayCandidate) _then) = _$EewWarningOverlayCandidateCopyWithImpl;
@useResult
$Res call({
 EewTelegramItem event, String warningAreaCode, String warningAreaName, String? forecastAreaName, EewForecastRegionInfo? localForecastRegion
});


$EewTelegramItemCopyWith<$Res> get event;$EewForecastRegionInfoCopyWith<$Res>? get localForecastRegion;

}
/// @nodoc
class _$EewWarningOverlayCandidateCopyWithImpl<$Res>
    implements $EewWarningOverlayCandidateCopyWith<$Res> {
  _$EewWarningOverlayCandidateCopyWithImpl(this._self, this._then);

  final EewWarningOverlayCandidate _self;
  final $Res Function(EewWarningOverlayCandidate) _then;

/// Create a copy of EewWarningOverlayCandidate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? event = null,Object? warningAreaCode = null,Object? warningAreaName = null,Object? forecastAreaName = freezed,Object? localForecastRegion = freezed,}) {
  return _then(_self.copyWith(
event: null == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as EewTelegramItem,warningAreaCode: null == warningAreaCode ? _self.warningAreaCode : warningAreaCode // ignore: cast_nullable_to_non_nullable
as String,warningAreaName: null == warningAreaName ? _self.warningAreaName : warningAreaName // ignore: cast_nullable_to_non_nullable
as String,forecastAreaName: freezed == forecastAreaName ? _self.forecastAreaName : forecastAreaName // ignore: cast_nullable_to_non_nullable
as String?,localForecastRegion: freezed == localForecastRegion ? _self.localForecastRegion : localForecastRegion // ignore: cast_nullable_to_non_nullable
as EewForecastRegionInfo?,
  ));
}
/// Create a copy of EewWarningOverlayCandidate
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EewTelegramItemCopyWith<$Res> get event {
  
  return $EewTelegramItemCopyWith<$Res>(_self.event, (value) {
    return _then(_self.copyWith(event: value));
  });
}/// Create a copy of EewWarningOverlayCandidate
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EewForecastRegionInfoCopyWith<$Res>? get localForecastRegion {
    if (_self.localForecastRegion == null) {
    return null;
  }

  return $EewForecastRegionInfoCopyWith<$Res>(_self.localForecastRegion!, (value) {
    return _then(_self.copyWith(localForecastRegion: value));
  });
}
}


/// Adds pattern-matching-related methods to [EewWarningOverlayCandidate].
extension EewWarningOverlayCandidatePatterns on EewWarningOverlayCandidate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EewWarningOverlayCandidate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EewWarningOverlayCandidate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EewWarningOverlayCandidate value)  $default,){
final _that = this;
switch (_that) {
case _EewWarningOverlayCandidate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EewWarningOverlayCandidate value)?  $default,){
final _that = this;
switch (_that) {
case _EewWarningOverlayCandidate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( EewTelegramItem event,  String warningAreaCode,  String warningAreaName,  String? forecastAreaName,  EewForecastRegionInfo? localForecastRegion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EewWarningOverlayCandidate() when $default != null:
return $default(_that.event,_that.warningAreaCode,_that.warningAreaName,_that.forecastAreaName,_that.localForecastRegion);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( EewTelegramItem event,  String warningAreaCode,  String warningAreaName,  String? forecastAreaName,  EewForecastRegionInfo? localForecastRegion)  $default,) {final _that = this;
switch (_that) {
case _EewWarningOverlayCandidate():
return $default(_that.event,_that.warningAreaCode,_that.warningAreaName,_that.forecastAreaName,_that.localForecastRegion);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( EewTelegramItem event,  String warningAreaCode,  String warningAreaName,  String? forecastAreaName,  EewForecastRegionInfo? localForecastRegion)?  $default,) {final _that = this;
switch (_that) {
case _EewWarningOverlayCandidate() when $default != null:
return $default(_that.event,_that.warningAreaCode,_that.warningAreaName,_that.forecastAreaName,_that.localForecastRegion);case _:
  return null;

}
}

}

/// @nodoc


class _EewWarningOverlayCandidate implements EewWarningOverlayCandidate {
  const _EewWarningOverlayCandidate({required this.event, required this.warningAreaCode, required this.warningAreaName, required this.forecastAreaName, required this.localForecastRegion});
  

@override final  EewTelegramItem event;
@override final  String warningAreaCode;
@override final  String warningAreaName;
@override final  String? forecastAreaName;
@override final  EewForecastRegionInfo? localForecastRegion;

/// Create a copy of EewWarningOverlayCandidate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EewWarningOverlayCandidateCopyWith<_EewWarningOverlayCandidate> get copyWith => __$EewWarningOverlayCandidateCopyWithImpl<_EewWarningOverlayCandidate>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EewWarningOverlayCandidate&&(identical(other.event, event) || other.event == event)&&(identical(other.warningAreaCode, warningAreaCode) || other.warningAreaCode == warningAreaCode)&&(identical(other.warningAreaName, warningAreaName) || other.warningAreaName == warningAreaName)&&(identical(other.forecastAreaName, forecastAreaName) || other.forecastAreaName == forecastAreaName)&&(identical(other.localForecastRegion, localForecastRegion) || other.localForecastRegion == localForecastRegion));
}


@override
int get hashCode => Object.hash(runtimeType,event,warningAreaCode,warningAreaName,forecastAreaName,localForecastRegion);

@override
String toString() {
  return 'EewWarningOverlayCandidate(event: $event, warningAreaCode: $warningAreaCode, warningAreaName: $warningAreaName, forecastAreaName: $forecastAreaName, localForecastRegion: $localForecastRegion)';
}


}

/// @nodoc
abstract mixin class _$EewWarningOverlayCandidateCopyWith<$Res> implements $EewWarningOverlayCandidateCopyWith<$Res> {
  factory _$EewWarningOverlayCandidateCopyWith(_EewWarningOverlayCandidate value, $Res Function(_EewWarningOverlayCandidate) _then) = __$EewWarningOverlayCandidateCopyWithImpl;
@override @useResult
$Res call({
 EewTelegramItem event, String warningAreaCode, String warningAreaName, String? forecastAreaName, EewForecastRegionInfo? localForecastRegion
});


@override $EewTelegramItemCopyWith<$Res> get event;@override $EewForecastRegionInfoCopyWith<$Res>? get localForecastRegion;

}
/// @nodoc
class __$EewWarningOverlayCandidateCopyWithImpl<$Res>
    implements _$EewWarningOverlayCandidateCopyWith<$Res> {
  __$EewWarningOverlayCandidateCopyWithImpl(this._self, this._then);

  final _EewWarningOverlayCandidate _self;
  final $Res Function(_EewWarningOverlayCandidate) _then;

/// Create a copy of EewWarningOverlayCandidate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? event = null,Object? warningAreaCode = null,Object? warningAreaName = null,Object? forecastAreaName = freezed,Object? localForecastRegion = freezed,}) {
  return _then(_EewWarningOverlayCandidate(
event: null == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as EewTelegramItem,warningAreaCode: null == warningAreaCode ? _self.warningAreaCode : warningAreaCode // ignore: cast_nullable_to_non_nullable
as String,warningAreaName: null == warningAreaName ? _self.warningAreaName : warningAreaName // ignore: cast_nullable_to_non_nullable
as String,forecastAreaName: freezed == forecastAreaName ? _self.forecastAreaName : forecastAreaName // ignore: cast_nullable_to_non_nullable
as String?,localForecastRegion: freezed == localForecastRegion ? _self.localForecastRegion : localForecastRegion // ignore: cast_nullable_to_non_nullable
as EewForecastRegionInfo?,
  ));
}

/// Create a copy of EewWarningOverlayCandidate
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EewTelegramItemCopyWith<$Res> get event {
  
  return $EewTelegramItemCopyWith<$Res>(_self.event, (value) {
    return _then(_self.copyWith(event: value));
  });
}/// Create a copy of EewWarningOverlayCandidate
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EewForecastRegionInfoCopyWith<$Res>? get localForecastRegion {
    if (_self.localForecastRegion == null) {
    return null;
  }

  return $EewForecastRegionInfoCopyWith<$Res>(_self.localForecastRegion!, (value) {
    return _then(_self.copyWith(localForecastRegion: value));
  });
}
}

// dart format on
