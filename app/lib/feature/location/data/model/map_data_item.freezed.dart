// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map_data_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MapDataLatLng {

 double get lat; double get lng;
/// Create a copy of MapDataLatLng
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MapDataLatLngCopyWith<MapDataLatLng> get copyWith => _$MapDataLatLngCopyWithImpl<MapDataLatLng>(this as MapDataLatLng, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MapDataLatLng&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng));
}


@override
int get hashCode => Object.hash(runtimeType,lat,lng);

@override
String toString() {
  return 'MapDataLatLng(lat: $lat, lng: $lng)';
}


}

/// @nodoc
abstract mixin class $MapDataLatLngCopyWith<$Res>  {
  factory $MapDataLatLngCopyWith(MapDataLatLng value, $Res Function(MapDataLatLng) _then) = _$MapDataLatLngCopyWithImpl;
@useResult
$Res call({
 double lat, double lng
});




}
/// @nodoc
class _$MapDataLatLngCopyWithImpl<$Res>
    implements $MapDataLatLngCopyWith<$Res> {
  _$MapDataLatLngCopyWithImpl(this._self, this._then);

  final MapDataLatLng _self;
  final $Res Function(MapDataLatLng) _then;

/// Create a copy of MapDataLatLng
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lat = null,Object? lng = null,}) {
  return _then(MapDataLatLng(
lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lng: null == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [MapDataLatLng].
extension MapDataLatLngPatterns on MapDataLatLng {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MapDataLatLng value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MapDataLatLng() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MapDataLatLng value)  $default,){
final _that = this;
switch (_that) {
case _MapDataLatLng():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MapDataLatLng value)?  $default,){
final _that = this;
switch (_that) {
case _MapDataLatLng() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double lat,  double lng)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MapDataLatLng() when $default != null:
return $default(_that.lat,_that.lng);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double lat,  double lng)  $default,) {final _that = this;
switch (_that) {
case _MapDataLatLng():
return $default(_that.lat,_that.lng);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double lat,  double lng)?  $default,) {final _that = this;
switch (_that) {
case _MapDataLatLng() when $default != null:
return $default(_that.lat,_that.lng);case _:
  return null;

}
}

}

/// @nodoc


class _MapDataLatLng implements MapDataLatLng {
  const _MapDataLatLng({required this.lat, required this.lng});
  

@override final  double lat;
@override final  double lng;

/// Create a copy of MapDataLatLng
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MapDataLatLngCopyWith<_MapDataLatLng> get copyWith => __$MapDataLatLngCopyWithImpl<_MapDataLatLng>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MapDataLatLng&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng));
}


@override
int get hashCode => Object.hash(runtimeType,lat,lng);

@override
String toString() {
  return 'MapDataLatLng(lat: $lat, lng: $lng)';
}


}

/// @nodoc
abstract mixin class _$MapDataLatLngCopyWith<$Res> implements $MapDataLatLngCopyWith<$Res> {
  factory _$MapDataLatLngCopyWith(_MapDataLatLng value, $Res Function(_MapDataLatLng) _then) = __$MapDataLatLngCopyWithImpl;
@override @useResult
$Res call({
 double lat, double lng
});




}
/// @nodoc
class __$MapDataLatLngCopyWithImpl<$Res>
    implements _$MapDataLatLngCopyWith<$Res> {
  __$MapDataLatLngCopyWithImpl(this._self, this._then);

  final _MapDataLatLng _self;
  final $Res Function(_MapDataLatLng) _then;

/// Create a copy of MapDataLatLng
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lat = null,Object? lng = null,}) {
  return _then(_MapDataLatLng(
lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lng: null == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$MapDataBounds {

 MapDataLatLng get southWest; MapDataLatLng get northEast;
/// Create a copy of MapDataBounds
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MapDataBoundsCopyWith<MapDataBounds> get copyWith => _$MapDataBoundsCopyWithImpl<MapDataBounds>(this as MapDataBounds, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MapDataBounds&&(identical(other.southWest, southWest) || other.southWest == southWest)&&(identical(other.northEast, northEast) || other.northEast == northEast));
}


@override
int get hashCode => Object.hash(runtimeType,southWest,northEast);

@override
String toString() {
  return 'MapDataBounds(southWest: $southWest, northEast: $northEast)';
}


}

/// @nodoc
abstract mixin class $MapDataBoundsCopyWith<$Res>  {
  factory $MapDataBoundsCopyWith(MapDataBounds value, $Res Function(MapDataBounds) _then) = _$MapDataBoundsCopyWithImpl;
@useResult
$Res call({
 MapDataLatLng southWest, MapDataLatLng northEast
});


$MapDataLatLngCopyWith<$Res> get southWest;$MapDataLatLngCopyWith<$Res> get northEast;

}
/// @nodoc
class _$MapDataBoundsCopyWithImpl<$Res>
    implements $MapDataBoundsCopyWith<$Res> {
  _$MapDataBoundsCopyWithImpl(this._self, this._then);

  final MapDataBounds _self;
  final $Res Function(MapDataBounds) _then;

/// Create a copy of MapDataBounds
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? southWest = null,Object? northEast = null,}) {
  return _then(MapDataBounds(
southWest: null == southWest ? _self.southWest : southWest // ignore: cast_nullable_to_non_nullable
as MapDataLatLng,northEast: null == northEast ? _self.northEast : northEast // ignore: cast_nullable_to_non_nullable
as MapDataLatLng,
  ));
}
/// Create a copy of MapDataBounds
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MapDataLatLngCopyWith<$Res> get southWest {
  
  return $MapDataLatLngCopyWith<$Res>(_self.southWest, (value) {
    return _then(_self.copyWith(southWest: value));
  });
}/// Create a copy of MapDataBounds
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MapDataLatLngCopyWith<$Res> get northEast {
  
  return $MapDataLatLngCopyWith<$Res>(_self.northEast, (value) {
    return _then(_self.copyWith(northEast: value));
  });
}
}


/// Adds pattern-matching-related methods to [MapDataBounds].
extension MapDataBoundsPatterns on MapDataBounds {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MapDataBounds value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MapDataBounds() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MapDataBounds value)  $default,){
final _that = this;
switch (_that) {
case _MapDataBounds():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MapDataBounds value)?  $default,){
final _that = this;
switch (_that) {
case _MapDataBounds() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MapDataLatLng southWest,  MapDataLatLng northEast)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MapDataBounds() when $default != null:
return $default(_that.southWest,_that.northEast);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MapDataLatLng southWest,  MapDataLatLng northEast)  $default,) {final _that = this;
switch (_that) {
case _MapDataBounds():
return $default(_that.southWest,_that.northEast);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MapDataLatLng southWest,  MapDataLatLng northEast)?  $default,) {final _that = this;
switch (_that) {
case _MapDataBounds() when $default != null:
return $default(_that.southWest,_that.northEast);case _:
  return null;

}
}

}

/// @nodoc


class _MapDataBounds implements MapDataBounds {
  const _MapDataBounds({required this.southWest, required this.northEast});
  

@override final  MapDataLatLng southWest;
@override final  MapDataLatLng northEast;

/// Create a copy of MapDataBounds
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MapDataBoundsCopyWith<_MapDataBounds> get copyWith => __$MapDataBoundsCopyWithImpl<_MapDataBounds>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MapDataBounds&&(identical(other.southWest, southWest) || other.southWest == southWest)&&(identical(other.northEast, northEast) || other.northEast == northEast));
}


@override
int get hashCode => Object.hash(runtimeType,southWest,northEast);

@override
String toString() {
  return 'MapDataBounds(southWest: $southWest, northEast: $northEast)';
}


}

/// @nodoc
abstract mixin class _$MapDataBoundsCopyWith<$Res> implements $MapDataBoundsCopyWith<$Res> {
  factory _$MapDataBoundsCopyWith(_MapDataBounds value, $Res Function(_MapDataBounds) _then) = __$MapDataBoundsCopyWithImpl;
@override @useResult
$Res call({
 MapDataLatLng southWest, MapDataLatLng northEast
});


@override $MapDataLatLngCopyWith<$Res> get southWest;@override $MapDataLatLngCopyWith<$Res> get northEast;

}
/// @nodoc
class __$MapDataBoundsCopyWithImpl<$Res>
    implements _$MapDataBoundsCopyWith<$Res> {
  __$MapDataBoundsCopyWithImpl(this._self, this._then);

  final _MapDataBounds _self;
  final $Res Function(_MapDataBounds) _then;

/// Create a copy of MapDataBounds
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? southWest = null,Object? northEast = null,}) {
  return _then(_MapDataBounds(
southWest: null == southWest ? _self.southWest : southWest // ignore: cast_nullable_to_non_nullable
as MapDataLatLng,northEast: null == northEast ? _self.northEast : northEast // ignore: cast_nullable_to_non_nullable
as MapDataLatLng,
  ));
}

/// Create a copy of MapDataBounds
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MapDataLatLngCopyWith<$Res> get southWest {
  
  return $MapDataLatLngCopyWith<$Res>(_self.southWest, (value) {
    return _then(_self.copyWith(southWest: value));
  });
}/// Create a copy of MapDataBounds
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MapDataLatLngCopyWith<$Res> get northEast {
  
  return $MapDataLatLngCopyWith<$Res>(_self.northEast, (value) {
    return _then(_self.copyWith(northEast: value));
  });
}
}

/// @nodoc
mixin _$MapDataProperty {

 String get code; String get name; String get nameKana;
/// Create a copy of MapDataProperty
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MapDataPropertyCopyWith<MapDataProperty> get copyWith => _$MapDataPropertyCopyWithImpl<MapDataProperty>(this as MapDataProperty, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MapDataProperty&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.nameKana, nameKana) || other.nameKana == nameKana));
}


@override
int get hashCode => Object.hash(runtimeType,code,name,nameKana);

@override
String toString() {
  return 'MapDataProperty(code: $code, name: $name, nameKana: $nameKana)';
}


}

/// @nodoc
abstract mixin class $MapDataPropertyCopyWith<$Res>  {
  factory $MapDataPropertyCopyWith(MapDataProperty value, $Res Function(MapDataProperty) _then) = _$MapDataPropertyCopyWithImpl;
@useResult
$Res call({
 String code, String name, String nameKana
});




}
/// @nodoc
class _$MapDataPropertyCopyWithImpl<$Res>
    implements $MapDataPropertyCopyWith<$Res> {
  _$MapDataPropertyCopyWithImpl(this._self, this._then);

  final MapDataProperty _self;
  final $Res Function(MapDataProperty) _then;

/// Create a copy of MapDataProperty
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? nameKana = null,}) {
  return _then(MapDataProperty(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,nameKana: null == nameKana ? _self.nameKana : nameKana // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MapDataProperty].
extension MapDataPropertyPatterns on MapDataProperty {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MapDataProperty value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MapDataProperty() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MapDataProperty value)  $default,){
final _that = this;
switch (_that) {
case _MapDataProperty():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MapDataProperty value)?  $default,){
final _that = this;
switch (_that) {
case _MapDataProperty() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String name,  String nameKana)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MapDataProperty() when $default != null:
return $default(_that.code,_that.name,_that.nameKana);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String name,  String nameKana)  $default,) {final _that = this;
switch (_that) {
case _MapDataProperty():
return $default(_that.code,_that.name,_that.nameKana);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String name,  String nameKana)?  $default,) {final _that = this;
switch (_that) {
case _MapDataProperty() when $default != null:
return $default(_that.code,_that.name,_that.nameKana);case _:
  return null;

}
}

}

/// @nodoc


class _MapDataProperty implements MapDataProperty {
  const _MapDataProperty({required this.code, required this.name, required this.nameKana});
  

@override final  String code;
@override final  String name;
@override final  String nameKana;

/// Create a copy of MapDataProperty
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MapDataPropertyCopyWith<_MapDataProperty> get copyWith => __$MapDataPropertyCopyWithImpl<_MapDataProperty>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MapDataProperty&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.nameKana, nameKana) || other.nameKana == nameKana));
}


@override
int get hashCode => Object.hash(runtimeType,code,name,nameKana);

@override
String toString() {
  return 'MapDataProperty(code: $code, name: $name, nameKana: $nameKana)';
}


}

/// @nodoc
abstract mixin class _$MapDataPropertyCopyWith<$Res> implements $MapDataPropertyCopyWith<$Res> {
  factory _$MapDataPropertyCopyWith(_MapDataProperty value, $Res Function(_MapDataProperty) _then) = __$MapDataPropertyCopyWithImpl;
@override @useResult
$Res call({
 String code, String name, String nameKana
});




}
/// @nodoc
class __$MapDataPropertyCopyWithImpl<$Res>
    implements _$MapDataPropertyCopyWith<$Res> {
  __$MapDataPropertyCopyWithImpl(this._self, this._then);

  final _MapDataProperty _self;
  final $Res Function(_MapDataProperty) _then;

/// Create a copy of MapDataProperty
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? nameKana = null,}) {
  return _then(_MapDataProperty(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,nameKana: null == nameKana ? _self.nameKana : nameKana // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$MapDataItem {

 MapDataBounds? get bounds; MapDataProperty? get property; MapDataLatLng? get polylabel;/// 現在地から該当海岸線までの最短距離（km）。津波予報区のみ設定される。
 double? get distanceToCoastlineKm;
/// Create a copy of MapDataItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MapDataItemCopyWith<MapDataItem> get copyWith => _$MapDataItemCopyWithImpl<MapDataItem>(this as MapDataItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MapDataItem&&(identical(other.bounds, bounds) || other.bounds == bounds)&&(identical(other.property, property) || other.property == property)&&(identical(other.polylabel, polylabel) || other.polylabel == polylabel)&&(identical(other.distanceToCoastlineKm, distanceToCoastlineKm) || other.distanceToCoastlineKm == distanceToCoastlineKm));
}


@override
int get hashCode => Object.hash(runtimeType,bounds,property,polylabel,distanceToCoastlineKm);

@override
String toString() {
  return 'MapDataItem(bounds: $bounds, property: $property, polylabel: $polylabel, distanceToCoastlineKm: $distanceToCoastlineKm)';
}


}

/// @nodoc
abstract mixin class $MapDataItemCopyWith<$Res>  {
  factory $MapDataItemCopyWith(MapDataItem value, $Res Function(MapDataItem) _then) = _$MapDataItemCopyWithImpl;
@useResult
$Res call({
 MapDataBounds? bounds, MapDataProperty? property, MapDataLatLng? polylabel, double? distanceToCoastlineKm
});


$MapDataBoundsCopyWith<$Res>? get bounds;$MapDataPropertyCopyWith<$Res>? get property;$MapDataLatLngCopyWith<$Res>? get polylabel;

}
/// @nodoc
class _$MapDataItemCopyWithImpl<$Res>
    implements $MapDataItemCopyWith<$Res> {
  _$MapDataItemCopyWithImpl(this._self, this._then);

  final MapDataItem _self;
  final $Res Function(MapDataItem) _then;

/// Create a copy of MapDataItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bounds = freezed,Object? property = freezed,Object? polylabel = freezed,Object? distanceToCoastlineKm = freezed,}) {
  return _then(MapDataItem(
bounds: freezed == bounds ? _self.bounds : bounds // ignore: cast_nullable_to_non_nullable
as MapDataBounds?,property: freezed == property ? _self.property : property // ignore: cast_nullable_to_non_nullable
as MapDataProperty?,polylabel: freezed == polylabel ? _self.polylabel : polylabel // ignore: cast_nullable_to_non_nullable
as MapDataLatLng?,distanceToCoastlineKm: freezed == distanceToCoastlineKm ? _self.distanceToCoastlineKm : distanceToCoastlineKm // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}
/// Create a copy of MapDataItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MapDataBoundsCopyWith<$Res>? get bounds {
    if (_self.bounds == null) {
    return null;
  }

  return $MapDataBoundsCopyWith<$Res>(_self.bounds!, (value) {
    return _then(_self.copyWith(bounds: value));
  });
}/// Create a copy of MapDataItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MapDataPropertyCopyWith<$Res>? get property {
    if (_self.property == null) {
    return null;
  }

  return $MapDataPropertyCopyWith<$Res>(_self.property!, (value) {
    return _then(_self.copyWith(property: value));
  });
}/// Create a copy of MapDataItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MapDataLatLngCopyWith<$Res>? get polylabel {
    if (_self.polylabel == null) {
    return null;
  }

  return $MapDataLatLngCopyWith<$Res>(_self.polylabel!, (value) {
    return _then(_self.copyWith(polylabel: value));
  });
}
}


/// Adds pattern-matching-related methods to [MapDataItem].
extension MapDataItemPatterns on MapDataItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MapDataItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MapDataItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MapDataItem value)  $default,){
final _that = this;
switch (_that) {
case _MapDataItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MapDataItem value)?  $default,){
final _that = this;
switch (_that) {
case _MapDataItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MapDataBounds? bounds,  MapDataProperty? property,  MapDataLatLng? polylabel,  double? distanceToCoastlineKm)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MapDataItem() when $default != null:
return $default(_that.bounds,_that.property,_that.polylabel,_that.distanceToCoastlineKm);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MapDataBounds? bounds,  MapDataProperty? property,  MapDataLatLng? polylabel,  double? distanceToCoastlineKm)  $default,) {final _that = this;
switch (_that) {
case _MapDataItem():
return $default(_that.bounds,_that.property,_that.polylabel,_that.distanceToCoastlineKm);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MapDataBounds? bounds,  MapDataProperty? property,  MapDataLatLng? polylabel,  double? distanceToCoastlineKm)?  $default,) {final _that = this;
switch (_that) {
case _MapDataItem() when $default != null:
return $default(_that.bounds,_that.property,_that.polylabel,_that.distanceToCoastlineKm);case _:
  return null;

}
}

}

/// @nodoc


class _MapDataItem implements MapDataItem {
  const _MapDataItem({this.bounds, this.property, this.polylabel, this.distanceToCoastlineKm});
  

@override final  MapDataBounds? bounds;
@override final  MapDataProperty? property;
@override final  MapDataLatLng? polylabel;
/// 現在地から該当海岸線までの最短距離（km）。津波予報区のみ設定される。
@override final  double? distanceToCoastlineKm;

/// Create a copy of MapDataItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MapDataItemCopyWith<_MapDataItem> get copyWith => __$MapDataItemCopyWithImpl<_MapDataItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MapDataItem&&(identical(other.bounds, bounds) || other.bounds == bounds)&&(identical(other.property, property) || other.property == property)&&(identical(other.polylabel, polylabel) || other.polylabel == polylabel)&&(identical(other.distanceToCoastlineKm, distanceToCoastlineKm) || other.distanceToCoastlineKm == distanceToCoastlineKm));
}


@override
int get hashCode => Object.hash(runtimeType,bounds,property,polylabel,distanceToCoastlineKm);

@override
String toString() {
  return 'MapDataItem(bounds: $bounds, property: $property, polylabel: $polylabel, distanceToCoastlineKm: $distanceToCoastlineKm)';
}


}

/// @nodoc
abstract mixin class _$MapDataItemCopyWith<$Res> implements $MapDataItemCopyWith<$Res> {
  factory _$MapDataItemCopyWith(_MapDataItem value, $Res Function(_MapDataItem) _then) = __$MapDataItemCopyWithImpl;
@override @useResult
$Res call({
 MapDataBounds? bounds, MapDataProperty? property, MapDataLatLng? polylabel, double? distanceToCoastlineKm
});


@override $MapDataBoundsCopyWith<$Res>? get bounds;@override $MapDataPropertyCopyWith<$Res>? get property;@override $MapDataLatLngCopyWith<$Res>? get polylabel;

}
/// @nodoc
class __$MapDataItemCopyWithImpl<$Res>
    implements _$MapDataItemCopyWith<$Res> {
  __$MapDataItemCopyWithImpl(this._self, this._then);

  final _MapDataItem _self;
  final $Res Function(_MapDataItem) _then;

/// Create a copy of MapDataItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bounds = freezed,Object? property = freezed,Object? polylabel = freezed,Object? distanceToCoastlineKm = freezed,}) {
  return _then(_MapDataItem(
bounds: freezed == bounds ? _self.bounds : bounds // ignore: cast_nullable_to_non_nullable
as MapDataBounds?,property: freezed == property ? _self.property : property // ignore: cast_nullable_to_non_nullable
as MapDataProperty?,polylabel: freezed == polylabel ? _self.polylabel : polylabel // ignore: cast_nullable_to_non_nullable
as MapDataLatLng?,distanceToCoastlineKm: freezed == distanceToCoastlineKm ? _self.distanceToCoastlineKm : distanceToCoastlineKm // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

/// Create a copy of MapDataItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MapDataBoundsCopyWith<$Res>? get bounds {
    if (_self.bounds == null) {
    return null;
  }

  return $MapDataBoundsCopyWith<$Res>(_self.bounds!, (value) {
    return _then(_self.copyWith(bounds: value));
  });
}/// Create a copy of MapDataItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MapDataPropertyCopyWith<$Res>? get property {
    if (_self.property == null) {
    return null;
  }

  return $MapDataPropertyCopyWith<$Res>(_self.property!, (value) {
    return _then(_self.copyWith(property: value));
  });
}/// Create a copy of MapDataItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MapDataLatLngCopyWith<$Res>? get polylabel {
    if (_self.polylabel == null) {
    return null;
  }

  return $MapDataLatLngCopyWith<$Res>(_self.polylabel!, (value) {
    return _then(_self.copyWith(polylabel: value));
  });
}
}

// dart format on
