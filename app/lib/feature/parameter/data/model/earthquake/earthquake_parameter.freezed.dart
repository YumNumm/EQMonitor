// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_parameter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EarthquakeParameter {

 ParameterMetadata get metadata; List<EarthquakeParameterPrefectureItem> get prefectures;
/// Create a copy of EarthquakeParameter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeParameterCopyWith<EarthquakeParameter> get copyWith => _$EarthquakeParameterCopyWithImpl<EarthquakeParameter>(this as EarthquakeParameter, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeParameter&&(identical(other.metadata, metadata) || other.metadata == metadata)&&const DeepCollectionEquality().equals(other.prefectures, prefectures));
}


@override
int get hashCode => Object.hash(runtimeType,metadata,const DeepCollectionEquality().hash(prefectures));

@override
String toString() {
  return 'EarthquakeParameter(metadata: $metadata, prefectures: $prefectures)';
}


}

/// @nodoc
abstract mixin class $EarthquakeParameterCopyWith<$Res>  {
  factory $EarthquakeParameterCopyWith(EarthquakeParameter value, $Res Function(EarthquakeParameter) _then) = _$EarthquakeParameterCopyWithImpl;
@useResult
$Res call({
 ParameterMetadata metadata, List<EarthquakeParameterPrefectureItem> prefectures
});


$ParameterMetadataCopyWith<$Res> get metadata;

}
/// @nodoc
class _$EarthquakeParameterCopyWithImpl<$Res>
    implements $EarthquakeParameterCopyWith<$Res> {
  _$EarthquakeParameterCopyWithImpl(this._self, this._then);

  final EarthquakeParameter _self;
  final $Res Function(EarthquakeParameter) _then;

/// Create a copy of EarthquakeParameter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? metadata = null,Object? prefectures = null,}) {
  return _then(EarthquakeParameter(
metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as ParameterMetadata,prefectures: null == prefectures ? _self.prefectures : prefectures // ignore: cast_nullable_to_non_nullable
as List<EarthquakeParameterPrefectureItem>,
  ));
}
/// Create a copy of EarthquakeParameter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ParameterMetadataCopyWith<$Res> get metadata {
  
  return $ParameterMetadataCopyWith<$Res>(_self.metadata, (value) {
    return _then(_self.copyWith(metadata: value));
  });
}
}


/// Adds pattern-matching-related methods to [EarthquakeParameter].
extension EarthquakeParameterPatterns on EarthquakeParameter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeParameter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeParameter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeParameter value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeParameter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeParameter value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeParameter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ParameterMetadata metadata,  List<EarthquakeParameterPrefectureItem> prefectures)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeParameter() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ParameterMetadata metadata,  List<EarthquakeParameterPrefectureItem> prefectures)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeParameter():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ParameterMetadata metadata,  List<EarthquakeParameterPrefectureItem> prefectures)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeParameter() when $default != null:
return $default(_that.metadata,_that.prefectures);case _:
  return null;

}
}

}

/// @nodoc


class _EarthquakeParameter implements EarthquakeParameter {
  const _EarthquakeParameter({required this.metadata, required  List<EarthquakeParameterPrefectureItem> prefectures}): _prefectures = prefectures;
  

@override final  ParameterMetadata metadata;
 final  List<EarthquakeParameterPrefectureItem> _prefectures;
@override List<EarthquakeParameterPrefectureItem> get prefectures {
  if (_prefectures is EqualUnmodifiableListView) return _prefectures;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_prefectures);
}


/// Create a copy of EarthquakeParameter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeParameterCopyWith<_EarthquakeParameter> get copyWith => __$EarthquakeParameterCopyWithImpl<_EarthquakeParameter>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeParameter&&(identical(other.metadata, metadata) || other.metadata == metadata)&&const DeepCollectionEquality().equals(other._prefectures, _prefectures));
}


@override
int get hashCode => Object.hash(runtimeType,metadata,const DeepCollectionEquality().hash(_prefectures));

@override
String toString() {
  return 'EarthquakeParameter(metadata: $metadata, prefectures: $prefectures)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeParameterCopyWith<$Res> implements $EarthquakeParameterCopyWith<$Res> {
  factory _$EarthquakeParameterCopyWith(_EarthquakeParameter value, $Res Function(_EarthquakeParameter) _then) = __$EarthquakeParameterCopyWithImpl;
@override @useResult
$Res call({
 ParameterMetadata metadata, List<EarthquakeParameterPrefectureItem> prefectures
});


@override $ParameterMetadataCopyWith<$Res> get metadata;

}
/// @nodoc
class __$EarthquakeParameterCopyWithImpl<$Res>
    implements _$EarthquakeParameterCopyWith<$Res> {
  __$EarthquakeParameterCopyWithImpl(this._self, this._then);

  final _EarthquakeParameter _self;
  final $Res Function(_EarthquakeParameter) _then;

/// Create a copy of EarthquakeParameter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? metadata = null,Object? prefectures = null,}) {
  return _then(_EarthquakeParameter(
metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as ParameterMetadata,prefectures: null == prefectures ? _self._prefectures : prefectures // ignore: cast_nullable_to_non_nullable
as List<EarthquakeParameterPrefectureItem>,
  ));
}

/// Create a copy of EarthquakeParameter
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
mixin _$EarthquakeParameterPrefectureItem {

 String get code; LocalizedName get name; List<EarthquakeParameterRegionItem> get regions;
/// Create a copy of EarthquakeParameterPrefectureItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeParameterPrefectureItemCopyWith<EarthquakeParameterPrefectureItem> get copyWith => _$EarthquakeParameterPrefectureItemCopyWithImpl<EarthquakeParameterPrefectureItem>(this as EarthquakeParameterPrefectureItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeParameterPrefectureItem&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.regions, regions));
}


@override
int get hashCode => Object.hash(runtimeType,code,name,const DeepCollectionEquality().hash(regions));

@override
String toString() {
  return 'EarthquakeParameterPrefectureItem(code: $code, name: $name, regions: $regions)';
}


}

/// @nodoc
abstract mixin class $EarthquakeParameterPrefectureItemCopyWith<$Res>  {
  factory $EarthquakeParameterPrefectureItemCopyWith(EarthquakeParameterPrefectureItem value, $Res Function(EarthquakeParameterPrefectureItem) _then) = _$EarthquakeParameterPrefectureItemCopyWithImpl;
@useResult
$Res call({
 String code, LocalizedName name, List<EarthquakeParameterRegionItem> regions
});


$LocalizedNameCopyWith<$Res> get name;

}
/// @nodoc
class _$EarthquakeParameterPrefectureItemCopyWithImpl<$Res>
    implements $EarthquakeParameterPrefectureItemCopyWith<$Res> {
  _$EarthquakeParameterPrefectureItemCopyWithImpl(this._self, this._then);

  final EarthquakeParameterPrefectureItem _self;
  final $Res Function(EarthquakeParameterPrefectureItem) _then;

/// Create a copy of EarthquakeParameterPrefectureItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? regions = null,}) {
  return _then(EarthquakeParameterPrefectureItem(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedName,regions: null == regions ? _self.regions : regions // ignore: cast_nullable_to_non_nullable
as List<EarthquakeParameterRegionItem>,
  ));
}
/// Create a copy of EarthquakeParameterPrefectureItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedNameCopyWith<$Res> get name {
  
  return $LocalizedNameCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}
}


/// Adds pattern-matching-related methods to [EarthquakeParameterPrefectureItem].
extension EarthquakeParameterPrefectureItemPatterns on EarthquakeParameterPrefectureItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeParameterPrefectureItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeParameterPrefectureItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeParameterPrefectureItem value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeParameterPrefectureItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeParameterPrefectureItem value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeParameterPrefectureItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  LocalizedName name,  List<EarthquakeParameterRegionItem> regions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeParameterPrefectureItem() when $default != null:
return $default(_that.code,_that.name,_that.regions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  LocalizedName name,  List<EarthquakeParameterRegionItem> regions)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeParameterPrefectureItem():
return $default(_that.code,_that.name,_that.regions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  LocalizedName name,  List<EarthquakeParameterRegionItem> regions)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeParameterPrefectureItem() when $default != null:
return $default(_that.code,_that.name,_that.regions);case _:
  return null;

}
}

}

/// @nodoc


class _EarthquakeParameterPrefectureItem implements EarthquakeParameterPrefectureItem {
  const _EarthquakeParameterPrefectureItem({required this.code, required this.name, required  List<EarthquakeParameterRegionItem> regions}): _regions = regions;
  

@override final  String code;
@override final  LocalizedName name;
 final  List<EarthquakeParameterRegionItem> _regions;
@override List<EarthquakeParameterRegionItem> get regions {
  if (_regions is EqualUnmodifiableListView) return _regions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_regions);
}


/// Create a copy of EarthquakeParameterPrefectureItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeParameterPrefectureItemCopyWith<_EarthquakeParameterPrefectureItem> get copyWith => __$EarthquakeParameterPrefectureItemCopyWithImpl<_EarthquakeParameterPrefectureItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeParameterPrefectureItem&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._regions, _regions));
}


@override
int get hashCode => Object.hash(runtimeType,code,name,const DeepCollectionEquality().hash(_regions));

@override
String toString() {
  return 'EarthquakeParameterPrefectureItem(code: $code, name: $name, regions: $regions)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeParameterPrefectureItemCopyWith<$Res> implements $EarthquakeParameterPrefectureItemCopyWith<$Res> {
  factory _$EarthquakeParameterPrefectureItemCopyWith(_EarthquakeParameterPrefectureItem value, $Res Function(_EarthquakeParameterPrefectureItem) _then) = __$EarthquakeParameterPrefectureItemCopyWithImpl;
@override @useResult
$Res call({
 String code, LocalizedName name, List<EarthquakeParameterRegionItem> regions
});


@override $LocalizedNameCopyWith<$Res> get name;

}
/// @nodoc
class __$EarthquakeParameterPrefectureItemCopyWithImpl<$Res>
    implements _$EarthquakeParameterPrefectureItemCopyWith<$Res> {
  __$EarthquakeParameterPrefectureItemCopyWithImpl(this._self, this._then);

  final _EarthquakeParameterPrefectureItem _self;
  final $Res Function(_EarthquakeParameterPrefectureItem) _then;

/// Create a copy of EarthquakeParameterPrefectureItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? regions = null,}) {
  return _then(_EarthquakeParameterPrefectureItem(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedName,regions: null == regions ? _self._regions : regions // ignore: cast_nullable_to_non_nullable
as List<EarthquakeParameterRegionItem>,
  ));
}

/// Create a copy of EarthquakeParameterPrefectureItem
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
mixin _$EarthquakeParameterRegionItem {

 String get code; LocalizedName get name; String? get kana; List<EarthquakeParameterCityItem> get cities;
/// Create a copy of EarthquakeParameterRegionItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeParameterRegionItemCopyWith<EarthquakeParameterRegionItem> get copyWith => _$EarthquakeParameterRegionItemCopyWithImpl<EarthquakeParameterRegionItem>(this as EarthquakeParameterRegionItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeParameterRegionItem&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.kana, kana) || other.kana == kana)&&const DeepCollectionEquality().equals(other.cities, cities));
}


@override
int get hashCode => Object.hash(runtimeType,code,name,kana,const DeepCollectionEquality().hash(cities));

@override
String toString() {
  return 'EarthquakeParameterRegionItem(code: $code, name: $name, kana: $kana, cities: $cities)';
}


}

/// @nodoc
abstract mixin class $EarthquakeParameterRegionItemCopyWith<$Res>  {
  factory $EarthquakeParameterRegionItemCopyWith(EarthquakeParameterRegionItem value, $Res Function(EarthquakeParameterRegionItem) _then) = _$EarthquakeParameterRegionItemCopyWithImpl;
@useResult
$Res call({
 String code, LocalizedName name, String? kana, List<EarthquakeParameterCityItem> cities
});


$LocalizedNameCopyWith<$Res> get name;

}
/// @nodoc
class _$EarthquakeParameterRegionItemCopyWithImpl<$Res>
    implements $EarthquakeParameterRegionItemCopyWith<$Res> {
  _$EarthquakeParameterRegionItemCopyWithImpl(this._self, this._then);

  final EarthquakeParameterRegionItem _self;
  final $Res Function(EarthquakeParameterRegionItem) _then;

/// Create a copy of EarthquakeParameterRegionItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? kana = freezed,Object? cities = null,}) {
  return _then(EarthquakeParameterRegionItem(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedName,kana: freezed == kana ? _self.kana : kana // ignore: cast_nullable_to_non_nullable
as String?,cities: null == cities ? _self.cities : cities // ignore: cast_nullable_to_non_nullable
as List<EarthquakeParameterCityItem>,
  ));
}
/// Create a copy of EarthquakeParameterRegionItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedNameCopyWith<$Res> get name {
  
  return $LocalizedNameCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}
}


/// Adds pattern-matching-related methods to [EarthquakeParameterRegionItem].
extension EarthquakeParameterRegionItemPatterns on EarthquakeParameterRegionItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeParameterRegionItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeParameterRegionItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeParameterRegionItem value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeParameterRegionItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeParameterRegionItem value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeParameterRegionItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  LocalizedName name,  String? kana,  List<EarthquakeParameterCityItem> cities)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeParameterRegionItem() when $default != null:
return $default(_that.code,_that.name,_that.kana,_that.cities);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  LocalizedName name,  String? kana,  List<EarthquakeParameterCityItem> cities)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeParameterRegionItem():
return $default(_that.code,_that.name,_that.kana,_that.cities);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  LocalizedName name,  String? kana,  List<EarthquakeParameterCityItem> cities)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeParameterRegionItem() when $default != null:
return $default(_that.code,_that.name,_that.kana,_that.cities);case _:
  return null;

}
}

}

/// @nodoc


class _EarthquakeParameterRegionItem implements EarthquakeParameterRegionItem {
  const _EarthquakeParameterRegionItem({required this.code, required this.name, required this.kana, required  List<EarthquakeParameterCityItem> cities}): _cities = cities;
  

@override final  String code;
@override final  LocalizedName name;
@override final  String? kana;
 final  List<EarthquakeParameterCityItem> _cities;
@override List<EarthquakeParameterCityItem> get cities {
  if (_cities is EqualUnmodifiableListView) return _cities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cities);
}


/// Create a copy of EarthquakeParameterRegionItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeParameterRegionItemCopyWith<_EarthquakeParameterRegionItem> get copyWith => __$EarthquakeParameterRegionItemCopyWithImpl<_EarthquakeParameterRegionItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeParameterRegionItem&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.kana, kana) || other.kana == kana)&&const DeepCollectionEquality().equals(other._cities, _cities));
}


@override
int get hashCode => Object.hash(runtimeType,code,name,kana,const DeepCollectionEquality().hash(_cities));

@override
String toString() {
  return 'EarthquakeParameterRegionItem(code: $code, name: $name, kana: $kana, cities: $cities)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeParameterRegionItemCopyWith<$Res> implements $EarthquakeParameterRegionItemCopyWith<$Res> {
  factory _$EarthquakeParameterRegionItemCopyWith(_EarthquakeParameterRegionItem value, $Res Function(_EarthquakeParameterRegionItem) _then) = __$EarthquakeParameterRegionItemCopyWithImpl;
@override @useResult
$Res call({
 String code, LocalizedName name, String? kana, List<EarthquakeParameterCityItem> cities
});


@override $LocalizedNameCopyWith<$Res> get name;

}
/// @nodoc
class __$EarthquakeParameterRegionItemCopyWithImpl<$Res>
    implements _$EarthquakeParameterRegionItemCopyWith<$Res> {
  __$EarthquakeParameterRegionItemCopyWithImpl(this._self, this._then);

  final _EarthquakeParameterRegionItem _self;
  final $Res Function(_EarthquakeParameterRegionItem) _then;

/// Create a copy of EarthquakeParameterRegionItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? kana = freezed,Object? cities = null,}) {
  return _then(_EarthquakeParameterRegionItem(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedName,kana: freezed == kana ? _self.kana : kana // ignore: cast_nullable_to_non_nullable
as String?,cities: null == cities ? _self._cities : cities // ignore: cast_nullable_to_non_nullable
as List<EarthquakeParameterCityItem>,
  ));
}

/// Create a copy of EarthquakeParameterRegionItem
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
mixin _$EarthquakeParameterCityItem {

 String get code; LocalizedName get name; String? get kana; List<EarthquakeParameterStationItem> get stations;
/// Create a copy of EarthquakeParameterCityItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeParameterCityItemCopyWith<EarthquakeParameterCityItem> get copyWith => _$EarthquakeParameterCityItemCopyWithImpl<EarthquakeParameterCityItem>(this as EarthquakeParameterCityItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeParameterCityItem&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.kana, kana) || other.kana == kana)&&const DeepCollectionEquality().equals(other.stations, stations));
}


@override
int get hashCode => Object.hash(runtimeType,code,name,kana,const DeepCollectionEquality().hash(stations));

@override
String toString() {
  return 'EarthquakeParameterCityItem(code: $code, name: $name, kana: $kana, stations: $stations)';
}


}

/// @nodoc
abstract mixin class $EarthquakeParameterCityItemCopyWith<$Res>  {
  factory $EarthquakeParameterCityItemCopyWith(EarthquakeParameterCityItem value, $Res Function(EarthquakeParameterCityItem) _then) = _$EarthquakeParameterCityItemCopyWithImpl;
@useResult
$Res call({
 String code, LocalizedName name, String? kana, List<EarthquakeParameterStationItem> stations
});


$LocalizedNameCopyWith<$Res> get name;

}
/// @nodoc
class _$EarthquakeParameterCityItemCopyWithImpl<$Res>
    implements $EarthquakeParameterCityItemCopyWith<$Res> {
  _$EarthquakeParameterCityItemCopyWithImpl(this._self, this._then);

  final EarthquakeParameterCityItem _self;
  final $Res Function(EarthquakeParameterCityItem) _then;

/// Create a copy of EarthquakeParameterCityItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? kana = freezed,Object? stations = null,}) {
  return _then(EarthquakeParameterCityItem(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedName,kana: freezed == kana ? _self.kana : kana // ignore: cast_nullable_to_non_nullable
as String?,stations: null == stations ? _self.stations : stations // ignore: cast_nullable_to_non_nullable
as List<EarthquakeParameterStationItem>,
  ));
}
/// Create a copy of EarthquakeParameterCityItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedNameCopyWith<$Res> get name {
  
  return $LocalizedNameCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}
}


/// Adds pattern-matching-related methods to [EarthquakeParameterCityItem].
extension EarthquakeParameterCityItemPatterns on EarthquakeParameterCityItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeParameterCityItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeParameterCityItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeParameterCityItem value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeParameterCityItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeParameterCityItem value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeParameterCityItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  LocalizedName name,  String? kana,  List<EarthquakeParameterStationItem> stations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeParameterCityItem() when $default != null:
return $default(_that.code,_that.name,_that.kana,_that.stations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  LocalizedName name,  String? kana,  List<EarthquakeParameterStationItem> stations)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeParameterCityItem():
return $default(_that.code,_that.name,_that.kana,_that.stations);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  LocalizedName name,  String? kana,  List<EarthquakeParameterStationItem> stations)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeParameterCityItem() when $default != null:
return $default(_that.code,_that.name,_that.kana,_that.stations);case _:
  return null;

}
}

}

/// @nodoc


class _EarthquakeParameterCityItem implements EarthquakeParameterCityItem {
  const _EarthquakeParameterCityItem({required this.code, required this.name, required this.kana, required  List<EarthquakeParameterStationItem> stations}): _stations = stations;
  

@override final  String code;
@override final  LocalizedName name;
@override final  String? kana;
 final  List<EarthquakeParameterStationItem> _stations;
@override List<EarthquakeParameterStationItem> get stations {
  if (_stations is EqualUnmodifiableListView) return _stations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stations);
}


/// Create a copy of EarthquakeParameterCityItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeParameterCityItemCopyWith<_EarthquakeParameterCityItem> get copyWith => __$EarthquakeParameterCityItemCopyWithImpl<_EarthquakeParameterCityItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeParameterCityItem&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.kana, kana) || other.kana == kana)&&const DeepCollectionEquality().equals(other._stations, _stations));
}


@override
int get hashCode => Object.hash(runtimeType,code,name,kana,const DeepCollectionEquality().hash(_stations));

@override
String toString() {
  return 'EarthquakeParameterCityItem(code: $code, name: $name, kana: $kana, stations: $stations)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeParameterCityItemCopyWith<$Res> implements $EarthquakeParameterCityItemCopyWith<$Res> {
  factory _$EarthquakeParameterCityItemCopyWith(_EarthquakeParameterCityItem value, $Res Function(_EarthquakeParameterCityItem) _then) = __$EarthquakeParameterCityItemCopyWithImpl;
@override @useResult
$Res call({
 String code, LocalizedName name, String? kana, List<EarthquakeParameterStationItem> stations
});


@override $LocalizedNameCopyWith<$Res> get name;

}
/// @nodoc
class __$EarthquakeParameterCityItemCopyWithImpl<$Res>
    implements _$EarthquakeParameterCityItemCopyWith<$Res> {
  __$EarthquakeParameterCityItemCopyWithImpl(this._self, this._then);

  final _EarthquakeParameterCityItem _self;
  final $Res Function(_EarthquakeParameterCityItem) _then;

/// Create a copy of EarthquakeParameterCityItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? kana = freezed,Object? stations = null,}) {
  return _then(_EarthquakeParameterCityItem(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedName,kana: freezed == kana ? _self.kana : kana // ignore: cast_nullable_to_non_nullable
as String?,stations: null == stations ? _self._stations : stations // ignore: cast_nullable_to_non_nullable
as List<EarthquakeParameterStationItem>,
  ));
}

/// Create a copy of EarthquakeParameterCityItem
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
mixin _$EarthquakeParameterStationItem {

 String get code; String get noCode; LocalizedName get name; String? get kana; EarthquakeStationStatus get status; String get sourceStatus; String get owner; LatLng get location; double? get arv400;
/// Create a copy of EarthquakeParameterStationItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeParameterStationItemCopyWith<EarthquakeParameterStationItem> get copyWith => _$EarthquakeParameterStationItemCopyWithImpl<EarthquakeParameterStationItem>(this as EarthquakeParameterStationItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeParameterStationItem&&(identical(other.code, code) || other.code == code)&&(identical(other.noCode, noCode) || other.noCode == noCode)&&(identical(other.name, name) || other.name == name)&&(identical(other.kana, kana) || other.kana == kana)&&(identical(other.status, status) || other.status == status)&&(identical(other.sourceStatus, sourceStatus) || other.sourceStatus == sourceStatus)&&(identical(other.owner, owner) || other.owner == owner)&&(identical(other.location, location) || other.location == location)&&(identical(other.arv400, arv400) || other.arv400 == arv400));
}


@override
int get hashCode => Object.hash(runtimeType,code,noCode,name,kana,status,sourceStatus,owner,location,arv400);

@override
String toString() {
  return 'EarthquakeParameterStationItem(code: $code, noCode: $noCode, name: $name, kana: $kana, status: $status, sourceStatus: $sourceStatus, owner: $owner, location: $location, arv400: $arv400)';
}


}

/// @nodoc
abstract mixin class $EarthquakeParameterStationItemCopyWith<$Res>  {
  factory $EarthquakeParameterStationItemCopyWith(EarthquakeParameterStationItem value, $Res Function(EarthquakeParameterStationItem) _then) = _$EarthquakeParameterStationItemCopyWithImpl;
@useResult
$Res call({
 String code, String noCode, LocalizedName name, String? kana, EarthquakeStationStatus status, String sourceStatus, String owner, LatLng location, double? arv400
});


$LocalizedNameCopyWith<$Res> get name;

}
/// @nodoc
class _$EarthquakeParameterStationItemCopyWithImpl<$Res>
    implements $EarthquakeParameterStationItemCopyWith<$Res> {
  _$EarthquakeParameterStationItemCopyWithImpl(this._self, this._then);

  final EarthquakeParameterStationItem _self;
  final $Res Function(EarthquakeParameterStationItem) _then;

/// Create a copy of EarthquakeParameterStationItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? noCode = null,Object? name = null,Object? kana = freezed,Object? status = null,Object? sourceStatus = null,Object? owner = null,Object? location = null,Object? arv400 = freezed,}) {
  return _then(EarthquakeParameterStationItem(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,noCode: null == noCode ? _self.noCode : noCode // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedName,kana: freezed == kana ? _self.kana : kana // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as EarthquakeStationStatus,sourceStatus: null == sourceStatus ? _self.sourceStatus : sourceStatus // ignore: cast_nullable_to_non_nullable
as String,owner: null == owner ? _self.owner : owner // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LatLng,arv400: freezed == arv400 ? _self.arv400 : arv400 // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}
/// Create a copy of EarthquakeParameterStationItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedNameCopyWith<$Res> get name {
  
  return $LocalizedNameCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}
}


/// Adds pattern-matching-related methods to [EarthquakeParameterStationItem].
extension EarthquakeParameterStationItemPatterns on EarthquakeParameterStationItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeParameterStationItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeParameterStationItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeParameterStationItem value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeParameterStationItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeParameterStationItem value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeParameterStationItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String noCode,  LocalizedName name,  String? kana,  EarthquakeStationStatus status,  String sourceStatus,  String owner,  LatLng location,  double? arv400)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeParameterStationItem() when $default != null:
return $default(_that.code,_that.noCode,_that.name,_that.kana,_that.status,_that.sourceStatus,_that.owner,_that.location,_that.arv400);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String noCode,  LocalizedName name,  String? kana,  EarthquakeStationStatus status,  String sourceStatus,  String owner,  LatLng location,  double? arv400)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeParameterStationItem():
return $default(_that.code,_that.noCode,_that.name,_that.kana,_that.status,_that.sourceStatus,_that.owner,_that.location,_that.arv400);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String noCode,  LocalizedName name,  String? kana,  EarthquakeStationStatus status,  String sourceStatus,  String owner,  LatLng location,  double? arv400)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeParameterStationItem() when $default != null:
return $default(_that.code,_that.noCode,_that.name,_that.kana,_that.status,_that.sourceStatus,_that.owner,_that.location,_that.arv400);case _:
  return null;

}
}

}

/// @nodoc


class _EarthquakeParameterStationItem implements EarthquakeParameterStationItem {
  const _EarthquakeParameterStationItem({required this.code, required this.noCode, required this.name, required this.kana, required this.status, required this.sourceStatus, required this.owner, required this.location, this.arv400});
  

@override final  String code;
@override final  String noCode;
@override final  LocalizedName name;
@override final  String? kana;
@override final  EarthquakeStationStatus status;
@override final  String sourceStatus;
@override final  String owner;
@override final  LatLng location;
@override final  double? arv400;

/// Create a copy of EarthquakeParameterStationItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeParameterStationItemCopyWith<_EarthquakeParameterStationItem> get copyWith => __$EarthquakeParameterStationItemCopyWithImpl<_EarthquakeParameterStationItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeParameterStationItem&&(identical(other.code, code) || other.code == code)&&(identical(other.noCode, noCode) || other.noCode == noCode)&&(identical(other.name, name) || other.name == name)&&(identical(other.kana, kana) || other.kana == kana)&&(identical(other.status, status) || other.status == status)&&(identical(other.sourceStatus, sourceStatus) || other.sourceStatus == sourceStatus)&&(identical(other.owner, owner) || other.owner == owner)&&(identical(other.location, location) || other.location == location)&&(identical(other.arv400, arv400) || other.arv400 == arv400));
}


@override
int get hashCode => Object.hash(runtimeType,code,noCode,name,kana,status,sourceStatus,owner,location,arv400);

@override
String toString() {
  return 'EarthquakeParameterStationItem(code: $code, noCode: $noCode, name: $name, kana: $kana, status: $status, sourceStatus: $sourceStatus, owner: $owner, location: $location, arv400: $arv400)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeParameterStationItemCopyWith<$Res> implements $EarthquakeParameterStationItemCopyWith<$Res> {
  factory _$EarthquakeParameterStationItemCopyWith(_EarthquakeParameterStationItem value, $Res Function(_EarthquakeParameterStationItem) _then) = __$EarthquakeParameterStationItemCopyWithImpl;
@override @useResult
$Res call({
 String code, String noCode, LocalizedName name, String? kana, EarthquakeStationStatus status, String sourceStatus, String owner, LatLng location, double? arv400
});


@override $LocalizedNameCopyWith<$Res> get name;

}
/// @nodoc
class __$EarthquakeParameterStationItemCopyWithImpl<$Res>
    implements _$EarthquakeParameterStationItemCopyWith<$Res> {
  __$EarthquakeParameterStationItemCopyWithImpl(this._self, this._then);

  final _EarthquakeParameterStationItem _self;
  final $Res Function(_EarthquakeParameterStationItem) _then;

/// Create a copy of EarthquakeParameterStationItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? noCode = null,Object? name = null,Object? kana = freezed,Object? status = null,Object? sourceStatus = null,Object? owner = null,Object? location = null,Object? arv400 = freezed,}) {
  return _then(_EarthquakeParameterStationItem(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,noCode: null == noCode ? _self.noCode : noCode // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedName,kana: freezed == kana ? _self.kana : kana // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as EarthquakeStationStatus,sourceStatus: null == sourceStatus ? _self.sourceStatus : sourceStatus // ignore: cast_nullable_to_non_nullable
as String,owner: null == owner ? _self.owner : owner // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LatLng,arv400: freezed == arv400 ? _self.arv400 : arv400 // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

/// Create a copy of EarthquakeParameterStationItem
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
