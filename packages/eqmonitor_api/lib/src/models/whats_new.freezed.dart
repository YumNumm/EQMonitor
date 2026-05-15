// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'whats_new.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WhatsNew {

 String get content;@JsonKey(includeIfNull: false) String? get title;
/// Create a copy of WhatsNew
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WhatsNewCopyWith<WhatsNew> get copyWith => _$WhatsNewCopyWithImpl<WhatsNew>(this as WhatsNew, _$identity);

  /// Serializes this WhatsNew to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WhatsNew&&(identical(other.content, content) || other.content == content)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,content,title);

@override
String toString() {
  return 'WhatsNew(content: $content, title: $title)';
}


}

/// @nodoc
abstract mixin class $WhatsNewCopyWith<$Res>  {
  factory $WhatsNewCopyWith(WhatsNew value, $Res Function(WhatsNew) _then) = _$WhatsNewCopyWithImpl;
@useResult
$Res call({
 String content,@JsonKey(includeIfNull: false) String? title
});




}
/// @nodoc
class _$WhatsNewCopyWithImpl<$Res>
    implements $WhatsNewCopyWith<$Res> {
  _$WhatsNewCopyWithImpl(this._self, this._then);

  final WhatsNew _self;
  final $Res Function(WhatsNew) _then;

/// Create a copy of WhatsNew
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? content = null,Object? title = freezed,}) {
  return _then(_self.copyWith(
content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [WhatsNew].
extension WhatsNewPatterns on WhatsNew {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WhatsNew value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WhatsNew() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WhatsNew value)  $default,){
final _that = this;
switch (_that) {
case _WhatsNew():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WhatsNew value)?  $default,){
final _that = this;
switch (_that) {
case _WhatsNew() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String content, @JsonKey(includeIfNull: false)  String? title)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WhatsNew() when $default != null:
return $default(_that.content,_that.title);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String content, @JsonKey(includeIfNull: false)  String? title)  $default,) {final _that = this;
switch (_that) {
case _WhatsNew():
return $default(_that.content,_that.title);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String content, @JsonKey(includeIfNull: false)  String? title)?  $default,) {final _that = this;
switch (_that) {
case _WhatsNew() when $default != null:
return $default(_that.content,_that.title);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WhatsNew implements WhatsNew {
  const _WhatsNew({required this.content, @JsonKey(includeIfNull: false) this.title});
  factory _WhatsNew.fromJson(Map<String, dynamic> json) => _$WhatsNewFromJson(json);

@override final  String content;
@override@JsonKey(includeIfNull: false) final  String? title;

/// Create a copy of WhatsNew
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WhatsNewCopyWith<_WhatsNew> get copyWith => __$WhatsNewCopyWithImpl<_WhatsNew>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WhatsNewToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WhatsNew&&(identical(other.content, content) || other.content == content)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,content,title);

@override
String toString() {
  return 'WhatsNew(content: $content, title: $title)';
}


}

/// @nodoc
abstract mixin class _$WhatsNewCopyWith<$Res> implements $WhatsNewCopyWith<$Res> {
  factory _$WhatsNewCopyWith(_WhatsNew value, $Res Function(_WhatsNew) _then) = __$WhatsNewCopyWithImpl;
@override @useResult
$Res call({
 String content,@JsonKey(includeIfNull: false) String? title
});




}
/// @nodoc
class __$WhatsNewCopyWithImpl<$Res>
    implements _$WhatsNewCopyWith<$Res> {
  __$WhatsNewCopyWithImpl(this._self, this._then);

  final _WhatsNew _self;
  final $Res Function(_WhatsNew) _then;

/// Create a copy of WhatsNew
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? content = null,Object? title = freezed,}) {
  return _then(_WhatsNew(
content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
