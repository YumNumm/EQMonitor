// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'catalog_station_periods.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CatalogStationPeriods {

@JsonKey(includeIfNull: false) CatalogStationPeriodComponent? get ns;@JsonKey(includeIfNull: false) CatalogStationPeriodComponent? get ew;@JsonKey(includeIfNull: false) CatalogStationPeriodComponent? get ud;
/// Create a copy of CatalogStationPeriods
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CatalogStationPeriodsCopyWith<CatalogStationPeriods> get copyWith => _$CatalogStationPeriodsCopyWithImpl<CatalogStationPeriods>(this as CatalogStationPeriods, _$identity);

  /// Serializes this CatalogStationPeriods to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CatalogStationPeriods&&(identical(other.ns, ns) || other.ns == ns)&&(identical(other.ew, ew) || other.ew == ew)&&(identical(other.ud, ud) || other.ud == ud));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ns,ew,ud);

@override
String toString() {
  return 'CatalogStationPeriods(ns: $ns, ew: $ew, ud: $ud)';
}


}

/// @nodoc
abstract mixin class $CatalogStationPeriodsCopyWith<$Res>  {
  factory $CatalogStationPeriodsCopyWith(CatalogStationPeriods value, $Res Function(CatalogStationPeriods) _then) = _$CatalogStationPeriodsCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeIfNull: false) CatalogStationPeriodComponent? ns,@JsonKey(includeIfNull: false) CatalogStationPeriodComponent? ew,@JsonKey(includeIfNull: false) CatalogStationPeriodComponent? ud
});


$CatalogStationPeriodComponentCopyWith<$Res>? get ns;$CatalogStationPeriodComponentCopyWith<$Res>? get ew;$CatalogStationPeriodComponentCopyWith<$Res>? get ud;

}
/// @nodoc
class _$CatalogStationPeriodsCopyWithImpl<$Res>
    implements $CatalogStationPeriodsCopyWith<$Res> {
  _$CatalogStationPeriodsCopyWithImpl(this._self, this._then);

  final CatalogStationPeriods _self;
  final $Res Function(CatalogStationPeriods) _then;

/// Create a copy of CatalogStationPeriods
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ns = freezed,Object? ew = freezed,Object? ud = freezed,}) {
  return _then(CatalogStationPeriods(
ns: freezed == ns ? _self.ns : ns // ignore: cast_nullable_to_non_nullable
as CatalogStationPeriodComponent?,ew: freezed == ew ? _self.ew : ew // ignore: cast_nullable_to_non_nullable
as CatalogStationPeriodComponent?,ud: freezed == ud ? _self.ud : ud // ignore: cast_nullable_to_non_nullable
as CatalogStationPeriodComponent?,
  ));
}
/// Create a copy of CatalogStationPeriods
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CatalogStationPeriodComponentCopyWith<$Res>? get ns {
    if (_self.ns == null) {
    return null;
  }

  return $CatalogStationPeriodComponentCopyWith<$Res>(_self.ns!, (value) {
    return _then(_self.copyWith(ns: value));
  });
}/// Create a copy of CatalogStationPeriods
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CatalogStationPeriodComponentCopyWith<$Res>? get ew {
    if (_self.ew == null) {
    return null;
  }

  return $CatalogStationPeriodComponentCopyWith<$Res>(_self.ew!, (value) {
    return _then(_self.copyWith(ew: value));
  });
}/// Create a copy of CatalogStationPeriods
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CatalogStationPeriodComponentCopyWith<$Res>? get ud {
    if (_self.ud == null) {
    return null;
  }

  return $CatalogStationPeriodComponentCopyWith<$Res>(_self.ud!, (value) {
    return _then(_self.copyWith(ud: value));
  });
}
}


/// Adds pattern-matching-related methods to [CatalogStationPeriods].
extension CatalogStationPeriodsPatterns on CatalogStationPeriods {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CatalogStationPeriods value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CatalogStationPeriods() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CatalogStationPeriods value)  $default,){
final _that = this;
switch (_that) {
case _CatalogStationPeriods():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CatalogStationPeriods value)?  $default,){
final _that = this;
switch (_that) {
case _CatalogStationPeriods() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false)  CatalogStationPeriodComponent? ns, @JsonKey(includeIfNull: false)  CatalogStationPeriodComponent? ew, @JsonKey(includeIfNull: false)  CatalogStationPeriodComponent? ud)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CatalogStationPeriods() when $default != null:
return $default(_that.ns,_that.ew,_that.ud);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false)  CatalogStationPeriodComponent? ns, @JsonKey(includeIfNull: false)  CatalogStationPeriodComponent? ew, @JsonKey(includeIfNull: false)  CatalogStationPeriodComponent? ud)  $default,) {final _that = this;
switch (_that) {
case _CatalogStationPeriods():
return $default(_that.ns,_that.ew,_that.ud);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeIfNull: false)  CatalogStationPeriodComponent? ns, @JsonKey(includeIfNull: false)  CatalogStationPeriodComponent? ew, @JsonKey(includeIfNull: false)  CatalogStationPeriodComponent? ud)?  $default,) {final _that = this;
switch (_that) {
case _CatalogStationPeriods() when $default != null:
return $default(_that.ns,_that.ew,_that.ud);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CatalogStationPeriods implements CatalogStationPeriods {
  const _CatalogStationPeriods({@JsonKey(includeIfNull: false) this.ns, @JsonKey(includeIfNull: false) this.ew, @JsonKey(includeIfNull: false) this.ud});
  factory _CatalogStationPeriods.fromJson(Map<String, dynamic> json) => _$CatalogStationPeriodsFromJson(json);

@override@JsonKey(includeIfNull: false) final  CatalogStationPeriodComponent? ns;
@override@JsonKey(includeIfNull: false) final  CatalogStationPeriodComponent? ew;
@override@JsonKey(includeIfNull: false) final  CatalogStationPeriodComponent? ud;

/// Create a copy of CatalogStationPeriods
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CatalogStationPeriodsCopyWith<_CatalogStationPeriods> get copyWith => __$CatalogStationPeriodsCopyWithImpl<_CatalogStationPeriods>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CatalogStationPeriodsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CatalogStationPeriods&&(identical(other.ns, ns) || other.ns == ns)&&(identical(other.ew, ew) || other.ew == ew)&&(identical(other.ud, ud) || other.ud == ud));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ns,ew,ud);

@override
String toString() {
  return 'CatalogStationPeriods(ns: $ns, ew: $ew, ud: $ud)';
}


}

/// @nodoc
abstract mixin class _$CatalogStationPeriodsCopyWith<$Res> implements $CatalogStationPeriodsCopyWith<$Res> {
  factory _$CatalogStationPeriodsCopyWith(_CatalogStationPeriods value, $Res Function(_CatalogStationPeriods) _then) = __$CatalogStationPeriodsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeIfNull: false) CatalogStationPeriodComponent? ns,@JsonKey(includeIfNull: false) CatalogStationPeriodComponent? ew,@JsonKey(includeIfNull: false) CatalogStationPeriodComponent? ud
});


@override $CatalogStationPeriodComponentCopyWith<$Res>? get ns;@override $CatalogStationPeriodComponentCopyWith<$Res>? get ew;@override $CatalogStationPeriodComponentCopyWith<$Res>? get ud;

}
/// @nodoc
class __$CatalogStationPeriodsCopyWithImpl<$Res>
    implements _$CatalogStationPeriodsCopyWith<$Res> {
  __$CatalogStationPeriodsCopyWithImpl(this._self, this._then);

  final _CatalogStationPeriods _self;
  final $Res Function(_CatalogStationPeriods) _then;

/// Create a copy of CatalogStationPeriods
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ns = freezed,Object? ew = freezed,Object? ud = freezed,}) {
  return _then(_CatalogStationPeriods(
ns: freezed == ns ? _self.ns : ns // ignore: cast_nullable_to_non_nullable
as CatalogStationPeriodComponent?,ew: freezed == ew ? _self.ew : ew // ignore: cast_nullable_to_non_nullable
as CatalogStationPeriodComponent?,ud: freezed == ud ? _self.ud : ud // ignore: cast_nullable_to_non_nullable
as CatalogStationPeriodComponent?,
  ));
}

/// Create a copy of CatalogStationPeriods
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CatalogStationPeriodComponentCopyWith<$Res>? get ns {
    if (_self.ns == null) {
    return null;
  }

  return $CatalogStationPeriodComponentCopyWith<$Res>(_self.ns!, (value) {
    return _then(_self.copyWith(ns: value));
  });
}/// Create a copy of CatalogStationPeriods
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CatalogStationPeriodComponentCopyWith<$Res>? get ew {
    if (_self.ew == null) {
    return null;
  }

  return $CatalogStationPeriodComponentCopyWith<$Res>(_self.ew!, (value) {
    return _then(_self.copyWith(ew: value));
  });
}/// Create a copy of CatalogStationPeriods
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CatalogStationPeriodComponentCopyWith<$Res>? get ud {
    if (_self.ud == null) {
    return null;
  }

  return $CatalogStationPeriodComponentCopyWith<$Res>(_self.ud!, (value) {
    return _then(_self.copyWith(ud: value));
  });
}
}

// dart format on
