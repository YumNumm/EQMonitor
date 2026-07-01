// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'highest_intensity_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HighestIntensityResponse {

/// このレスポンスで最高震度集計を生成した時刻
@JsonKey(name: 'aggregated_at') DateTime get aggregatedAt; List<HighestIntensityItem> get items;
/// Create a copy of HighestIntensityResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HighestIntensityResponseCopyWith<HighestIntensityResponse> get copyWith => _$HighestIntensityResponseCopyWithImpl<HighestIntensityResponse>(this as HighestIntensityResponse, _$identity);

  /// Serializes this HighestIntensityResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HighestIntensityResponse&&(identical(other.aggregatedAt, aggregatedAt) || other.aggregatedAt == aggregatedAt)&&const DeepCollectionEquality().equals(other.items, items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,aggregatedAt,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'HighestIntensityResponse(aggregatedAt: $aggregatedAt, items: $items)';
}


}

/// @nodoc
abstract mixin class $HighestIntensityResponseCopyWith<$Res>  {
  factory $HighestIntensityResponseCopyWith(HighestIntensityResponse value, $Res Function(HighestIntensityResponse) _then) = _$HighestIntensityResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'aggregated_at') DateTime aggregatedAt, List<HighestIntensityItem> items
});




}
/// @nodoc
class _$HighestIntensityResponseCopyWithImpl<$Res>
    implements $HighestIntensityResponseCopyWith<$Res> {
  _$HighestIntensityResponseCopyWithImpl(this._self, this._then);

  final HighestIntensityResponse _self;
  final $Res Function(HighestIntensityResponse) _then;

/// Create a copy of HighestIntensityResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? aggregatedAt = null,Object? items = null,}) {
  return _then(_self.copyWith(
aggregatedAt: null == aggregatedAt ? _self.aggregatedAt : aggregatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<HighestIntensityItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [HighestIntensityResponse].
extension HighestIntensityResponsePatterns on HighestIntensityResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HighestIntensityResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HighestIntensityResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HighestIntensityResponse value)  $default,){
final _that = this;
switch (_that) {
case _HighestIntensityResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HighestIntensityResponse value)?  $default,){
final _that = this;
switch (_that) {
case _HighestIntensityResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'aggregated_at')  DateTime aggregatedAt,  List<HighestIntensityItem> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HighestIntensityResponse() when $default != null:
return $default(_that.aggregatedAt,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'aggregated_at')  DateTime aggregatedAt,  List<HighestIntensityItem> items)  $default,) {final _that = this;
switch (_that) {
case _HighestIntensityResponse():
return $default(_that.aggregatedAt,_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'aggregated_at')  DateTime aggregatedAt,  List<HighestIntensityItem> items)?  $default,) {final _that = this;
switch (_that) {
case _HighestIntensityResponse() when $default != null:
return $default(_that.aggregatedAt,_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HighestIntensityResponse implements HighestIntensityResponse {
  const _HighestIntensityResponse({@JsonKey(name: 'aggregated_at') required this.aggregatedAt, required final  List<HighestIntensityItem> items}): _items = items;
  factory _HighestIntensityResponse.fromJson(Map<String, dynamic> json) => _$HighestIntensityResponseFromJson(json);

/// このレスポンスで最高震度集計を生成した時刻
@override@JsonKey(name: 'aggregated_at') final  DateTime aggregatedAt;
 final  List<HighestIntensityItem> _items;
@override List<HighestIntensityItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of HighestIntensityResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HighestIntensityResponseCopyWith<_HighestIntensityResponse> get copyWith => __$HighestIntensityResponseCopyWithImpl<_HighestIntensityResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HighestIntensityResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HighestIntensityResponse&&(identical(other.aggregatedAt, aggregatedAt) || other.aggregatedAt == aggregatedAt)&&const DeepCollectionEquality().equals(other._items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,aggregatedAt,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'HighestIntensityResponse(aggregatedAt: $aggregatedAt, items: $items)';
}


}

/// @nodoc
abstract mixin class _$HighestIntensityResponseCopyWith<$Res> implements $HighestIntensityResponseCopyWith<$Res> {
  factory _$HighestIntensityResponseCopyWith(_HighestIntensityResponse value, $Res Function(_HighestIntensityResponse) _then) = __$HighestIntensityResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'aggregated_at') DateTime aggregatedAt, List<HighestIntensityItem> items
});




}
/// @nodoc
class __$HighestIntensityResponseCopyWithImpl<$Res>
    implements _$HighestIntensityResponseCopyWith<$Res> {
  __$HighestIntensityResponseCopyWithImpl(this._self, this._then);

  final _HighestIntensityResponse _self;
  final $Res Function(_HighestIntensityResponse) _then;

/// Create a copy of HighestIntensityResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? aggregatedAt = null,Object? items = null,}) {
  return _then(_HighestIntensityResponse(
aggregatedAt: null == aggregatedAt ? _self.aggregatedAt : aggregatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<HighestIntensityItem>,
  ));
}


}

// dart format on
