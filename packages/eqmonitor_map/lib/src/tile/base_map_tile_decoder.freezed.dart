// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'base_map_tile_decoder.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BaseMapTileDecodeLimits implements DiagnosticableTreeMixin {

 MvtDecodeLimits get mvtLimits; FillMeshBuilderLimits get fillLimits; LineMeshBuilderLimits get lineLimits; double get lineMiterLimit;
/// Create a copy of BaseMapTileDecodeLimits
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BaseMapTileDecodeLimitsCopyWith<BaseMapTileDecodeLimits> get copyWith => _$BaseMapTileDecodeLimitsCopyWithImpl<BaseMapTileDecodeLimits>(this as BaseMapTileDecodeLimits, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'BaseMapTileDecodeLimits'))
    ..add(DiagnosticsProperty('mvtLimits', mvtLimits))..add(DiagnosticsProperty('fillLimits', fillLimits))..add(DiagnosticsProperty('lineLimits', lineLimits))..add(DiagnosticsProperty('lineMiterLimit', lineMiterLimit));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BaseMapTileDecodeLimits&&(identical(other.mvtLimits, mvtLimits) || other.mvtLimits == mvtLimits)&&(identical(other.fillLimits, fillLimits) || other.fillLimits == fillLimits)&&(identical(other.lineLimits, lineLimits) || other.lineLimits == lineLimits)&&(identical(other.lineMiterLimit, lineMiterLimit) || other.lineMiterLimit == lineMiterLimit));
}


@override
int get hashCode => Object.hash(runtimeType,mvtLimits,fillLimits,lineLimits,lineMiterLimit);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'BaseMapTileDecodeLimits(mvtLimits: $mvtLimits, fillLimits: $fillLimits, lineLimits: $lineLimits, lineMiterLimit: $lineMiterLimit)';
}


}

/// @nodoc
abstract mixin class $BaseMapTileDecodeLimitsCopyWith<$Res>  {
  factory $BaseMapTileDecodeLimitsCopyWith(BaseMapTileDecodeLimits value, $Res Function(BaseMapTileDecodeLimits) _then) = _$BaseMapTileDecodeLimitsCopyWithImpl;
@useResult
$Res call({
 MvtDecodeLimits mvtLimits, FillMeshBuilderLimits fillLimits, LineMeshBuilderLimits lineLimits, double lineMiterLimit
});


$MvtDecodeLimitsCopyWith<$Res> get mvtLimits;$FillMeshBuilderLimitsCopyWith<$Res> get fillLimits;$LineMeshBuilderLimitsCopyWith<$Res> get lineLimits;

}
/// @nodoc
class _$BaseMapTileDecodeLimitsCopyWithImpl<$Res>
    implements $BaseMapTileDecodeLimitsCopyWith<$Res> {
  _$BaseMapTileDecodeLimitsCopyWithImpl(this._self, this._then);

  final BaseMapTileDecodeLimits _self;
  final $Res Function(BaseMapTileDecodeLimits) _then;

/// Create a copy of BaseMapTileDecodeLimits
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mvtLimits = null,Object? fillLimits = null,Object? lineLimits = null,Object? lineMiterLimit = null,}) {
  return _then(_self.copyWith(
mvtLimits: null == mvtLimits ? _self.mvtLimits : mvtLimits // ignore: cast_nullable_to_non_nullable
as MvtDecodeLimits,fillLimits: null == fillLimits ? _self.fillLimits : fillLimits // ignore: cast_nullable_to_non_nullable
as FillMeshBuilderLimits,lineLimits: null == lineLimits ? _self.lineLimits : lineLimits // ignore: cast_nullable_to_non_nullable
as LineMeshBuilderLimits,lineMiterLimit: null == lineMiterLimit ? _self.lineMiterLimit : lineMiterLimit // ignore: cast_nullable_to_non_nullable
as double,
  ));
}
/// Create a copy of BaseMapTileDecodeLimits
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MvtDecodeLimitsCopyWith<$Res> get mvtLimits {
  
  return $MvtDecodeLimitsCopyWith<$Res>(_self.mvtLimits, (value) {
    return _then(_self.copyWith(mvtLimits: value));
  });
}/// Create a copy of BaseMapTileDecodeLimits
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FillMeshBuilderLimitsCopyWith<$Res> get fillLimits {
  
  return $FillMeshBuilderLimitsCopyWith<$Res>(_self.fillLimits, (value) {
    return _then(_self.copyWith(fillLimits: value));
  });
}/// Create a copy of BaseMapTileDecodeLimits
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LineMeshBuilderLimitsCopyWith<$Res> get lineLimits {
  
  return $LineMeshBuilderLimitsCopyWith<$Res>(_self.lineLimits, (value) {
    return _then(_self.copyWith(lineLimits: value));
  });
}
}


/// Adds pattern-matching-related methods to [BaseMapTileDecodeLimits].
extension BaseMapTileDecodeLimitsPatterns on BaseMapTileDecodeLimits {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BaseMapTileDecodeLimits value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BaseMapTileDecodeLimits() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BaseMapTileDecodeLimits value)  $default,){
final _that = this;
switch (_that) {
case _BaseMapTileDecodeLimits():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BaseMapTileDecodeLimits value)?  $default,){
final _that = this;
switch (_that) {
case _BaseMapTileDecodeLimits() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MvtDecodeLimits mvtLimits,  FillMeshBuilderLimits fillLimits,  LineMeshBuilderLimits lineLimits,  double lineMiterLimit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BaseMapTileDecodeLimits() when $default != null:
return $default(_that.mvtLimits,_that.fillLimits,_that.lineLimits,_that.lineMiterLimit);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MvtDecodeLimits mvtLimits,  FillMeshBuilderLimits fillLimits,  LineMeshBuilderLimits lineLimits,  double lineMiterLimit)  $default,) {final _that = this;
switch (_that) {
case _BaseMapTileDecodeLimits():
return $default(_that.mvtLimits,_that.fillLimits,_that.lineLimits,_that.lineMiterLimit);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MvtDecodeLimits mvtLimits,  FillMeshBuilderLimits fillLimits,  LineMeshBuilderLimits lineLimits,  double lineMiterLimit)?  $default,) {final _that = this;
switch (_that) {
case _BaseMapTileDecodeLimits() when $default != null:
return $default(_that.mvtLimits,_that.fillLimits,_that.lineLimits,_that.lineMiterLimit);case _:
  return null;

}
}

}

/// @nodoc


class _BaseMapTileDecodeLimits with DiagnosticableTreeMixin implements BaseMapTileDecodeLimits {
  const _BaseMapTileDecodeLimits({required this.mvtLimits, required this.fillLimits, required this.lineLimits, required this.lineMiterLimit});
  

@override final  MvtDecodeLimits mvtLimits;
@override final  FillMeshBuilderLimits fillLimits;
@override final  LineMeshBuilderLimits lineLimits;
@override final  double lineMiterLimit;

/// Create a copy of BaseMapTileDecodeLimits
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BaseMapTileDecodeLimitsCopyWith<_BaseMapTileDecodeLimits> get copyWith => __$BaseMapTileDecodeLimitsCopyWithImpl<_BaseMapTileDecodeLimits>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'BaseMapTileDecodeLimits'))
    ..add(DiagnosticsProperty('mvtLimits', mvtLimits))..add(DiagnosticsProperty('fillLimits', fillLimits))..add(DiagnosticsProperty('lineLimits', lineLimits))..add(DiagnosticsProperty('lineMiterLimit', lineMiterLimit));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BaseMapTileDecodeLimits&&(identical(other.mvtLimits, mvtLimits) || other.mvtLimits == mvtLimits)&&(identical(other.fillLimits, fillLimits) || other.fillLimits == fillLimits)&&(identical(other.lineLimits, lineLimits) || other.lineLimits == lineLimits)&&(identical(other.lineMiterLimit, lineMiterLimit) || other.lineMiterLimit == lineMiterLimit));
}


@override
int get hashCode => Object.hash(runtimeType,mvtLimits,fillLimits,lineLimits,lineMiterLimit);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'BaseMapTileDecodeLimits(mvtLimits: $mvtLimits, fillLimits: $fillLimits, lineLimits: $lineLimits, lineMiterLimit: $lineMiterLimit)';
}


}

/// @nodoc
abstract mixin class _$BaseMapTileDecodeLimitsCopyWith<$Res> implements $BaseMapTileDecodeLimitsCopyWith<$Res> {
  factory _$BaseMapTileDecodeLimitsCopyWith(_BaseMapTileDecodeLimits value, $Res Function(_BaseMapTileDecodeLimits) _then) = __$BaseMapTileDecodeLimitsCopyWithImpl;
@override @useResult
$Res call({
 MvtDecodeLimits mvtLimits, FillMeshBuilderLimits fillLimits, LineMeshBuilderLimits lineLimits, double lineMiterLimit
});


@override $MvtDecodeLimitsCopyWith<$Res> get mvtLimits;@override $FillMeshBuilderLimitsCopyWith<$Res> get fillLimits;@override $LineMeshBuilderLimitsCopyWith<$Res> get lineLimits;

}
/// @nodoc
class __$BaseMapTileDecodeLimitsCopyWithImpl<$Res>
    implements _$BaseMapTileDecodeLimitsCopyWith<$Res> {
  __$BaseMapTileDecodeLimitsCopyWithImpl(this._self, this._then);

  final _BaseMapTileDecodeLimits _self;
  final $Res Function(_BaseMapTileDecodeLimits) _then;

/// Create a copy of BaseMapTileDecodeLimits
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mvtLimits = null,Object? fillLimits = null,Object? lineLimits = null,Object? lineMiterLimit = null,}) {
  return _then(_BaseMapTileDecodeLimits(
mvtLimits: null == mvtLimits ? _self.mvtLimits : mvtLimits // ignore: cast_nullable_to_non_nullable
as MvtDecodeLimits,fillLimits: null == fillLimits ? _self.fillLimits : fillLimits // ignore: cast_nullable_to_non_nullable
as FillMeshBuilderLimits,lineLimits: null == lineLimits ? _self.lineLimits : lineLimits // ignore: cast_nullable_to_non_nullable
as LineMeshBuilderLimits,lineMiterLimit: null == lineMiterLimit ? _self.lineMiterLimit : lineMiterLimit // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

/// Create a copy of BaseMapTileDecodeLimits
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MvtDecodeLimitsCopyWith<$Res> get mvtLimits {
  
  return $MvtDecodeLimitsCopyWith<$Res>(_self.mvtLimits, (value) {
    return _then(_self.copyWith(mvtLimits: value));
  });
}/// Create a copy of BaseMapTileDecodeLimits
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FillMeshBuilderLimitsCopyWith<$Res> get fillLimits {
  
  return $FillMeshBuilderLimitsCopyWith<$Res>(_self.fillLimits, (value) {
    return _then(_self.copyWith(fillLimits: value));
  });
}/// Create a copy of BaseMapTileDecodeLimits
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LineMeshBuilderLimitsCopyWith<$Res> get lineLimits {
  
  return $LineMeshBuilderLimitsCopyWith<$Res>(_self.lineLimits, (value) {
    return _then(_self.copyWith(lineLimits: value));
  });
}
}

// dart format on
