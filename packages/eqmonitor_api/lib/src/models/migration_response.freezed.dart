// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'migration_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MigrationResponse {

 MigrationResultResponse get migrated;
/// Create a copy of MigrationResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MigrationResponseCopyWith<MigrationResponse> get copyWith => _$MigrationResponseCopyWithImpl<MigrationResponse>(this as MigrationResponse, _$identity);

  /// Serializes this MigrationResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MigrationResponse&&(identical(other.migrated, migrated) || other.migrated == migrated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,migrated);

@override
String toString() {
  return 'MigrationResponse(migrated: $migrated)';
}


}

/// @nodoc
abstract mixin class $MigrationResponseCopyWith<$Res>  {
  factory $MigrationResponseCopyWith(MigrationResponse value, $Res Function(MigrationResponse) _then) = _$MigrationResponseCopyWithImpl;
@useResult
$Res call({
 MigrationResultResponse migrated
});


$MigrationResultResponseCopyWith<$Res> get migrated;

}
/// @nodoc
class _$MigrationResponseCopyWithImpl<$Res>
    implements $MigrationResponseCopyWith<$Res> {
  _$MigrationResponseCopyWithImpl(this._self, this._then);

  final MigrationResponse _self;
  final $Res Function(MigrationResponse) _then;

/// Create a copy of MigrationResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? migrated = null,}) {
  return _then(_self.copyWith(
migrated: null == migrated ? _self.migrated : migrated // ignore: cast_nullable_to_non_nullable
as MigrationResultResponse,
  ));
}
/// Create a copy of MigrationResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MigrationResultResponseCopyWith<$Res> get migrated {
  
  return $MigrationResultResponseCopyWith<$Res>(_self.migrated, (value) {
    return _then(_self.copyWith(migrated: value));
  });
}
}


/// Adds pattern-matching-related methods to [MigrationResponse].
extension MigrationResponsePatterns on MigrationResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MigrationResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MigrationResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MigrationResponse value)  $default,){
final _that = this;
switch (_that) {
case _MigrationResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MigrationResponse value)?  $default,){
final _that = this;
switch (_that) {
case _MigrationResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MigrationResultResponse migrated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MigrationResponse() when $default != null:
return $default(_that.migrated);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MigrationResultResponse migrated)  $default,) {final _that = this;
switch (_that) {
case _MigrationResponse():
return $default(_that.migrated);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MigrationResultResponse migrated)?  $default,) {final _that = this;
switch (_that) {
case _MigrationResponse() when $default != null:
return $default(_that.migrated);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MigrationResponse implements MigrationResponse {
  const _MigrationResponse({required this.migrated});
  factory _MigrationResponse.fromJson(Map<String, dynamic> json) => _$MigrationResponseFromJson(json);

@override final  MigrationResultResponse migrated;

/// Create a copy of MigrationResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MigrationResponseCopyWith<_MigrationResponse> get copyWith => __$MigrationResponseCopyWithImpl<_MigrationResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MigrationResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MigrationResponse&&(identical(other.migrated, migrated) || other.migrated == migrated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,migrated);

@override
String toString() {
  return 'MigrationResponse(migrated: $migrated)';
}


}

/// @nodoc
abstract mixin class _$MigrationResponseCopyWith<$Res> implements $MigrationResponseCopyWith<$Res> {
  factory _$MigrationResponseCopyWith(_MigrationResponse value, $Res Function(_MigrationResponse) _then) = __$MigrationResponseCopyWithImpl;
@override @useResult
$Res call({
 MigrationResultResponse migrated
});


@override $MigrationResultResponseCopyWith<$Res> get migrated;

}
/// @nodoc
class __$MigrationResponseCopyWithImpl<$Res>
    implements _$MigrationResponseCopyWith<$Res> {
  __$MigrationResponseCopyWithImpl(this._self, this._then);

  final _MigrationResponse _self;
  final $Res Function(_MigrationResponse) _then;

/// Create a copy of MigrationResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? migrated = null,}) {
  return _then(_MigrationResponse(
migrated: null == migrated ? _self.migrated : migrated // ignore: cast_nullable_to_non_nullable
as MigrationResultResponse,
  ));
}

/// Create a copy of MigrationResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MigrationResultResponseCopyWith<$Res> get migrated {
  
  return $MigrationResultResponseCopyWith<$Res>(_self.migrated, (value) {
    return _then(_self.copyWith(migrated: value));
  });
}
}

// dart format on
