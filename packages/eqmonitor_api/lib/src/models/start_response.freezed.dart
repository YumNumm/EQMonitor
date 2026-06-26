// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'start_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StartResponse {

 StartFlags get flags; StartApp get app;
/// Create a copy of StartResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StartResponseCopyWith<StartResponse> get copyWith => _$StartResponseCopyWithImpl<StartResponse>(this as StartResponse, _$identity);

  /// Serializes this StartResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StartResponse&&(identical(other.flags, flags) || other.flags == flags)&&(identical(other.app, app) || other.app == app));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,flags,app);

@override
String toString() {
  return 'StartResponse(flags: $flags, app: $app)';
}


}

/// @nodoc
abstract mixin class $StartResponseCopyWith<$Res>  {
  factory $StartResponseCopyWith(StartResponse value, $Res Function(StartResponse) _then) = _$StartResponseCopyWithImpl;
@useResult
$Res call({
 StartFlags flags, StartApp app
});


$StartFlagsCopyWith<$Res> get flags;$StartAppCopyWith<$Res> get app;

}
/// @nodoc
class _$StartResponseCopyWithImpl<$Res>
    implements $StartResponseCopyWith<$Res> {
  _$StartResponseCopyWithImpl(this._self, this._then);

  final StartResponse _self;
  final $Res Function(StartResponse) _then;

/// Create a copy of StartResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? flags = null,Object? app = null,}) {
  return _then(_self.copyWith(
flags: null == flags ? _self.flags : flags // ignore: cast_nullable_to_non_nullable
as StartFlags,app: null == app ? _self.app : app // ignore: cast_nullable_to_non_nullable
as StartApp,
  ));
}
/// Create a copy of StartResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StartFlagsCopyWith<$Res> get flags {
  
  return $StartFlagsCopyWith<$Res>(_self.flags, (value) {
    return _then(_self.copyWith(flags: value));
  });
}/// Create a copy of StartResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StartAppCopyWith<$Res> get app {
  
  return $StartAppCopyWith<$Res>(_self.app, (value) {
    return _then(_self.copyWith(app: value));
  });
}
}


/// Adds pattern-matching-related methods to [StartResponse].
extension StartResponsePatterns on StartResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StartResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StartResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StartResponse value)  $default,){
final _that = this;
switch (_that) {
case _StartResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StartResponse value)?  $default,){
final _that = this;
switch (_that) {
case _StartResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( StartFlags flags,  StartApp app)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StartResponse() when $default != null:
return $default(_that.flags,_that.app);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( StartFlags flags,  StartApp app)  $default,) {final _that = this;
switch (_that) {
case _StartResponse():
return $default(_that.flags,_that.app);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( StartFlags flags,  StartApp app)?  $default,) {final _that = this;
switch (_that) {
case _StartResponse() when $default != null:
return $default(_that.flags,_that.app);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StartResponse implements StartResponse {
  const _StartResponse({required this.flags, required this.app});
  factory _StartResponse.fromJson(Map<String, dynamic> json) => _$StartResponseFromJson(json);

@override final  StartFlags flags;
@override final  StartApp app;

/// Create a copy of StartResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StartResponseCopyWith<_StartResponse> get copyWith => __$StartResponseCopyWithImpl<_StartResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StartResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StartResponse&&(identical(other.flags, flags) || other.flags == flags)&&(identical(other.app, app) || other.app == app));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,flags,app);

@override
String toString() {
  return 'StartResponse(flags: $flags, app: $app)';
}


}

/// @nodoc
abstract mixin class _$StartResponseCopyWith<$Res> implements $StartResponseCopyWith<$Res> {
  factory _$StartResponseCopyWith(_StartResponse value, $Res Function(_StartResponse) _then) = __$StartResponseCopyWithImpl;
@override @useResult
$Res call({
 StartFlags flags, StartApp app
});


@override $StartFlagsCopyWith<$Res> get flags;@override $StartAppCopyWith<$Res> get app;

}
/// @nodoc
class __$StartResponseCopyWithImpl<$Res>
    implements _$StartResponseCopyWith<$Res> {
  __$StartResponseCopyWithImpl(this._self, this._then);

  final _StartResponse _self;
  final $Res Function(_StartResponse) _then;

/// Create a copy of StartResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? flags = null,Object? app = null,}) {
  return _then(_StartResponse(
flags: null == flags ? _self.flags : flags // ignore: cast_nullable_to_non_nullable
as StartFlags,app: null == app ? _self.app : app // ignore: cast_nullable_to_non_nullable
as StartApp,
  ));
}

/// Create a copy of StartResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StartFlagsCopyWith<$Res> get flags {
  
  return $StartFlagsCopyWith<$Res>(_self.flags, (value) {
    return _then(_self.copyWith(flags: value));
  });
}/// Create a copy of StartResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StartAppCopyWith<$Res> get app {
  
  return $StartAppCopyWith<$Res>(_self.app, (value) {
    return _then(_self.copyWith(app: value));
  });
}
}

// dart format on
