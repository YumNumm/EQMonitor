// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'changelog_section.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChangelogSection {

 String get title; List<String> get items;
/// Create a copy of ChangelogSection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChangelogSectionCopyWith<ChangelogSection> get copyWith => _$ChangelogSectionCopyWithImpl<ChangelogSection>(this as ChangelogSection, _$identity);

  /// Serializes this ChangelogSection to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangelogSection&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.items, items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'ChangelogSection(title: $title, items: $items)';
}


}

/// @nodoc
abstract mixin class $ChangelogSectionCopyWith<$Res>  {
  factory $ChangelogSectionCopyWith(ChangelogSection value, $Res Function(ChangelogSection) _then) = _$ChangelogSectionCopyWithImpl;
@useResult
$Res call({
 String title, List<String> items
});




}
/// @nodoc
class _$ChangelogSectionCopyWithImpl<$Res>
    implements $ChangelogSectionCopyWith<$Res> {
  _$ChangelogSectionCopyWithImpl(this._self, this._then);

  final ChangelogSection _self;
  final $Res Function(ChangelogSection) _then;

/// Create a copy of ChangelogSection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? items = null,}) {
  return _then(ChangelogSection(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [ChangelogSection].
extension ChangelogSectionPatterns on ChangelogSection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChangelogSection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChangelogSection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChangelogSection value)  $default,){
final _that = this;
switch (_that) {
case _ChangelogSection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChangelogSection value)?  $default,){
final _that = this;
switch (_that) {
case _ChangelogSection() when $default != null:
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
case _ChangelogSection() when $default != null:
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
case _ChangelogSection():
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
case _ChangelogSection() when $default != null:
return $default(_that.title,_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChangelogSection implements ChangelogSection {
  const _ChangelogSection({required this.title, required  List<String> items}): _items = items;
  factory _ChangelogSection.fromJson(Map<String, dynamic> json) => _$ChangelogSectionFromJson(json);

@override final  String title;
 final  List<String> _items;
@override List<String> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of ChangelogSection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChangelogSectionCopyWith<_ChangelogSection> get copyWith => __$ChangelogSectionCopyWithImpl<_ChangelogSection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChangelogSectionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChangelogSection&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'ChangelogSection(title: $title, items: $items)';
}


}

/// @nodoc
abstract mixin class _$ChangelogSectionCopyWith<$Res> implements $ChangelogSectionCopyWith<$Res> {
  factory _$ChangelogSectionCopyWith(_ChangelogSection value, $Res Function(_ChangelogSection) _then) = __$ChangelogSectionCopyWithImpl;
@override @useResult
$Res call({
 String title, List<String> items
});




}
/// @nodoc
class __$ChangelogSectionCopyWithImpl<$Res>
    implements _$ChangelogSectionCopyWith<$Res> {
  __$ChangelogSectionCopyWithImpl(this._self, this._then);

  final _ChangelogSection _self;
  final $Res Function(_ChangelogSection) _then;

/// Create a copy of ChangelogSection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? items = null,}) {
  return _then(_ChangelogSection(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
