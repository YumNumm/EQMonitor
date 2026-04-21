// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_list_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TsunamiListItem {

 String get id;@JsonKey(name: 'event_ids') List<String> get eventIds;@JsonKey(name: 'is_canceled') bool get isCanceled;@JsonKey(name: 'forecast_region_count') num get forecastRegionCount;@JsonKey(name: 'telegram_count') num get telegramCount;@JsonKey(name: 'telegram_types') List<TelegramTypes> get telegramTypes;@JsonKey(includeIfNull: false) String? get headline;@JsonKey(includeIfNull: false, name: 'latest_created_at') String? get latestCreatedAt;@JsonKey(includeIfNull: false, name: 'latest_press_at') String? get latestPressAt;@JsonKey(includeIfNull: false) Status? get status;@JsonKey(includeIfNull: false, name: 'max_forecast_grade') TsunamiWarningKind? get maxForecastGrade;@JsonKey(includeIfNull: false, name: 'earthquake_hypocenter_name') String? get earthquakeHypocenterName;@JsonKey(includeIfNull: false, name: 'earthquake_origin_time') String? get earthquakeOriginTime;@JsonKey(includeIfNull: false, name: 'earthquake_magnitude') num? get earthquakeMagnitude;
/// Create a copy of TsunamiListItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiListItemCopyWith<TsunamiListItem> get copyWith => _$TsunamiListItemCopyWithImpl<TsunamiListItem>(this as TsunamiListItem, _$identity);

  /// Serializes this TsunamiListItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiListItem&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.eventIds, eventIds)&&(identical(other.isCanceled, isCanceled) || other.isCanceled == isCanceled)&&(identical(other.forecastRegionCount, forecastRegionCount) || other.forecastRegionCount == forecastRegionCount)&&(identical(other.telegramCount, telegramCount) || other.telegramCount == telegramCount)&&const DeepCollectionEquality().equals(other.telegramTypes, telegramTypes)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.latestCreatedAt, latestCreatedAt) || other.latestCreatedAt == latestCreatedAt)&&(identical(other.latestPressAt, latestPressAt) || other.latestPressAt == latestPressAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.maxForecastGrade, maxForecastGrade) || other.maxForecastGrade == maxForecastGrade)&&(identical(other.earthquakeHypocenterName, earthquakeHypocenterName) || other.earthquakeHypocenterName == earthquakeHypocenterName)&&(identical(other.earthquakeOriginTime, earthquakeOriginTime) || other.earthquakeOriginTime == earthquakeOriginTime)&&(identical(other.earthquakeMagnitude, earthquakeMagnitude) || other.earthquakeMagnitude == earthquakeMagnitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(eventIds),isCanceled,forecastRegionCount,telegramCount,const DeepCollectionEquality().hash(telegramTypes),headline,latestCreatedAt,latestPressAt,status,maxForecastGrade,earthquakeHypocenterName,earthquakeOriginTime,earthquakeMagnitude);

@override
String toString() {
  return 'TsunamiListItem(id: $id, eventIds: $eventIds, isCanceled: $isCanceled, forecastRegionCount: $forecastRegionCount, telegramCount: $telegramCount, telegramTypes: $telegramTypes, headline: $headline, latestCreatedAt: $latestCreatedAt, latestPressAt: $latestPressAt, status: $status, maxForecastGrade: $maxForecastGrade, earthquakeHypocenterName: $earthquakeHypocenterName, earthquakeOriginTime: $earthquakeOriginTime, earthquakeMagnitude: $earthquakeMagnitude)';
}


}

/// @nodoc
abstract mixin class $TsunamiListItemCopyWith<$Res>  {
  factory $TsunamiListItemCopyWith(TsunamiListItem value, $Res Function(TsunamiListItem) _then) = _$TsunamiListItemCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'event_ids') List<String> eventIds,@JsonKey(name: 'is_canceled') bool isCanceled,@JsonKey(name: 'forecast_region_count') num forecastRegionCount,@JsonKey(name: 'telegram_count') num telegramCount,@JsonKey(name: 'telegram_types') List<TelegramTypes> telegramTypes,@JsonKey(includeIfNull: false) String? headline,@JsonKey(includeIfNull: false, name: 'latest_created_at') String? latestCreatedAt,@JsonKey(includeIfNull: false, name: 'latest_press_at') String? latestPressAt,@JsonKey(includeIfNull: false) Status? status,@JsonKey(includeIfNull: false, name: 'max_forecast_grade') TsunamiWarningKind? maxForecastGrade,@JsonKey(includeIfNull: false, name: 'earthquake_hypocenter_name') String? earthquakeHypocenterName,@JsonKey(includeIfNull: false, name: 'earthquake_origin_time') String? earthquakeOriginTime,@JsonKey(includeIfNull: false, name: 'earthquake_magnitude') num? earthquakeMagnitude
});




}
/// @nodoc
class _$TsunamiListItemCopyWithImpl<$Res>
    implements $TsunamiListItemCopyWith<$Res> {
  _$TsunamiListItemCopyWithImpl(this._self, this._then);

  final TsunamiListItem _self;
  final $Res Function(TsunamiListItem) _then;

/// Create a copy of TsunamiListItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? eventIds = null,Object? isCanceled = null,Object? forecastRegionCount = null,Object? telegramCount = null,Object? telegramTypes = null,Object? headline = freezed,Object? latestCreatedAt = freezed,Object? latestPressAt = freezed,Object? status = freezed,Object? maxForecastGrade = freezed,Object? earthquakeHypocenterName = freezed,Object? earthquakeOriginTime = freezed,Object? earthquakeMagnitude = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,eventIds: null == eventIds ? _self.eventIds : eventIds // ignore: cast_nullable_to_non_nullable
as List<String>,isCanceled: null == isCanceled ? _self.isCanceled : isCanceled // ignore: cast_nullable_to_non_nullable
as bool,forecastRegionCount: null == forecastRegionCount ? _self.forecastRegionCount : forecastRegionCount // ignore: cast_nullable_to_non_nullable
as num,telegramCount: null == telegramCount ? _self.telegramCount : telegramCount // ignore: cast_nullable_to_non_nullable
as num,telegramTypes: null == telegramTypes ? _self.telegramTypes : telegramTypes // ignore: cast_nullable_to_non_nullable
as List<TelegramTypes>,headline: freezed == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String?,latestCreatedAt: freezed == latestCreatedAt ? _self.latestCreatedAt : latestCreatedAt // ignore: cast_nullable_to_non_nullable
as String?,latestPressAt: freezed == latestPressAt ? _self.latestPressAt : latestPressAt // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as Status?,maxForecastGrade: freezed == maxForecastGrade ? _self.maxForecastGrade : maxForecastGrade // ignore: cast_nullable_to_non_nullable
as TsunamiWarningKind?,earthquakeHypocenterName: freezed == earthquakeHypocenterName ? _self.earthquakeHypocenterName : earthquakeHypocenterName // ignore: cast_nullable_to_non_nullable
as String?,earthquakeOriginTime: freezed == earthquakeOriginTime ? _self.earthquakeOriginTime : earthquakeOriginTime // ignore: cast_nullable_to_non_nullable
as String?,earthquakeMagnitude: freezed == earthquakeMagnitude ? _self.earthquakeMagnitude : earthquakeMagnitude // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}

}


/// Adds pattern-matching-related methods to [TsunamiListItem].
extension TsunamiListItemPatterns on TsunamiListItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiListItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiListItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiListItem value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiListItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiListItem value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiListItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'event_ids')  List<String> eventIds, @JsonKey(name: 'is_canceled')  bool isCanceled, @JsonKey(name: 'forecast_region_count')  num forecastRegionCount, @JsonKey(name: 'telegram_count')  num telegramCount, @JsonKey(name: 'telegram_types')  List<TelegramTypes> telegramTypes, @JsonKey(includeIfNull: false)  String? headline, @JsonKey(includeIfNull: false, name: 'latest_created_at')  String? latestCreatedAt, @JsonKey(includeIfNull: false, name: 'latest_press_at')  String? latestPressAt, @JsonKey(includeIfNull: false)  Status? status, @JsonKey(includeIfNull: false, name: 'max_forecast_grade')  TsunamiWarningKind? maxForecastGrade, @JsonKey(includeIfNull: false, name: 'earthquake_hypocenter_name')  String? earthquakeHypocenterName, @JsonKey(includeIfNull: false, name: 'earthquake_origin_time')  String? earthquakeOriginTime, @JsonKey(includeIfNull: false, name: 'earthquake_magnitude')  num? earthquakeMagnitude)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiListItem() when $default != null:
return $default(_that.id,_that.eventIds,_that.isCanceled,_that.forecastRegionCount,_that.telegramCount,_that.telegramTypes,_that.headline,_that.latestCreatedAt,_that.latestPressAt,_that.status,_that.maxForecastGrade,_that.earthquakeHypocenterName,_that.earthquakeOriginTime,_that.earthquakeMagnitude);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'event_ids')  List<String> eventIds, @JsonKey(name: 'is_canceled')  bool isCanceled, @JsonKey(name: 'forecast_region_count')  num forecastRegionCount, @JsonKey(name: 'telegram_count')  num telegramCount, @JsonKey(name: 'telegram_types')  List<TelegramTypes> telegramTypes, @JsonKey(includeIfNull: false)  String? headline, @JsonKey(includeIfNull: false, name: 'latest_created_at')  String? latestCreatedAt, @JsonKey(includeIfNull: false, name: 'latest_press_at')  String? latestPressAt, @JsonKey(includeIfNull: false)  Status? status, @JsonKey(includeIfNull: false, name: 'max_forecast_grade')  TsunamiWarningKind? maxForecastGrade, @JsonKey(includeIfNull: false, name: 'earthquake_hypocenter_name')  String? earthquakeHypocenterName, @JsonKey(includeIfNull: false, name: 'earthquake_origin_time')  String? earthquakeOriginTime, @JsonKey(includeIfNull: false, name: 'earthquake_magnitude')  num? earthquakeMagnitude)  $default,) {final _that = this;
switch (_that) {
case _TsunamiListItem():
return $default(_that.id,_that.eventIds,_that.isCanceled,_that.forecastRegionCount,_that.telegramCount,_that.telegramTypes,_that.headline,_that.latestCreatedAt,_that.latestPressAt,_that.status,_that.maxForecastGrade,_that.earthquakeHypocenterName,_that.earthquakeOriginTime,_that.earthquakeMagnitude);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'event_ids')  List<String> eventIds, @JsonKey(name: 'is_canceled')  bool isCanceled, @JsonKey(name: 'forecast_region_count')  num forecastRegionCount, @JsonKey(name: 'telegram_count')  num telegramCount, @JsonKey(name: 'telegram_types')  List<TelegramTypes> telegramTypes, @JsonKey(includeIfNull: false)  String? headline, @JsonKey(includeIfNull: false, name: 'latest_created_at')  String? latestCreatedAt, @JsonKey(includeIfNull: false, name: 'latest_press_at')  String? latestPressAt, @JsonKey(includeIfNull: false)  Status? status, @JsonKey(includeIfNull: false, name: 'max_forecast_grade')  TsunamiWarningKind? maxForecastGrade, @JsonKey(includeIfNull: false, name: 'earthquake_hypocenter_name')  String? earthquakeHypocenterName, @JsonKey(includeIfNull: false, name: 'earthquake_origin_time')  String? earthquakeOriginTime, @JsonKey(includeIfNull: false, name: 'earthquake_magnitude')  num? earthquakeMagnitude)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiListItem() when $default != null:
return $default(_that.id,_that.eventIds,_that.isCanceled,_that.forecastRegionCount,_that.telegramCount,_that.telegramTypes,_that.headline,_that.latestCreatedAt,_that.latestPressAt,_that.status,_that.maxForecastGrade,_that.earthquakeHypocenterName,_that.earthquakeOriginTime,_that.earthquakeMagnitude);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TsunamiListItem implements TsunamiListItem {
  const _TsunamiListItem({required this.id, @JsonKey(name: 'event_ids') required final  List<String> eventIds, @JsonKey(name: 'is_canceled') required this.isCanceled, @JsonKey(name: 'forecast_region_count') required this.forecastRegionCount, @JsonKey(name: 'telegram_count') required this.telegramCount, @JsonKey(name: 'telegram_types') required final  List<TelegramTypes> telegramTypes, @JsonKey(includeIfNull: false) this.headline, @JsonKey(includeIfNull: false, name: 'latest_created_at') this.latestCreatedAt, @JsonKey(includeIfNull: false, name: 'latest_press_at') this.latestPressAt, @JsonKey(includeIfNull: false) this.status, @JsonKey(includeIfNull: false, name: 'max_forecast_grade') this.maxForecastGrade, @JsonKey(includeIfNull: false, name: 'earthquake_hypocenter_name') this.earthquakeHypocenterName, @JsonKey(includeIfNull: false, name: 'earthquake_origin_time') this.earthquakeOriginTime, @JsonKey(includeIfNull: false, name: 'earthquake_magnitude') this.earthquakeMagnitude}): _eventIds = eventIds,_telegramTypes = telegramTypes;
  factory _TsunamiListItem.fromJson(Map<String, dynamic> json) => _$TsunamiListItemFromJson(json);

@override final  String id;
 final  List<String> _eventIds;
@override@JsonKey(name: 'event_ids') List<String> get eventIds {
  if (_eventIds is EqualUnmodifiableListView) return _eventIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_eventIds);
}

@override@JsonKey(name: 'is_canceled') final  bool isCanceled;
@override@JsonKey(name: 'forecast_region_count') final  num forecastRegionCount;
@override@JsonKey(name: 'telegram_count') final  num telegramCount;
 final  List<TelegramTypes> _telegramTypes;
@override@JsonKey(name: 'telegram_types') List<TelegramTypes> get telegramTypes {
  if (_telegramTypes is EqualUnmodifiableListView) return _telegramTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_telegramTypes);
}

@override@JsonKey(includeIfNull: false) final  String? headline;
@override@JsonKey(includeIfNull: false, name: 'latest_created_at') final  String? latestCreatedAt;
@override@JsonKey(includeIfNull: false, name: 'latest_press_at') final  String? latestPressAt;
@override@JsonKey(includeIfNull: false) final  Status? status;
@override@JsonKey(includeIfNull: false, name: 'max_forecast_grade') final  TsunamiWarningKind? maxForecastGrade;
@override@JsonKey(includeIfNull: false, name: 'earthquake_hypocenter_name') final  String? earthquakeHypocenterName;
@override@JsonKey(includeIfNull: false, name: 'earthquake_origin_time') final  String? earthquakeOriginTime;
@override@JsonKey(includeIfNull: false, name: 'earthquake_magnitude') final  num? earthquakeMagnitude;

/// Create a copy of TsunamiListItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiListItemCopyWith<_TsunamiListItem> get copyWith => __$TsunamiListItemCopyWithImpl<_TsunamiListItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiListItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiListItem&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other._eventIds, _eventIds)&&(identical(other.isCanceled, isCanceled) || other.isCanceled == isCanceled)&&(identical(other.forecastRegionCount, forecastRegionCount) || other.forecastRegionCount == forecastRegionCount)&&(identical(other.telegramCount, telegramCount) || other.telegramCount == telegramCount)&&const DeepCollectionEquality().equals(other._telegramTypes, _telegramTypes)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.latestCreatedAt, latestCreatedAt) || other.latestCreatedAt == latestCreatedAt)&&(identical(other.latestPressAt, latestPressAt) || other.latestPressAt == latestPressAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.maxForecastGrade, maxForecastGrade) || other.maxForecastGrade == maxForecastGrade)&&(identical(other.earthquakeHypocenterName, earthquakeHypocenterName) || other.earthquakeHypocenterName == earthquakeHypocenterName)&&(identical(other.earthquakeOriginTime, earthquakeOriginTime) || other.earthquakeOriginTime == earthquakeOriginTime)&&(identical(other.earthquakeMagnitude, earthquakeMagnitude) || other.earthquakeMagnitude == earthquakeMagnitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(_eventIds),isCanceled,forecastRegionCount,telegramCount,const DeepCollectionEquality().hash(_telegramTypes),headline,latestCreatedAt,latestPressAt,status,maxForecastGrade,earthquakeHypocenterName,earthquakeOriginTime,earthquakeMagnitude);

@override
String toString() {
  return 'TsunamiListItem(id: $id, eventIds: $eventIds, isCanceled: $isCanceled, forecastRegionCount: $forecastRegionCount, telegramCount: $telegramCount, telegramTypes: $telegramTypes, headline: $headline, latestCreatedAt: $latestCreatedAt, latestPressAt: $latestPressAt, status: $status, maxForecastGrade: $maxForecastGrade, earthquakeHypocenterName: $earthquakeHypocenterName, earthquakeOriginTime: $earthquakeOriginTime, earthquakeMagnitude: $earthquakeMagnitude)';
}


}

/// @nodoc
abstract mixin class _$TsunamiListItemCopyWith<$Res> implements $TsunamiListItemCopyWith<$Res> {
  factory _$TsunamiListItemCopyWith(_TsunamiListItem value, $Res Function(_TsunamiListItem) _then) = __$TsunamiListItemCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'event_ids') List<String> eventIds,@JsonKey(name: 'is_canceled') bool isCanceled,@JsonKey(name: 'forecast_region_count') num forecastRegionCount,@JsonKey(name: 'telegram_count') num telegramCount,@JsonKey(name: 'telegram_types') List<TelegramTypes> telegramTypes,@JsonKey(includeIfNull: false) String? headline,@JsonKey(includeIfNull: false, name: 'latest_created_at') String? latestCreatedAt,@JsonKey(includeIfNull: false, name: 'latest_press_at') String? latestPressAt,@JsonKey(includeIfNull: false) Status? status,@JsonKey(includeIfNull: false, name: 'max_forecast_grade') TsunamiWarningKind? maxForecastGrade,@JsonKey(includeIfNull: false, name: 'earthquake_hypocenter_name') String? earthquakeHypocenterName,@JsonKey(includeIfNull: false, name: 'earthquake_origin_time') String? earthquakeOriginTime,@JsonKey(includeIfNull: false, name: 'earthquake_magnitude') num? earthquakeMagnitude
});




}
/// @nodoc
class __$TsunamiListItemCopyWithImpl<$Res>
    implements _$TsunamiListItemCopyWith<$Res> {
  __$TsunamiListItemCopyWithImpl(this._self, this._then);

  final _TsunamiListItem _self;
  final $Res Function(_TsunamiListItem) _then;

/// Create a copy of TsunamiListItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? eventIds = null,Object? isCanceled = null,Object? forecastRegionCount = null,Object? telegramCount = null,Object? telegramTypes = null,Object? headline = freezed,Object? latestCreatedAt = freezed,Object? latestPressAt = freezed,Object? status = freezed,Object? maxForecastGrade = freezed,Object? earthquakeHypocenterName = freezed,Object? earthquakeOriginTime = freezed,Object? earthquakeMagnitude = freezed,}) {
  return _then(_TsunamiListItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,eventIds: null == eventIds ? _self._eventIds : eventIds // ignore: cast_nullable_to_non_nullable
as List<String>,isCanceled: null == isCanceled ? _self.isCanceled : isCanceled // ignore: cast_nullable_to_non_nullable
as bool,forecastRegionCount: null == forecastRegionCount ? _self.forecastRegionCount : forecastRegionCount // ignore: cast_nullable_to_non_nullable
as num,telegramCount: null == telegramCount ? _self.telegramCount : telegramCount // ignore: cast_nullable_to_non_nullable
as num,telegramTypes: null == telegramTypes ? _self._telegramTypes : telegramTypes // ignore: cast_nullable_to_non_nullable
as List<TelegramTypes>,headline: freezed == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String?,latestCreatedAt: freezed == latestCreatedAt ? _self.latestCreatedAt : latestCreatedAt // ignore: cast_nullable_to_non_nullable
as String?,latestPressAt: freezed == latestPressAt ? _self.latestPressAt : latestPressAt // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as Status?,maxForecastGrade: freezed == maxForecastGrade ? _self.maxForecastGrade : maxForecastGrade // ignore: cast_nullable_to_non_nullable
as TsunamiWarningKind?,earthquakeHypocenterName: freezed == earthquakeHypocenterName ? _self.earthquakeHypocenterName : earthquakeHypocenterName // ignore: cast_nullable_to_non_nullable
as String?,earthquakeOriginTime: freezed == earthquakeOriginTime ? _self.earthquakeOriginTime : earthquakeOriginTime // ignore: cast_nullable_to_non_nullable
as String?,earthquakeMagnitude: freezed == earthquakeMagnitude ? _self.earthquakeMagnitude : earthquakeMagnitude // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}


}

// dart format on
