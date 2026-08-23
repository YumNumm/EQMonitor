// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'city_max_intensity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CityMaxIntensity {

/// 集計を最後に更新した時刻。取得できなかった場合は `null`([items] は返る)。
 DateTime? get aggregatedAt; List<CityMaxIntensityEntry> get items;
/// Create a copy of CityMaxIntensity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CityMaxIntensityCopyWith<CityMaxIntensity> get copyWith => _$CityMaxIntensityCopyWithImpl<CityMaxIntensity>(this as CityMaxIntensity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CityMaxIntensity&&(identical(other.aggregatedAt, aggregatedAt) || other.aggregatedAt == aggregatedAt)&&const DeepCollectionEquality().equals(other.items, items));
}


@override
int get hashCode => Object.hash(runtimeType,aggregatedAt,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'CityMaxIntensity(aggregatedAt: $aggregatedAt, items: $items)';
}


}

/// @nodoc
abstract mixin class $CityMaxIntensityCopyWith<$Res>  {
  factory $CityMaxIntensityCopyWith(CityMaxIntensity value, $Res Function(CityMaxIntensity) _then) = _$CityMaxIntensityCopyWithImpl;
@useResult
$Res call({
 DateTime? aggregatedAt, List<CityMaxIntensityEntry> items
});




}
/// @nodoc
class _$CityMaxIntensityCopyWithImpl<$Res>
    implements $CityMaxIntensityCopyWith<$Res> {
  _$CityMaxIntensityCopyWithImpl(this._self, this._then);

  final CityMaxIntensity _self;
  final $Res Function(CityMaxIntensity) _then;

/// Create a copy of CityMaxIntensity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? aggregatedAt = freezed,Object? items = null,}) {
  return _then(CityMaxIntensity(
aggregatedAt: freezed == aggregatedAt ? _self.aggregatedAt : aggregatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<CityMaxIntensityEntry>,
  ));
}

}


/// Adds pattern-matching-related methods to [CityMaxIntensity].
extension CityMaxIntensityPatterns on CityMaxIntensity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CityMaxIntensity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CityMaxIntensity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CityMaxIntensity value)  $default,){
final _that = this;
switch (_that) {
case _CityMaxIntensity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CityMaxIntensity value)?  $default,){
final _that = this;
switch (_that) {
case _CityMaxIntensity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime? aggregatedAt,  List<CityMaxIntensityEntry> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CityMaxIntensity() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime? aggregatedAt,  List<CityMaxIntensityEntry> items)  $default,) {final _that = this;
switch (_that) {
case _CityMaxIntensity():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime? aggregatedAt,  List<CityMaxIntensityEntry> items)?  $default,) {final _that = this;
switch (_that) {
case _CityMaxIntensity() when $default != null:
return $default(_that.aggregatedAt,_that.items);case _:
  return null;

}
}

}

/// @nodoc


class _CityMaxIntensity extends CityMaxIntensity {
  const _CityMaxIntensity({required this.aggregatedAt, required  List<CityMaxIntensityEntry> items}): _items = items,super._();
  

/// 集計を最後に更新した時刻。取得できなかった場合は `null`([items] は返る)。
@override final  DateTime? aggregatedAt;
 final  List<CityMaxIntensityEntry> _items;
@override List<CityMaxIntensityEntry> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of CityMaxIntensity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CityMaxIntensityCopyWith<_CityMaxIntensity> get copyWith => __$CityMaxIntensityCopyWithImpl<_CityMaxIntensity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CityMaxIntensity&&(identical(other.aggregatedAt, aggregatedAt) || other.aggregatedAt == aggregatedAt)&&const DeepCollectionEquality().equals(other._items, _items));
}


@override
int get hashCode => Object.hash(runtimeType,aggregatedAt,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'CityMaxIntensity(aggregatedAt: $aggregatedAt, items: $items)';
}


}

/// @nodoc
abstract mixin class _$CityMaxIntensityCopyWith<$Res> implements $CityMaxIntensityCopyWith<$Res> {
  factory _$CityMaxIntensityCopyWith(_CityMaxIntensity value, $Res Function(_CityMaxIntensity) _then) = __$CityMaxIntensityCopyWithImpl;
@override @useResult
$Res call({
 DateTime? aggregatedAt, List<CityMaxIntensityEntry> items
});




}
/// @nodoc
class __$CityMaxIntensityCopyWithImpl<$Res>
    implements _$CityMaxIntensityCopyWith<$Res> {
  __$CityMaxIntensityCopyWithImpl(this._self, this._then);

  final _CityMaxIntensity _self;
  final $Res Function(_CityMaxIntensity) _then;

/// Create a copy of CityMaxIntensity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? aggregatedAt = freezed,Object? items = null,}) {
  return _then(_CityMaxIntensity(
aggregatedAt: freezed == aggregatedAt ? _self.aggregatedAt : aggregatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<CityMaxIntensityEntry>,
  ));
}


}

// dart format on
