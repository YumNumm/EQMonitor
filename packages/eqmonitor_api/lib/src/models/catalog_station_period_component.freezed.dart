// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'catalog_station_period_component.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CatalogStationPeriodComponent {

@JsonKey(includeIfNull: false, name: 'max_accel_period') CatalogPeriodValue? get maxAccelPeriod;@JsonKey(includeIfNull: false, name: 'predominant_period') CatalogPeriodValue? get predominantPeriod;
/// Create a copy of CatalogStationPeriodComponent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CatalogStationPeriodComponentCopyWith<CatalogStationPeriodComponent> get copyWith => _$CatalogStationPeriodComponentCopyWithImpl<CatalogStationPeriodComponent>(this as CatalogStationPeriodComponent, _$identity);

  /// Serializes this CatalogStationPeriodComponent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CatalogStationPeriodComponent&&(identical(other.maxAccelPeriod, maxAccelPeriod) || other.maxAccelPeriod == maxAccelPeriod)&&(identical(other.predominantPeriod, predominantPeriod) || other.predominantPeriod == predominantPeriod));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,maxAccelPeriod,predominantPeriod);

@override
String toString() {
  return 'CatalogStationPeriodComponent(maxAccelPeriod: $maxAccelPeriod, predominantPeriod: $predominantPeriod)';
}


}

/// @nodoc
abstract mixin class $CatalogStationPeriodComponentCopyWith<$Res>  {
  factory $CatalogStationPeriodComponentCopyWith(CatalogStationPeriodComponent value, $Res Function(CatalogStationPeriodComponent) _then) = _$CatalogStationPeriodComponentCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeIfNull: false, name: 'max_accel_period') CatalogPeriodValue? maxAccelPeriod,@JsonKey(includeIfNull: false, name: 'predominant_period') CatalogPeriodValue? predominantPeriod
});


$CatalogPeriodValueCopyWith<$Res>? get maxAccelPeriod;$CatalogPeriodValueCopyWith<$Res>? get predominantPeriod;

}
/// @nodoc
class _$CatalogStationPeriodComponentCopyWithImpl<$Res>
    implements $CatalogStationPeriodComponentCopyWith<$Res> {
  _$CatalogStationPeriodComponentCopyWithImpl(this._self, this._then);

  final CatalogStationPeriodComponent _self;
  final $Res Function(CatalogStationPeriodComponent) _then;

/// Create a copy of CatalogStationPeriodComponent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? maxAccelPeriod = freezed,Object? predominantPeriod = freezed,}) {
  return _then(CatalogStationPeriodComponent(
maxAccelPeriod: freezed == maxAccelPeriod ? _self.maxAccelPeriod : maxAccelPeriod // ignore: cast_nullable_to_non_nullable
as CatalogPeriodValue?,predominantPeriod: freezed == predominantPeriod ? _self.predominantPeriod : predominantPeriod // ignore: cast_nullable_to_non_nullable
as CatalogPeriodValue?,
  ));
}
/// Create a copy of CatalogStationPeriodComponent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CatalogPeriodValueCopyWith<$Res>? get maxAccelPeriod {
    if (_self.maxAccelPeriod == null) {
    return null;
  }

  return $CatalogPeriodValueCopyWith<$Res>(_self.maxAccelPeriod!, (value) {
    return _then(_self.copyWith(maxAccelPeriod: value));
  });
}/// Create a copy of CatalogStationPeriodComponent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CatalogPeriodValueCopyWith<$Res>? get predominantPeriod {
    if (_self.predominantPeriod == null) {
    return null;
  }

  return $CatalogPeriodValueCopyWith<$Res>(_self.predominantPeriod!, (value) {
    return _then(_self.copyWith(predominantPeriod: value));
  });
}
}


/// Adds pattern-matching-related methods to [CatalogStationPeriodComponent].
extension CatalogStationPeriodComponentPatterns on CatalogStationPeriodComponent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CatalogStationPeriodComponent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CatalogStationPeriodComponent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CatalogStationPeriodComponent value)  $default,){
final _that = this;
switch (_that) {
case _CatalogStationPeriodComponent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CatalogStationPeriodComponent value)?  $default,){
final _that = this;
switch (_that) {
case _CatalogStationPeriodComponent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false, name: 'max_accel_period')  CatalogPeriodValue? maxAccelPeriod, @JsonKey(includeIfNull: false, name: 'predominant_period')  CatalogPeriodValue? predominantPeriod)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CatalogStationPeriodComponent() when $default != null:
return $default(_that.maxAccelPeriod,_that.predominantPeriod);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false, name: 'max_accel_period')  CatalogPeriodValue? maxAccelPeriod, @JsonKey(includeIfNull: false, name: 'predominant_period')  CatalogPeriodValue? predominantPeriod)  $default,) {final _that = this;
switch (_that) {
case _CatalogStationPeriodComponent():
return $default(_that.maxAccelPeriod,_that.predominantPeriod);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeIfNull: false, name: 'max_accel_period')  CatalogPeriodValue? maxAccelPeriod, @JsonKey(includeIfNull: false, name: 'predominant_period')  CatalogPeriodValue? predominantPeriod)?  $default,) {final _that = this;
switch (_that) {
case _CatalogStationPeriodComponent() when $default != null:
return $default(_that.maxAccelPeriod,_that.predominantPeriod);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CatalogStationPeriodComponent implements CatalogStationPeriodComponent {
  const _CatalogStationPeriodComponent({@JsonKey(includeIfNull: false, name: 'max_accel_period') this.maxAccelPeriod, @JsonKey(includeIfNull: false, name: 'predominant_period') this.predominantPeriod});
  factory _CatalogStationPeriodComponent.fromJson(Map<String, dynamic> json) => _$CatalogStationPeriodComponentFromJson(json);

@override@JsonKey(includeIfNull: false, name: 'max_accel_period') final  CatalogPeriodValue? maxAccelPeriod;
@override@JsonKey(includeIfNull: false, name: 'predominant_period') final  CatalogPeriodValue? predominantPeriod;

/// Create a copy of CatalogStationPeriodComponent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CatalogStationPeriodComponentCopyWith<_CatalogStationPeriodComponent> get copyWith => __$CatalogStationPeriodComponentCopyWithImpl<_CatalogStationPeriodComponent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CatalogStationPeriodComponentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CatalogStationPeriodComponent&&(identical(other.maxAccelPeriod, maxAccelPeriod) || other.maxAccelPeriod == maxAccelPeriod)&&(identical(other.predominantPeriod, predominantPeriod) || other.predominantPeriod == predominantPeriod));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,maxAccelPeriod,predominantPeriod);

@override
String toString() {
  return 'CatalogStationPeriodComponent(maxAccelPeriod: $maxAccelPeriod, predominantPeriod: $predominantPeriod)';
}


}

/// @nodoc
abstract mixin class _$CatalogStationPeriodComponentCopyWith<$Res> implements $CatalogStationPeriodComponentCopyWith<$Res> {
  factory _$CatalogStationPeriodComponentCopyWith(_CatalogStationPeriodComponent value, $Res Function(_CatalogStationPeriodComponent) _then) = __$CatalogStationPeriodComponentCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeIfNull: false, name: 'max_accel_period') CatalogPeriodValue? maxAccelPeriod,@JsonKey(includeIfNull: false, name: 'predominant_period') CatalogPeriodValue? predominantPeriod
});


@override $CatalogPeriodValueCopyWith<$Res>? get maxAccelPeriod;@override $CatalogPeriodValueCopyWith<$Res>? get predominantPeriod;

}
/// @nodoc
class __$CatalogStationPeriodComponentCopyWithImpl<$Res>
    implements _$CatalogStationPeriodComponentCopyWith<$Res> {
  __$CatalogStationPeriodComponentCopyWithImpl(this._self, this._then);

  final _CatalogStationPeriodComponent _self;
  final $Res Function(_CatalogStationPeriodComponent) _then;

/// Create a copy of CatalogStationPeriodComponent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? maxAccelPeriod = freezed,Object? predominantPeriod = freezed,}) {
  return _then(_CatalogStationPeriodComponent(
maxAccelPeriod: freezed == maxAccelPeriod ? _self.maxAccelPeriod : maxAccelPeriod // ignore: cast_nullable_to_non_nullable
as CatalogPeriodValue?,predominantPeriod: freezed == predominantPeriod ? _self.predominantPeriod : predominantPeriod // ignore: cast_nullable_to_non_nullable
as CatalogPeriodValue?,
  ));
}

/// Create a copy of CatalogStationPeriodComponent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CatalogPeriodValueCopyWith<$Res>? get maxAccelPeriod {
    if (_self.maxAccelPeriod == null) {
    return null;
  }

  return $CatalogPeriodValueCopyWith<$Res>(_self.maxAccelPeriod!, (value) {
    return _then(_self.copyWith(maxAccelPeriod: value));
  });
}/// Create a copy of CatalogStationPeriodComponent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CatalogPeriodValueCopyWith<$Res>? get predominantPeriod {
    if (_self.predominantPeriod == null) {
    return null;
  }

  return $CatalogPeriodValueCopyWith<$Res>(_self.predominantPeriod!, (value) {
    return _then(_self.copyWith(predominantPeriod: value));
  });
}
}

// dart format on
