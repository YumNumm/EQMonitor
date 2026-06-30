// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'info_link.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InfoLink {

 String get title; String get url;
/// Create a copy of InfoLink
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InfoLinkCopyWith<InfoLink> get copyWith => _$InfoLinkCopyWithImpl<InfoLink>(this as InfoLink, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InfoLink&&(identical(other.title, title) || other.title == title)&&(identical(other.url, url) || other.url == url));
}


@override
int get hashCode => Object.hash(runtimeType,title,url);

@override
String toString() {
  return 'InfoLink(title: $title, url: $url)';
}


}

/// @nodoc
abstract mixin class $InfoLinkCopyWith<$Res>  {
  factory $InfoLinkCopyWith(InfoLink value, $Res Function(InfoLink) _then) = _$InfoLinkCopyWithImpl;
@useResult
$Res call({
 String title, String url
});




}
/// @nodoc
class _$InfoLinkCopyWithImpl<$Res>
    implements $InfoLinkCopyWith<$Res> {
  _$InfoLinkCopyWithImpl(this._self, this._then);

  final InfoLink _self;
  final $Res Function(InfoLink) _then;

/// Create a copy of InfoLink
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? url = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [InfoLink].
extension InfoLinkPatterns on InfoLink {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InfoLink value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InfoLink() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InfoLink value)  $default,){
final _that = this;
switch (_that) {
case _InfoLink():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InfoLink value)?  $default,){
final _that = this;
switch (_that) {
case _InfoLink() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String url)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InfoLink() when $default != null:
return $default(_that.title,_that.url);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String url)  $default,) {final _that = this;
switch (_that) {
case _InfoLink():
return $default(_that.title,_that.url);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String url)?  $default,) {final _that = this;
switch (_that) {
case _InfoLink() when $default != null:
return $default(_that.title,_that.url);case _:
  return null;

}
}

}

/// @nodoc


class _InfoLink implements InfoLink {
  const _InfoLink({required this.title, required this.url});
  

@override final  String title;
@override final  String url;

/// Create a copy of InfoLink
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InfoLinkCopyWith<_InfoLink> get copyWith => __$InfoLinkCopyWithImpl<_InfoLink>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InfoLink&&(identical(other.title, title) || other.title == title)&&(identical(other.url, url) || other.url == url));
}


@override
int get hashCode => Object.hash(runtimeType,title,url);

@override
String toString() {
  return 'InfoLink(title: $title, url: $url)';
}


}

/// @nodoc
abstract mixin class _$InfoLinkCopyWith<$Res> implements $InfoLinkCopyWith<$Res> {
  factory _$InfoLinkCopyWith(_InfoLink value, $Res Function(_InfoLink) _then) = __$InfoLinkCopyWithImpl;
@override @useResult
$Res call({
 String title, String url
});




}
/// @nodoc
class __$InfoLinkCopyWithImpl<$Res>
    implements _$InfoLinkCopyWith<$Res> {
  __$InfoLinkCopyWithImpl(this._self, this._then);

  final _InfoLink _self;
  final $Res Function(_InfoLink) _then;

/// Create a copy of InfoLink
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? url = null,}) {
  return _then(_InfoLink(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
