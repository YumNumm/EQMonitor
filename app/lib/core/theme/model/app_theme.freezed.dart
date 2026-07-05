// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_theme.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppTheme {

 String get name; int get version; String get author; List<ThemeBrightnessMode> get modes; ThemeColorSet? get light; ThemeColorSet? get dark;
/// Create a copy of AppTheme
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppThemeCopyWith<AppTheme> get copyWith => _$AppThemeCopyWithImpl<AppTheme>(this as AppTheme, _$identity);

  /// Serializes this AppTheme to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppTheme&&(identical(other.name, name) || other.name == name)&&(identical(other.version, version) || other.version == version)&&(identical(other.author, author) || other.author == author)&&const DeepCollectionEquality().equals(other.modes, modes)&&(identical(other.light, light) || other.light == light)&&(identical(other.dark, dark) || other.dark == dark));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,version,author,const DeepCollectionEquality().hash(modes),light,dark);

@override
String toString() {
  return 'AppTheme(name: $name, version: $version, author: $author, modes: $modes, light: $light, dark: $dark)';
}


}

/// @nodoc
abstract mixin class $AppThemeCopyWith<$Res>  {
  factory $AppThemeCopyWith(AppTheme value, $Res Function(AppTheme) _then) = _$AppThemeCopyWithImpl;
@useResult
$Res call({
 String name, int version, String author, List<ThemeBrightnessMode> modes, ThemeColorSet? light, ThemeColorSet? dark
});


$ThemeColorSetCopyWith<$Res>? get light;$ThemeColorSetCopyWith<$Res>? get dark;

}
/// @nodoc
class _$AppThemeCopyWithImpl<$Res>
    implements $AppThemeCopyWith<$Res> {
  _$AppThemeCopyWithImpl(this._self, this._then);

  final AppTheme _self;
  final $Res Function(AppTheme) _then;

/// Create a copy of AppTheme
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? version = null,Object? author = null,Object? modes = null,Object? light = freezed,Object? dark = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,modes: null == modes ? _self.modes : modes // ignore: cast_nullable_to_non_nullable
as List<ThemeBrightnessMode>,light: freezed == light ? _self.light : light // ignore: cast_nullable_to_non_nullable
as ThemeColorSet?,dark: freezed == dark ? _self.dark : dark // ignore: cast_nullable_to_non_nullable
as ThemeColorSet?,
  ));
}
/// Create a copy of AppTheme
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ThemeColorSetCopyWith<$Res>? get light {
    if (_self.light == null) {
    return null;
  }

  return $ThemeColorSetCopyWith<$Res>(_self.light!, (value) {
    return _then(_self.copyWith(light: value));
  });
}/// Create a copy of AppTheme
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ThemeColorSetCopyWith<$Res>? get dark {
    if (_self.dark == null) {
    return null;
  }

  return $ThemeColorSetCopyWith<$Res>(_self.dark!, (value) {
    return _then(_self.copyWith(dark: value));
  });
}
}


/// Adds pattern-matching-related methods to [AppTheme].
extension AppThemePatterns on AppTheme {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppTheme value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppTheme() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppTheme value)  $default,){
final _that = this;
switch (_that) {
case _AppTheme():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppTheme value)?  $default,){
final _that = this;
switch (_that) {
case _AppTheme() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  int version,  String author,  List<ThemeBrightnessMode> modes,  ThemeColorSet? light,  ThemeColorSet? dark)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppTheme() when $default != null:
return $default(_that.name,_that.version,_that.author,_that.modes,_that.light,_that.dark);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  int version,  String author,  List<ThemeBrightnessMode> modes,  ThemeColorSet? light,  ThemeColorSet? dark)  $default,) {final _that = this;
switch (_that) {
case _AppTheme():
return $default(_that.name,_that.version,_that.author,_that.modes,_that.light,_that.dark);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  int version,  String author,  List<ThemeBrightnessMode> modes,  ThemeColorSet? light,  ThemeColorSet? dark)?  $default,) {final _that = this;
switch (_that) {
case _AppTheme() when $default != null:
return $default(_that.name,_that.version,_that.author,_that.modes,_that.light,_that.dark);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppTheme extends AppTheme {
  const _AppTheme({required this.name, required this.version, required this.author, required final  List<ThemeBrightnessMode> modes, this.light, this.dark}): _modes = modes,super._();
  factory _AppTheme.fromJson(Map<String, dynamic> json) => _$AppThemeFromJson(json);

@override final  String name;
@override final  int version;
@override final  String author;
 final  List<ThemeBrightnessMode> _modes;
@override List<ThemeBrightnessMode> get modes {
  if (_modes is EqualUnmodifiableListView) return _modes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_modes);
}

@override final  ThemeColorSet? light;
@override final  ThemeColorSet? dark;

/// Create a copy of AppTheme
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppThemeCopyWith<_AppTheme> get copyWith => __$AppThemeCopyWithImpl<_AppTheme>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppThemeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppTheme&&(identical(other.name, name) || other.name == name)&&(identical(other.version, version) || other.version == version)&&(identical(other.author, author) || other.author == author)&&const DeepCollectionEquality().equals(other._modes, _modes)&&(identical(other.light, light) || other.light == light)&&(identical(other.dark, dark) || other.dark == dark));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,version,author,const DeepCollectionEquality().hash(_modes),light,dark);

@override
String toString() {
  return 'AppTheme(name: $name, version: $version, author: $author, modes: $modes, light: $light, dark: $dark)';
}


}

/// @nodoc
abstract mixin class _$AppThemeCopyWith<$Res> implements $AppThemeCopyWith<$Res> {
  factory _$AppThemeCopyWith(_AppTheme value, $Res Function(_AppTheme) _then) = __$AppThemeCopyWithImpl;
@override @useResult
$Res call({
 String name, int version, String author, List<ThemeBrightnessMode> modes, ThemeColorSet? light, ThemeColorSet? dark
});


@override $ThemeColorSetCopyWith<$Res>? get light;@override $ThemeColorSetCopyWith<$Res>? get dark;

}
/// @nodoc
class __$AppThemeCopyWithImpl<$Res>
    implements _$AppThemeCopyWith<$Res> {
  __$AppThemeCopyWithImpl(this._self, this._then);

  final _AppTheme _self;
  final $Res Function(_AppTheme) _then;

/// Create a copy of AppTheme
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? version = null,Object? author = null,Object? modes = null,Object? light = freezed,Object? dark = freezed,}) {
  return _then(_AppTheme(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,modes: null == modes ? _self._modes : modes // ignore: cast_nullable_to_non_nullable
as List<ThemeBrightnessMode>,light: freezed == light ? _self.light : light // ignore: cast_nullable_to_non_nullable
as ThemeColorSet?,dark: freezed == dark ? _self.dark : dark // ignore: cast_nullable_to_non_nullable
as ThemeColorSet?,
  ));
}

/// Create a copy of AppTheme
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ThemeColorSetCopyWith<$Res>? get light {
    if (_self.light == null) {
    return null;
  }

  return $ThemeColorSetCopyWith<$Res>(_self.light!, (value) {
    return _then(_self.copyWith(light: value));
  });
}/// Create a copy of AppTheme
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ThemeColorSetCopyWith<$Res>? get dark {
    if (_self.dark == null) {
    return null;
  }

  return $ThemeColorSetCopyWith<$Res>(_self.dark!, (value) {
    return _then(_self.copyWith(dark: value));
  });
}
}

// dart format on
