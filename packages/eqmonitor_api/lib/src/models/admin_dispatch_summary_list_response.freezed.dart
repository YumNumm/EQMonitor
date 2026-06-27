// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_dispatch_summary_list_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AdminDispatchSummaryListResponse {

 List<Items> get items;
/// Create a copy of AdminDispatchSummaryListResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminDispatchSummaryListResponseCopyWith<AdminDispatchSummaryListResponse> get copyWith => _$AdminDispatchSummaryListResponseCopyWithImpl<AdminDispatchSummaryListResponse>(this as AdminDispatchSummaryListResponse, _$identity);

  /// Serializes this AdminDispatchSummaryListResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminDispatchSummaryListResponse&&const DeepCollectionEquality().equals(other.items, items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'AdminDispatchSummaryListResponse(items: $items)';
}


}

/// @nodoc
abstract mixin class $AdminDispatchSummaryListResponseCopyWith<$Res>  {
  factory $AdminDispatchSummaryListResponseCopyWith(AdminDispatchSummaryListResponse value, $Res Function(AdminDispatchSummaryListResponse) _then) = _$AdminDispatchSummaryListResponseCopyWithImpl;
@useResult
$Res call({
 List<Items> items
});




}
/// @nodoc
class _$AdminDispatchSummaryListResponseCopyWithImpl<$Res>
    implements $AdminDispatchSummaryListResponseCopyWith<$Res> {
  _$AdminDispatchSummaryListResponseCopyWithImpl(this._self, this._then);

  final AdminDispatchSummaryListResponse _self;
  final $Res Function(AdminDispatchSummaryListResponse) _then;

/// Create a copy of AdminDispatchSummaryListResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<Items>,
  ));
}

}


/// Adds pattern-matching-related methods to [AdminDispatchSummaryListResponse].
extension AdminDispatchSummaryListResponsePatterns on AdminDispatchSummaryListResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdminDispatchSummaryListResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdminDispatchSummaryListResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdminDispatchSummaryListResponse value)  $default,){
final _that = this;
switch (_that) {
case _AdminDispatchSummaryListResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdminDispatchSummaryListResponse value)?  $default,){
final _that = this;
switch (_that) {
case _AdminDispatchSummaryListResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Items> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdminDispatchSummaryListResponse() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Items> items)  $default,) {final _that = this;
switch (_that) {
case _AdminDispatchSummaryListResponse():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Items> items)?  $default,) {final _that = this;
switch (_that) {
case _AdminDispatchSummaryListResponse() when $default != null:
return $default(_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AdminDispatchSummaryListResponse implements AdminDispatchSummaryListResponse {
  const _AdminDispatchSummaryListResponse({required final  List<Items> items}): _items = items;
  factory _AdminDispatchSummaryListResponse.fromJson(Map<String, dynamic> json) => _$AdminDispatchSummaryListResponseFromJson(json);

 final  List<Items> _items;
@override List<Items> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of AdminDispatchSummaryListResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminDispatchSummaryListResponseCopyWith<_AdminDispatchSummaryListResponse> get copyWith => __$AdminDispatchSummaryListResponseCopyWithImpl<_AdminDispatchSummaryListResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AdminDispatchSummaryListResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminDispatchSummaryListResponse&&const DeepCollectionEquality().equals(other._items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'AdminDispatchSummaryListResponse(items: $items)';
}


}

/// @nodoc
abstract mixin class _$AdminDispatchSummaryListResponseCopyWith<$Res> implements $AdminDispatchSummaryListResponseCopyWith<$Res> {
  factory _$AdminDispatchSummaryListResponseCopyWith(_AdminDispatchSummaryListResponse value, $Res Function(_AdminDispatchSummaryListResponse) _then) = __$AdminDispatchSummaryListResponseCopyWithImpl;
@override @useResult
$Res call({
 List<Items> items
});




}
/// @nodoc
class __$AdminDispatchSummaryListResponseCopyWithImpl<$Res>
    implements _$AdminDispatchSummaryListResponseCopyWith<$Res> {
  __$AdminDispatchSummaryListResponseCopyWithImpl(this._self, this._then);

  final _AdminDispatchSummaryListResponse _self;
  final $Res Function(_AdminDispatchSummaryListResponse) _then;

/// Create a copy of AdminDispatchSummaryListResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,}) {
  return _then(_AdminDispatchSummaryListResponse(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<Items>,
  ));
}


}

// dart format on
