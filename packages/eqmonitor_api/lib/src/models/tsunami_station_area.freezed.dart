// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_station_area.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TsunamiStationArea {

@JsonKey(includeIfNull: true) LocalizedName? get name; List<TsunamiStation> get stations;
/// Create a copy of TsunamiStationArea
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiStationAreaCopyWith<TsunamiStationArea> get copyWith => _$TsunamiStationAreaCopyWithImpl<TsunamiStationArea>(this as TsunamiStationArea, _$identity);

  /// Serializes this TsunamiStationArea to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiStationArea&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.stations, stations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,const DeepCollectionEquality().hash(stations));

@override
String toString() {
  return 'TsunamiStationArea(name: $name, stations: $stations)';
}


}

/// @nodoc
abstract mixin class $TsunamiStationAreaCopyWith<$Res>  {
  factory $TsunamiStationAreaCopyWith(TsunamiStationArea value, $Res Function(TsunamiStationArea) _then) = _$TsunamiStationAreaCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeIfNull: true) LocalizedName? name, List<TsunamiStation> stations
});


$LocalizedNameCopyWith<$Res>? get name;

}
/// @nodoc
class _$TsunamiStationAreaCopyWithImpl<$Res>
    implements $TsunamiStationAreaCopyWith<$Res> {
  _$TsunamiStationAreaCopyWithImpl(this._self, this._then);

  final TsunamiStationArea _self;
  final $Res Function(TsunamiStationArea) _then;

/// Create a copy of TsunamiStationArea
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = freezed,Object? stations = null,}) {
  return _then(_self.copyWith(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedName?,stations: null == stations ? _self.stations : stations // ignore: cast_nullable_to_non_nullable
as List<TsunamiStation>,
  ));
}
/// Create a copy of TsunamiStationArea
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedNameCopyWith<$Res>? get name {
    if (_self.name == null) {
    return null;
  }

  return $LocalizedNameCopyWith<$Res>(_self.name!, (value) {
    return _then(_self.copyWith(name: value));
  });
}
}


/// Adds pattern-matching-related methods to [TsunamiStationArea].
extension TsunamiStationAreaPatterns on TsunamiStationArea {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiStationArea value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiStationArea() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiStationArea value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiStationArea():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiStationArea value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiStationArea() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: true)  LocalizedName? name,  List<TsunamiStation> stations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiStationArea() when $default != null:
return $default(_that.name,_that.stations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: true)  LocalizedName? name,  List<TsunamiStation> stations)  $default,) {final _that = this;
switch (_that) {
case _TsunamiStationArea():
return $default(_that.name,_that.stations);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeIfNull: true)  LocalizedName? name,  List<TsunamiStation> stations)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiStationArea() when $default != null:
return $default(_that.name,_that.stations);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TsunamiStationArea implements TsunamiStationArea {
  const _TsunamiStationArea({@JsonKey(includeIfNull: true) required this.name, required final  List<TsunamiStation> stations}): _stations = stations;
  factory _TsunamiStationArea.fromJson(Map<String, dynamic> json) => _$TsunamiStationAreaFromJson(json);

@override@JsonKey(includeIfNull: true) final  LocalizedName? name;
 final  List<TsunamiStation> _stations;
@override List<TsunamiStation> get stations {
  if (_stations is EqualUnmodifiableListView) return _stations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stations);
}


/// Create a copy of TsunamiStationArea
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiStationAreaCopyWith<_TsunamiStationArea> get copyWith => __$TsunamiStationAreaCopyWithImpl<_TsunamiStationArea>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiStationAreaToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiStationArea&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._stations, _stations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,const DeepCollectionEquality().hash(_stations));

@override
String toString() {
  return 'TsunamiStationArea(name: $name, stations: $stations)';
}


}

/// @nodoc
abstract mixin class _$TsunamiStationAreaCopyWith<$Res> implements $TsunamiStationAreaCopyWith<$Res> {
  factory _$TsunamiStationAreaCopyWith(_TsunamiStationArea value, $Res Function(_TsunamiStationArea) _then) = __$TsunamiStationAreaCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeIfNull: true) LocalizedName? name, List<TsunamiStation> stations
});


@override $LocalizedNameCopyWith<$Res>? get name;

}
/// @nodoc
class __$TsunamiStationAreaCopyWithImpl<$Res>
    implements _$TsunamiStationAreaCopyWith<$Res> {
  __$TsunamiStationAreaCopyWithImpl(this._self, this._then);

  final _TsunamiStationArea _self;
  final $Res Function(_TsunamiStationArea) _then;

/// Create a copy of TsunamiStationArea
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = freezed,Object? stations = null,}) {
  return _then(_TsunamiStationArea(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedName?,stations: null == stations ? _self._stations : stations // ignore: cast_nullable_to_non_nullable
as List<TsunamiStation>,
  ));
}

/// Create a copy of TsunamiStationArea
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedNameCopyWith<$Res>? get name {
    if (_self.name == null) {
    return null;
  }

  return $LocalizedNameCopyWith<$Res>(_self.name!, (value) {
    return _then(_self.copyWith(name: value));
  });
}
}

// dart format on
