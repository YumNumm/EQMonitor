// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dispatch_summary_detail_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DispatchSummaryDetailResponse {

 DispatchSummaryItem get item;
/// Create a copy of DispatchSummaryDetailResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DispatchSummaryDetailResponseCopyWith<DispatchSummaryDetailResponse> get copyWith => _$DispatchSummaryDetailResponseCopyWithImpl<DispatchSummaryDetailResponse>(this as DispatchSummaryDetailResponse, _$identity);

  /// Serializes this DispatchSummaryDetailResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DispatchSummaryDetailResponse&&(identical(other.item, item) || other.item == item));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,item);

@override
String toString() {
  return 'DispatchSummaryDetailResponse(item: $item)';
}


}

/// @nodoc
abstract mixin class $DispatchSummaryDetailResponseCopyWith<$Res>  {
  factory $DispatchSummaryDetailResponseCopyWith(DispatchSummaryDetailResponse value, $Res Function(DispatchSummaryDetailResponse) _then) = _$DispatchSummaryDetailResponseCopyWithImpl;
@useResult
$Res call({
 DispatchSummaryItem item
});


$DispatchSummaryItemCopyWith<$Res> get item;

}
/// @nodoc
class _$DispatchSummaryDetailResponseCopyWithImpl<$Res>
    implements $DispatchSummaryDetailResponseCopyWith<$Res> {
  _$DispatchSummaryDetailResponseCopyWithImpl(this._self, this._then);

  final DispatchSummaryDetailResponse _self;
  final $Res Function(DispatchSummaryDetailResponse) _then;

/// Create a copy of DispatchSummaryDetailResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? item = null,}) {
  return _then(_self.copyWith(
item: null == item ? _self.item : item // ignore: cast_nullable_to_non_nullable
as DispatchSummaryItem,
  ));
}
/// Create a copy of DispatchSummaryDetailResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DispatchSummaryItemCopyWith<$Res> get item {
  
  return $DispatchSummaryItemCopyWith<$Res>(_self.item, (value) {
    return _then(_self.copyWith(item: value));
  });
}
}


/// Adds pattern-matching-related methods to [DispatchSummaryDetailResponse].
extension DispatchSummaryDetailResponsePatterns on DispatchSummaryDetailResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DispatchSummaryDetailResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DispatchSummaryDetailResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DispatchSummaryDetailResponse value)  $default,){
final _that = this;
switch (_that) {
case _DispatchSummaryDetailResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DispatchSummaryDetailResponse value)?  $default,){
final _that = this;
switch (_that) {
case _DispatchSummaryDetailResponse() when $default != null:
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
case _DispatchSummaryDetailResponse() when $default != null:
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
case _DispatchSummaryDetailResponse():
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
case _DispatchSummaryDetailResponse() when $default != null:
return $default(_that.item);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DispatchSummaryDetailResponse implements DispatchSummaryDetailResponse {
  const _DispatchSummaryDetailResponse({required this.item});
  factory _DispatchSummaryDetailResponse.fromJson(Map<String, dynamic> json) => _$DispatchSummaryDetailResponseFromJson(json);

@override final  DispatchSummaryItem item;

/// Create a copy of DispatchSummaryDetailResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DispatchSummaryDetailResponseCopyWith<_DispatchSummaryDetailResponse> get copyWith => __$DispatchSummaryDetailResponseCopyWithImpl<_DispatchSummaryDetailResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DispatchSummaryDetailResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DispatchSummaryDetailResponse&&(identical(other.item, item) || other.item == item));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,item);

@override
String toString() {
  return 'DispatchSummaryDetailResponse(item: $item)';
}


}

/// @nodoc
abstract mixin class _$DispatchSummaryDetailResponseCopyWith<$Res> implements $DispatchSummaryDetailResponseCopyWith<$Res> {
  factory _$DispatchSummaryDetailResponseCopyWith(_DispatchSummaryDetailResponse value, $Res Function(_DispatchSummaryDetailResponse) _then) = __$DispatchSummaryDetailResponseCopyWithImpl;
@override @useResult
$Res call({
 DispatchSummaryItem item
});


@override $DispatchSummaryItemCopyWith<$Res> get item;

}
/// @nodoc
class __$DispatchSummaryDetailResponseCopyWithImpl<$Res>
    implements _$DispatchSummaryDetailResponseCopyWith<$Res> {
  __$DispatchSummaryDetailResponseCopyWithImpl(this._self, this._then);

  final _DispatchSummaryDetailResponse _self;
  final $Res Function(_DispatchSummaryDetailResponse) _then;

/// Create a copy of DispatchSummaryDetailResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? item = null,}) {
  return _then(_DispatchSummaryDetailResponse(
item: null == item ? _self.item : item // ignore: cast_nullable_to_non_nullable
as DispatchSummaryItem,
  ));
}

/// Create a copy of DispatchSummaryDetailResponse
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
