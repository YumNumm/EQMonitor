// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_dispatch_summary_detail_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AdminDispatchSummaryDetailResponse {

 DispatchSummaryItem get item;
/// Create a copy of AdminDispatchSummaryDetailResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminDispatchSummaryDetailResponseCopyWith<AdminDispatchSummaryDetailResponse> get copyWith => _$AdminDispatchSummaryDetailResponseCopyWithImpl<AdminDispatchSummaryDetailResponse>(this as AdminDispatchSummaryDetailResponse, _$identity);

  /// Serializes this AdminDispatchSummaryDetailResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminDispatchSummaryDetailResponse&&(identical(other.item, item) || other.item == item));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,item);

@override
String toString() {
  return 'AdminDispatchSummaryDetailResponse(item: $item)';
}


}

/// @nodoc
abstract mixin class $AdminDispatchSummaryDetailResponseCopyWith<$Res>  {
  factory $AdminDispatchSummaryDetailResponseCopyWith(AdminDispatchSummaryDetailResponse value, $Res Function(AdminDispatchSummaryDetailResponse) _then) = _$AdminDispatchSummaryDetailResponseCopyWithImpl;
@useResult
$Res call({
 DispatchSummaryItem item
});


$DispatchSummaryItemCopyWith<$Res> get item;

}
/// @nodoc
class _$AdminDispatchSummaryDetailResponseCopyWithImpl<$Res>
    implements $AdminDispatchSummaryDetailResponseCopyWith<$Res> {
  _$AdminDispatchSummaryDetailResponseCopyWithImpl(this._self, this._then);

  final AdminDispatchSummaryDetailResponse _self;
  final $Res Function(AdminDispatchSummaryDetailResponse) _then;

/// Create a copy of AdminDispatchSummaryDetailResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? item = null,}) {
  return _then(AdminDispatchSummaryDetailResponse(
item: null == item ? _self.item : item // ignore: cast_nullable_to_non_nullable
as DispatchSummaryItem,
  ));
}
/// Create a copy of AdminDispatchSummaryDetailResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DispatchSummaryItemCopyWith<$Res> get item {
  
  return $DispatchSummaryItemCopyWith<$Res>(_self.item, (value) {
    return _then(_self.copyWith(item: value));
  });
}
}


/// Adds pattern-matching-related methods to [AdminDispatchSummaryDetailResponse].
extension AdminDispatchSummaryDetailResponsePatterns on AdminDispatchSummaryDetailResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdminDispatchSummaryDetailResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdminDispatchSummaryDetailResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdminDispatchSummaryDetailResponse value)  $default,){
final _that = this;
switch (_that) {
case _AdminDispatchSummaryDetailResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdminDispatchSummaryDetailResponse value)?  $default,){
final _that = this;
switch (_that) {
case _AdminDispatchSummaryDetailResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DispatchSummaryItem item)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdminDispatchSummaryDetailResponse() when $default != null:
return $default(_that.item);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DispatchSummaryItem item)  $default,) {final _that = this;
switch (_that) {
case _AdminDispatchSummaryDetailResponse():
return $default(_that.item);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DispatchSummaryItem item)?  $default,) {final _that = this;
switch (_that) {
case _AdminDispatchSummaryDetailResponse() when $default != null:
return $default(_that.item);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AdminDispatchSummaryDetailResponse implements AdminDispatchSummaryDetailResponse {
  const _AdminDispatchSummaryDetailResponse({required this.item});
  factory _AdminDispatchSummaryDetailResponse.fromJson(Map<String, dynamic> json) => _$AdminDispatchSummaryDetailResponseFromJson(json);

@override final  DispatchSummaryItem item;

/// Create a copy of AdminDispatchSummaryDetailResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminDispatchSummaryDetailResponseCopyWith<_AdminDispatchSummaryDetailResponse> get copyWith => __$AdminDispatchSummaryDetailResponseCopyWithImpl<_AdminDispatchSummaryDetailResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AdminDispatchSummaryDetailResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminDispatchSummaryDetailResponse&&(identical(other.item, item) || other.item == item));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,item);

@override
String toString() {
  return 'AdminDispatchSummaryDetailResponse(item: $item)';
}


}

/// @nodoc
abstract mixin class _$AdminDispatchSummaryDetailResponseCopyWith<$Res> implements $AdminDispatchSummaryDetailResponseCopyWith<$Res> {
  factory _$AdminDispatchSummaryDetailResponseCopyWith(_AdminDispatchSummaryDetailResponse value, $Res Function(_AdminDispatchSummaryDetailResponse) _then) = __$AdminDispatchSummaryDetailResponseCopyWithImpl;
@override @useResult
$Res call({
 DispatchSummaryItem item
});


@override $DispatchSummaryItemCopyWith<$Res> get item;

}
/// @nodoc
class __$AdminDispatchSummaryDetailResponseCopyWithImpl<$Res>
    implements _$AdminDispatchSummaryDetailResponseCopyWith<$Res> {
  __$AdminDispatchSummaryDetailResponseCopyWithImpl(this._self, this._then);

  final _AdminDispatchSummaryDetailResponse _self;
  final $Res Function(_AdminDispatchSummaryDetailResponse) _then;

/// Create a copy of AdminDispatchSummaryDetailResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? item = null,}) {
  return _then(_AdminDispatchSummaryDetailResponse(
item: null == item ? _self.item : item // ignore: cast_nullable_to_non_nullable
as DispatchSummaryItem,
  ));
}

/// Create a copy of AdminDispatchSummaryDetailResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DispatchSummaryItemCopyWith<$Res> get item {
  
  return $DispatchSummaryItemCopyWith<$Res>(_self.item, (value) {
    return _then(_self.copyWith(item: value));
  });
}
}

// dart format on
