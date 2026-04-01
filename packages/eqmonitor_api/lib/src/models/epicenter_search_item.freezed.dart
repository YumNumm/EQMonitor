// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'epicenter_search_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EpicenterSearchItem {

@JsonKey(name: 'event_id') String get eventId; EpicenterInfo get epicenter; EarthquakePartial get earthquake;
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
@JsonKey(name: 'event_id') String eventId, EpicenterInfo epicenter, EarthquakePartial earthquake
});


$EpicenterInfoCopyWith<$Res> get epicenter;$EarthquakePartialCopyWith<$Res> get earthquake;

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
as EpicenterInfo,earthquake: null == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as EarthquakePartial,
  ));
}
/// Create a copy of EpicenterSearchItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EpicenterInfoCopyWith<$Res> get epicenter {
  
  return $EpicenterInfoCopyWith<$Res>(_self.epicenter, (value) {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'event_id')  String eventId,  EpicenterInfo epicenter,  EarthquakePartial earthquake)?  $default,{required TResult orElse(),}) {final _that = this;
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'event_id')  String eventId,  EpicenterInfo epicenter,  EarthquakePartial earthquake)  $default,) {final _that = this;
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'event_id')  String eventId,  EpicenterInfo epicenter,  EarthquakePartial earthquake)?  $default,) {final _that = this;
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
  const _EpicenterSearchItem({@JsonKey(name: 'event_id') required this.eventId, required this.epicenter, required this.earthquake});
  factory _EpicenterSearchItem.fromJson(Map<String, dynamic> json) => _$EpicenterSearchItemFromJson(json);

@override@JsonKey(name: 'event_id') final  String eventId;
@override final  EpicenterInfo epicenter;
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
@JsonKey(name: 'event_id') String eventId, EpicenterInfo epicenter, EarthquakePartial earthquake
});


@override $EpicenterInfoCopyWith<$Res> get epicenter;@override $EarthquakePartialCopyWith<$Res> get earthquake;

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
as EpicenterInfo,earthquake: null == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as EarthquakePartial,
  ));
}

/// Create a copy of EpicenterSearchItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EpicenterInfoCopyWith<$Res> get epicenter {
  
  return $EpicenterInfoCopyWith<$Res>(_self.epicenter, (value) {
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
