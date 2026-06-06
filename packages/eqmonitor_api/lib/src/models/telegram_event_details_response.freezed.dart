// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'telegram_event_details_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TelegramEventDetailsResponse {

 List<TelegramDetailResponse> get items;
/// Create a copy of TelegramEventDetailsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TelegramEventDetailsResponseCopyWith<TelegramEventDetailsResponse> get copyWith => _$TelegramEventDetailsResponseCopyWithImpl<TelegramEventDetailsResponse>(this as TelegramEventDetailsResponse, _$identity);

  /// Serializes this TelegramEventDetailsResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TelegramEventDetailsResponse&&const DeepCollectionEquality().equals(other.items, items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'TelegramEventDetailsResponse(items: $items)';
}


}

/// @nodoc
abstract mixin class $TelegramEventDetailsResponseCopyWith<$Res>  {
  factory $TelegramEventDetailsResponseCopyWith(TelegramEventDetailsResponse value, $Res Function(TelegramEventDetailsResponse) _then) = _$TelegramEventDetailsResponseCopyWithImpl;
@useResult
$Res call({
 List<TelegramDetailResponse> items
});




}
/// @nodoc
class _$TelegramEventDetailsResponseCopyWithImpl<$Res>
    implements $TelegramEventDetailsResponseCopyWith<$Res> {
  _$TelegramEventDetailsResponseCopyWithImpl(this._self, this._then);

  final TelegramEventDetailsResponse _self;
  final $Res Function(TelegramEventDetailsResponse) _then;

/// Create a copy of TelegramEventDetailsResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<TelegramDetailResponse>,
  ));
}

}


/// Adds pattern-matching-related methods to [TelegramEventDetailsResponse].
extension TelegramEventDetailsResponsePatterns on TelegramEventDetailsResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TelegramEventDetailsResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TelegramEventDetailsResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TelegramEventDetailsResponse value)  $default,){
final _that = this;
switch (_that) {
case _TelegramEventDetailsResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TelegramEventDetailsResponse value)?  $default,){
final _that = this;
switch (_that) {
case _TelegramEventDetailsResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<TelegramDetailResponse> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TelegramEventDetailsResponse() when $default != null:
return $default(_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<TelegramDetailResponse> items)  $default,) {final _that = this;
switch (_that) {
case _TelegramEventDetailsResponse():
return $default(_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<TelegramDetailResponse> items)?  $default,) {final _that = this;
switch (_that) {
case _TelegramEventDetailsResponse() when $default != null:
return $default(_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TelegramEventDetailsResponse implements TelegramEventDetailsResponse {
  const _TelegramEventDetailsResponse({required final  List<TelegramDetailResponse> items}): _items = items;
  factory _TelegramEventDetailsResponse.fromJson(Map<String, dynamic> json) => _$TelegramEventDetailsResponseFromJson(json);

 final  List<TelegramDetailResponse> _items;
@override List<TelegramDetailResponse> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of TelegramEventDetailsResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TelegramEventDetailsResponseCopyWith<_TelegramEventDetailsResponse> get copyWith => __$TelegramEventDetailsResponseCopyWithImpl<_TelegramEventDetailsResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TelegramEventDetailsResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TelegramEventDetailsResponse&&const DeepCollectionEquality().equals(other._items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'TelegramEventDetailsResponse(items: $items)';
}


}

/// @nodoc
abstract mixin class _$TelegramEventDetailsResponseCopyWith<$Res> implements $TelegramEventDetailsResponseCopyWith<$Res> {
  factory _$TelegramEventDetailsResponseCopyWith(_TelegramEventDetailsResponse value, $Res Function(_TelegramEventDetailsResponse) _then) = __$TelegramEventDetailsResponseCopyWithImpl;
@override @useResult
$Res call({
 List<TelegramDetailResponse> items
});




}
/// @nodoc
class __$TelegramEventDetailsResponseCopyWithImpl<$Res>
    implements _$TelegramEventDetailsResponseCopyWith<$Res> {
  __$TelegramEventDetailsResponseCopyWithImpl(this._self, this._then);

  final _TelegramEventDetailsResponse _self;
  final $Res Function(_TelegramEventDetailsResponse) _then;

/// Create a copy of TelegramEventDetailsResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,}) {
  return _then(_TelegramEventDetailsResponse(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<TelegramDetailResponse>,
  ));
}


}

// dart format on
