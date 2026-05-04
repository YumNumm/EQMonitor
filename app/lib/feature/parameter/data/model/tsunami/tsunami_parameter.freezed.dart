// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_parameter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TsunamiParameter {

 ParameterMetadata get metadata; List<TsunamiParameterPrefectureItem> get prefectures;
/// Create a copy of TsunamiParameter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiParameterCopyWith<TsunamiParameter> get copyWith => _$TsunamiParameterCopyWithImpl<TsunamiParameter>(this as TsunamiParameter, _$identity);

  /// Serializes this TsunamiParameter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiParameter&&(identical(other.metadata, metadata) || other.metadata == metadata)&&const DeepCollectionEquality().equals(other.prefectures, prefectures));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,metadata,const DeepCollectionEquality().hash(prefectures));

@override
String toString() {
  return 'TsunamiParameter(metadata: $metadata, prefectures: $prefectures)';
}


}

/// @nodoc
abstract mixin class $TsunamiParameterCopyWith<$Res>  {
  factory $TsunamiParameterCopyWith(TsunamiParameter value, $Res Function(TsunamiParameter) _then) = _$TsunamiParameterCopyWithImpl;
@useResult
$Res call({
 ParameterMetadata metadata, List<TsunamiParameterPrefectureItem> prefectures
});


$ParameterMetadataCopyWith<$Res> get metadata;

}
/// @nodoc
class _$TsunamiParameterCopyWithImpl<$Res>
    implements $TsunamiParameterCopyWith<$Res> {
  _$TsunamiParameterCopyWithImpl(this._self, this._then);

  final TsunamiParameter _self;
  final $Res Function(TsunamiParameter) _then;

/// Create a copy of TsunamiParameter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? metadata = null,Object? prefectures = null,}) {
  return _then(_self.copyWith(
metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as ParameterMetadata,prefectures: null == prefectures ? _self.prefectures : prefectures // ignore: cast_nullable_to_non_nullable
as List<TsunamiParameterPrefectureItem>,
  ));
}
/// Create a copy of TsunamiParameter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ParameterMetadataCopyWith<$Res> get metadata {
  
  return $ParameterMetadataCopyWith<$Res>(_self.metadata, (value) {
    return _then(_self.copyWith(metadata: value));
  });
}
}


/// Adds pattern-matching-related methods to [TsunamiParameter].
extension TsunamiParameterPatterns on TsunamiParameter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiParameter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiParameter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiParameter value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiParameter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiParameter value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiParameter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ParameterMetadata metadata,  List<TsunamiParameterPrefectureItem> prefectures)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiParameter() when $default != null:
return $default(_that.metadata,_that.prefectures);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ParameterMetadata metadata,  List<TsunamiParameterPrefectureItem> prefectures)  $default,) {final _that = this;
switch (_that) {
case _TsunamiParameter():
return $default(_that.metadata,_that.prefectures);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ParameterMetadata metadata,  List<TsunamiParameterPrefectureItem> prefectures)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiParameter() when $default != null:
return $default(_that.metadata,_that.prefectures);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TsunamiParameter implements TsunamiParameter {
  const _TsunamiParameter({required this.metadata, required final  List<TsunamiParameterPrefectureItem> prefectures}): _prefectures = prefectures;
  factory _TsunamiParameter.fromJson(Map<String, dynamic> json) => _$TsunamiParameterFromJson(json);

@override final  ParameterMetadata metadata;
 final  List<TsunamiParameterPrefectureItem> _prefectures;
@override List<TsunamiParameterPrefectureItem> get prefectures {
  if (_prefectures is EqualUnmodifiableListView) return _prefectures;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_prefectures);
}


/// Create a copy of TsunamiParameter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiParameterCopyWith<_TsunamiParameter> get copyWith => __$TsunamiParameterCopyWithImpl<_TsunamiParameter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiParameterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiParameter&&(identical(other.metadata, metadata) || other.metadata == metadata)&&const DeepCollectionEquality().equals(other._prefectures, _prefectures));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,metadata,const DeepCollectionEquality().hash(_prefectures));

@override
String toString() {
  return 'TsunamiParameter(metadata: $metadata, prefectures: $prefectures)';
}


}

/// @nodoc
abstract mixin class _$TsunamiParameterCopyWith<$Res> implements $TsunamiParameterCopyWith<$Res> {
  factory _$TsunamiParameterCopyWith(_TsunamiParameter value, $Res Function(_TsunamiParameter) _then) = __$TsunamiParameterCopyWithImpl;
@override @useResult
$Res call({
 ParameterMetadata metadata, List<TsunamiParameterPrefectureItem> prefectures
});


@override $ParameterMetadataCopyWith<$Res> get metadata;

}
/// @nodoc
class __$TsunamiParameterCopyWithImpl<$Res>
    implements _$TsunamiParameterCopyWith<$Res> {
  __$TsunamiParameterCopyWithImpl(this._self, this._then);

  final _TsunamiParameter _self;
  final $Res Function(_TsunamiParameter) _then;

/// Create a copy of TsunamiParameter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? metadata = null,Object? prefectures = null,}) {
  return _then(_TsunamiParameter(
metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as ParameterMetadata,prefectures: null == prefectures ? _self._prefectures : prefectures // ignore: cast_nullable_to_non_nullable
as List<TsunamiParameterPrefectureItem>,
  ));
}

/// Create a copy of TsunamiParameter
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
mixin _$TsunamiParameterPrefectureItem {

 String get code; LocalizedName get name; List<TsunamiParameterAreaItem> get areas;
/// Create a copy of TsunamiParameterPrefectureItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiParameterPrefectureItemCopyWith<TsunamiParameterPrefectureItem> get copyWith => _$TsunamiParameterPrefectureItemCopyWithImpl<TsunamiParameterPrefectureItem>(this as TsunamiParameterPrefectureItem, _$identity);

  /// Serializes this TsunamiParameterPrefectureItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiParameterPrefectureItem&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.areas, areas));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,const DeepCollectionEquality().hash(areas));

@override
String toString() {
  return 'TsunamiParameterPrefectureItem(code: $code, name: $name, areas: $areas)';
}


}

/// @nodoc
abstract mixin class $TsunamiParameterPrefectureItemCopyWith<$Res>  {
  factory $TsunamiParameterPrefectureItemCopyWith(TsunamiParameterPrefectureItem value, $Res Function(TsunamiParameterPrefectureItem) _then) = _$TsunamiParameterPrefectureItemCopyWithImpl;
@useResult
$Res call({
 String code, LocalizedName name, List<TsunamiParameterAreaItem> areas
});


$LocalizedNameCopyWith<$Res> get name;

}
/// @nodoc
class _$TsunamiParameterPrefectureItemCopyWithImpl<$Res>
    implements $TsunamiParameterPrefectureItemCopyWith<$Res> {
  _$TsunamiParameterPrefectureItemCopyWithImpl(this._self, this._then);

  final TsunamiParameterPrefectureItem _self;
  final $Res Function(TsunamiParameterPrefectureItem) _then;

/// Create a copy of TsunamiParameterPrefectureItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? areas = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedName,areas: null == areas ? _self.areas : areas // ignore: cast_nullable_to_non_nullable
as List<TsunamiParameterAreaItem>,
  ));
}
/// Create a copy of TsunamiParameterPrefectureItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedNameCopyWith<$Res> get name {
  
  return $LocalizedNameCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}
}


/// Adds pattern-matching-related methods to [TsunamiParameterPrefectureItem].
extension TsunamiParameterPrefectureItemPatterns on TsunamiParameterPrefectureItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiParameterPrefectureItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiParameterPrefectureItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiParameterPrefectureItem value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiParameterPrefectureItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiParameterPrefectureItem value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiParameterPrefectureItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  LocalizedName name,  List<TsunamiParameterAreaItem> areas)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiParameterPrefectureItem() when $default != null:
return $default(_that.code,_that.name,_that.areas);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  LocalizedName name,  List<TsunamiParameterAreaItem> areas)  $default,) {final _that = this;
switch (_that) {
case _TsunamiParameterPrefectureItem():
return $default(_that.code,_that.name,_that.areas);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  LocalizedName name,  List<TsunamiParameterAreaItem> areas)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiParameterPrefectureItem() when $default != null:
return $default(_that.code,_that.name,_that.areas);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TsunamiParameterPrefectureItem implements TsunamiParameterPrefectureItem {
  const _TsunamiParameterPrefectureItem({required this.code, required this.name, required final  List<TsunamiParameterAreaItem> areas}): _areas = areas;
  factory _TsunamiParameterPrefectureItem.fromJson(Map<String, dynamic> json) => _$TsunamiParameterPrefectureItemFromJson(json);

@override final  String code;
@override final  LocalizedName name;
 final  List<TsunamiParameterAreaItem> _areas;
@override List<TsunamiParameterAreaItem> get areas {
  if (_areas is EqualUnmodifiableListView) return _areas;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_areas);
}


/// Create a copy of TsunamiParameterPrefectureItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiParameterPrefectureItemCopyWith<_TsunamiParameterPrefectureItem> get copyWith => __$TsunamiParameterPrefectureItemCopyWithImpl<_TsunamiParameterPrefectureItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiParameterPrefectureItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiParameterPrefectureItem&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._areas, _areas));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,const DeepCollectionEquality().hash(_areas));

@override
String toString() {
  return 'TsunamiParameterPrefectureItem(code: $code, name: $name, areas: $areas)';
}


}

/// @nodoc
abstract mixin class _$TsunamiParameterPrefectureItemCopyWith<$Res> implements $TsunamiParameterPrefectureItemCopyWith<$Res> {
  factory _$TsunamiParameterPrefectureItemCopyWith(_TsunamiParameterPrefectureItem value, $Res Function(_TsunamiParameterPrefectureItem) _then) = __$TsunamiParameterPrefectureItemCopyWithImpl;
@override @useResult
$Res call({
 String code, LocalizedName name, List<TsunamiParameterAreaItem> areas
});


@override $LocalizedNameCopyWith<$Res> get name;

}
/// @nodoc
class __$TsunamiParameterPrefectureItemCopyWithImpl<$Res>
    implements _$TsunamiParameterPrefectureItemCopyWith<$Res> {
  __$TsunamiParameterPrefectureItemCopyWithImpl(this._self, this._then);

  final _TsunamiParameterPrefectureItem _self;
  final $Res Function(_TsunamiParameterPrefectureItem) _then;

/// Create a copy of TsunamiParameterPrefectureItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? areas = null,}) {
  return _then(_TsunamiParameterPrefectureItem(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedName,areas: null == areas ? _self._areas : areas // ignore: cast_nullable_to_non_nullable
as List<TsunamiParameterAreaItem>,
  ));
}

/// Create a copy of TsunamiParameterPrefectureItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedNameCopyWith<$Res> get name {
  
  return $LocalizedNameCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}
}


/// @nodoc
mixin _$TsunamiParameterAreaItem {

 LocalizedName? get name; List<TsunamiParameterStationItem> get stations;
/// Create a copy of TsunamiParameterAreaItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiParameterAreaItemCopyWith<TsunamiParameterAreaItem> get copyWith => _$TsunamiParameterAreaItemCopyWithImpl<TsunamiParameterAreaItem>(this as TsunamiParameterAreaItem, _$identity);

  /// Serializes this TsunamiParameterAreaItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiParameterAreaItem&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.stations, stations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,const DeepCollectionEquality().hash(stations));

@override
String toString() {
  return 'TsunamiParameterAreaItem(name: $name, stations: $stations)';
}


}

/// @nodoc
abstract mixin class $TsunamiParameterAreaItemCopyWith<$Res>  {
  factory $TsunamiParameterAreaItemCopyWith(TsunamiParameterAreaItem value, $Res Function(TsunamiParameterAreaItem) _then) = _$TsunamiParameterAreaItemCopyWithImpl;
@useResult
$Res call({
 LocalizedName? name, List<TsunamiParameterStationItem> stations
});


$LocalizedNameCopyWith<$Res>? get name;

}
/// @nodoc
class _$TsunamiParameterAreaItemCopyWithImpl<$Res>
    implements $TsunamiParameterAreaItemCopyWith<$Res> {
  _$TsunamiParameterAreaItemCopyWithImpl(this._self, this._then);

  final TsunamiParameterAreaItem _self;
  final $Res Function(TsunamiParameterAreaItem) _then;

/// Create a copy of TsunamiParameterAreaItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = freezed,Object? stations = null,}) {
  return _then(_self.copyWith(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedName?,stations: null == stations ? _self.stations : stations // ignore: cast_nullable_to_non_nullable
as List<TsunamiParameterStationItem>,
  ));
}
/// Create a copy of TsunamiParameterAreaItem
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


/// Adds pattern-matching-related methods to [TsunamiParameterAreaItem].
extension TsunamiParameterAreaItemPatterns on TsunamiParameterAreaItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiParameterAreaItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiParameterAreaItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiParameterAreaItem value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiParameterAreaItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiParameterAreaItem value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiParameterAreaItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LocalizedName? name,  List<TsunamiParameterStationItem> stations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiParameterAreaItem() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LocalizedName? name,  List<TsunamiParameterStationItem> stations)  $default,) {final _that = this;
switch (_that) {
case _TsunamiParameterAreaItem():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LocalizedName? name,  List<TsunamiParameterStationItem> stations)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiParameterAreaItem() when $default != null:
return $default(_that.name,_that.stations);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TsunamiParameterAreaItem implements TsunamiParameterAreaItem {
  const _TsunamiParameterAreaItem({required this.name, required final  List<TsunamiParameterStationItem> stations}): _stations = stations;
  factory _TsunamiParameterAreaItem.fromJson(Map<String, dynamic> json) => _$TsunamiParameterAreaItemFromJson(json);

@override final  LocalizedName? name;
 final  List<TsunamiParameterStationItem> _stations;
@override List<TsunamiParameterStationItem> get stations {
  if (_stations is EqualUnmodifiableListView) return _stations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stations);
}


/// Create a copy of TsunamiParameterAreaItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiParameterAreaItemCopyWith<_TsunamiParameterAreaItem> get copyWith => __$TsunamiParameterAreaItemCopyWithImpl<_TsunamiParameterAreaItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiParameterAreaItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiParameterAreaItem&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._stations, _stations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,const DeepCollectionEquality().hash(_stations));

@override
String toString() {
  return 'TsunamiParameterAreaItem(name: $name, stations: $stations)';
}


}

/// @nodoc
abstract mixin class _$TsunamiParameterAreaItemCopyWith<$Res> implements $TsunamiParameterAreaItemCopyWith<$Res> {
  factory _$TsunamiParameterAreaItemCopyWith(_TsunamiParameterAreaItem value, $Res Function(_TsunamiParameterAreaItem) _then) = __$TsunamiParameterAreaItemCopyWithImpl;
@override @useResult
$Res call({
 LocalizedName? name, List<TsunamiParameterStationItem> stations
});


@override $LocalizedNameCopyWith<$Res>? get name;

}
/// @nodoc
class __$TsunamiParameterAreaItemCopyWithImpl<$Res>
    implements _$TsunamiParameterAreaItemCopyWith<$Res> {
  __$TsunamiParameterAreaItemCopyWithImpl(this._self, this._then);

  final _TsunamiParameterAreaItem _self;
  final $Res Function(_TsunamiParameterAreaItem) _then;

/// Create a copy of TsunamiParameterAreaItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = freezed,Object? stations = null,}) {
  return _then(_TsunamiParameterAreaItem(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedName?,stations: null == stations ? _self._stations : stations // ignore: cast_nullable_to_non_nullable
as List<TsunamiParameterStationItem>,
  ));
}

/// Create a copy of TsunamiParameterAreaItem
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


/// @nodoc
mixin _$TsunamiParameterStationItem {

 String get code; LocalizedName get name; String? get kana; String get owner; LatLng get location;
/// Create a copy of TsunamiParameterStationItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiParameterStationItemCopyWith<TsunamiParameterStationItem> get copyWith => _$TsunamiParameterStationItemCopyWithImpl<TsunamiParameterStationItem>(this as TsunamiParameterStationItem, _$identity);

  /// Serializes this TsunamiParameterStationItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiParameterStationItem&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.kana, kana) || other.kana == kana)&&(identical(other.owner, owner) || other.owner == owner)&&(identical(other.location, location) || other.location == location));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,kana,owner,location);

@override
String toString() {
  return 'TsunamiParameterStationItem(code: $code, name: $name, kana: $kana, owner: $owner, location: $location)';
}


}

/// @nodoc
abstract mixin class $TsunamiParameterStationItemCopyWith<$Res>  {
  factory $TsunamiParameterStationItemCopyWith(TsunamiParameterStationItem value, $Res Function(TsunamiParameterStationItem) _then) = _$TsunamiParameterStationItemCopyWithImpl;
@useResult
$Res call({
 String code, LocalizedName name, String? kana, String owner, LatLng location
});


$LocalizedNameCopyWith<$Res> get name;

}
/// @nodoc
class _$TsunamiParameterStationItemCopyWithImpl<$Res>
    implements $TsunamiParameterStationItemCopyWith<$Res> {
  _$TsunamiParameterStationItemCopyWithImpl(this._self, this._then);

  final TsunamiParameterStationItem _self;
  final $Res Function(TsunamiParameterStationItem) _then;

/// Create a copy of TsunamiParameterStationItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? kana = freezed,Object? owner = null,Object? location = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedName,kana: freezed == kana ? _self.kana : kana // ignore: cast_nullable_to_non_nullable
as String?,owner: null == owner ? _self.owner : owner // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LatLng,
  ));
}
/// Create a copy of TsunamiParameterStationItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedNameCopyWith<$Res> get name {
  
  return $LocalizedNameCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}
}


/// Adds pattern-matching-related methods to [TsunamiParameterStationItem].
extension TsunamiParameterStationItemPatterns on TsunamiParameterStationItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiParameterStationItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiParameterStationItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiParameterStationItem value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiParameterStationItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiParameterStationItem value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiParameterStationItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  LocalizedName name,  String? kana,  String owner,  LatLng location)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiParameterStationItem() when $default != null:
return $default(_that.code,_that.name,_that.kana,_that.owner,_that.location);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  LocalizedName name,  String? kana,  String owner,  LatLng location)  $default,) {final _that = this;
switch (_that) {
case _TsunamiParameterStationItem():
return $default(_that.code,_that.name,_that.kana,_that.owner,_that.location);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  LocalizedName name,  String? kana,  String owner,  LatLng location)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiParameterStationItem() when $default != null:
return $default(_that.code,_that.name,_that.kana,_that.owner,_that.location);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TsunamiParameterStationItem implements TsunamiParameterStationItem {
  const _TsunamiParameterStationItem({required this.code, required this.name, required this.kana, required this.owner, required this.location});
  factory _TsunamiParameterStationItem.fromJson(Map<String, dynamic> json) => _$TsunamiParameterStationItemFromJson(json);

@override final  String code;
@override final  LocalizedName name;
@override final  String? kana;
@override final  String owner;
@override final  LatLng location;

/// Create a copy of TsunamiParameterStationItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiParameterStationItemCopyWith<_TsunamiParameterStationItem> get copyWith => __$TsunamiParameterStationItemCopyWithImpl<_TsunamiParameterStationItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiParameterStationItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiParameterStationItem&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.kana, kana) || other.kana == kana)&&(identical(other.owner, owner) || other.owner == owner)&&(identical(other.location, location) || other.location == location));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,kana,owner,location);

@override
String toString() {
  return 'TsunamiParameterStationItem(code: $code, name: $name, kana: $kana, owner: $owner, location: $location)';
}


}

/// @nodoc
abstract mixin class _$TsunamiParameterStationItemCopyWith<$Res> implements $TsunamiParameterStationItemCopyWith<$Res> {
  factory _$TsunamiParameterStationItemCopyWith(_TsunamiParameterStationItem value, $Res Function(_TsunamiParameterStationItem) _then) = __$TsunamiParameterStationItemCopyWithImpl;
@override @useResult
$Res call({
 String code, LocalizedName name, String? kana, String owner, LatLng location
});


@override $LocalizedNameCopyWith<$Res> get name;

}
/// @nodoc
class __$TsunamiParameterStationItemCopyWithImpl<$Res>
    implements _$TsunamiParameterStationItemCopyWith<$Res> {
  __$TsunamiParameterStationItemCopyWithImpl(this._self, this._then);

  final _TsunamiParameterStationItem _self;
  final $Res Function(_TsunamiParameterStationItem) _then;

/// Create a copy of TsunamiParameterStationItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? kana = freezed,Object? owner = null,Object? location = null,}) {
  return _then(_TsunamiParameterStationItem(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedName,kana: freezed == kana ? _self.kana : kana // ignore: cast_nullable_to_non_nullable
as String?,owner: null == owner ? _self.owner : owner // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LatLng,
  ));
}

/// Create a copy of TsunamiParameterStationItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedNameCopyWith<$Res> get name {
  
  return $LocalizedNameCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}
}

// dart format on
