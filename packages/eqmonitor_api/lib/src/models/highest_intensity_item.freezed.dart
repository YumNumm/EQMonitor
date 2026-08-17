// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'highest_intensity_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HighestIntensityItem {

/// 地域コード（気象庁防災情報XMLフォーマット コード表）
 String get code;/// 地域名
 String get name; JmaIntensity get intensity;/// 同震度を観測した地震の件数
 int get count; EarthquakePartial get earthquake;
/// Create a copy of HighestIntensityItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HighestIntensityItemCopyWith<HighestIntensityItem> get copyWith => _$HighestIntensityItemCopyWithImpl<HighestIntensityItem>(this as HighestIntensityItem, _$identity);

  /// Serializes this HighestIntensityItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HighestIntensityItem&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.count, count) || other.count == count)&&(identical(other.earthquake, earthquake) || other.earthquake == earthquake));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,intensity,count,earthquake);

@override
String toString() {
  return 'HighestIntensityItem(code: $code, name: $name, intensity: $intensity, count: $count, earthquake: $earthquake)';
}


}

/// @nodoc
abstract mixin class $HighestIntensityItemCopyWith<$Res>  {
  factory $HighestIntensityItemCopyWith(HighestIntensityItem value, $Res Function(HighestIntensityItem) _then) = _$HighestIntensityItemCopyWithImpl;
@useResult
$Res call({
 String code, String name, JmaIntensity intensity, int count, EarthquakePartial earthquake
});


$EarthquakePartialCopyWith<$Res> get earthquake;

}
/// @nodoc
class _$HighestIntensityItemCopyWithImpl<$Res>
    implements $HighestIntensityItemCopyWith<$Res> {
  _$HighestIntensityItemCopyWithImpl(this._self, this._then);

  final HighestIntensityItem _self;
  final $Res Function(HighestIntensityItem) _then;

/// Create a copy of HighestIntensityItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? intensity = null,Object? count = null,Object? earthquake = null,}) {
  return _then(HighestIntensityItem(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,earthquake: null == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as EarthquakePartial,
  ));
}
/// Create a copy of HighestIntensityItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakePartialCopyWith<$Res> get earthquake {
  
  return $EarthquakePartialCopyWith<$Res>(_self.earthquake, (value) {
    return _then(_self.copyWith(earthquake: value));
  });
}
}


/// Adds pattern-matching-related methods to [HighestIntensityItem].
extension HighestIntensityItemPatterns on HighestIntensityItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HighestIntensityItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HighestIntensityItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HighestIntensityItem value)  $default,){
final _that = this;
switch (_that) {
case _HighestIntensityItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HighestIntensityItem value)?  $default,){
final _that = this;
switch (_that) {
case _HighestIntensityItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String name,  JmaIntensity intensity,  int count,  EarthquakePartial earthquake)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HighestIntensityItem() when $default != null:
return $default(_that.code,_that.name,_that.intensity,_that.count,_that.earthquake);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String name,  JmaIntensity intensity,  int count,  EarthquakePartial earthquake)  $default,) {final _that = this;
switch (_that) {
case _HighestIntensityItem():
return $default(_that.code,_that.name,_that.intensity,_that.count,_that.earthquake);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String name,  JmaIntensity intensity,  int count,  EarthquakePartial earthquake)?  $default,) {final _that = this;
switch (_that) {
case _HighestIntensityItem() when $default != null:
return $default(_that.code,_that.name,_that.intensity,_that.count,_that.earthquake);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HighestIntensityItem implements HighestIntensityItem {
  const _HighestIntensityItem({required this.code, required this.name, required this.intensity, required this.count, required this.earthquake});
  factory _HighestIntensityItem.fromJson(Map<String, dynamic> json) => _$HighestIntensityItemFromJson(json);

/// 地域コード（気象庁防災情報XMLフォーマット コード表）
@override final  String code;
/// 地域名
@override final  String name;
@override final  JmaIntensity intensity;
/// 同震度を観測した地震の件数
@override final  int count;
@override final  EarthquakePartial earthquake;

/// Create a copy of HighestIntensityItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HighestIntensityItemCopyWith<_HighestIntensityItem> get copyWith => __$HighestIntensityItemCopyWithImpl<_HighestIntensityItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HighestIntensityItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HighestIntensityItem&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.count, count) || other.count == count)&&(identical(other.earthquake, earthquake) || other.earthquake == earthquake));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,intensity,count,earthquake);

@override
String toString() {
  return 'HighestIntensityItem(code: $code, name: $name, intensity: $intensity, count: $count, earthquake: $earthquake)';
}


}

/// @nodoc
abstract mixin class _$HighestIntensityItemCopyWith<$Res> implements $HighestIntensityItemCopyWith<$Res> {
  factory _$HighestIntensityItemCopyWith(_HighestIntensityItem value, $Res Function(_HighestIntensityItem) _then) = __$HighestIntensityItemCopyWithImpl;
@override @useResult
$Res call({
 String code, String name, JmaIntensity intensity, int count, EarthquakePartial earthquake
});


@override $EarthquakePartialCopyWith<$Res> get earthquake;

}
/// @nodoc
class __$HighestIntensityItemCopyWithImpl<$Res>
    implements _$HighestIntensityItemCopyWith<$Res> {
  __$HighestIntensityItemCopyWithImpl(this._self, this._then);

  final _HighestIntensityItem _self;
  final $Res Function(_HighestIntensityItem) _then;

/// Create a copy of HighestIntensityItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? intensity = null,Object? count = null,Object? earthquake = null,}) {
  return _then(_HighestIntensityItem(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,earthquake: null == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as EarthquakePartial,
  ));
}

/// Create a copy of HighestIntensityItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakePartialCopyWith<$Res> get earthquake {
  
  return $EarthquakePartialCopyWith<$Res>(_self.earthquake, (value) {
    return _then(_self.copyWith(earthquake: value));
  });
}
}

// dart format on
