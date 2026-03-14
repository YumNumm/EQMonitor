// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_search_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PaginatedSearchResponse<T> {

 List<T> get items; String? get nextToken;
/// Create a copy of PaginatedSearchResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaginatedSearchResponseCopyWith<T, PaginatedSearchResponse<T>> get copyWith => _$PaginatedSearchResponseCopyWithImpl<T, PaginatedSearchResponse<T>>(this as PaginatedSearchResponse<T>, _$identity);

  /// Serializes this PaginatedSearchResponse to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT);


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaginatedSearchResponse<T>&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.nextToken, nextToken) || other.nextToken == nextToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),nextToken);

@override
String toString() {
  return 'PaginatedSearchResponse<$T>(items: $items, nextToken: $nextToken)';
}


}

/// @nodoc
abstract mixin class $PaginatedSearchResponseCopyWith<T,$Res>  {
  factory $PaginatedSearchResponseCopyWith(PaginatedSearchResponse<T> value, $Res Function(PaginatedSearchResponse<T>) _then) = _$PaginatedSearchResponseCopyWithImpl;
@useResult
$Res call({
 List<T> items, String? nextToken
});




}
/// @nodoc
class _$PaginatedSearchResponseCopyWithImpl<T,$Res>
    implements $PaginatedSearchResponseCopyWith<T, $Res> {
  _$PaginatedSearchResponseCopyWithImpl(this._self, this._then);

  final PaginatedSearchResponse<T> _self;
  final $Res Function(PaginatedSearchResponse<T>) _then;

/// Create a copy of PaginatedSearchResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? nextToken = freezed,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<T>,nextToken: freezed == nextToken ? _self.nextToken : nextToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PaginatedSearchResponse].
extension PaginatedSearchResponsePatterns<T> on PaginatedSearchResponse<T> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaginatedSearchResponse<T> value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaginatedSearchResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaginatedSearchResponse<T> value)  $default,){
final _that = this;
switch (_that) {
case _PaginatedSearchResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaginatedSearchResponse<T> value)?  $default,){
final _that = this;
switch (_that) {
case _PaginatedSearchResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<T> items,  String? nextToken)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaginatedSearchResponse() when $default != null:
return $default(_that.items,_that.nextToken);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<T> items,  String? nextToken)  $default,) {final _that = this;
switch (_that) {
case _PaginatedSearchResponse():
return $default(_that.items,_that.nextToken);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<T> items,  String? nextToken)?  $default,) {final _that = this;
switch (_that) {
case _PaginatedSearchResponse() when $default != null:
return $default(_that.items,_that.nextToken);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)

class _PaginatedSearchResponse<T> implements PaginatedSearchResponse<T> {
  const _PaginatedSearchResponse({required final  List<T> items, required this.nextToken}): _items = items;
  factory _PaginatedSearchResponse.fromJson(Map<String, dynamic> json,T Function(Object?) fromJsonT) => _$PaginatedSearchResponseFromJson(json,fromJsonT);

 final  List<T> _items;
@override List<T> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  String? nextToken;

/// Create a copy of PaginatedSearchResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaginatedSearchResponseCopyWith<T, _PaginatedSearchResponse<T>> get copyWith => __$PaginatedSearchResponseCopyWithImpl<T, _PaginatedSearchResponse<T>>(this, _$identity);

@override
Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
  return _$PaginatedSearchResponseToJson<T>(this, toJsonT);
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaginatedSearchResponse<T>&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.nextToken, nextToken) || other.nextToken == nextToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),nextToken);

@override
String toString() {
  return 'PaginatedSearchResponse<$T>(items: $items, nextToken: $nextToken)';
}


}

/// @nodoc
abstract mixin class _$PaginatedSearchResponseCopyWith<T,$Res> implements $PaginatedSearchResponseCopyWith<T, $Res> {
  factory _$PaginatedSearchResponseCopyWith(_PaginatedSearchResponse<T> value, $Res Function(_PaginatedSearchResponse<T>) _then) = __$PaginatedSearchResponseCopyWithImpl;
@override @useResult
$Res call({
 List<T> items, String? nextToken
});




}
/// @nodoc
class __$PaginatedSearchResponseCopyWithImpl<T,$Res>
    implements _$PaginatedSearchResponseCopyWith<T, $Res> {
  __$PaginatedSearchResponseCopyWithImpl(this._self, this._then);

  final _PaginatedSearchResponse<T> _self;
  final $Res Function(_PaginatedSearchResponse<T>) _then;

/// Create a copy of PaginatedSearchResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? nextToken = freezed,}) {
  return _then(_PaginatedSearchResponse<T>(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<T>,nextToken: freezed == nextToken ? _self.nextToken : nextToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$IntensityAreaSearchItem {

 String get eventId; IntensityAreaInfo get area; EarthquakePartial get earthquake;
/// Create a copy of IntensityAreaSearchItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntensityAreaSearchItemCopyWith<IntensityAreaSearchItem> get copyWith => _$IntensityAreaSearchItemCopyWithImpl<IntensityAreaSearchItem>(this as IntensityAreaSearchItem, _$identity);

  /// Serializes this IntensityAreaSearchItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntensityAreaSearchItem&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.area, area) || other.area == area)&&(identical(other.earthquake, earthquake) || other.earthquake == earthquake));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,area,earthquake);

@override
String toString() {
  return 'IntensityAreaSearchItem(eventId: $eventId, area: $area, earthquake: $earthquake)';
}


}

/// @nodoc
abstract mixin class $IntensityAreaSearchItemCopyWith<$Res>  {
  factory $IntensityAreaSearchItemCopyWith(IntensityAreaSearchItem value, $Res Function(IntensityAreaSearchItem) _then) = _$IntensityAreaSearchItemCopyWithImpl;
@useResult
$Res call({
 String eventId, IntensityAreaInfo area, EarthquakePartial earthquake
});


$IntensityAreaInfoCopyWith<$Res> get area;$EarthquakePartialCopyWith<$Res> get earthquake;

}
/// @nodoc
class _$IntensityAreaSearchItemCopyWithImpl<$Res>
    implements $IntensityAreaSearchItemCopyWith<$Res> {
  _$IntensityAreaSearchItemCopyWithImpl(this._self, this._then);

  final IntensityAreaSearchItem _self;
  final $Res Function(IntensityAreaSearchItem) _then;

/// Create a copy of IntensityAreaSearchItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? area = null,Object? earthquake = null,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,area: null == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as IntensityAreaInfo,earthquake: null == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as EarthquakePartial,
  ));
}
/// Create a copy of IntensityAreaSearchItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IntensityAreaInfoCopyWith<$Res> get area {
  
  return $IntensityAreaInfoCopyWith<$Res>(_self.area, (value) {
    return _then(_self.copyWith(area: value));
  });
}/// Create a copy of IntensityAreaSearchItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakePartialCopyWith<$Res> get earthquake {
  
  return $EarthquakePartialCopyWith<$Res>(_self.earthquake, (value) {
    return _then(_self.copyWith(earthquake: value));
  });
}
}


/// Adds pattern-matching-related methods to [IntensityAreaSearchItem].
extension IntensityAreaSearchItemPatterns on IntensityAreaSearchItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IntensityAreaSearchItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IntensityAreaSearchItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IntensityAreaSearchItem value)  $default,){
final _that = this;
switch (_that) {
case _IntensityAreaSearchItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IntensityAreaSearchItem value)?  $default,){
final _that = this;
switch (_that) {
case _IntensityAreaSearchItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String eventId,  IntensityAreaInfo area,  EarthquakePartial earthquake)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IntensityAreaSearchItem() when $default != null:
return $default(_that.eventId,_that.area,_that.earthquake);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String eventId,  IntensityAreaInfo area,  EarthquakePartial earthquake)  $default,) {final _that = this;
switch (_that) {
case _IntensityAreaSearchItem():
return $default(_that.eventId,_that.area,_that.earthquake);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String eventId,  IntensityAreaInfo area,  EarthquakePartial earthquake)?  $default,) {final _that = this;
switch (_that) {
case _IntensityAreaSearchItem() when $default != null:
return $default(_that.eventId,_that.area,_that.earthquake);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IntensityAreaSearchItem implements IntensityAreaSearchItem {
  const _IntensityAreaSearchItem({required this.eventId, required this.area, required this.earthquake});
  factory _IntensityAreaSearchItem.fromJson(Map<String, dynamic> json) => _$IntensityAreaSearchItemFromJson(json);

@override final  String eventId;
@override final  IntensityAreaInfo area;
@override final  EarthquakePartial earthquake;

/// Create a copy of IntensityAreaSearchItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntensityAreaSearchItemCopyWith<_IntensityAreaSearchItem> get copyWith => __$IntensityAreaSearchItemCopyWithImpl<_IntensityAreaSearchItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IntensityAreaSearchItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntensityAreaSearchItem&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.area, area) || other.area == area)&&(identical(other.earthquake, earthquake) || other.earthquake == earthquake));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,area,earthquake);

@override
String toString() {
  return 'IntensityAreaSearchItem(eventId: $eventId, area: $area, earthquake: $earthquake)';
}


}

/// @nodoc
abstract mixin class _$IntensityAreaSearchItemCopyWith<$Res> implements $IntensityAreaSearchItemCopyWith<$Res> {
  factory _$IntensityAreaSearchItemCopyWith(_IntensityAreaSearchItem value, $Res Function(_IntensityAreaSearchItem) _then) = __$IntensityAreaSearchItemCopyWithImpl;
@override @useResult
$Res call({
 String eventId, IntensityAreaInfo area, EarthquakePartial earthquake
});


@override $IntensityAreaInfoCopyWith<$Res> get area;@override $EarthquakePartialCopyWith<$Res> get earthquake;

}
/// @nodoc
class __$IntensityAreaSearchItemCopyWithImpl<$Res>
    implements _$IntensityAreaSearchItemCopyWith<$Res> {
  __$IntensityAreaSearchItemCopyWithImpl(this._self, this._then);

  final _IntensityAreaSearchItem _self;
  final $Res Function(_IntensityAreaSearchItem) _then;

/// Create a copy of IntensityAreaSearchItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? area = null,Object? earthquake = null,}) {
  return _then(_IntensityAreaSearchItem(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,area: null == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as IntensityAreaInfo,earthquake: null == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as EarthquakePartial,
  ));
}

/// Create a copy of IntensityAreaSearchItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IntensityAreaInfoCopyWith<$Res> get area {
  
  return $IntensityAreaInfoCopyWith<$Res>(_self.area, (value) {
    return _then(_self.copyWith(area: value));
  });
}/// Create a copy of IntensityAreaSearchItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakePartialCopyWith<$Res> get earthquake {
  
  return $EarthquakePartialCopyWith<$Res>(_self.earthquake, (value) {
    return _then(_self.copyWith(earthquake: value));
  });
}
}


/// @nodoc
mixin _$StationSearchItem {

 String get eventId; StationSearchInfo get station; EarthquakePartial get earthquake;
/// Create a copy of StationSearchItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StationSearchItemCopyWith<StationSearchItem> get copyWith => _$StationSearchItemCopyWithImpl<StationSearchItem>(this as StationSearchItem, _$identity);

  /// Serializes this StationSearchItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StationSearchItem&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.station, station) || other.station == station)&&(identical(other.earthquake, earthquake) || other.earthquake == earthquake));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,station,earthquake);

@override
String toString() {
  return 'StationSearchItem(eventId: $eventId, station: $station, earthquake: $earthquake)';
}


}

/// @nodoc
abstract mixin class $StationSearchItemCopyWith<$Res>  {
  factory $StationSearchItemCopyWith(StationSearchItem value, $Res Function(StationSearchItem) _then) = _$StationSearchItemCopyWithImpl;
@useResult
$Res call({
 String eventId, StationSearchInfo station, EarthquakePartial earthquake
});


$StationSearchInfoCopyWith<$Res> get station;$EarthquakePartialCopyWith<$Res> get earthquake;

}
/// @nodoc
class _$StationSearchItemCopyWithImpl<$Res>
    implements $StationSearchItemCopyWith<$Res> {
  _$StationSearchItemCopyWithImpl(this._self, this._then);

  final StationSearchItem _self;
  final $Res Function(StationSearchItem) _then;

/// Create a copy of StationSearchItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? station = null,Object? earthquake = null,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,station: null == station ? _self.station : station // ignore: cast_nullable_to_non_nullable
as StationSearchInfo,earthquake: null == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as EarthquakePartial,
  ));
}
/// Create a copy of StationSearchItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StationSearchInfoCopyWith<$Res> get station {
  
  return $StationSearchInfoCopyWith<$Res>(_self.station, (value) {
    return _then(_self.copyWith(station: value));
  });
}/// Create a copy of StationSearchItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakePartialCopyWith<$Res> get earthquake {
  
  return $EarthquakePartialCopyWith<$Res>(_self.earthquake, (value) {
    return _then(_self.copyWith(earthquake: value));
  });
}
}


/// Adds pattern-matching-related methods to [StationSearchItem].
extension StationSearchItemPatterns on StationSearchItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StationSearchItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StationSearchItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StationSearchItem value)  $default,){
final _that = this;
switch (_that) {
case _StationSearchItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StationSearchItem value)?  $default,){
final _that = this;
switch (_that) {
case _StationSearchItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String eventId,  StationSearchInfo station,  EarthquakePartial earthquake)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StationSearchItem() when $default != null:
return $default(_that.eventId,_that.station,_that.earthquake);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String eventId,  StationSearchInfo station,  EarthquakePartial earthquake)  $default,) {final _that = this;
switch (_that) {
case _StationSearchItem():
return $default(_that.eventId,_that.station,_that.earthquake);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String eventId,  StationSearchInfo station,  EarthquakePartial earthquake)?  $default,) {final _that = this;
switch (_that) {
case _StationSearchItem() when $default != null:
return $default(_that.eventId,_that.station,_that.earthquake);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StationSearchItem implements StationSearchItem {
  const _StationSearchItem({required this.eventId, required this.station, required this.earthquake});
  factory _StationSearchItem.fromJson(Map<String, dynamic> json) => _$StationSearchItemFromJson(json);

@override final  String eventId;
@override final  StationSearchInfo station;
@override final  EarthquakePartial earthquake;

/// Create a copy of StationSearchItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StationSearchItemCopyWith<_StationSearchItem> get copyWith => __$StationSearchItemCopyWithImpl<_StationSearchItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StationSearchItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StationSearchItem&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.station, station) || other.station == station)&&(identical(other.earthquake, earthquake) || other.earthquake == earthquake));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,station,earthquake);

@override
String toString() {
  return 'StationSearchItem(eventId: $eventId, station: $station, earthquake: $earthquake)';
}


}

/// @nodoc
abstract mixin class _$StationSearchItemCopyWith<$Res> implements $StationSearchItemCopyWith<$Res> {
  factory _$StationSearchItemCopyWith(_StationSearchItem value, $Res Function(_StationSearchItem) _then) = __$StationSearchItemCopyWithImpl;
@override @useResult
$Res call({
 String eventId, StationSearchInfo station, EarthquakePartial earthquake
});


@override $StationSearchInfoCopyWith<$Res> get station;@override $EarthquakePartialCopyWith<$Res> get earthquake;

}
/// @nodoc
class __$StationSearchItemCopyWithImpl<$Res>
    implements _$StationSearchItemCopyWith<$Res> {
  __$StationSearchItemCopyWithImpl(this._self, this._then);

  final _StationSearchItem _self;
  final $Res Function(_StationSearchItem) _then;

/// Create a copy of StationSearchItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? station = null,Object? earthquake = null,}) {
  return _then(_StationSearchItem(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,station: null == station ? _self.station : station // ignore: cast_nullable_to_non_nullable
as StationSearchInfo,earthquake: null == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as EarthquakePartial,
  ));
}

/// Create a copy of StationSearchItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StationSearchInfoCopyWith<$Res> get station {
  
  return $StationSearchInfoCopyWith<$Res>(_self.station, (value) {
    return _then(_self.copyWith(station: value));
  });
}/// Create a copy of StationSearchItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakePartialCopyWith<$Res> get earthquake {
  
  return $EarthquakePartialCopyWith<$Res>(_self.earthquake, (value) {
    return _then(_self.copyWith(earthquake: value));
  });
}
}


/// @nodoc
mixin _$EpicenterSearchItem {

 String get eventId; EpicenterSearchInfo get epicenter; EarthquakePartial get earthquake;
/// Create a copy of EpicenterSearchItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EpicenterSearchItemCopyWith<EpicenterSearchItem> get copyWith => _$EpicenterSearchItemCopyWithImpl<EpicenterSearchItem>(this as EpicenterSearchItem, _$identity);

  /// Serializes this EpicenterSearchItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EpicenterSearchItem&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.epicenter, epicenter) || other.epicenter == epicenter)&&(identical(other.earthquake, earthquake) || other.earthquake == earthquake));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,epicenter,earthquake);

@override
String toString() {
  return 'EpicenterSearchItem(eventId: $eventId, epicenter: $epicenter, earthquake: $earthquake)';
}


}

/// @nodoc
abstract mixin class $EpicenterSearchItemCopyWith<$Res>  {
  factory $EpicenterSearchItemCopyWith(EpicenterSearchItem value, $Res Function(EpicenterSearchItem) _then) = _$EpicenterSearchItemCopyWithImpl;
@useResult
$Res call({
 String eventId, EpicenterSearchInfo epicenter, EarthquakePartial earthquake
});


$EpicenterSearchInfoCopyWith<$Res> get epicenter;$EarthquakePartialCopyWith<$Res> get earthquake;

}
/// @nodoc
class _$EpicenterSearchItemCopyWithImpl<$Res>
    implements $EpicenterSearchItemCopyWith<$Res> {
  _$EpicenterSearchItemCopyWithImpl(this._self, this._then);

  final EpicenterSearchItem _self;
  final $Res Function(EpicenterSearchItem) _then;

/// Create a copy of EpicenterSearchItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? epicenter = null,Object? earthquake = null,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,epicenter: null == epicenter ? _self.epicenter : epicenter // ignore: cast_nullable_to_non_nullable
as EpicenterSearchInfo,earthquake: null == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as EarthquakePartial,
  ));
}
/// Create a copy of EpicenterSearchItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EpicenterSearchInfoCopyWith<$Res> get epicenter {
  
  return $EpicenterSearchInfoCopyWith<$Res>(_self.epicenter, (value) {
    return _then(_self.copyWith(epicenter: value));
  });
}/// Create a copy of EpicenterSearchItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakePartialCopyWith<$Res> get earthquake {
  
  return $EarthquakePartialCopyWith<$Res>(_self.earthquake, (value) {
    return _then(_self.copyWith(earthquake: value));
  });
}
}


/// Adds pattern-matching-related methods to [EpicenterSearchItem].
extension EpicenterSearchItemPatterns on EpicenterSearchItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EpicenterSearchItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EpicenterSearchItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EpicenterSearchItem value)  $default,){
final _that = this;
switch (_that) {
case _EpicenterSearchItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EpicenterSearchItem value)?  $default,){
final _that = this;
switch (_that) {
case _EpicenterSearchItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String eventId,  EpicenterSearchInfo epicenter,  EarthquakePartial earthquake)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EpicenterSearchItem() when $default != null:
return $default(_that.eventId,_that.epicenter,_that.earthquake);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String eventId,  EpicenterSearchInfo epicenter,  EarthquakePartial earthquake)  $default,) {final _that = this;
switch (_that) {
case _EpicenterSearchItem():
return $default(_that.eventId,_that.epicenter,_that.earthquake);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String eventId,  EpicenterSearchInfo epicenter,  EarthquakePartial earthquake)?  $default,) {final _that = this;
switch (_that) {
case _EpicenterSearchItem() when $default != null:
return $default(_that.eventId,_that.epicenter,_that.earthquake);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EpicenterSearchItem implements EpicenterSearchItem {
  const _EpicenterSearchItem({required this.eventId, required this.epicenter, required this.earthquake});
  factory _EpicenterSearchItem.fromJson(Map<String, dynamic> json) => _$EpicenterSearchItemFromJson(json);

@override final  String eventId;
@override final  EpicenterSearchInfo epicenter;
@override final  EarthquakePartial earthquake;

/// Create a copy of EpicenterSearchItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EpicenterSearchItemCopyWith<_EpicenterSearchItem> get copyWith => __$EpicenterSearchItemCopyWithImpl<_EpicenterSearchItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EpicenterSearchItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EpicenterSearchItem&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.epicenter, epicenter) || other.epicenter == epicenter)&&(identical(other.earthquake, earthquake) || other.earthquake == earthquake));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,epicenter,earthquake);

@override
String toString() {
  return 'EpicenterSearchItem(eventId: $eventId, epicenter: $epicenter, earthquake: $earthquake)';
}


}

/// @nodoc
abstract mixin class _$EpicenterSearchItemCopyWith<$Res> implements $EpicenterSearchItemCopyWith<$Res> {
  factory _$EpicenterSearchItemCopyWith(_EpicenterSearchItem value, $Res Function(_EpicenterSearchItem) _then) = __$EpicenterSearchItemCopyWithImpl;
@override @useResult
$Res call({
 String eventId, EpicenterSearchInfo epicenter, EarthquakePartial earthquake
});


@override $EpicenterSearchInfoCopyWith<$Res> get epicenter;@override $EarthquakePartialCopyWith<$Res> get earthquake;

}
/// @nodoc
class __$EpicenterSearchItemCopyWithImpl<$Res>
    implements _$EpicenterSearchItemCopyWith<$Res> {
  __$EpicenterSearchItemCopyWithImpl(this._self, this._then);

  final _EpicenterSearchItem _self;
  final $Res Function(_EpicenterSearchItem) _then;

/// Create a copy of EpicenterSearchItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? epicenter = null,Object? earthquake = null,}) {
  return _then(_EpicenterSearchItem(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,epicenter: null == epicenter ? _self.epicenter : epicenter // ignore: cast_nullable_to_non_nullable
as EpicenterSearchInfo,earthquake: null == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as EarthquakePartial,
  ));
}

/// Create a copy of EpicenterSearchItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EpicenterSearchInfoCopyWith<$Res> get epicenter {
  
  return $EpicenterSearchInfoCopyWith<$Res>(_self.epicenter, (value) {
    return _then(_self.copyWith(epicenter: value));
  });
}/// Create a copy of EpicenterSearchItem
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
