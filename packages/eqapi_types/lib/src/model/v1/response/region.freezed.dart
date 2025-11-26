// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'region.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RegionItem {

 int get id; int get eventId; String get areaCode; JmaIntensity get maxIntensity; JmaLgIntensity? get maxLpgmIntensity; EarthquakeV1Base get earthquake;
/// Create a copy of RegionItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegionItemCopyWith<RegionItem> get copyWith => _$RegionItemCopyWithImpl<RegionItem>(this as RegionItem, _$identity);

  /// Serializes this RegionItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegionItem&&(identical(other.id, id) || other.id == id)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.areaCode, areaCode) || other.areaCode == areaCode)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&(identical(other.maxLpgmIntensity, maxLpgmIntensity) || other.maxLpgmIntensity == maxLpgmIntensity)&&(identical(other.earthquake, earthquake) || other.earthquake == earthquake));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,eventId,areaCode,maxIntensity,maxLpgmIntensity,earthquake);

@override
String toString() {
  return 'RegionItem(id: $id, eventId: $eventId, areaCode: $areaCode, maxIntensity: $maxIntensity, maxLpgmIntensity: $maxLpgmIntensity, earthquake: $earthquake)';
}


}

/// @nodoc
abstract mixin class $RegionItemCopyWith<$Res>  {
  factory $RegionItemCopyWith(RegionItem value, $Res Function(RegionItem) _then) = _$RegionItemCopyWithImpl;
@useResult
$Res call({
 int id, int eventId, String areaCode, JmaIntensity maxIntensity, JmaLgIntensity? maxLpgmIntensity, EarthquakeV1Base earthquake
});


$EarthquakeV1BaseCopyWith<$Res> get earthquake;

}
/// @nodoc
class _$RegionItemCopyWithImpl<$Res>
    implements $RegionItemCopyWith<$Res> {
  _$RegionItemCopyWithImpl(this._self, this._then);

  final RegionItem _self;
  final $Res Function(RegionItem) _then;

/// Create a copy of RegionItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? eventId = null,Object? areaCode = null,Object? maxIntensity = null,Object? maxLpgmIntensity = freezed,Object? earthquake = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as int,areaCode: null == areaCode ? _self.areaCode : areaCode // ignore: cast_nullable_to_non_nullable
as String,maxIntensity: null == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity,maxLpgmIntensity: freezed == maxLpgmIntensity ? _self.maxLpgmIntensity : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLgIntensity?,earthquake: null == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as EarthquakeV1Base,
  ));
}
/// Create a copy of RegionItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeV1BaseCopyWith<$Res> get earthquake {
  
  return $EarthquakeV1BaseCopyWith<$Res>(_self.earthquake, (value) {
    return _then(_self.copyWith(earthquake: value));
  });
}
}


/// Adds pattern-matching-related methods to [RegionItem].
extension RegionItemPatterns on RegionItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegionItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegionItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegionItem value)  $default,){
final _that = this;
switch (_that) {
case _RegionItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegionItem value)?  $default,){
final _that = this;
switch (_that) {
case _RegionItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int eventId,  String areaCode,  JmaIntensity maxIntensity,  JmaLgIntensity? maxLpgmIntensity,  EarthquakeV1Base earthquake)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegionItem() when $default != null:
return $default(_that.id,_that.eventId,_that.areaCode,_that.maxIntensity,_that.maxLpgmIntensity,_that.earthquake);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int eventId,  String areaCode,  JmaIntensity maxIntensity,  JmaLgIntensity? maxLpgmIntensity,  EarthquakeV1Base earthquake)  $default,) {final _that = this;
switch (_that) {
case _RegionItem():
return $default(_that.id,_that.eventId,_that.areaCode,_that.maxIntensity,_that.maxLpgmIntensity,_that.earthquake);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int eventId,  String areaCode,  JmaIntensity maxIntensity,  JmaLgIntensity? maxLpgmIntensity,  EarthquakeV1Base earthquake)?  $default,) {final _that = this;
switch (_that) {
case _RegionItem() when $default != null:
return $default(_that.id,_that.eventId,_that.areaCode,_that.maxIntensity,_that.maxLpgmIntensity,_that.earthquake);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RegionItem implements RegionItem {
  const _RegionItem({required this.id, required this.eventId, required this.areaCode, required this.maxIntensity, required this.maxLpgmIntensity, required this.earthquake});
  factory _RegionItem.fromJson(Map<String, dynamic> json) => _$RegionItemFromJson(json);

@override final  int id;
@override final  int eventId;
@override final  String areaCode;
@override final  JmaIntensity maxIntensity;
@override final  JmaLgIntensity? maxLpgmIntensity;
@override final  EarthquakeV1Base earthquake;

/// Create a copy of RegionItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegionItemCopyWith<_RegionItem> get copyWith => __$RegionItemCopyWithImpl<_RegionItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RegionItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegionItem&&(identical(other.id, id) || other.id == id)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.areaCode, areaCode) || other.areaCode == areaCode)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&(identical(other.maxLpgmIntensity, maxLpgmIntensity) || other.maxLpgmIntensity == maxLpgmIntensity)&&(identical(other.earthquake, earthquake) || other.earthquake == earthquake));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,eventId,areaCode,maxIntensity,maxLpgmIntensity,earthquake);

@override
String toString() {
  return 'RegionItem(id: $id, eventId: $eventId, areaCode: $areaCode, maxIntensity: $maxIntensity, maxLpgmIntensity: $maxLpgmIntensity, earthquake: $earthquake)';
}


}

/// @nodoc
abstract mixin class _$RegionItemCopyWith<$Res> implements $RegionItemCopyWith<$Res> {
  factory _$RegionItemCopyWith(_RegionItem value, $Res Function(_RegionItem) _then) = __$RegionItemCopyWithImpl;
@override @useResult
$Res call({
 int id, int eventId, String areaCode, JmaIntensity maxIntensity, JmaLgIntensity? maxLpgmIntensity, EarthquakeV1Base earthquake
});


@override $EarthquakeV1BaseCopyWith<$Res> get earthquake;

}
/// @nodoc
class __$RegionItemCopyWithImpl<$Res>
    implements _$RegionItemCopyWith<$Res> {
  __$RegionItemCopyWithImpl(this._self, this._then);

  final _RegionItem _self;
  final $Res Function(_RegionItem) _then;

/// Create a copy of RegionItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? eventId = null,Object? areaCode = null,Object? maxIntensity = null,Object? maxLpgmIntensity = freezed,Object? earthquake = null,}) {
  return _then(_RegionItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as int,areaCode: null == areaCode ? _self.areaCode : areaCode // ignore: cast_nullable_to_non_nullable
as String,maxIntensity: null == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity,maxLpgmIntensity: freezed == maxLpgmIntensity ? _self.maxLpgmIntensity : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLgIntensity?,earthquake: null == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as EarthquakeV1Base,
  ));
}

/// Create a copy of RegionItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeV1BaseCopyWith<$Res> get earthquake {
  
  return $EarthquakeV1BaseCopyWith<$Res>(_self.earthquake, (value) {
    return _then(_self.copyWith(earthquake: value));
  });
}
}

// dart format on
