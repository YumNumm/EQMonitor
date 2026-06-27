// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eew_list_parameter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EewListParameter {

 double? get magnitudeGte; double? get magnitudeLte; int? get depthGte; int? get depthLte; JmaIntensity? get intensityGte; JmaIntensity? get intensityLte; Date? get originTimeGte; Date? get originTimeLte; bool? get isWarning;
/// Create a copy of EewListParameter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewListParameterCopyWith<EewListParameter> get copyWith => _$EewListParameterCopyWithImpl<EewListParameter>(this as EewListParameter, _$identity);

  /// Serializes this EewListParameter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewListParameter&&(identical(other.magnitudeGte, magnitudeGte) || other.magnitudeGte == magnitudeGte)&&(identical(other.magnitudeLte, magnitudeLte) || other.magnitudeLte == magnitudeLte)&&(identical(other.depthGte, depthGte) || other.depthGte == depthGte)&&(identical(other.depthLte, depthLte) || other.depthLte == depthLte)&&(identical(other.intensityGte, intensityGte) || other.intensityGte == intensityGte)&&(identical(other.intensityLte, intensityLte) || other.intensityLte == intensityLte)&&(identical(other.originTimeGte, originTimeGte) || other.originTimeGte == originTimeGte)&&(identical(other.originTimeLte, originTimeLte) || other.originTimeLte == originTimeLte)&&(identical(other.isWarning, isWarning) || other.isWarning == isWarning));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,magnitudeGte,magnitudeLte,depthGte,depthLte,intensityGte,intensityLte,originTimeGte,originTimeLte,isWarning);

@override
String toString() {
  return 'EewListParameter(magnitudeGte: $magnitudeGte, magnitudeLte: $magnitudeLte, depthGte: $depthGte, depthLte: $depthLte, intensityGte: $intensityGte, intensityLte: $intensityLte, originTimeGte: $originTimeGte, originTimeLte: $originTimeLte, isWarning: $isWarning)';
}


}

/// @nodoc
abstract mixin class $EewListParameterCopyWith<$Res>  {
  factory $EewListParameterCopyWith(EewListParameter value, $Res Function(EewListParameter) _then) = _$EewListParameterCopyWithImpl;
@useResult
$Res call({
 double? magnitudeGte, double? magnitudeLte, int? depthGte, int? depthLte, JmaIntensity? intensityGte, JmaIntensity? intensityLte, Date? originTimeGte, Date? originTimeLte, bool? isWarning
});


$DateCopyWith<$Res>? get originTimeGte;$DateCopyWith<$Res>? get originTimeLte;

}
/// @nodoc
class _$EewListParameterCopyWithImpl<$Res>
    implements $EewListParameterCopyWith<$Res> {
  _$EewListParameterCopyWithImpl(this._self, this._then);

  final EewListParameter _self;
  final $Res Function(EewListParameter) _then;

/// Create a copy of EewListParameter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? magnitudeGte = freezed,Object? magnitudeLte = freezed,Object? depthGte = freezed,Object? depthLte = freezed,Object? intensityGte = freezed,Object? intensityLte = freezed,Object? originTimeGte = freezed,Object? originTimeLte = freezed,Object? isWarning = freezed,}) {
  return _then(_self.copyWith(
magnitudeGte: freezed == magnitudeGte ? _self.magnitudeGte : magnitudeGte // ignore: cast_nullable_to_non_nullable
as double?,magnitudeLte: freezed == magnitudeLte ? _self.magnitudeLte : magnitudeLte // ignore: cast_nullable_to_non_nullable
as double?,depthGte: freezed == depthGte ? _self.depthGte : depthGte // ignore: cast_nullable_to_non_nullable
as int?,depthLte: freezed == depthLte ? _self.depthLte : depthLte // ignore: cast_nullable_to_non_nullable
as int?,intensityGte: freezed == intensityGte ? _self.intensityGte : intensityGte // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,intensityLte: freezed == intensityLte ? _self.intensityLte : intensityLte // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,originTimeGte: freezed == originTimeGte ? _self.originTimeGte : originTimeGte // ignore: cast_nullable_to_non_nullable
as Date?,originTimeLte: freezed == originTimeLte ? _self.originTimeLte : originTimeLte // ignore: cast_nullable_to_non_nullable
as Date?,isWarning: freezed == isWarning ? _self.isWarning : isWarning // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}
/// Create a copy of EewListParameter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DateCopyWith<$Res>? get originTimeGte {
    if (_self.originTimeGte == null) {
    return null;
  }

  return $DateCopyWith<$Res>(_self.originTimeGte!, (value) {
    return _then(_self.copyWith(originTimeGte: value));
  });
}/// Create a copy of EewListParameter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DateCopyWith<$Res>? get originTimeLte {
    if (_self.originTimeLte == null) {
    return null;
  }

  return $DateCopyWith<$Res>(_self.originTimeLte!, (value) {
    return _then(_self.copyWith(originTimeLte: value));
  });
}
}


/// Adds pattern-matching-related methods to [EewListParameter].
extension EewListParameterPatterns on EewListParameter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EewListParameter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EewListParameter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EewListParameter value)  $default,){
final _that = this;
switch (_that) {
case _EewListParameter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EewListParameter value)?  $default,){
final _that = this;
switch (_that) {
case _EewListParameter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double? magnitudeGte,  double? magnitudeLte,  int? depthGte,  int? depthLte,  JmaIntensity? intensityGte,  JmaIntensity? intensityLte,  Date? originTimeGte,  Date? originTimeLte,  bool? isWarning)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EewListParameter() when $default != null:
return $default(_that.magnitudeGte,_that.magnitudeLte,_that.depthGte,_that.depthLte,_that.intensityGte,_that.intensityLte,_that.originTimeGte,_that.originTimeLte,_that.isWarning);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double? magnitudeGte,  double? magnitudeLte,  int? depthGte,  int? depthLte,  JmaIntensity? intensityGte,  JmaIntensity? intensityLte,  Date? originTimeGte,  Date? originTimeLte,  bool? isWarning)  $default,) {final _that = this;
switch (_that) {
case _EewListParameter():
return $default(_that.magnitudeGte,_that.magnitudeLte,_that.depthGte,_that.depthLte,_that.intensityGte,_that.intensityLte,_that.originTimeGte,_that.originTimeLte,_that.isWarning);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double? magnitudeGte,  double? magnitudeLte,  int? depthGte,  int? depthLte,  JmaIntensity? intensityGte,  JmaIntensity? intensityLte,  Date? originTimeGte,  Date? originTimeLte,  bool? isWarning)?  $default,) {final _that = this;
switch (_that) {
case _EewListParameter() when $default != null:
return $default(_that.magnitudeGte,_that.magnitudeLte,_that.depthGte,_that.depthLte,_that.intensityGte,_that.intensityLte,_that.originTimeGte,_that.originTimeLte,_that.isWarning);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EewListParameter extends EewListParameter {
  const _EewListParameter({this.magnitudeGte, this.magnitudeLte, this.depthGte, this.depthLte, this.intensityGte, this.intensityLte, this.originTimeGte, this.originTimeLte, this.isWarning}): super._();
  factory _EewListParameter.fromJson(Map<String, dynamic> json) => _$EewListParameterFromJson(json);

@override final  double? magnitudeGte;
@override final  double? magnitudeLte;
@override final  int? depthGte;
@override final  int? depthLte;
@override final  JmaIntensity? intensityGte;
@override final  JmaIntensity? intensityLte;
@override final  Date? originTimeGte;
@override final  Date? originTimeLte;
@override final  bool? isWarning;

/// Create a copy of EewListParameter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EewListParameterCopyWith<_EewListParameter> get copyWith => __$EewListParameterCopyWithImpl<_EewListParameter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EewListParameterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EewListParameter&&(identical(other.magnitudeGte, magnitudeGte) || other.magnitudeGte == magnitudeGte)&&(identical(other.magnitudeLte, magnitudeLte) || other.magnitudeLte == magnitudeLte)&&(identical(other.depthGte, depthGte) || other.depthGte == depthGte)&&(identical(other.depthLte, depthLte) || other.depthLte == depthLte)&&(identical(other.intensityGte, intensityGte) || other.intensityGte == intensityGte)&&(identical(other.intensityLte, intensityLte) || other.intensityLte == intensityLte)&&(identical(other.originTimeGte, originTimeGte) || other.originTimeGte == originTimeGte)&&(identical(other.originTimeLte, originTimeLte) || other.originTimeLte == originTimeLte)&&(identical(other.isWarning, isWarning) || other.isWarning == isWarning));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,magnitudeGte,magnitudeLte,depthGte,depthLte,intensityGte,intensityLte,originTimeGte,originTimeLte,isWarning);

@override
String toString() {
  return 'EewListParameter(magnitudeGte: $magnitudeGte, magnitudeLte: $magnitudeLte, depthGte: $depthGte, depthLte: $depthLte, intensityGte: $intensityGte, intensityLte: $intensityLte, originTimeGte: $originTimeGte, originTimeLte: $originTimeLte, isWarning: $isWarning)';
}


}

/// @nodoc
abstract mixin class _$EewListParameterCopyWith<$Res> implements $EewListParameterCopyWith<$Res> {
  factory _$EewListParameterCopyWith(_EewListParameter value, $Res Function(_EewListParameter) _then) = __$EewListParameterCopyWithImpl;
@override @useResult
$Res call({
 double? magnitudeGte, double? magnitudeLte, int? depthGte, int? depthLte, JmaIntensity? intensityGte, JmaIntensity? intensityLte, Date? originTimeGte, Date? originTimeLte, bool? isWarning
});


@override $DateCopyWith<$Res>? get originTimeGte;@override $DateCopyWith<$Res>? get originTimeLte;

}
/// @nodoc
class __$EewListParameterCopyWithImpl<$Res>
    implements _$EewListParameterCopyWith<$Res> {
  __$EewListParameterCopyWithImpl(this._self, this._then);

  final _EewListParameter _self;
  final $Res Function(_EewListParameter) _then;

/// Create a copy of EewListParameter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? magnitudeGte = freezed,Object? magnitudeLte = freezed,Object? depthGte = freezed,Object? depthLte = freezed,Object? intensityGte = freezed,Object? intensityLte = freezed,Object? originTimeGte = freezed,Object? originTimeLte = freezed,Object? isWarning = freezed,}) {
  return _then(_EewListParameter(
magnitudeGte: freezed == magnitudeGte ? _self.magnitudeGte : magnitudeGte // ignore: cast_nullable_to_non_nullable
as double?,magnitudeLte: freezed == magnitudeLte ? _self.magnitudeLte : magnitudeLte // ignore: cast_nullable_to_non_nullable
as double?,depthGte: freezed == depthGte ? _self.depthGte : depthGte // ignore: cast_nullable_to_non_nullable
as int?,depthLte: freezed == depthLte ? _self.depthLte : depthLte // ignore: cast_nullable_to_non_nullable
as int?,intensityGte: freezed == intensityGte ? _self.intensityGte : intensityGte // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,intensityLte: freezed == intensityLte ? _self.intensityLte : intensityLte // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,originTimeGte: freezed == originTimeGte ? _self.originTimeGte : originTimeGte // ignore: cast_nullable_to_non_nullable
as Date?,originTimeLte: freezed == originTimeLte ? _self.originTimeLte : originTimeLte // ignore: cast_nullable_to_non_nullable
as Date?,isWarning: freezed == isWarning ? _self.isWarning : isWarning // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

/// Create a copy of EewListParameter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DateCopyWith<$Res>? get originTimeGte {
    if (_self.originTimeGte == null) {
    return null;
  }

  return $DateCopyWith<$Res>(_self.originTimeGte!, (value) {
    return _then(_self.copyWith(originTimeGte: value));
  });
}/// Create a copy of EewListParameter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DateCopyWith<$Res>? get originTimeLte {
    if (_self.originTimeLte == null) {
    return null;
  }

  return $DateCopyWith<$Res>(_self.originTimeLte!, (value) {
    return _then(_self.copyWith(originTimeLte: value));
  });
}
}

// dart format on
