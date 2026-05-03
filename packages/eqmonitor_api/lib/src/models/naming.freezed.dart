// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'naming.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Naming {

 String get text;@JsonKey(includeIfNull: false) String? get en;
/// Create a copy of Naming
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NamingCopyWith<Naming> get copyWith => _$NamingCopyWithImpl<Naming>(this as Naming, _$identity);

  /// Serializes this Naming to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Naming&&(identical(other.text, text) || other.text == text)&&(identical(other.en, en) || other.en == en));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,en);

@override
String toString() {
  return 'Naming(text: $text, en: $en)';
}


}

/// @nodoc
abstract mixin class $NamingCopyWith<$Res>  {
  factory $NamingCopyWith(Naming value, $Res Function(Naming) _then) = _$NamingCopyWithImpl;
@useResult
$Res call({
 String text,@JsonKey(includeIfNull: false) String? en
});




}
/// @nodoc
class _$NamingCopyWithImpl<$Res>
    implements $NamingCopyWith<$Res> {
  _$NamingCopyWithImpl(this._self, this._then);

  final Naming _self;
  final $Res Function(Naming) _then;

/// Create a copy of Naming
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? text = null,Object? en = freezed,}) {
  return _then(_self.copyWith(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,en: freezed == en ? _self.en : en // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Naming].
extension NamingPatterns on Naming {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Naming value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Naming() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Naming value)  $default,){
final _that = this;
switch (_that) {
case _Naming():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Naming value)?  $default,){
final _that = this;
switch (_that) {
case _Naming() when $default != null:
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
case _Naming() when $default != null:
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
case _Naming():
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
case _Naming() when $default != null:
return $default(_that.text,_that.en);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Naming implements Naming {
  const _Naming({required this.text, @JsonKey(includeIfNull: false) this.en});
  factory _Naming.fromJson(Map<String, dynamic> json) => _$NamingFromJson(json);

@override final  String text;
@override@JsonKey(includeIfNull: false) final  String? en;

/// Create a copy of Naming
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NamingCopyWith<_Naming> get copyWith => __$NamingCopyWithImpl<_Naming>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NamingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Naming&&(identical(other.text, text) || other.text == text)&&(identical(other.en, en) || other.en == en));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,en);

@override
String toString() {
  return 'Naming(text: $text, en: $en)';
}


}

/// @nodoc
abstract mixin class _$NamingCopyWith<$Res> implements $NamingCopyWith<$Res> {
  factory _$NamingCopyWith(_Naming value, $Res Function(_Naming) _then) = __$NamingCopyWithImpl;
@override @useResult
$Res call({
 String text,@JsonKey(includeIfNull: false) String? en
});




}
/// @nodoc
class __$NamingCopyWithImpl<$Res>
    implements _$NamingCopyWith<$Res> {
  __$NamingCopyWithImpl(this._self, this._then);

  final _Naming _self;
  final $Res Function(_Naming) _then;

/// Create a copy of Naming
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = null,Object? en = freezed,}) {
  return _then(_Naming(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,en: freezed == en ? _self.en : en // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
