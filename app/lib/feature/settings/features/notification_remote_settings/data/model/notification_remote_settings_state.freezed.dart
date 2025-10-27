// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_remote_settings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationRemoteSettingsState {

 NotificationRemoteSettingsEew get eew; NotificationRemoteSettingsEarthquake get earthquake;
/// Create a copy of NotificationRemoteSettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationRemoteSettingsStateCopyWith<NotificationRemoteSettingsState> get copyWith => _$NotificationRemoteSettingsStateCopyWithImpl<NotificationRemoteSettingsState>(this as NotificationRemoteSettingsState, _$identity);

  /// Serializes this NotificationRemoteSettingsState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationRemoteSettingsState&&(identical(other.eew, eew) || other.eew == eew)&&(identical(other.earthquake, earthquake) || other.earthquake == earthquake));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eew,earthquake);

@override
String toString() {
  return 'NotificationRemoteSettingsState(eew: $eew, earthquake: $earthquake)';
}


}

/// @nodoc
abstract mixin class $NotificationRemoteSettingsStateCopyWith<$Res>  {
  factory $NotificationRemoteSettingsStateCopyWith(NotificationRemoteSettingsState value, $Res Function(NotificationRemoteSettingsState) _then) = _$NotificationRemoteSettingsStateCopyWithImpl;
@useResult
$Res call({
 NotificationRemoteSettingsEew eew, NotificationRemoteSettingsEarthquake earthquake
});


$NotificationRemoteSettingsEewCopyWith<$Res> get eew;$NotificationRemoteSettingsEarthquakeCopyWith<$Res> get earthquake;

}
/// @nodoc
class _$NotificationRemoteSettingsStateCopyWithImpl<$Res>
    implements $NotificationRemoteSettingsStateCopyWith<$Res> {
  _$NotificationRemoteSettingsStateCopyWithImpl(this._self, this._then);

  final NotificationRemoteSettingsState _self;
  final $Res Function(NotificationRemoteSettingsState) _then;

/// Create a copy of NotificationRemoteSettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eew = null,Object? earthquake = null,}) {
  return _then(_self.copyWith(
eew: null == eew ? _self.eew : eew // ignore: cast_nullable_to_non_nullable
as NotificationRemoteSettingsEew,earthquake: null == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as NotificationRemoteSettingsEarthquake,
  ));
}
/// Create a copy of NotificationRemoteSettingsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationRemoteSettingsEewCopyWith<$Res> get eew {
  
  return $NotificationRemoteSettingsEewCopyWith<$Res>(_self.eew, (value) {
    return _then(_self.copyWith(eew: value));
  });
}/// Create a copy of NotificationRemoteSettingsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationRemoteSettingsEarthquakeCopyWith<$Res> get earthquake {
  
  return $NotificationRemoteSettingsEarthquakeCopyWith<$Res>(_self.earthquake, (value) {
    return _then(_self.copyWith(earthquake: value));
  });
}
}


/// Adds pattern-matching-related methods to [NotificationRemoteSettingsState].
extension NotificationRemoteSettingsStatePatterns on NotificationRemoteSettingsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationRemoteSettingsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationRemoteSettingsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationRemoteSettingsState value)  $default,){
final _that = this;
switch (_that) {
case _NotificationRemoteSettingsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationRemoteSettingsState value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationRemoteSettingsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( NotificationRemoteSettingsEew eew,  NotificationRemoteSettingsEarthquake earthquake)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationRemoteSettingsState() when $default != null:
return $default(_that.eew,_that.earthquake);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( NotificationRemoteSettingsEew eew,  NotificationRemoteSettingsEarthquake earthquake)  $default,) {final _that = this;
switch (_that) {
case _NotificationRemoteSettingsState():
return $default(_that.eew,_that.earthquake);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( NotificationRemoteSettingsEew eew,  NotificationRemoteSettingsEarthquake earthquake)?  $default,) {final _that = this;
switch (_that) {
case _NotificationRemoteSettingsState() when $default != null:
return $default(_that.eew,_that.earthquake);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationRemoteSettingsState implements NotificationRemoteSettingsState {
  const _NotificationRemoteSettingsState({required this.eew, required this.earthquake});
  factory _NotificationRemoteSettingsState.fromJson(Map<String, dynamic> json) => _$NotificationRemoteSettingsStateFromJson(json);

@override final  NotificationRemoteSettingsEew eew;
@override final  NotificationRemoteSettingsEarthquake earthquake;

/// Create a copy of NotificationRemoteSettingsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationRemoteSettingsStateCopyWith<_NotificationRemoteSettingsState> get copyWith => __$NotificationRemoteSettingsStateCopyWithImpl<_NotificationRemoteSettingsState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationRemoteSettingsStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationRemoteSettingsState&&(identical(other.eew, eew) || other.eew == eew)&&(identical(other.earthquake, earthquake) || other.earthquake == earthquake));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eew,earthquake);

@override
String toString() {
  return 'NotificationRemoteSettingsState(eew: $eew, earthquake: $earthquake)';
}


}

/// @nodoc
abstract mixin class _$NotificationRemoteSettingsStateCopyWith<$Res> implements $NotificationRemoteSettingsStateCopyWith<$Res> {
  factory _$NotificationRemoteSettingsStateCopyWith(_NotificationRemoteSettingsState value, $Res Function(_NotificationRemoteSettingsState) _then) = __$NotificationRemoteSettingsStateCopyWithImpl;
@override @useResult
$Res call({
 NotificationRemoteSettingsEew eew, NotificationRemoteSettingsEarthquake earthquake
});


@override $NotificationRemoteSettingsEewCopyWith<$Res> get eew;@override $NotificationRemoteSettingsEarthquakeCopyWith<$Res> get earthquake;

}
/// @nodoc
class __$NotificationRemoteSettingsStateCopyWithImpl<$Res>
    implements _$NotificationRemoteSettingsStateCopyWith<$Res> {
  __$NotificationRemoteSettingsStateCopyWithImpl(this._self, this._then);

  final _NotificationRemoteSettingsState _self;
  final $Res Function(_NotificationRemoteSettingsState) _then;

/// Create a copy of NotificationRemoteSettingsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eew = null,Object? earthquake = null,}) {
  return _then(_NotificationRemoteSettingsState(
eew: null == eew ? _self.eew : eew // ignore: cast_nullable_to_non_nullable
as NotificationRemoteSettingsEew,earthquake: null == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as NotificationRemoteSettingsEarthquake,
  ));
}

/// Create a copy of NotificationRemoteSettingsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationRemoteSettingsEewCopyWith<$Res> get eew {
  
  return $NotificationRemoteSettingsEewCopyWith<$Res>(_self.eew, (value) {
    return _then(_self.copyWith(eew: value));
  });
}/// Create a copy of NotificationRemoteSettingsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationRemoteSettingsEarthquakeCopyWith<$Res> get earthquake {
  
  return $NotificationRemoteSettingsEarthquakeCopyWith<$Res>(_self.earthquake, (value) {
    return _then(_self.copyWith(earthquake: value));
  });
}
}


/// @nodoc
mixin _$NotificationRemoteSettingsEew {

 JmaForecastIntensity? get global; List<NotificationRemoteSettingsEewRegion> get regions;
/// Create a copy of NotificationRemoteSettingsEew
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationRemoteSettingsEewCopyWith<NotificationRemoteSettingsEew> get copyWith => _$NotificationRemoteSettingsEewCopyWithImpl<NotificationRemoteSettingsEew>(this as NotificationRemoteSettingsEew, _$identity);

  /// Serializes this NotificationRemoteSettingsEew to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationRemoteSettingsEew&&(identical(other.global, global) || other.global == global)&&const DeepCollectionEquality().equals(other.regions, regions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,global,const DeepCollectionEquality().hash(regions));

@override
String toString() {
  return 'NotificationRemoteSettingsEew(global: $global, regions: $regions)';
}


}

/// @nodoc
abstract mixin class $NotificationRemoteSettingsEewCopyWith<$Res>  {
  factory $NotificationRemoteSettingsEewCopyWith(NotificationRemoteSettingsEew value, $Res Function(NotificationRemoteSettingsEew) _then) = _$NotificationRemoteSettingsEewCopyWithImpl;
@useResult
$Res call({
 JmaForecastIntensity? global, List<NotificationRemoteSettingsEewRegion> regions
});




}
/// @nodoc
class _$NotificationRemoteSettingsEewCopyWithImpl<$Res>
    implements $NotificationRemoteSettingsEewCopyWith<$Res> {
  _$NotificationRemoteSettingsEewCopyWithImpl(this._self, this._then);

  final NotificationRemoteSettingsEew _self;
  final $Res Function(NotificationRemoteSettingsEew) _then;

/// Create a copy of NotificationRemoteSettingsEew
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? global = freezed,Object? regions = null,}) {
  return _then(_self.copyWith(
global: freezed == global ? _self.global : global // ignore: cast_nullable_to_non_nullable
as JmaForecastIntensity?,regions: null == regions ? _self.regions : regions // ignore: cast_nullable_to_non_nullable
as List<NotificationRemoteSettingsEewRegion>,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationRemoteSettingsEew].
extension NotificationRemoteSettingsEewPatterns on NotificationRemoteSettingsEew {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationRemoteSettingsEew value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationRemoteSettingsEew() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationRemoteSettingsEew value)  $default,){
final _that = this;
switch (_that) {
case _NotificationRemoteSettingsEew():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationRemoteSettingsEew value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationRemoteSettingsEew() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( JmaForecastIntensity? global,  List<NotificationRemoteSettingsEewRegion> regions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationRemoteSettingsEew() when $default != null:
return $default(_that.global,_that.regions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( JmaForecastIntensity? global,  List<NotificationRemoteSettingsEewRegion> regions)  $default,) {final _that = this;
switch (_that) {
case _NotificationRemoteSettingsEew():
return $default(_that.global,_that.regions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( JmaForecastIntensity? global,  List<NotificationRemoteSettingsEewRegion> regions)?  $default,) {final _that = this;
switch (_that) {
case _NotificationRemoteSettingsEew() when $default != null:
return $default(_that.global,_that.regions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationRemoteSettingsEew implements NotificationRemoteSettingsEew {
  const _NotificationRemoteSettingsEew({required this.global, required final  List<NotificationRemoteSettingsEewRegion> regions}): _regions = regions;
  factory _NotificationRemoteSettingsEew.fromJson(Map<String, dynamic> json) => _$NotificationRemoteSettingsEewFromJson(json);

@override final  JmaForecastIntensity? global;
 final  List<NotificationRemoteSettingsEewRegion> _regions;
@override List<NotificationRemoteSettingsEewRegion> get regions {
  if (_regions is EqualUnmodifiableListView) return _regions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_regions);
}


/// Create a copy of NotificationRemoteSettingsEew
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationRemoteSettingsEewCopyWith<_NotificationRemoteSettingsEew> get copyWith => __$NotificationRemoteSettingsEewCopyWithImpl<_NotificationRemoteSettingsEew>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationRemoteSettingsEewToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationRemoteSettingsEew&&(identical(other.global, global) || other.global == global)&&const DeepCollectionEquality().equals(other._regions, _regions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,global,const DeepCollectionEquality().hash(_regions));

@override
String toString() {
  return 'NotificationRemoteSettingsEew(global: $global, regions: $regions)';
}


}

/// @nodoc
abstract mixin class _$NotificationRemoteSettingsEewCopyWith<$Res> implements $NotificationRemoteSettingsEewCopyWith<$Res> {
  factory _$NotificationRemoteSettingsEewCopyWith(_NotificationRemoteSettingsEew value, $Res Function(_NotificationRemoteSettingsEew) _then) = __$NotificationRemoteSettingsEewCopyWithImpl;
@override @useResult
$Res call({
 JmaForecastIntensity? global, List<NotificationRemoteSettingsEewRegion> regions
});




}
/// @nodoc
class __$NotificationRemoteSettingsEewCopyWithImpl<$Res>
    implements _$NotificationRemoteSettingsEewCopyWith<$Res> {
  __$NotificationRemoteSettingsEewCopyWithImpl(this._self, this._then);

  final _NotificationRemoteSettingsEew _self;
  final $Res Function(_NotificationRemoteSettingsEew) _then;

/// Create a copy of NotificationRemoteSettingsEew
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? global = freezed,Object? regions = null,}) {
  return _then(_NotificationRemoteSettingsEew(
global: freezed == global ? _self.global : global // ignore: cast_nullable_to_non_nullable
as JmaForecastIntensity?,regions: null == regions ? _self._regions : regions // ignore: cast_nullable_to_non_nullable
as List<NotificationRemoteSettingsEewRegion>,
  ));
}


}


/// @nodoc
mixin _$NotificationRemoteSettingsEewRegion {

 int get regionId; JmaForecastIntensity get minJmaIntensity; String get name;
/// Create a copy of NotificationRemoteSettingsEewRegion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationRemoteSettingsEewRegionCopyWith<NotificationRemoteSettingsEewRegion> get copyWith => _$NotificationRemoteSettingsEewRegionCopyWithImpl<NotificationRemoteSettingsEewRegion>(this as NotificationRemoteSettingsEewRegion, _$identity);

  /// Serializes this NotificationRemoteSettingsEewRegion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationRemoteSettingsEewRegion&&(identical(other.regionId, regionId) || other.regionId == regionId)&&(identical(other.minJmaIntensity, minJmaIntensity) || other.minJmaIntensity == minJmaIntensity)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,regionId,minJmaIntensity,name);

@override
String toString() {
  return 'NotificationRemoteSettingsEewRegion(regionId: $regionId, minJmaIntensity: $minJmaIntensity, name: $name)';
}


}

/// @nodoc
abstract mixin class $NotificationRemoteSettingsEewRegionCopyWith<$Res>  {
  factory $NotificationRemoteSettingsEewRegionCopyWith(NotificationRemoteSettingsEewRegion value, $Res Function(NotificationRemoteSettingsEewRegion) _then) = _$NotificationRemoteSettingsEewRegionCopyWithImpl;
@useResult
$Res call({
 int regionId, JmaForecastIntensity minJmaIntensity, String name
});




}
/// @nodoc
class _$NotificationRemoteSettingsEewRegionCopyWithImpl<$Res>
    implements $NotificationRemoteSettingsEewRegionCopyWith<$Res> {
  _$NotificationRemoteSettingsEewRegionCopyWithImpl(this._self, this._then);

  final NotificationRemoteSettingsEewRegion _self;
  final $Res Function(NotificationRemoteSettingsEewRegion) _then;

/// Create a copy of NotificationRemoteSettingsEewRegion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? regionId = null,Object? minJmaIntensity = null,Object? name = null,}) {
  return _then(_self.copyWith(
regionId: null == regionId ? _self.regionId : regionId // ignore: cast_nullable_to_non_nullable
as int,minJmaIntensity: null == minJmaIntensity ? _self.minJmaIntensity : minJmaIntensity // ignore: cast_nullable_to_non_nullable
as JmaForecastIntensity,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationRemoteSettingsEewRegion].
extension NotificationRemoteSettingsEewRegionPatterns on NotificationRemoteSettingsEewRegion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationRemoteSettingsEewRegion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationRemoteSettingsEewRegion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationRemoteSettingsEewRegion value)  $default,){
final _that = this;
switch (_that) {
case _NotificationRemoteSettingsEewRegion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationRemoteSettingsEewRegion value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationRemoteSettingsEewRegion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int regionId,  JmaForecastIntensity minJmaIntensity,  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationRemoteSettingsEewRegion() when $default != null:
return $default(_that.regionId,_that.minJmaIntensity,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int regionId,  JmaForecastIntensity minJmaIntensity,  String name)  $default,) {final _that = this;
switch (_that) {
case _NotificationRemoteSettingsEewRegion():
return $default(_that.regionId,_that.minJmaIntensity,_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int regionId,  JmaForecastIntensity minJmaIntensity,  String name)?  $default,) {final _that = this;
switch (_that) {
case _NotificationRemoteSettingsEewRegion() when $default != null:
return $default(_that.regionId,_that.minJmaIntensity,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationRemoteSettingsEewRegion implements NotificationRemoteSettingsEewRegion {
  const _NotificationRemoteSettingsEewRegion({required this.regionId, required this.minJmaIntensity, required this.name});
  factory _NotificationRemoteSettingsEewRegion.fromJson(Map<String, dynamic> json) => _$NotificationRemoteSettingsEewRegionFromJson(json);

@override final  int regionId;
@override final  JmaForecastIntensity minJmaIntensity;
@override final  String name;

/// Create a copy of NotificationRemoteSettingsEewRegion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationRemoteSettingsEewRegionCopyWith<_NotificationRemoteSettingsEewRegion> get copyWith => __$NotificationRemoteSettingsEewRegionCopyWithImpl<_NotificationRemoteSettingsEewRegion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationRemoteSettingsEewRegionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationRemoteSettingsEewRegion&&(identical(other.regionId, regionId) || other.regionId == regionId)&&(identical(other.minJmaIntensity, minJmaIntensity) || other.minJmaIntensity == minJmaIntensity)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,regionId,minJmaIntensity,name);

@override
String toString() {
  return 'NotificationRemoteSettingsEewRegion(regionId: $regionId, minJmaIntensity: $minJmaIntensity, name: $name)';
}


}

/// @nodoc
abstract mixin class _$NotificationRemoteSettingsEewRegionCopyWith<$Res> implements $NotificationRemoteSettingsEewRegionCopyWith<$Res> {
  factory _$NotificationRemoteSettingsEewRegionCopyWith(_NotificationRemoteSettingsEewRegion value, $Res Function(_NotificationRemoteSettingsEewRegion) _then) = __$NotificationRemoteSettingsEewRegionCopyWithImpl;
@override @useResult
$Res call({
 int regionId, JmaForecastIntensity minJmaIntensity, String name
});




}
/// @nodoc
class __$NotificationRemoteSettingsEewRegionCopyWithImpl<$Res>
    implements _$NotificationRemoteSettingsEewRegionCopyWith<$Res> {
  __$NotificationRemoteSettingsEewRegionCopyWithImpl(this._self, this._then);

  final _NotificationRemoteSettingsEewRegion _self;
  final $Res Function(_NotificationRemoteSettingsEewRegion) _then;

/// Create a copy of NotificationRemoteSettingsEewRegion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? regionId = null,Object? minJmaIntensity = null,Object? name = null,}) {
  return _then(_NotificationRemoteSettingsEewRegion(
regionId: null == regionId ? _self.regionId : regionId // ignore: cast_nullable_to_non_nullable
as int,minJmaIntensity: null == minJmaIntensity ? _self.minJmaIntensity : minJmaIntensity // ignore: cast_nullable_to_non_nullable
as JmaForecastIntensity,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$NotificationRemoteSettingsEarthquake {

 JmaForecastIntensity? get global; List<NotificationRemoteSettingsEarthquakeRegion> get regions;
/// Create a copy of NotificationRemoteSettingsEarthquake
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationRemoteSettingsEarthquakeCopyWith<NotificationRemoteSettingsEarthquake> get copyWith => _$NotificationRemoteSettingsEarthquakeCopyWithImpl<NotificationRemoteSettingsEarthquake>(this as NotificationRemoteSettingsEarthquake, _$identity);

  /// Serializes this NotificationRemoteSettingsEarthquake to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationRemoteSettingsEarthquake&&(identical(other.global, global) || other.global == global)&&const DeepCollectionEquality().equals(other.regions, regions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,global,const DeepCollectionEquality().hash(regions));

@override
String toString() {
  return 'NotificationRemoteSettingsEarthquake(global: $global, regions: $regions)';
}


}

/// @nodoc
abstract mixin class $NotificationRemoteSettingsEarthquakeCopyWith<$Res>  {
  factory $NotificationRemoteSettingsEarthquakeCopyWith(NotificationRemoteSettingsEarthquake value, $Res Function(NotificationRemoteSettingsEarthquake) _then) = _$NotificationRemoteSettingsEarthquakeCopyWithImpl;
@useResult
$Res call({
 JmaForecastIntensity? global, List<NotificationRemoteSettingsEarthquakeRegion> regions
});




}
/// @nodoc
class _$NotificationRemoteSettingsEarthquakeCopyWithImpl<$Res>
    implements $NotificationRemoteSettingsEarthquakeCopyWith<$Res> {
  _$NotificationRemoteSettingsEarthquakeCopyWithImpl(this._self, this._then);

  final NotificationRemoteSettingsEarthquake _self;
  final $Res Function(NotificationRemoteSettingsEarthquake) _then;

/// Create a copy of NotificationRemoteSettingsEarthquake
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? global = freezed,Object? regions = null,}) {
  return _then(_self.copyWith(
global: freezed == global ? _self.global : global // ignore: cast_nullable_to_non_nullable
as JmaForecastIntensity?,regions: null == regions ? _self.regions : regions // ignore: cast_nullable_to_non_nullable
as List<NotificationRemoteSettingsEarthquakeRegion>,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationRemoteSettingsEarthquake].
extension NotificationRemoteSettingsEarthquakePatterns on NotificationRemoteSettingsEarthquake {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationRemoteSettingsEarthquake value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationRemoteSettingsEarthquake() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationRemoteSettingsEarthquake value)  $default,){
final _that = this;
switch (_that) {
case _NotificationRemoteSettingsEarthquake():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationRemoteSettingsEarthquake value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationRemoteSettingsEarthquake() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( JmaForecastIntensity? global,  List<NotificationRemoteSettingsEarthquakeRegion> regions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationRemoteSettingsEarthquake() when $default != null:
return $default(_that.global,_that.regions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( JmaForecastIntensity? global,  List<NotificationRemoteSettingsEarthquakeRegion> regions)  $default,) {final _that = this;
switch (_that) {
case _NotificationRemoteSettingsEarthquake():
return $default(_that.global,_that.regions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( JmaForecastIntensity? global,  List<NotificationRemoteSettingsEarthquakeRegion> regions)?  $default,) {final _that = this;
switch (_that) {
case _NotificationRemoteSettingsEarthquake() when $default != null:
return $default(_that.global,_that.regions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationRemoteSettingsEarthquake implements NotificationRemoteSettingsEarthquake {
  const _NotificationRemoteSettingsEarthquake({required this.global, required final  List<NotificationRemoteSettingsEarthquakeRegion> regions}): _regions = regions;
  factory _NotificationRemoteSettingsEarthquake.fromJson(Map<String, dynamic> json) => _$NotificationRemoteSettingsEarthquakeFromJson(json);

@override final  JmaForecastIntensity? global;
 final  List<NotificationRemoteSettingsEarthquakeRegion> _regions;
@override List<NotificationRemoteSettingsEarthquakeRegion> get regions {
  if (_regions is EqualUnmodifiableListView) return _regions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_regions);
}


/// Create a copy of NotificationRemoteSettingsEarthquake
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationRemoteSettingsEarthquakeCopyWith<_NotificationRemoteSettingsEarthquake> get copyWith => __$NotificationRemoteSettingsEarthquakeCopyWithImpl<_NotificationRemoteSettingsEarthquake>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationRemoteSettingsEarthquakeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationRemoteSettingsEarthquake&&(identical(other.global, global) || other.global == global)&&const DeepCollectionEquality().equals(other._regions, _regions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,global,const DeepCollectionEquality().hash(_regions));

@override
String toString() {
  return 'NotificationRemoteSettingsEarthquake(global: $global, regions: $regions)';
}


}

/// @nodoc
abstract mixin class _$NotificationRemoteSettingsEarthquakeCopyWith<$Res> implements $NotificationRemoteSettingsEarthquakeCopyWith<$Res> {
  factory _$NotificationRemoteSettingsEarthquakeCopyWith(_NotificationRemoteSettingsEarthquake value, $Res Function(_NotificationRemoteSettingsEarthquake) _then) = __$NotificationRemoteSettingsEarthquakeCopyWithImpl;
@override @useResult
$Res call({
 JmaForecastIntensity? global, List<NotificationRemoteSettingsEarthquakeRegion> regions
});




}
/// @nodoc
class __$NotificationRemoteSettingsEarthquakeCopyWithImpl<$Res>
    implements _$NotificationRemoteSettingsEarthquakeCopyWith<$Res> {
  __$NotificationRemoteSettingsEarthquakeCopyWithImpl(this._self, this._then);

  final _NotificationRemoteSettingsEarthquake _self;
  final $Res Function(_NotificationRemoteSettingsEarthquake) _then;

/// Create a copy of NotificationRemoteSettingsEarthquake
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? global = freezed,Object? regions = null,}) {
  return _then(_NotificationRemoteSettingsEarthquake(
global: freezed == global ? _self.global : global // ignore: cast_nullable_to_non_nullable
as JmaForecastIntensity?,regions: null == regions ? _self._regions : regions // ignore: cast_nullable_to_non_nullable
as List<NotificationRemoteSettingsEarthquakeRegion>,
  ));
}


}


/// @nodoc
mixin _$NotificationRemoteSettingsEarthquakeRegion {

 int get regionId; JmaForecastIntensity get minJmaIntensity; String get name;
/// Create a copy of NotificationRemoteSettingsEarthquakeRegion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationRemoteSettingsEarthquakeRegionCopyWith<NotificationRemoteSettingsEarthquakeRegion> get copyWith => _$NotificationRemoteSettingsEarthquakeRegionCopyWithImpl<NotificationRemoteSettingsEarthquakeRegion>(this as NotificationRemoteSettingsEarthquakeRegion, _$identity);

  /// Serializes this NotificationRemoteSettingsEarthquakeRegion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationRemoteSettingsEarthquakeRegion&&(identical(other.regionId, regionId) || other.regionId == regionId)&&(identical(other.minJmaIntensity, minJmaIntensity) || other.minJmaIntensity == minJmaIntensity)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,regionId,minJmaIntensity,name);

@override
String toString() {
  return 'NotificationRemoteSettingsEarthquakeRegion(regionId: $regionId, minJmaIntensity: $minJmaIntensity, name: $name)';
}


}

/// @nodoc
abstract mixin class $NotificationRemoteSettingsEarthquakeRegionCopyWith<$Res>  {
  factory $NotificationRemoteSettingsEarthquakeRegionCopyWith(NotificationRemoteSettingsEarthquakeRegion value, $Res Function(NotificationRemoteSettingsEarthquakeRegion) _then) = _$NotificationRemoteSettingsEarthquakeRegionCopyWithImpl;
@useResult
$Res call({
 int regionId, JmaForecastIntensity minJmaIntensity, String name
});




}
/// @nodoc
class _$NotificationRemoteSettingsEarthquakeRegionCopyWithImpl<$Res>
    implements $NotificationRemoteSettingsEarthquakeRegionCopyWith<$Res> {
  _$NotificationRemoteSettingsEarthquakeRegionCopyWithImpl(this._self, this._then);

  final NotificationRemoteSettingsEarthquakeRegion _self;
  final $Res Function(NotificationRemoteSettingsEarthquakeRegion) _then;

/// Create a copy of NotificationRemoteSettingsEarthquakeRegion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? regionId = null,Object? minJmaIntensity = null,Object? name = null,}) {
  return _then(_self.copyWith(
regionId: null == regionId ? _self.regionId : regionId // ignore: cast_nullable_to_non_nullable
as int,minJmaIntensity: null == minJmaIntensity ? _self.minJmaIntensity : minJmaIntensity // ignore: cast_nullable_to_non_nullable
as JmaForecastIntensity,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationRemoteSettingsEarthquakeRegion].
extension NotificationRemoteSettingsEarthquakeRegionPatterns on NotificationRemoteSettingsEarthquakeRegion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationRemoteSettingsEarthquakeRegion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationRemoteSettingsEarthquakeRegion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationRemoteSettingsEarthquakeRegion value)  $default,){
final _that = this;
switch (_that) {
case _NotificationRemoteSettingsEarthquakeRegion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationRemoteSettingsEarthquakeRegion value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationRemoteSettingsEarthquakeRegion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int regionId,  JmaForecastIntensity minJmaIntensity,  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationRemoteSettingsEarthquakeRegion() when $default != null:
return $default(_that.regionId,_that.minJmaIntensity,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int regionId,  JmaForecastIntensity minJmaIntensity,  String name)  $default,) {final _that = this;
switch (_that) {
case _NotificationRemoteSettingsEarthquakeRegion():
return $default(_that.regionId,_that.minJmaIntensity,_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int regionId,  JmaForecastIntensity minJmaIntensity,  String name)?  $default,) {final _that = this;
switch (_that) {
case _NotificationRemoteSettingsEarthquakeRegion() when $default != null:
return $default(_that.regionId,_that.minJmaIntensity,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationRemoteSettingsEarthquakeRegion implements NotificationRemoteSettingsEarthquakeRegion {
  const _NotificationRemoteSettingsEarthquakeRegion({required this.regionId, required this.minJmaIntensity, required this.name});
  factory _NotificationRemoteSettingsEarthquakeRegion.fromJson(Map<String, dynamic> json) => _$NotificationRemoteSettingsEarthquakeRegionFromJson(json);

@override final  int regionId;
@override final  JmaForecastIntensity minJmaIntensity;
@override final  String name;

/// Create a copy of NotificationRemoteSettingsEarthquakeRegion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationRemoteSettingsEarthquakeRegionCopyWith<_NotificationRemoteSettingsEarthquakeRegion> get copyWith => __$NotificationRemoteSettingsEarthquakeRegionCopyWithImpl<_NotificationRemoteSettingsEarthquakeRegion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationRemoteSettingsEarthquakeRegionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationRemoteSettingsEarthquakeRegion&&(identical(other.regionId, regionId) || other.regionId == regionId)&&(identical(other.minJmaIntensity, minJmaIntensity) || other.minJmaIntensity == minJmaIntensity)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,regionId,minJmaIntensity,name);

@override
String toString() {
  return 'NotificationRemoteSettingsEarthquakeRegion(regionId: $regionId, minJmaIntensity: $minJmaIntensity, name: $name)';
}


}

/// @nodoc
abstract mixin class _$NotificationRemoteSettingsEarthquakeRegionCopyWith<$Res> implements $NotificationRemoteSettingsEarthquakeRegionCopyWith<$Res> {
  factory _$NotificationRemoteSettingsEarthquakeRegionCopyWith(_NotificationRemoteSettingsEarthquakeRegion value, $Res Function(_NotificationRemoteSettingsEarthquakeRegion) _then) = __$NotificationRemoteSettingsEarthquakeRegionCopyWithImpl;
@override @useResult
$Res call({
 int regionId, JmaForecastIntensity minJmaIntensity, String name
});




}
/// @nodoc
class __$NotificationRemoteSettingsEarthquakeRegionCopyWithImpl<$Res>
    implements _$NotificationRemoteSettingsEarthquakeRegionCopyWith<$Res> {
  __$NotificationRemoteSettingsEarthquakeRegionCopyWithImpl(this._self, this._then);

  final _NotificationRemoteSettingsEarthquakeRegion _self;
  final $Res Function(_NotificationRemoteSettingsEarthquakeRegion) _then;

/// Create a copy of NotificationRemoteSettingsEarthquakeRegion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? regionId = null,Object? minJmaIntensity = null,Object? name = null,}) {
  return _then(_NotificationRemoteSettingsEarthquakeRegion(
regionId: null == regionId ? _self.regionId : regionId // ignore: cast_nullable_to_non_nullable
as int,minJmaIntensity: null == minJmaIntensity ? _self.minJmaIntensity : minJmaIntensity // ignore: cast_nullable_to_non_nullable
as JmaForecastIntensity,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
