// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_comments.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FeedComments {

 String get free;
/// Create a copy of FeedComments
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedCommentsCopyWith<FeedComments> get copyWith => _$FeedCommentsCopyWithImpl<FeedComments>(this as FeedComments, _$identity);

  /// Serializes this FeedComments to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedComments&&(identical(other.free, free) || other.free == free));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,free);

@override
String toString() {
  return 'FeedComments(free: $free)';
}


}

/// @nodoc
abstract mixin class $FeedCommentsCopyWith<$Res>  {
  factory $FeedCommentsCopyWith(FeedComments value, $Res Function(FeedComments) _then) = _$FeedCommentsCopyWithImpl;
@useResult
$Res call({
 String free
});




}
/// @nodoc
class _$FeedCommentsCopyWithImpl<$Res>
    implements $FeedCommentsCopyWith<$Res> {
  _$FeedCommentsCopyWithImpl(this._self, this._then);

  final FeedComments _self;
  final $Res Function(FeedComments) _then;

/// Create a copy of FeedComments
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? free = null,}) {
  return _then(FeedComments(
free: null == free ? _self.free : free // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FeedComments].
extension FeedCommentsPatterns on FeedComments {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedComments value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedComments() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedComments value)  $default,){
final _that = this;
switch (_that) {
case _FeedComments():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedComments value)?  $default,){
final _that = this;
switch (_that) {
case _FeedComments() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String free)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedComments() when $default != null:
return $default(_that.free);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String free)  $default,) {final _that = this;
switch (_that) {
case _FeedComments():
return $default(_that.free);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String free)?  $default,) {final _that = this;
switch (_that) {
case _FeedComments() when $default != null:
return $default(_that.free);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FeedComments implements FeedComments {
  const _FeedComments({required this.free});
  factory _FeedComments.fromJson(Map<String, dynamic> json) => _$FeedCommentsFromJson(json);

@override final  String free;

/// Create a copy of FeedComments
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedCommentsCopyWith<_FeedComments> get copyWith => __$FeedCommentsCopyWithImpl<_FeedComments>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeedCommentsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedComments&&(identical(other.free, free) || other.free == free));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,free);

@override
String toString() {
  return 'FeedComments(free: $free)';
}


}

/// @nodoc
abstract mixin class _$FeedCommentsCopyWith<$Res> implements $FeedCommentsCopyWith<$Res> {
  factory _$FeedCommentsCopyWith(_FeedComments value, $Res Function(_FeedComments) _then) = __$FeedCommentsCopyWithImpl;
@override @useResult
$Res call({
 String free
});




}
/// @nodoc
class __$FeedCommentsCopyWithImpl<$Res>
    implements _$FeedCommentsCopyWith<$Res> {
  __$FeedCommentsCopyWithImpl(this._self, this._then);

  final _FeedComments _self;
  final $Res Function(_FeedComments) _then;

/// Create a copy of FeedComments
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? free = null,}) {
  return _then(_FeedComments(
free: null == free ? _self.free : free // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
