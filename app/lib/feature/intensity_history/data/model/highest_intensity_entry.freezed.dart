// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'highest_intensity_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HighestIntensityEntry {

/// 気象庁防災情報XMLフォーマットの地域コード。
 String get code;/// 地域名。
 String get name;/// 過去最高震度。
 JmaIntensity get intensity;/// 同震度を観測した地震の件数。
 int get count;/// 最高震度を観測した直近の地震イベント。
 EarthquakePartial get earthquake;
/// Create a copy of HighestIntensityEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HighestIntensityEntryCopyWith<HighestIntensityEntry> get copyWith => _$HighestIntensityEntryCopyWithImpl<HighestIntensityEntry>(this as HighestIntensityEntry, _$identity);

  /// Serializes this HighestIntensityEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HighestIntensityEntry&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.count, count) || other.count == count)&&(identical(other.earthquake, earthquake) || other.earthquake == earthquake));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,intensity,count,earthquake);

@override
String toString() {
  return 'HighestIntensityEntry(code: $code, name: $name, intensity: $intensity, count: $count, earthquake: $earthquake)';
}


}

/// @nodoc
abstract mixin class $HighestIntensityEntryCopyWith<$Res>  {
  factory $HighestIntensityEntryCopyWith(HighestIntensityEntry value, $Res Function(HighestIntensityEntry) _then) = _$HighestIntensityEntryCopyWithImpl;
@useResult
$Res call({
 String code, String name, JmaIntensity intensity, int count, EarthquakePartial earthquake
});


$EarthquakePartialCopyWith<$Res> get earthquake;

}
/// @nodoc
class _$HighestIntensityEntryCopyWithImpl<$Res>
    implements $HighestIntensityEntryCopyWith<$Res> {
  _$HighestIntensityEntryCopyWithImpl(this._self, this._then);

  final HighestIntensityEntry _self;
  final $Res Function(HighestIntensityEntry) _then;

/// Create a copy of HighestIntensityEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? intensity = null,Object? count = null,Object? earthquake = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,earthquake: null == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as EarthquakePartial,
  ));
}
/// Create a copy of HighestIntensityEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakePartialCopyWith<$Res> get earthquake {
  
  return $EarthquakePartialCopyWith<$Res>(_self.earthquake, (value) {
    return _then(_self.copyWith(earthquake: value));
  });
}
}


/// Adds pattern-matching-related methods to [HighestIntensityEntry].
extension HighestIntensityEntryPatterns on HighestIntensityEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HighestIntensityEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HighestIntensityEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HighestIntensityEntry value)  $default,){
final _that = this;
switch (_that) {
case _HighestIntensityEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HighestIntensityEntry value)?  $default,){
final _that = this;
switch (_that) {
case _HighestIntensityEntry() when $default != null:
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
case _HighestIntensityEntry() when $default != null:
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
case _HighestIntensityEntry():
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
case _HighestIntensityEntry() when $default != null:
return $default(_that.code,_that.name,_that.intensity,_that.count,_that.earthquake);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HighestIntensityEntry extends HighestIntensityEntry {
  const _HighestIntensityEntry({required this.code, required this.name, required this.intensity, required this.count, required this.earthquake}): super._();
  factory _HighestIntensityEntry.fromJson(Map<String, dynamic> json) => _$HighestIntensityEntryFromJson(json);

/// 気象庁防災情報XMLフォーマットの地域コード。
@override final  String code;
/// 地域名。
@override final  String name;
/// 過去最高震度。
@override final  JmaIntensity intensity;
/// 同震度を観測した地震の件数。
@override final  int count;
/// 最高震度を観測した直近の地震イベント。
@override final  EarthquakePartial earthquake;

/// Create a copy of HighestIntensityEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HighestIntensityEntryCopyWith<_HighestIntensityEntry> get copyWith => __$HighestIntensityEntryCopyWithImpl<_HighestIntensityEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HighestIntensityEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HighestIntensityEntry&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.count, count) || other.count == count)&&(identical(other.earthquake, earthquake) || other.earthquake == earthquake));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,intensity,count,earthquake);

@override
String toString() {
  return 'HighestIntensityEntry(code: $code, name: $name, intensity: $intensity, count: $count, earthquake: $earthquake)';
}


}

/// @nodoc
abstract mixin class _$HighestIntensityEntryCopyWith<$Res> implements $HighestIntensityEntryCopyWith<$Res> {
  factory _$HighestIntensityEntryCopyWith(_HighestIntensityEntry value, $Res Function(_HighestIntensityEntry) _then) = __$HighestIntensityEntryCopyWithImpl;
@override @useResult
$Res call({
 String code, String name, JmaIntensity intensity, int count, EarthquakePartial earthquake
});


@override $EarthquakePartialCopyWith<$Res> get earthquake;

}
/// @nodoc
class __$HighestIntensityEntryCopyWithImpl<$Res>
    implements _$HighestIntensityEntryCopyWith<$Res> {
  __$HighestIntensityEntryCopyWithImpl(this._self, this._then);

  final _HighestIntensityEntry _self;
  final $Res Function(_HighestIntensityEntry) _then;

/// Create a copy of HighestIntensityEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? intensity = null,Object? count = null,Object? earthquake = null,}) {
  return _then(_HighestIntensityEntry(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,earthquake: null == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as EarthquakePartial,
  ));
}

/// Create a copy of HighestIntensityEntry
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
