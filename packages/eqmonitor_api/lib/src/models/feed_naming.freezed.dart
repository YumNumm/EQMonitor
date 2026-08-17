// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_naming.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FeedNaming {

 String get text;@JsonKey(includeIfNull: false) String? get en;
/// Create a copy of FeedNaming
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedNamingCopyWith<FeedNaming> get copyWith => _$FeedNamingCopyWithImpl<FeedNaming>(this as FeedNaming, _$identity);

  /// Serializes this FeedNaming to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedNaming&&(identical(other.text, text) || other.text == text)&&(identical(other.en, en) || other.en == en));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,en);

@override
String toString() {
  return 'FeedNaming(text: $text, en: $en)';
}


}

/// @nodoc
abstract mixin class $FeedNamingCopyWith<$Res>  {
  factory $FeedNamingCopyWith(FeedNaming value, $Res Function(FeedNaming) _then) = _$FeedNamingCopyWithImpl;
@useResult
$Res call({
 String text,@JsonKey(includeIfNull: false) String? en
});




}
/// @nodoc
class _$FeedNamingCopyWithImpl<$Res>
    implements $FeedNamingCopyWith<$Res> {
  _$FeedNamingCopyWithImpl(this._self, this._then);

  final FeedNaming _self;
  final $Res Function(FeedNaming) _then;

/// Create a copy of FeedNaming
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? text = null,Object? en = freezed,}) {
  return _then(FeedNaming(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,en: freezed == en ? _self.en : en // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FeedNaming].
extension FeedNamingPatterns on FeedNaming {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedNaming value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedNaming() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedNaming value)  $default,){
final _that = this;
switch (_that) {
case _FeedNaming():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedNaming value)?  $default,){
final _that = this;
switch (_that) {
case _FeedNaming() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String text, @JsonKey(includeIfNull: false)  String? en)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedNaming() when $default != null:
return $default(_that.text,_that.en);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String text, @JsonKey(includeIfNull: false)  String? en)  $default,) {final _that = this;
switch (_that) {
case _FeedNaming():
return $default(_that.text,_that.en);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String text, @JsonKey(includeIfNull: false)  String? en)?  $default,) {final _that = this;
switch (_that) {
case _FeedNaming() when $default != null:
return $default(_that.text,_that.en);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FeedNaming implements FeedNaming {
  const _FeedNaming({required this.text, @JsonKey(includeIfNull: false) this.en});
  factory _FeedNaming.fromJson(Map<String, dynamic> json) => _$FeedNamingFromJson(json);

@override final  String text;
@override@JsonKey(includeIfNull: false) final  String? en;

/// Create a copy of FeedNaming
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedNamingCopyWith<_FeedNaming> get copyWith => __$FeedNamingCopyWithImpl<_FeedNaming>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeedNamingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedNaming&&(identical(other.text, text) || other.text == text)&&(identical(other.en, en) || other.en == en));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,en);

@override
String toString() {
  return 'FeedNaming(text: $text, en: $en)';
}


}

/// @nodoc
abstract mixin class _$FeedNamingCopyWith<$Res> implements $FeedNamingCopyWith<$Res> {
  factory _$FeedNamingCopyWith(_FeedNaming value, $Res Function(_FeedNaming) _then) = __$FeedNamingCopyWithImpl;
@override @useResult
$Res call({
 String text,@JsonKey(includeIfNull: false) String? en
});




}
/// @nodoc
class __$FeedNamingCopyWithImpl<$Res>
    implements _$FeedNamingCopyWith<$Res> {
  __$FeedNamingCopyWithImpl(this._self, this._then);

  final _FeedNaming _self;
  final $Res Function(_FeedNaming) _then;

/// Create a copy of FeedNaming
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = null,Object? en = freezed,}) {
  return _then(_FeedNaming(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,en: freezed == en ? _self.en : en // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
