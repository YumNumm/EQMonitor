// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_history_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationHistoryResponse {

 List<NotificationLogItem> get items;@JsonKey(includeIfNull: false, name: 'next_cursor') String? get nextCursor;
/// Create a copy of NotificationHistoryResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationHistoryResponseCopyWith<NotificationHistoryResponse> get copyWith => _$NotificationHistoryResponseCopyWithImpl<NotificationHistoryResponse>(this as NotificationHistoryResponse, _$identity);

  /// Serializes this NotificationHistoryResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationHistoryResponse&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.nextCursor, nextCursor) || other.nextCursor == nextCursor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),nextCursor);

@override
String toString() {
  return 'NotificationHistoryResponse(items: $items, nextCursor: $nextCursor)';
}


}

/// @nodoc
abstract mixin class $NotificationHistoryResponseCopyWith<$Res>  {
  factory $NotificationHistoryResponseCopyWith(NotificationHistoryResponse value, $Res Function(NotificationHistoryResponse) _then) = _$NotificationHistoryResponseCopyWithImpl;
@useResult
$Res call({
 List<NotificationLogItem> items,@JsonKey(includeIfNull: false, name: 'next_cursor') String? nextCursor
});




}
/// @nodoc
class _$NotificationHistoryResponseCopyWithImpl<$Res>
    implements $NotificationHistoryResponseCopyWith<$Res> {
  _$NotificationHistoryResponseCopyWithImpl(this._self, this._then);

  final NotificationHistoryResponse _self;
  final $Res Function(NotificationHistoryResponse) _then;

/// Create a copy of NotificationHistoryResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? nextCursor = freezed,}) {
  return _then(NotificationHistoryResponse(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<NotificationLogItem>,nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationHistoryResponse].
extension NotificationHistoryResponsePatterns on NotificationHistoryResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationHistoryResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationHistoryResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationHistoryResponse value)  $default,){
final _that = this;
switch (_that) {
case _NotificationHistoryResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationHistoryResponse value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationHistoryResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<NotificationLogItem> items, @JsonKey(includeIfNull: false, name: 'next_cursor')  String? nextCursor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationHistoryResponse() when $default != null:
return $default(_that.items,_that.nextCursor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<NotificationLogItem> items, @JsonKey(includeIfNull: false, name: 'next_cursor')  String? nextCursor)  $default,) {final _that = this;
switch (_that) {
case _NotificationHistoryResponse():
return $default(_that.items,_that.nextCursor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<NotificationLogItem> items, @JsonKey(includeIfNull: false, name: 'next_cursor')  String? nextCursor)?  $default,) {final _that = this;
switch (_that) {
case _NotificationHistoryResponse() when $default != null:
return $default(_that.items,_that.nextCursor);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationHistoryResponse implements NotificationHistoryResponse {
  const _NotificationHistoryResponse({required  List<NotificationLogItem> items, @JsonKey(includeIfNull: false, name: 'next_cursor') this.nextCursor}): _items = items;
  factory _NotificationHistoryResponse.fromJson(Map<String, dynamic> json) => _$NotificationHistoryResponseFromJson(json);

 final  List<NotificationLogItem> _items;
@override List<NotificationLogItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@JsonKey(includeIfNull: false, name: 'next_cursor') final  String? nextCursor;

/// Create a copy of NotificationHistoryResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationHistoryResponseCopyWith<_NotificationHistoryResponse> get copyWith => __$NotificationHistoryResponseCopyWithImpl<_NotificationHistoryResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationHistoryResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationHistoryResponse&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.nextCursor, nextCursor) || other.nextCursor == nextCursor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),nextCursor);

@override
String toString() {
  return 'NotificationHistoryResponse(items: $items, nextCursor: $nextCursor)';
}


}

/// @nodoc
abstract mixin class _$NotificationHistoryResponseCopyWith<$Res> implements $NotificationHistoryResponseCopyWith<$Res> {
  factory _$NotificationHistoryResponseCopyWith(_NotificationHistoryResponse value, $Res Function(_NotificationHistoryResponse) _then) = __$NotificationHistoryResponseCopyWithImpl;
@override @useResult
$Res call({
 List<NotificationLogItem> items,@JsonKey(includeIfNull: false, name: 'next_cursor') String? nextCursor
});




}
/// @nodoc
class __$NotificationHistoryResponseCopyWithImpl<$Res>
    implements _$NotificationHistoryResponseCopyWith<$Res> {
  __$NotificationHistoryResponseCopyWithImpl(this._self, this._then);

  final _NotificationHistoryResponse _self;
  final $Res Function(_NotificationHistoryResponse) _then;

/// Create a copy of NotificationHistoryResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? nextCursor = freezed,}) {
  return _then(_NotificationHistoryResponse(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<NotificationLogItem>,nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
