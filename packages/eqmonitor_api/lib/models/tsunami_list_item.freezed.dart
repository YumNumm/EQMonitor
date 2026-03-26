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

 String get id;@JsonKey(name: 'event_ids') List<String> get eventIds;
/// Create a copy of TsunamiListItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiListItemCopyWith<TsunamiListItem> get copyWith => _$TsunamiListItemCopyWithImpl<TsunamiListItem>(this as TsunamiListItem, _$identity);

  /// Serializes this TsunamiListItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiListItem&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.eventIds, eventIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(eventIds));

@override
String toString() {
  return 'TsunamiListItem(id: $id, eventIds: $eventIds)';
}


}

/// @nodoc
abstract mixin class $TsunamiListItemCopyWith<$Res>  {
  factory $TsunamiListItemCopyWith(TsunamiListItem value, $Res Function(TsunamiListItem) _then) = _$TsunamiListItemCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'event_ids') List<String> eventIds
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? eventIds = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,eventIds: null == eventIds ? _self.eventIds : eventIds // ignore: cast_nullable_to_non_nullable
as List<String>,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'event_ids')  List<String> eventIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiListItem() when $default != null:
return $default(_that.id,_that.eventIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'event_ids')  List<String> eventIds)  $default,) {final _that = this;
switch (_that) {
case _TsunamiListItem():
return $default(_that.id,_that.eventIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'event_ids')  List<String> eventIds)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiListItem() when $default != null:
return $default(_that.id,_that.eventIds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TsunamiListItem implements TsunamiListItem {
  const _TsunamiListItem({required this.id, @JsonKey(name: 'event_ids') required final  List<String> eventIds}): _eventIds = eventIds;
  factory _TsunamiListItem.fromJson(Map<String, dynamic> json) => _$TsunamiListItemFromJson(json);

@override final  String id;
 final  List<String> _eventIds;
@override@JsonKey(name: 'event_ids') List<String> get eventIds {
  if (_eventIds is EqualUnmodifiableListView) return _eventIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_eventIds);
}


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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiListItem&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other._eventIds, _eventIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(_eventIds));

@override
String toString() {
  return 'TsunamiListItem(id: $id, eventIds: $eventIds)';
}


}

/// @nodoc
abstract mixin class _$TsunamiListItemCopyWith<$Res> implements $TsunamiListItemCopyWith<$Res> {
  factory _$TsunamiListItemCopyWith(_TsunamiListItem value, $Res Function(_TsunamiListItem) _then) = __$TsunamiListItemCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'event_ids') List<String> eventIds
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? eventIds = null,}) {
  return _then(_TsunamiListItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,eventIds: null == eventIds ? _self._eventIds : eventIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
