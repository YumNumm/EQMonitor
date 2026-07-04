// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'catalog.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Catalog {

 List<CatalogHypocenter> get hypocenters;@JsonKey(name: 'station_records') List<CatalogStationRecord> get stationRecords;@JsonKey(includeIfNull: true, name: 'damage_scale') String? get damageScale;@JsonKey(includeIfNull: true, name: 'tsunami_scale') String? get tsunamiScale;@JsonKey(includeIfNull: false) CatalogLink? get link;
/// Create a copy of Catalog
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CatalogCopyWith<Catalog> get copyWith => _$CatalogCopyWithImpl<Catalog>(this as Catalog, _$identity);

  /// Serializes this Catalog to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Catalog&&const DeepCollectionEquality().equals(other.hypocenters, hypocenters)&&const DeepCollectionEquality().equals(other.stationRecords, stationRecords)&&(identical(other.damageScale, damageScale) || other.damageScale == damageScale)&&(identical(other.tsunamiScale, tsunamiScale) || other.tsunamiScale == tsunamiScale)&&(identical(other.link, link) || other.link == link));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(hypocenters),const DeepCollectionEquality().hash(stationRecords),damageScale,tsunamiScale,link);

@override
String toString() {
  return 'Catalog(hypocenters: $hypocenters, stationRecords: $stationRecords, damageScale: $damageScale, tsunamiScale: $tsunamiScale, link: $link)';
}


}

/// @nodoc
abstract mixin class $CatalogCopyWith<$Res>  {
  factory $CatalogCopyWith(Catalog value, $Res Function(Catalog) _then) = _$CatalogCopyWithImpl;
@useResult
$Res call({
 List<CatalogHypocenter> hypocenters,@JsonKey(name: 'station_records') List<CatalogStationRecord> stationRecords,@JsonKey(includeIfNull: true, name: 'damage_scale') String? damageScale,@JsonKey(includeIfNull: true, name: 'tsunami_scale') String? tsunamiScale,@JsonKey(includeIfNull: false) CatalogLink? link
});


$CatalogLinkCopyWith<$Res>? get link;

}
/// @nodoc
class _$CatalogCopyWithImpl<$Res>
    implements $CatalogCopyWith<$Res> {
  _$CatalogCopyWithImpl(this._self, this._then);

  final Catalog _self;
  final $Res Function(Catalog) _then;

/// Create a copy of Catalog
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hypocenters = null,Object? stationRecords = null,Object? damageScale = freezed,Object? tsunamiScale = freezed,Object? link = freezed,}) {
  return _then(_self.copyWith(
hypocenters: null == hypocenters ? _self.hypocenters : hypocenters // ignore: cast_nullable_to_non_nullable
as List<CatalogHypocenter>,stationRecords: null == stationRecords ? _self.stationRecords : stationRecords // ignore: cast_nullable_to_non_nullable
as List<CatalogStationRecord>,damageScale: freezed == damageScale ? _self.damageScale : damageScale // ignore: cast_nullable_to_non_nullable
as String?,tsunamiScale: freezed == tsunamiScale ? _self.tsunamiScale : tsunamiScale // ignore: cast_nullable_to_non_nullable
as String?,link: freezed == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as CatalogLink?,
  ));
}
/// Create a copy of Catalog
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CatalogLinkCopyWith<$Res>? get link {
    if (_self.link == null) {
    return null;
  }

  return $CatalogLinkCopyWith<$Res>(_self.link!, (value) {
    return _then(_self.copyWith(link: value));
  });
}
}


/// Adds pattern-matching-related methods to [Catalog].
extension CatalogPatterns on Catalog {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Catalog value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Catalog() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Catalog value)  $default,){
final _that = this;
switch (_that) {
case _Catalog():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Catalog value)?  $default,){
final _that = this;
switch (_that) {
case _Catalog() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<CatalogHypocenter> hypocenters, @JsonKey(name: 'station_records')  List<CatalogStationRecord> stationRecords, @JsonKey(includeIfNull: true, name: 'damage_scale')  String? damageScale, @JsonKey(includeIfNull: true, name: 'tsunami_scale')  String? tsunamiScale, @JsonKey(includeIfNull: false)  CatalogLink? link)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Catalog() when $default != null:
return $default(_that.hypocenters,_that.stationRecords,_that.damageScale,_that.tsunamiScale,_that.link);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<CatalogHypocenter> hypocenters, @JsonKey(name: 'station_records')  List<CatalogStationRecord> stationRecords, @JsonKey(includeIfNull: true, name: 'damage_scale')  String? damageScale, @JsonKey(includeIfNull: true, name: 'tsunami_scale')  String? tsunamiScale, @JsonKey(includeIfNull: false)  CatalogLink? link)  $default,) {final _that = this;
switch (_that) {
case _Catalog():
return $default(_that.hypocenters,_that.stationRecords,_that.damageScale,_that.tsunamiScale,_that.link);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<CatalogHypocenter> hypocenters, @JsonKey(name: 'station_records')  List<CatalogStationRecord> stationRecords, @JsonKey(includeIfNull: true, name: 'damage_scale')  String? damageScale, @JsonKey(includeIfNull: true, name: 'tsunami_scale')  String? tsunamiScale, @JsonKey(includeIfNull: false)  CatalogLink? link)?  $default,) {final _that = this;
switch (_that) {
case _Catalog() when $default != null:
return $default(_that.hypocenters,_that.stationRecords,_that.damageScale,_that.tsunamiScale,_that.link);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Catalog implements Catalog {
  const _Catalog({required final  List<CatalogHypocenter> hypocenters, @JsonKey(name: 'station_records') required final  List<CatalogStationRecord> stationRecords, @JsonKey(includeIfNull: true, name: 'damage_scale') required this.damageScale, @JsonKey(includeIfNull: true, name: 'tsunami_scale') required this.tsunamiScale, @JsonKey(includeIfNull: false) this.link}): _hypocenters = hypocenters,_stationRecords = stationRecords;
  factory _Catalog.fromJson(Map<String, dynamic> json) => _$CatalogFromJson(json);

 final  List<CatalogHypocenter> _hypocenters;
@override List<CatalogHypocenter> get hypocenters {
  if (_hypocenters is EqualUnmodifiableListView) return _hypocenters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_hypocenters);
}

 final  List<CatalogStationRecord> _stationRecords;
@override@JsonKey(name: 'station_records') List<CatalogStationRecord> get stationRecords {
  if (_stationRecords is EqualUnmodifiableListView) return _stationRecords;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stationRecords);
}

@override@JsonKey(includeIfNull: true, name: 'damage_scale') final  String? damageScale;
@override@JsonKey(includeIfNull: true, name: 'tsunami_scale') final  String? tsunamiScale;
@override@JsonKey(includeIfNull: false) final  CatalogLink? link;

/// Create a copy of Catalog
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CatalogCopyWith<_Catalog> get copyWith => __$CatalogCopyWithImpl<_Catalog>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CatalogToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Catalog&&const DeepCollectionEquality().equals(other._hypocenters, _hypocenters)&&const DeepCollectionEquality().equals(other._stationRecords, _stationRecords)&&(identical(other.damageScale, damageScale) || other.damageScale == damageScale)&&(identical(other.tsunamiScale, tsunamiScale) || other.tsunamiScale == tsunamiScale)&&(identical(other.link, link) || other.link == link));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_hypocenters),const DeepCollectionEquality().hash(_stationRecords),damageScale,tsunamiScale,link);

@override
String toString() {
  return 'Catalog(hypocenters: $hypocenters, stationRecords: $stationRecords, damageScale: $damageScale, tsunamiScale: $tsunamiScale, link: $link)';
}


}

/// @nodoc
abstract mixin class _$CatalogCopyWith<$Res> implements $CatalogCopyWith<$Res> {
  factory _$CatalogCopyWith(_Catalog value, $Res Function(_Catalog) _then) = __$CatalogCopyWithImpl;
@override @useResult
$Res call({
 List<CatalogHypocenter> hypocenters,@JsonKey(name: 'station_records') List<CatalogStationRecord> stationRecords,@JsonKey(includeIfNull: true, name: 'damage_scale') String? damageScale,@JsonKey(includeIfNull: true, name: 'tsunami_scale') String? tsunamiScale,@JsonKey(includeIfNull: false) CatalogLink? link
});


@override $CatalogLinkCopyWith<$Res>? get link;

}
/// @nodoc
class __$CatalogCopyWithImpl<$Res>
    implements _$CatalogCopyWith<$Res> {
  __$CatalogCopyWithImpl(this._self, this._then);

  final _Catalog _self;
  final $Res Function(_Catalog) _then;

/// Create a copy of Catalog
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hypocenters = null,Object? stationRecords = null,Object? damageScale = freezed,Object? tsunamiScale = freezed,Object? link = freezed,}) {
  return _then(_Catalog(
hypocenters: null == hypocenters ? _self._hypocenters : hypocenters // ignore: cast_nullable_to_non_nullable
as List<CatalogHypocenter>,stationRecords: null == stationRecords ? _self._stationRecords : stationRecords // ignore: cast_nullable_to_non_nullable
as List<CatalogStationRecord>,damageScale: freezed == damageScale ? _self.damageScale : damageScale // ignore: cast_nullable_to_non_nullable
as String?,tsunamiScale: freezed == tsunamiScale ? _self.tsunamiScale : tsunamiScale // ignore: cast_nullable_to_non_nullable
as String?,link: freezed == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as CatalogLink?,
  ));
}

/// Create a copy of Catalog
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CatalogLinkCopyWith<$Res>? get link {
    if (_self.link == null) {
    return null;
  }

  return $CatalogLinkCopyWith<$Res>(_self.link!, (value) {
    return _then(_self.copyWith(link: value));
  });
}
}

// dart format on
