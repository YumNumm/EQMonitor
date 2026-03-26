// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dispatch_summary_list_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DispatchSummaryListResponse {

 List<Items> get items;
/// Create a copy of DispatchSummaryListResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DispatchSummaryListResponseCopyWith<DispatchSummaryListResponse> get copyWith => _$DispatchSummaryListResponseCopyWithImpl<DispatchSummaryListResponse>(this as DispatchSummaryListResponse, _$identity);

  /// Serializes this DispatchSummaryListResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DispatchSummaryListResponse&&const DeepCollectionEquality().equals(other.items, items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'DispatchSummaryListResponse(items: $items)';
}


}

/// @nodoc
abstract mixin class $DispatchSummaryListResponseCopyWith<$Res>  {
  factory $DispatchSummaryListResponseCopyWith(DispatchSummaryListResponse value, $Res Function(DispatchSummaryListResponse) _then) = _$DispatchSummaryListResponseCopyWithImpl;
@useResult
$Res call({
 List<Items> items
});




}
/// @nodoc
class _$DispatchSummaryListResponseCopyWithImpl<$Res>
    implements $DispatchSummaryListResponseCopyWith<$Res> {
  _$DispatchSummaryListResponseCopyWithImpl(this._self, this._then);

  final DispatchSummaryListResponse _self;
  final $Res Function(DispatchSummaryListResponse) _then;

/// Create a copy of DispatchSummaryListResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<Items>,
  ));
}

}


/// Adds pattern-matching-related methods to [DispatchSummaryListResponse].
extension DispatchSummaryListResponsePatterns on DispatchSummaryListResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DispatchSummaryListResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DispatchSummaryListResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DispatchSummaryListResponse value)  $default,){
final _that = this;
switch (_that) {
case _DispatchSummaryListResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DispatchSummaryListResponse value)?  $default,){
final _that = this;
switch (_that) {
case _DispatchSummaryListResponse() when $default != null:
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
case _DispatchSummaryListResponse() when $default != null:
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
case _DispatchSummaryListResponse():
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
case _DispatchSummaryListResponse() when $default != null:
return $default(_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DispatchSummaryListResponse implements DispatchSummaryListResponse {
  const _DispatchSummaryListResponse({required final  List<Items> items}): _items = items;
  factory _DispatchSummaryListResponse.fromJson(Map<String, dynamic> json) => _$DispatchSummaryListResponseFromJson(json);

 final  List<Items> _items;
@override List<Items> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of DispatchSummaryListResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DispatchSummaryListResponseCopyWith<_DispatchSummaryListResponse> get copyWith => __$DispatchSummaryListResponseCopyWithImpl<_DispatchSummaryListResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DispatchSummaryListResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DispatchSummaryListResponse&&const DeepCollectionEquality().equals(other._items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'DispatchSummaryListResponse(items: $items)';
}


}

/// @nodoc
abstract mixin class _$DispatchSummaryListResponseCopyWith<$Res> implements $DispatchSummaryListResponseCopyWith<$Res> {
  factory _$DispatchSummaryListResponseCopyWith(_DispatchSummaryListResponse value, $Res Function(_DispatchSummaryListResponse) _then) = __$DispatchSummaryListResponseCopyWithImpl;
@override @useResult
$Res call({
 List<Items> items
});




}
/// @nodoc
class __$DispatchSummaryListResponseCopyWithImpl<$Res>
    implements _$DispatchSummaryListResponseCopyWith<$Res> {
  __$DispatchSummaryListResponseCopyWithImpl(this._self, this._then);

  final _DispatchSummaryListResponse _self;
  final $Res Function(_DispatchSummaryListResponse) _then;

/// Create a copy of DispatchSummaryListResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,}) {
  return _then(_DispatchSummaryListResponse(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<Items>,
  ));
}


}

// dart format on
