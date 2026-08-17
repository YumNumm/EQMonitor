// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'changelog_section_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChangelogSectionModel {

 String get title; List<String> get items;
/// Create a copy of ChangelogSectionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChangelogSectionModelCopyWith<ChangelogSectionModel> get copyWith => _$ChangelogSectionModelCopyWithImpl<ChangelogSectionModel>(this as ChangelogSectionModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangelogSectionModel&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.items, items));
}


@override
int get hashCode => Object.hash(runtimeType,title,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'ChangelogSectionModel(title: $title, items: $items)';
}


}

/// @nodoc
abstract mixin class $ChangelogSectionModelCopyWith<$Res>  {
  factory $ChangelogSectionModelCopyWith(ChangelogSectionModel value, $Res Function(ChangelogSectionModel) _then) = _$ChangelogSectionModelCopyWithImpl;
@useResult
$Res call({
 String title, List<String> items
});




}
/// @nodoc
class _$ChangelogSectionModelCopyWithImpl<$Res>
    implements $ChangelogSectionModelCopyWith<$Res> {
  _$ChangelogSectionModelCopyWithImpl(this._self, this._then);

  final ChangelogSectionModel _self;
  final $Res Function(ChangelogSectionModel) _then;

/// Create a copy of ChangelogSectionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? items = null,}) {
  return _then(ChangelogSectionModel(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [ChangelogSectionModel].
extension ChangelogSectionModelPatterns on ChangelogSectionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChangelogSectionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChangelogSectionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChangelogSectionModel value)  $default,){
final _that = this;
switch (_that) {
case _ChangelogSectionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChangelogSectionModel value)?  $default,){
final _that = this;
switch (_that) {
case _ChangelogSectionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  List<String> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChangelogSectionModel() when $default != null:
return $default(_that.title,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  List<String> items)  $default,) {final _that = this;
switch (_that) {
case _ChangelogSectionModel():
return $default(_that.title,_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  List<String> items)?  $default,) {final _that = this;
switch (_that) {
case _ChangelogSectionModel() when $default != null:
return $default(_that.title,_that.items);case _:
  return null;

}
}

}

/// @nodoc


class _ChangelogSectionModel implements ChangelogSectionModel {
  const _ChangelogSectionModel({required this.title, required  List<String> items}): _items = items;
  

@override final  String title;
 final  List<String> _items;
@override List<String> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of ChangelogSectionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChangelogSectionModelCopyWith<_ChangelogSectionModel> get copyWith => __$ChangelogSectionModelCopyWithImpl<_ChangelogSectionModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChangelogSectionModel&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._items, _items));
}


@override
int get hashCode => Object.hash(runtimeType,title,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'ChangelogSectionModel(title: $title, items: $items)';
}


}

/// @nodoc
abstract mixin class _$ChangelogSectionModelCopyWith<$Res> implements $ChangelogSectionModelCopyWith<$Res> {
  factory _$ChangelogSectionModelCopyWith(_ChangelogSectionModel value, $Res Function(_ChangelogSectionModel) _then) = __$ChangelogSectionModelCopyWithImpl;
@override @useResult
$Res call({
 String title, List<String> items
});




}
/// @nodoc
class __$ChangelogSectionModelCopyWithImpl<$Res>
    implements _$ChangelogSectionModelCopyWith<$Res> {
  __$ChangelogSectionModelCopyWithImpl(this._self, this._then);

  final _ChangelogSectionModel _self;
  final $Res Function(_ChangelogSectionModel) _then;

/// Create a copy of ChangelogSectionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? items = null,}) {
  return _then(_ChangelogSectionModel(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
