// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'city_intensity_page.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CityIntensityPage {

 List<IntensityCitySearchItem> get items; String? get nextToken;
/// Create a copy of CityIntensityPage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CityIntensityPageCopyWith<CityIntensityPage> get copyWith => _$CityIntensityPageCopyWithImpl<CityIntensityPage>(this as CityIntensityPage, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CityIntensityPage&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.nextToken, nextToken) || other.nextToken == nextToken));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),nextToken);

@override
String toString() {
  return 'CityIntensityPage(items: $items, nextToken: $nextToken)';
}


}

/// @nodoc
abstract mixin class $CityIntensityPageCopyWith<$Res>  {
  factory $CityIntensityPageCopyWith(CityIntensityPage value, $Res Function(CityIntensityPage) _then) = _$CityIntensityPageCopyWithImpl;
@useResult
$Res call({
 List<IntensityCitySearchItem> items, String? nextToken
});




}
/// @nodoc
class _$CityIntensityPageCopyWithImpl<$Res>
    implements $CityIntensityPageCopyWith<$Res> {
  _$CityIntensityPageCopyWithImpl(this._self, this._then);

  final CityIntensityPage _self;
  final $Res Function(CityIntensityPage) _then;

/// Create a copy of CityIntensityPage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? nextToken = freezed,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<IntensityCitySearchItem>,nextToken: freezed == nextToken ? _self.nextToken : nextToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CityIntensityPage].
extension CityIntensityPagePatterns on CityIntensityPage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CityIntensityPage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CityIntensityPage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CityIntensityPage value)  $default,){
final _that = this;
switch (_that) {
case _CityIntensityPage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CityIntensityPage value)?  $default,){
final _that = this;
switch (_that) {
case _CityIntensityPage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<IntensityCitySearchItem> items,  String? nextToken)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CityIntensityPage() when $default != null:
return $default(_that.items,_that.nextToken);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<IntensityCitySearchItem> items,  String? nextToken)  $default,) {final _that = this;
switch (_that) {
case _CityIntensityPage():
return $default(_that.items,_that.nextToken);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<IntensityCitySearchItem> items,  String? nextToken)?  $default,) {final _that = this;
switch (_that) {
case _CityIntensityPage() when $default != null:
return $default(_that.items,_that.nextToken);case _:
  return null;

}
}

}

/// @nodoc


class _CityIntensityPage implements CityIntensityPage {
  const _CityIntensityPage({required final  List<IntensityCitySearchItem> items, required this.nextToken}): _items = items;
  

 final  List<IntensityCitySearchItem> _items;
@override List<IntensityCitySearchItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  String? nextToken;

/// Create a copy of CityIntensityPage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CityIntensityPageCopyWith<_CityIntensityPage> get copyWith => __$CityIntensityPageCopyWithImpl<_CityIntensityPage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CityIntensityPage&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.nextToken, nextToken) || other.nextToken == nextToken));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),nextToken);

@override
String toString() {
  return 'CityIntensityPage(items: $items, nextToken: $nextToken)';
}


}

/// @nodoc
abstract mixin class _$CityIntensityPageCopyWith<$Res> implements $CityIntensityPageCopyWith<$Res> {
  factory _$CityIntensityPageCopyWith(_CityIntensityPage value, $Res Function(_CityIntensityPage) _then) = __$CityIntensityPageCopyWithImpl;
@override @useResult
$Res call({
 List<IntensityCitySearchItem> items, String? nextToken
});




}
/// @nodoc
class __$CityIntensityPageCopyWithImpl<$Res>
    implements _$CityIntensityPageCopyWith<$Res> {
  __$CityIntensityPageCopyWithImpl(this._self, this._then);

  final _CityIntensityPage _self;
  final $Res Function(_CityIntensityPage) _then;

/// Create a copy of CityIntensityPage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? nextToken = freezed,}) {
  return _then(_CityIntensityPage(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<IntensityCitySearchItem>,nextToken: freezed == nextToken ? _self.nextToken : nextToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
