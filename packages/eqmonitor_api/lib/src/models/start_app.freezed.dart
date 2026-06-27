// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'start_app.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StartApp {

 StartAppVersion get version;@JsonKey(name: 'store_url') StoreUrl get storeUrl;
/// Create a copy of StartApp
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StartAppCopyWith<StartApp> get copyWith => _$StartAppCopyWithImpl<StartApp>(this as StartApp, _$identity);

  /// Serializes this StartApp to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StartApp&&(identical(other.version, version) || other.version == version)&&(identical(other.storeUrl, storeUrl) || other.storeUrl == storeUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,version,storeUrl);

@override
String toString() {
  return 'StartApp(version: $version, storeUrl: $storeUrl)';
}


}

/// @nodoc
abstract mixin class $StartAppCopyWith<$Res>  {
  factory $StartAppCopyWith(StartApp value, $Res Function(StartApp) _then) = _$StartAppCopyWithImpl;
@useResult
$Res call({
 StartAppVersion version,@JsonKey(name: 'store_url') StoreUrl storeUrl
});


$StartAppVersionCopyWith<$Res> get version;$StoreUrlCopyWith<$Res> get storeUrl;

}
/// @nodoc
class _$StartAppCopyWithImpl<$Res>
    implements $StartAppCopyWith<$Res> {
  _$StartAppCopyWithImpl(this._self, this._then);

  final StartApp _self;
  final $Res Function(StartApp) _then;

/// Create a copy of StartApp
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? version = null,Object? storeUrl = null,}) {
  return _then(_self.copyWith(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as StartAppVersion,storeUrl: null == storeUrl ? _self.storeUrl : storeUrl // ignore: cast_nullable_to_non_nullable
as StoreUrl,
  ));
}
/// Create a copy of StartApp
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StartAppVersionCopyWith<$Res> get version {
  
  return $StartAppVersionCopyWith<$Res>(_self.version, (value) {
    return _then(_self.copyWith(version: value));
  });
}/// Create a copy of StartApp
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StoreUrlCopyWith<$Res> get storeUrl {
  
  return $StoreUrlCopyWith<$Res>(_self.storeUrl, (value) {
    return _then(_self.copyWith(storeUrl: value));
  });
}
}


/// Adds pattern-matching-related methods to [StartApp].
extension StartAppPatterns on StartApp {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StartApp value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StartApp() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StartApp value)  $default,){
final _that = this;
switch (_that) {
case _StartApp():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StartApp value)?  $default,){
final _that = this;
switch (_that) {
case _StartApp() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( StartAppVersion version, @JsonKey(name: 'store_url')  StoreUrl storeUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StartApp() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( StartAppVersion version, @JsonKey(name: 'store_url')  StoreUrl storeUrl)  $default,) {final _that = this;
switch (_that) {
case _StartApp():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( StartAppVersion version, @JsonKey(name: 'store_url')  StoreUrl storeUrl)?  $default,) {final _that = this;
switch (_that) {
case _StartApp() when $default != null:
return $default(_that.version,_that.storeUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StartApp implements StartApp {
  const _StartApp({required this.version, @JsonKey(name: 'store_url') required this.storeUrl});
  factory _StartApp.fromJson(Map<String, dynamic> json) => _$StartAppFromJson(json);

@override final  StartAppVersion version;
@override@JsonKey(name: 'store_url') final  StoreUrl storeUrl;

/// Create a copy of StartApp
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StartAppCopyWith<_StartApp> get copyWith => __$StartAppCopyWithImpl<_StartApp>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StartAppToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StartApp&&(identical(other.version, version) || other.version == version)&&(identical(other.storeUrl, storeUrl) || other.storeUrl == storeUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,version,storeUrl);

@override
String toString() {
  return 'StartApp(version: $version, storeUrl: $storeUrl)';
}


}

/// @nodoc
abstract mixin class _$StartAppCopyWith<$Res> implements $StartAppCopyWith<$Res> {
  factory _$StartAppCopyWith(_StartApp value, $Res Function(_StartApp) _then) = __$StartAppCopyWithImpl;
@override @useResult
$Res call({
 StartAppVersion version,@JsonKey(name: 'store_url') StoreUrl storeUrl
});


@override $StartAppVersionCopyWith<$Res> get version;@override $StoreUrlCopyWith<$Res> get storeUrl;

}
/// @nodoc
class __$StartAppCopyWithImpl<$Res>
    implements _$StartAppCopyWith<$Res> {
  __$StartAppCopyWithImpl(this._self, this._then);

  final _StartApp _self;
  final $Res Function(_StartApp) _then;

/// Create a copy of StartApp
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? version = null,Object? storeUrl = null,}) {
  return _then(_StartApp(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as StartAppVersion,storeUrl: null == storeUrl ? _self.storeUrl : storeUrl // ignore: cast_nullable_to_non_nullable
as StoreUrl,
  ));
}

/// Create a copy of StartApp
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StartAppVersionCopyWith<$Res> get version {
  
  return $StartAppVersionCopyWith<$Res>(_self.version, (value) {
    return _then(_self.copyWith(version: value));
  });
}/// Create a copy of StartApp
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
