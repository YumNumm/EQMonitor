// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_offshore_station.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TsunamiOffshoreStation {

 String get code; String get name;@JsonKey(name: 'first_height') TsunamiStationObservationFirstHeight get firstHeight;@JsonKey(includeIfNull: false) String? get sensor;@JsonKey(includeIfNull: false, name: 'max_height') TsunamiStationObservationMaxHeight? get maxHeight;
/// Create a copy of TsunamiOffshoreStation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiOffshoreStationCopyWith<TsunamiOffshoreStation> get copyWith => _$TsunamiOffshoreStationCopyWithImpl<TsunamiOffshoreStation>(this as TsunamiOffshoreStation, _$identity);

  /// Serializes this TsunamiOffshoreStation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiOffshoreStation&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.firstHeight, firstHeight) || other.firstHeight == firstHeight)&&(identical(other.sensor, sensor) || other.sensor == sensor)&&(identical(other.maxHeight, maxHeight) || other.maxHeight == maxHeight));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,firstHeight,sensor,maxHeight);

@override
String toString() {
  return 'TsunamiOffshoreStation(code: $code, name: $name, firstHeight: $firstHeight, sensor: $sensor, maxHeight: $maxHeight)';
}


}

/// @nodoc
abstract mixin class $TsunamiOffshoreStationCopyWith<$Res>  {
  factory $TsunamiOffshoreStationCopyWith(TsunamiOffshoreStation value, $Res Function(TsunamiOffshoreStation) _then) = _$TsunamiOffshoreStationCopyWithImpl;
@useResult
$Res call({
 String code, String name,@JsonKey(name: 'first_height') TsunamiStationObservationFirstHeight firstHeight,@JsonKey(includeIfNull: false) String? sensor,@JsonKey(includeIfNull: false, name: 'max_height') TsunamiStationObservationMaxHeight? maxHeight
});


$TsunamiStationObservationFirstHeightCopyWith<$Res> get firstHeight;$TsunamiStationObservationMaxHeightCopyWith<$Res>? get maxHeight;

}
/// @nodoc
class _$TsunamiOffshoreStationCopyWithImpl<$Res>
    implements $TsunamiOffshoreStationCopyWith<$Res> {
  _$TsunamiOffshoreStationCopyWithImpl(this._self, this._then);

  final TsunamiOffshoreStation _self;
  final $Res Function(TsunamiOffshoreStation) _then;

/// Create a copy of TsunamiOffshoreStation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? firstHeight = null,Object? sensor = freezed,Object? maxHeight = freezed,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,firstHeight: null == firstHeight ? _self.firstHeight : firstHeight // ignore: cast_nullable_to_non_nullable
as TsunamiStationObservationFirstHeight,sensor: freezed == sensor ? _self.sensor : sensor // ignore: cast_nullable_to_non_nullable
as String?,maxHeight: freezed == maxHeight ? _self.maxHeight : maxHeight // ignore: cast_nullable_to_non_nullable
as TsunamiStationObservationMaxHeight?,
  ));
}
/// Create a copy of TsunamiOffshoreStation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiStationObservationFirstHeightCopyWith<$Res> get firstHeight {
  
  return $TsunamiStationObservationFirstHeightCopyWith<$Res>(_self.firstHeight, (value) {
    return _then(_self.copyWith(firstHeight: value));
  });
}/// Create a copy of TsunamiOffshoreStation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiStationObservationMaxHeightCopyWith<$Res>? get maxHeight {
    if (_self.maxHeight == null) {
    return null;
  }

  return $TsunamiStationObservationMaxHeightCopyWith<$Res>(_self.maxHeight!, (value) {
    return _then(_self.copyWith(maxHeight: value));
  });
}
}


/// Adds pattern-matching-related methods to [TsunamiOffshoreStation].
extension TsunamiOffshoreStationPatterns on TsunamiOffshoreStation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiOffshoreStation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiOffshoreStation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiOffshoreStation value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiOffshoreStation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiOffshoreStation value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiOffshoreStation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String name, @JsonKey(name: 'first_height')  TsunamiStationObservationFirstHeight firstHeight, @JsonKey(includeIfNull: false)  String? sensor, @JsonKey(includeIfNull: false, name: 'max_height')  TsunamiStationObservationMaxHeight? maxHeight)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiOffshoreStation() when $default != null:
return $default(_that.code,_that.name,_that.firstHeight,_that.sensor,_that.maxHeight);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String name, @JsonKey(name: 'first_height')  TsunamiStationObservationFirstHeight firstHeight, @JsonKey(includeIfNull: false)  String? sensor, @JsonKey(includeIfNull: false, name: 'max_height')  TsunamiStationObservationMaxHeight? maxHeight)  $default,) {final _that = this;
switch (_that) {
case _TsunamiOffshoreStation():
return $default(_that.code,_that.name,_that.firstHeight,_that.sensor,_that.maxHeight);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String name, @JsonKey(name: 'first_height')  TsunamiStationObservationFirstHeight firstHeight, @JsonKey(includeIfNull: false)  String? sensor, @JsonKey(includeIfNull: false, name: 'max_height')  TsunamiStationObservationMaxHeight? maxHeight)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiOffshoreStation() when $default != null:
return $default(_that.code,_that.name,_that.firstHeight,_that.sensor,_that.maxHeight);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TsunamiOffshoreStation implements TsunamiOffshoreStation {
  const _TsunamiOffshoreStation({required this.code, required this.name, @JsonKey(name: 'first_height') required this.firstHeight, @JsonKey(includeIfNull: false) this.sensor, @JsonKey(includeIfNull: false, name: 'max_height') this.maxHeight});
  factory _TsunamiOffshoreStation.fromJson(Map<String, dynamic> json) => _$TsunamiOffshoreStationFromJson(json);

@override final  String code;
@override final  String name;
@override@JsonKey(name: 'first_height') final  TsunamiStationObservationFirstHeight firstHeight;
@override@JsonKey(includeIfNull: false) final  String? sensor;
@override@JsonKey(includeIfNull: false, name: 'max_height') final  TsunamiStationObservationMaxHeight? maxHeight;

/// Create a copy of TsunamiOffshoreStation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiOffshoreStationCopyWith<_TsunamiOffshoreStation> get copyWith => __$TsunamiOffshoreStationCopyWithImpl<_TsunamiOffshoreStation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiOffshoreStationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiOffshoreStation&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.firstHeight, firstHeight) || other.firstHeight == firstHeight)&&(identical(other.sensor, sensor) || other.sensor == sensor)&&(identical(other.maxHeight, maxHeight) || other.maxHeight == maxHeight));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,firstHeight,sensor,maxHeight);

@override
String toString() {
  return 'TsunamiOffshoreStation(code: $code, name: $name, firstHeight: $firstHeight, sensor: $sensor, maxHeight: $maxHeight)';
}


}

/// @nodoc
abstract mixin class _$TsunamiOffshoreStationCopyWith<$Res> implements $TsunamiOffshoreStationCopyWith<$Res> {
  factory _$TsunamiOffshoreStationCopyWith(_TsunamiOffshoreStation value, $Res Function(_TsunamiOffshoreStation) _then) = __$TsunamiOffshoreStationCopyWithImpl;
@override @useResult
$Res call({
 String code, String name,@JsonKey(name: 'first_height') TsunamiStationObservationFirstHeight firstHeight,@JsonKey(includeIfNull: false) String? sensor,@JsonKey(includeIfNull: false, name: 'max_height') TsunamiStationObservationMaxHeight? maxHeight
});


@override $TsunamiStationObservationFirstHeightCopyWith<$Res> get firstHeight;@override $TsunamiStationObservationMaxHeightCopyWith<$Res>? get maxHeight;

}
/// @nodoc
class __$TsunamiOffshoreStationCopyWithImpl<$Res>
    implements _$TsunamiOffshoreStationCopyWith<$Res> {
  __$TsunamiOffshoreStationCopyWithImpl(this._self, this._then);

  final _TsunamiOffshoreStation _self;
  final $Res Function(_TsunamiOffshoreStation) _then;

/// Create a copy of TsunamiOffshoreStation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? firstHeight = null,Object? sensor = freezed,Object? maxHeight = freezed,}) {
  return _then(_TsunamiOffshoreStation(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,firstHeight: null == firstHeight ? _self.firstHeight : firstHeight // ignore: cast_nullable_to_non_nullable
as TsunamiStationObservationFirstHeight,sensor: freezed == sensor ? _self.sensor : sensor // ignore: cast_nullable_to_non_nullable
as String?,maxHeight: freezed == maxHeight ? _self.maxHeight : maxHeight // ignore: cast_nullable_to_non_nullable
as TsunamiStationObservationMaxHeight?,
  ));
}

/// Create a copy of TsunamiOffshoreStation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiStationObservationFirstHeightCopyWith<$Res> get firstHeight {
  
  return $TsunamiStationObservationFirstHeightCopyWith<$Res>(_self.firstHeight, (value) {
    return _then(_self.copyWith(firstHeight: value));
  });
}/// Create a copy of TsunamiOffshoreStation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiStationObservationMaxHeightCopyWith<$Res>? get maxHeight {
    if (_self.maxHeight == null) {
    return null;
  }

  return $TsunamiStationObservationMaxHeightCopyWith<$Res>(_self.maxHeight!, (value) {
    return _then(_self.copyWith(maxHeight: value));
  });
}
}

// dart format on
