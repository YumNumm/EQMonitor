// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prefecture_intensity_page.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PrefectureIntensityPage {

 List<IntensityAreaSearchItem> get items; String? get nextToken;
/// Create a copy of PrefectureIntensityPage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrefectureIntensityPageCopyWith<PrefectureIntensityPage> get copyWith => _$PrefectureIntensityPageCopyWithImpl<PrefectureIntensityPage>(this as PrefectureIntensityPage, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrefectureIntensityPage&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.nextToken, nextToken) || other.nextToken == nextToken));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),nextToken);

@override
String toString() {
  return 'PrefectureIntensityPage(items: $items, nextToken: $nextToken)';
}


}

/// @nodoc
abstract mixin class $PrefectureIntensityPageCopyWith<$Res>  {
  factory $PrefectureIntensityPageCopyWith(PrefectureIntensityPage value, $Res Function(PrefectureIntensityPage) _then) = _$PrefectureIntensityPageCopyWithImpl;
@useResult
$Res call({
 List<IntensityAreaSearchItem> items, String? nextToken
});




}
/// @nodoc
class _$PrefectureIntensityPageCopyWithImpl<$Res>
    implements $PrefectureIntensityPageCopyWith<$Res> {
  _$PrefectureIntensityPageCopyWithImpl(this._self, this._then);

  final PrefectureIntensityPage _self;
  final $Res Function(PrefectureIntensityPage) _then;

/// Create a copy of PrefectureIntensityPage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? nextToken = freezed,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<IntensityAreaSearchItem>,nextToken: freezed == nextToken ? _self.nextToken : nextToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PrefectureIntensityPage].
extension PrefectureIntensityPagePatterns on PrefectureIntensityPage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PrefectureIntensityPage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PrefectureIntensityPage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PrefectureIntensityPage value)  $default,){
final _that = this;
switch (_that) {
case _PrefectureIntensityPage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PrefectureIntensityPage value)?  $default,){
final _that = this;
switch (_that) {
case _PrefectureIntensityPage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<IntensityAreaSearchItem> items,  String? nextToken)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PrefectureIntensityPage() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<IntensityAreaSearchItem> items,  String? nextToken)  $default,) {final _that = this;
switch (_that) {
case _PrefectureIntensityPage():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<IntensityAreaSearchItem> items,  String? nextToken)?  $default,) {final _that = this;
switch (_that) {
case _PrefectureIntensityPage() when $default != null:
return $default(_that.items,_that.nextToken);case _:
  return null;

}
}

}

/// @nodoc


class _PrefectureIntensityPage implements PrefectureIntensityPage {
  const _PrefectureIntensityPage({required final  List<IntensityAreaSearchItem> items, required this.nextToken}): _items = items;
  

 final  List<IntensityAreaSearchItem> _items;
@override List<IntensityAreaSearchItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  String? nextToken;

/// Create a copy of PrefectureIntensityPage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PrefectureIntensityPageCopyWith<_PrefectureIntensityPage> get copyWith => __$PrefectureIntensityPageCopyWithImpl<_PrefectureIntensityPage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PrefectureIntensityPage&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.nextToken, nextToken) || other.nextToken == nextToken));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),nextToken);

@override
String toString() {
  return 'PrefectureIntensityPage(items: $items, nextToken: $nextToken)';
}


}

/// @nodoc
abstract mixin class _$PrefectureIntensityPageCopyWith<$Res> implements $PrefectureIntensityPageCopyWith<$Res> {
  factory _$PrefectureIntensityPageCopyWith(_PrefectureIntensityPage value, $Res Function(_PrefectureIntensityPage) _then) = __$PrefectureIntensityPageCopyWithImpl;
@override @useResult
$Res call({
 List<IntensityAreaSearchItem> items, String? nextToken
});




}
/// @nodoc
class __$PrefectureIntensityPageCopyWithImpl<$Res>
    implements _$PrefectureIntensityPageCopyWith<$Res> {
  __$PrefectureIntensityPageCopyWithImpl(this._self, this._then);

  final _PrefectureIntensityPage _self;
  final $Res Function(_PrefectureIntensityPage) _then;

/// Create a copy of PrefectureIntensityPage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? nextToken = freezed,}) {
  return _then(_PrefectureIntensityPage(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<IntensityAreaSearchItem>,nextToken: freezed == nextToken ? _self.nextToken : nextToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
