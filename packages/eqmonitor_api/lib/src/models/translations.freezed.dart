// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'translations.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Translations {

 String get locale;@JsonKey(includeIfNull: false) String? get title;@JsonKey(includeIfNull: false) String? get summary;@JsonKey(includeIfNull: false) String? get body;
/// Create a copy of Translations
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TranslationsCopyWith<Translations> get copyWith => _$TranslationsCopyWithImpl<Translations>(this as Translations, _$identity);

  /// Serializes this Translations to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Translations&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.title, title) || other.title == title)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.body, body) || other.body == body));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,locale,title,summary,body);

@override
String toString() {
  return 'Translations(locale: $locale, title: $title, summary: $summary, body: $body)';
}


}

/// @nodoc
abstract mixin class $TranslationsCopyWith<$Res>  {
  factory $TranslationsCopyWith(Translations value, $Res Function(Translations) _then) = _$TranslationsCopyWithImpl;
@useResult
$Res call({
 String locale,@JsonKey(includeIfNull: false) String? title,@JsonKey(includeIfNull: false) String? summary,@JsonKey(includeIfNull: false) String? body
});




}
/// @nodoc
class _$TranslationsCopyWithImpl<$Res>
    implements $TranslationsCopyWith<$Res> {
  _$TranslationsCopyWithImpl(this._self, this._then);

  final Translations _self;
  final $Res Function(Translations) _then;

/// Create a copy of Translations
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? locale = null,Object? title = freezed,Object? summary = freezed,Object? body = freezed,}) {
  return _then(Translations(
locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String?,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Translations].
extension TranslationsPatterns on Translations {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Translations value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Translations() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Translations value)  $default,){
final _that = this;
switch (_that) {
case _Translations():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Translations value)?  $default,){
final _that = this;
switch (_that) {
case _Translations() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String locale, @JsonKey(includeIfNull: false)  String? title, @JsonKey(includeIfNull: false)  String? summary, @JsonKey(includeIfNull: false)  String? body)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Translations() when $default != null:
return $default(_that.locale,_that.title,_that.summary,_that.body);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String locale, @JsonKey(includeIfNull: false)  String? title, @JsonKey(includeIfNull: false)  String? summary, @JsonKey(includeIfNull: false)  String? body)  $default,) {final _that = this;
switch (_that) {
case _Translations():
return $default(_that.locale,_that.title,_that.summary,_that.body);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String locale, @JsonKey(includeIfNull: false)  String? title, @JsonKey(includeIfNull: false)  String? summary, @JsonKey(includeIfNull: false)  String? body)?  $default,) {final _that = this;
switch (_that) {
case _Translations() when $default != null:
return $default(_that.locale,_that.title,_that.summary,_that.body);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Translations implements Translations {
  const _Translations({required this.locale, @JsonKey(includeIfNull: false) this.title, @JsonKey(includeIfNull: false) this.summary, @JsonKey(includeIfNull: false) this.body});
  factory _Translations.fromJson(Map<String, dynamic> json) => _$TranslationsFromJson(json);

@override final  String locale;
@override@JsonKey(includeIfNull: false) final  String? title;
@override@JsonKey(includeIfNull: false) final  String? summary;
@override@JsonKey(includeIfNull: false) final  String? body;

/// Create a copy of Translations
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TranslationsCopyWith<_Translations> get copyWith => __$TranslationsCopyWithImpl<_Translations>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TranslationsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Translations&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.title, title) || other.title == title)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.body, body) || other.body == body));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,locale,title,summary,body);

@override
String toString() {
  return 'Translations(locale: $locale, title: $title, summary: $summary, body: $body)';
}


}

/// @nodoc
abstract mixin class _$TranslationsCopyWith<$Res> implements $TranslationsCopyWith<$Res> {
  factory _$TranslationsCopyWith(_Translations value, $Res Function(_Translations) _then) = __$TranslationsCopyWithImpl;
@override @useResult
$Res call({
 String locale,@JsonKey(includeIfNull: false) String? title,@JsonKey(includeIfNull: false) String? summary,@JsonKey(includeIfNull: false) String? body
});




}
/// @nodoc
class __$TranslationsCopyWithImpl<$Res>
    implements _$TranslationsCopyWith<$Res> {
  __$TranslationsCopyWithImpl(this._self, this._then);

  final _Translations _self;
  final $Res Function(_Translations) _then;

/// Create a copy of Translations
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? locale = null,Object? title = freezed,Object? summary = freezed,Object? body = freezed,}) {
  return _then(_Translations(
locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String?,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
