// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eew_list_page.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EewListPage {

 List<EewTelegramItem> get items; String? get nextToken;
/// Create a copy of EewListPage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewListPageCopyWith<EewListPage> get copyWith => _$EewListPageCopyWithImpl<EewListPage>(this as EewListPage, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewListPage&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.nextToken, nextToken) || other.nextToken == nextToken));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),nextToken);

@override
String toString() {
  return 'EewListPage(items: $items, nextToken: $nextToken)';
}


}

/// @nodoc
abstract mixin class $EewListPageCopyWith<$Res>  {
  factory $EewListPageCopyWith(EewListPage value, $Res Function(EewListPage) _then) = _$EewListPageCopyWithImpl;
@useResult
$Res call({
 List<EewTelegramItem> items, String? nextToken
});




}
/// @nodoc
class _$EewListPageCopyWithImpl<$Res>
    implements $EewListPageCopyWith<$Res> {
  _$EewListPageCopyWithImpl(this._self, this._then);

  final EewListPage _self;
  final $Res Function(EewListPage) _then;

/// Create a copy of EewListPage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? nextToken = freezed,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<EewTelegramItem>,nextToken: freezed == nextToken ? _self.nextToken : nextToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EewListPage].
extension EewListPagePatterns on EewListPage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EewListPage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EewListPage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EewListPage value)  $default,){
final _that = this;
switch (_that) {
case _EewListPage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EewListPage value)?  $default,){
final _that = this;
switch (_that) {
case _EewListPage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<EewTelegramItem> items,  String? nextToken)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EewListPage() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<EewTelegramItem> items,  String? nextToken)  $default,) {final _that = this;
switch (_that) {
case _EewListPage():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<EewTelegramItem> items,  String? nextToken)?  $default,) {final _that = this;
switch (_that) {
case _EewListPage() when $default != null:
return $default(_that.items,_that.nextToken);case _:
  return null;

}
}

}

/// @nodoc


class _EewListPage implements EewListPage {
  const _EewListPage({required final  List<EewTelegramItem> items, required this.nextToken}): _items = items;
  

 final  List<EewTelegramItem> _items;
@override List<EewTelegramItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  String? nextToken;

/// Create a copy of EewListPage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EewListPageCopyWith<_EewListPage> get copyWith => __$EewListPageCopyWithImpl<_EewListPage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EewListPage&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.nextToken, nextToken) || other.nextToken == nextToken));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),nextToken);

@override
String toString() {
  return 'EewListPage(items: $items, nextToken: $nextToken)';
}


}

/// @nodoc
abstract mixin class _$EewListPageCopyWith<$Res> implements $EewListPageCopyWith<$Res> {
  factory _$EewListPageCopyWith(_EewListPage value, $Res Function(_EewListPage) _then) = __$EewListPageCopyWithImpl;
@override @useResult
$Res call({
 List<EewTelegramItem> items, String? nextToken
});




}
/// @nodoc
class __$EewListPageCopyWithImpl<$Res>
    implements _$EewListPageCopyWith<$Res> {
  __$EewListPageCopyWithImpl(this._self, this._then);

  final _EewListPage _self;
  final $Res Function(_EewListPage) _then;

/// Create a copy of EewListPage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? nextToken = freezed,}) {
  return _then(_EewListPage(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<EewTelegramItem>,nextToken: freezed == nextToken ? _self.nextToken : nextToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
