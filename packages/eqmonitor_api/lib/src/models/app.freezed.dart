// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$App {

 Version get version;@JsonKey(name: 'store_url') StoreUrl get storeUrl;
/// Create a copy of App
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppCopyWith<App> get copyWith => _$AppCopyWithImpl<App>(this as App, _$identity);

  /// Serializes this App to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is App&&(identical(other.version, version) || other.version == version)&&(identical(other.storeUrl, storeUrl) || other.storeUrl == storeUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,version,storeUrl);

@override
String toString() {
  return 'App(version: $version, storeUrl: $storeUrl)';
}


}

/// @nodoc
abstract mixin class $AppCopyWith<$Res>  {
  factory $AppCopyWith(App value, $Res Function(App) _then) = _$AppCopyWithImpl;
@useResult
$Res call({
 Version version,@JsonKey(name: 'store_url') StoreUrl storeUrl
});


$VersionCopyWith<$Res> get version;$StoreUrlCopyWith<$Res> get storeUrl;

}
/// @nodoc
class _$AppCopyWithImpl<$Res>
    implements $AppCopyWith<$Res> {
  _$AppCopyWithImpl(this._self, this._then);

  final App _self;
  final $Res Function(App) _then;

/// Create a copy of App
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? version = null,Object? storeUrl = null,}) {
  return _then(_self.copyWith(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as Version,storeUrl: null == storeUrl ? _self.storeUrl : storeUrl // ignore: cast_nullable_to_non_nullable
as StoreUrl,
  ));
}
/// Create a copy of App
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VersionCopyWith<$Res> get version {
  
  return $VersionCopyWith<$Res>(_self.version, (value) {
    return _then(_self.copyWith(version: value));
  });
}/// Create a copy of App
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StoreUrlCopyWith<$Res> get storeUrl {
  
  return $StoreUrlCopyWith<$Res>(_self.storeUrl, (value) {
    return _then(_self.copyWith(storeUrl: value));
  });
}
}


/// Adds pattern-matching-related methods to [App].
extension AppPatterns on App {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _App value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _App() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _App value)  $default,){
final _that = this;
switch (_that) {
case _App():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _App value)?  $default,){
final _that = this;
switch (_that) {
case _App() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Version version, @JsonKey(name: 'store_url')  StoreUrl storeUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _App() when $default != null:
return $default(_that.version,_that.storeUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Version version, @JsonKey(name: 'store_url')  StoreUrl storeUrl)  $default,) {final _that = this;
switch (_that) {
case _App():
return $default(_that.version,_that.storeUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Version version, @JsonKey(name: 'store_url')  StoreUrl storeUrl)?  $default,) {final _that = this;
switch (_that) {
case _App() when $default != null:
return $default(_that.version,_that.storeUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _App implements App {
  const _App({required this.version, @JsonKey(name: 'store_url') required this.storeUrl});
  factory _App.fromJson(Map<String, dynamic> json) => _$AppFromJson(json);

@override final  Version version;
@override@JsonKey(name: 'store_url') final  StoreUrl storeUrl;

/// Create a copy of App
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppCopyWith<_App> get copyWith => __$AppCopyWithImpl<_App>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _App&&(identical(other.version, version) || other.version == version)&&(identical(other.storeUrl, storeUrl) || other.storeUrl == storeUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,version,storeUrl);

@override
String toString() {
  return 'App(version: $version, storeUrl: $storeUrl)';
}


}

/// @nodoc
abstract mixin class _$AppCopyWith<$Res> implements $AppCopyWith<$Res> {
  factory _$AppCopyWith(_App value, $Res Function(_App) _then) = __$AppCopyWithImpl;
@override @useResult
$Res call({
 Version version,@JsonKey(name: 'store_url') StoreUrl storeUrl
});


@override $VersionCopyWith<$Res> get version;@override $StoreUrlCopyWith<$Res> get storeUrl;

}
/// @nodoc
class __$AppCopyWithImpl<$Res>
    implements _$AppCopyWith<$Res> {
  __$AppCopyWithImpl(this._self, this._then);

  final _App _self;
  final $Res Function(_App) _then;

/// Create a copy of App
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? version = null,Object? storeUrl = null,}) {
  return _then(_App(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as Version,storeUrl: null == storeUrl ? _self.storeUrl : storeUrl // ignore: cast_nullable_to_non_nullable
as StoreUrl,
  ));
}

/// Create a copy of App
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VersionCopyWith<$Res> get version {
  
  return $VersionCopyWith<$Res>(_self.version, (value) {
    return _then(_self.copyWith(version: value));
  });
}/// Create a copy of App
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StoreUrlCopyWith<$Res> get storeUrl {
  
  return $StoreUrlCopyWith<$Res>(_self.storeUrl, (value) {
    return _then(_self.copyWith(storeUrl: value));
  });
}
}

// dart format on
