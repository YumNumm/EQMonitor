// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shindo_db_stations_parameter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ShindoDbStationsParameter {

 ParameterMetadata get metadata; List<ShindoDbStationItem> get stations;
/// Create a copy of ShindoDbStationsParameter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShindoDbStationsParameterCopyWith<ShindoDbStationsParameter> get copyWith => _$ShindoDbStationsParameterCopyWithImpl<ShindoDbStationsParameter>(this as ShindoDbStationsParameter, _$identity);

  /// Serializes this ShindoDbStationsParameter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShindoDbStationsParameter&&(identical(other.metadata, metadata) || other.metadata == metadata)&&const DeepCollectionEquality().equals(other.stations, stations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,metadata,const DeepCollectionEquality().hash(stations));

@override
String toString() {
  return 'ShindoDbStationsParameter(metadata: $metadata, stations: $stations)';
}


}

/// @nodoc
abstract mixin class $ShindoDbStationsParameterCopyWith<$Res>  {
  factory $ShindoDbStationsParameterCopyWith(ShindoDbStationsParameter value, $Res Function(ShindoDbStationsParameter) _then) = _$ShindoDbStationsParameterCopyWithImpl;
@useResult
$Res call({
 ParameterMetadata metadata, List<ShindoDbStationItem> stations
});


$ParameterMetadataCopyWith<$Res> get metadata;

}
/// @nodoc
class _$ShindoDbStationsParameterCopyWithImpl<$Res>
    implements $ShindoDbStationsParameterCopyWith<$Res> {
  _$ShindoDbStationsParameterCopyWithImpl(this._self, this._then);

  final ShindoDbStationsParameter _self;
  final $Res Function(ShindoDbStationsParameter) _then;

/// Create a copy of ShindoDbStationsParameter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? metadata = null,Object? stations = null,}) {
  return _then(_self.copyWith(
metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as ParameterMetadata,stations: null == stations ? _self.stations : stations // ignore: cast_nullable_to_non_nullable
as List<ShindoDbStationItem>,
  ));
}
/// Create a copy of ShindoDbStationsParameter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ParameterMetadataCopyWith<$Res> get metadata {

  return $ParameterMetadataCopyWith<$Res>(_self.metadata, (value) {
    return _then(_self.copyWith(metadata: value));
  });
}
}


/// Adds pattern-matching-related methods to [ShindoDbStationsParameter].
extension ShindoDbStationsParameterPatterns on ShindoDbStationsParameter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShindoDbStationsParameter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShindoDbStationsParameter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShindoDbStationsParameter value)  $default,){
final _that = this;
switch (_that) {
case _ShindoDbStationsParameter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShindoDbStationsParameter value)?  $default,){
final _that = this;
switch (_that) {
case _ShindoDbStationsParameter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ParameterMetadata metadata,  List<ShindoDbStationItem> stations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShindoDbStationsParameter() when $default != null:
return $default(_that.metadata,_that.stations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ParameterMetadata metadata,  List<ShindoDbStationItem> stations)  $default,) {final _that = this;
switch (_that) {
case _ShindoDbStationsParameter():
return $default(_that.metadata,_that.stations);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ParameterMetadata metadata,  List<ShindoDbStationItem> stations)?  $default,) {final _that = this;
switch (_that) {
case _ShindoDbStationsParameter() when $default != null:
return $default(_that.metadata,_that.stations);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ShindoDbStationsParameter implements ShindoDbStationsParameter {
  const _ShindoDbStationsParameter({required this.metadata, required final  List<ShindoDbStationItem> stations}): _stations = stations;
  factory _ShindoDbStationsParameter.fromJson(Map<String, dynamic> json) => _$ShindoDbStationsParameterFromJson(json);

@override final  ParameterMetadata metadata;
 final  List<ShindoDbStationItem> _stations;
@override List<ShindoDbStationItem> get stations {
  if (_stations is EqualUnmodifiableListView) return _stations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stations);
}


/// Create a copy of ShindoDbStationsParameter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShindoDbStationsParameterCopyWith<_ShindoDbStationsParameter> get copyWith => __$ShindoDbStationsParameterCopyWithImpl<_ShindoDbStationsParameter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShindoDbStationsParameterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShindoDbStationsParameter&&(identical(other.metadata, metadata) || other.metadata == metadata)&&const DeepCollectionEquality().equals(other._stations, _stations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,metadata,const DeepCollectionEquality().hash(_stations));

@override
String toString() {
  return 'ShindoDbStationsParameter(metadata: $metadata, stations: $stations)';
}


}

/// @nodoc
abstract mixin class _$ShindoDbStationsParameterCopyWith<$Res> implements $ShindoDbStationsParameterCopyWith<$Res> {
  factory _$ShindoDbStationsParameterCopyWith(_ShindoDbStationsParameter value, $Res Function(_ShindoDbStationsParameter) _then) = __$ShindoDbStationsParameterCopyWithImpl;
@override @useResult
$Res call({
 ParameterMetadata metadata, List<ShindoDbStationItem> stations
});


@override $ParameterMetadataCopyWith<$Res> get metadata;

}
/// @nodoc
class __$ShindoDbStationsParameterCopyWithImpl<$Res>
    implements _$ShindoDbStationsParameterCopyWith<$Res> {
  __$ShindoDbStationsParameterCopyWithImpl(this._self, this._then);

  final _ShindoDbStationsParameter _self;
  final $Res Function(_ShindoDbStationsParameter) _then;

/// Create a copy of ShindoDbStationsParameter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? metadata = null,Object? stations = null,}) {
  return _then(_ShindoDbStationsParameter(
metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as ParameterMetadata,stations: null == stations ? _self._stations : stations // ignore: cast_nullable_to_non_nullable
as List<ShindoDbStationItem>,
  ));
}

/// Create a copy of ShindoDbStationsParameter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ParameterMetadataCopyWith<$Res> get metadata {

  return $ParameterMetadataCopyWith<$Res>(_self.metadata, (value) {
    return _then(_self.copyWith(metadata: value));
  });
}
}

/// @nodoc
mixin _$ShindoDbStationItem {

 String get code; String get name; LatLng get location;
/// Create a copy of ShindoDbStationItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShindoDbStationItemCopyWith<ShindoDbStationItem> get copyWith => _$ShindoDbStationItemCopyWithImpl<ShindoDbStationItem>(this as ShindoDbStationItem, _$identity);

  /// Serializes this ShindoDbStationItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShindoDbStationItem&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.location, location) || other.location == location));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,location);

@override
String toString() {
  return 'ShindoDbStationItem(code: $code, name: $name, location: $location)';
}


}

/// @nodoc
abstract mixin class $ShindoDbStationItemCopyWith<$Res>  {
  factory $ShindoDbStationItemCopyWith(ShindoDbStationItem value, $Res Function(ShindoDbStationItem) _then) = _$ShindoDbStationItemCopyWithImpl;
@useResult
$Res call({
 String code, String name, LatLng location
});




}
/// @nodoc
class _$ShindoDbStationItemCopyWithImpl<$Res>
    implements $ShindoDbStationItemCopyWith<$Res> {
  _$ShindoDbStationItemCopyWithImpl(this._self, this._then);

  final ShindoDbStationItem _self;
  final $Res Function(ShindoDbStationItem) _then;

/// Create a copy of ShindoDbStationItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? location = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LatLng,
  ));
}

}


/// Adds pattern-matching-related methods to [ShindoDbStationItem].
extension ShindoDbStationItemPatterns on ShindoDbStationItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShindoDbStationItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShindoDbStationItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShindoDbStationItem value)  $default,){
final _that = this;
switch (_that) {
case _ShindoDbStationItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShindoDbStationItem value)?  $default,){
final _that = this;
switch (_that) {
case _ShindoDbStationItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String name,  LatLng location)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShindoDbStationItem() when $default != null:
return $default(_that.code,_that.name,_that.location);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String name,  LatLng location)  $default,) {final _that = this;
switch (_that) {
case _ShindoDbStationItem():
return $default(_that.code,_that.name,_that.location);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String name,  LatLng location)?  $default,) {final _that = this;
switch (_that) {
case _ShindoDbStationItem() when $default != null:
return $default(_that.code,_that.name,_that.location);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createFactory: false)

class _ShindoDbStationItem implements ShindoDbStationItem {
  const _ShindoDbStationItem({required this.code, required this.name, required this.location});


@override final  String code;
@override final  String name;
@override final  LatLng location;

/// Create a copy of ShindoDbStationItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShindoDbStationItemCopyWith<_ShindoDbStationItem> get copyWith => __$ShindoDbStationItemCopyWithImpl<_ShindoDbStationItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShindoDbStationItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShindoDbStationItem&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.location, location) || other.location == location));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,location);

@override
String toString() {
  return 'ShindoDbStationItem(code: $code, name: $name, location: $location)';
}


}

/// @nodoc
abstract mixin class _$ShindoDbStationItemCopyWith<$Res> implements $ShindoDbStationItemCopyWith<$Res> {
  factory _$ShindoDbStationItemCopyWith(_ShindoDbStationItem value, $Res Function(_ShindoDbStationItem) _then) = __$ShindoDbStationItemCopyWithImpl;
@override @useResult
$Res call({
 String code, String name, LatLng location
});




}
/// @nodoc
class __$ShindoDbStationItemCopyWithImpl<$Res>
    implements _$ShindoDbStationItemCopyWith<$Res> {
  __$ShindoDbStationItemCopyWithImpl(this._self, this._then);

  final _ShindoDbStationItem _self;
  final $Res Function(_ShindoDbStationItem) _then;

/// Create a copy of ShindoDbStationItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? location = null,}) {
  return _then(_ShindoDbStationItem(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LatLng,
  ));
}


}

// dart format on
