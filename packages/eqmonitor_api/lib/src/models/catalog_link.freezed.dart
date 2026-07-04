// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'catalog_link.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CatalogLink {

@JsonKey(name: 'match_confidence') num get matchConfidence;@JsonKey(name: 'match_method') CatalogLinkMatchMethod get matchMethod;@JsonKey(name: 'time_diff_seconds') num get timeDiffSeconds;@JsonKey(includeIfNull: true, name: 'distance_km') num? get distanceKm;
/// Create a copy of CatalogLink
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CatalogLinkCopyWith<CatalogLink> get copyWith => _$CatalogLinkCopyWithImpl<CatalogLink>(this as CatalogLink, _$identity);

  /// Serializes this CatalogLink to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CatalogLink&&(identical(other.matchConfidence, matchConfidence) || other.matchConfidence == matchConfidence)&&(identical(other.matchMethod, matchMethod) || other.matchMethod == matchMethod)&&(identical(other.timeDiffSeconds, timeDiffSeconds) || other.timeDiffSeconds == timeDiffSeconds)&&(identical(other.distanceKm, distanceKm) || other.distanceKm == distanceKm));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,matchConfidence,matchMethod,timeDiffSeconds,distanceKm);

@override
String toString() {
  return 'CatalogLink(matchConfidence: $matchConfidence, matchMethod: $matchMethod, timeDiffSeconds: $timeDiffSeconds, distanceKm: $distanceKm)';
}


}

/// @nodoc
abstract mixin class $CatalogLinkCopyWith<$Res>  {
  factory $CatalogLinkCopyWith(CatalogLink value, $Res Function(CatalogLink) _then) = _$CatalogLinkCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'match_confidence') num matchConfidence,@JsonKey(name: 'match_method') CatalogLinkMatchMethod matchMethod,@JsonKey(name: 'time_diff_seconds') num timeDiffSeconds,@JsonKey(includeIfNull: true, name: 'distance_km') num? distanceKm
});




}
/// @nodoc
class _$CatalogLinkCopyWithImpl<$Res>
    implements $CatalogLinkCopyWith<$Res> {
  _$CatalogLinkCopyWithImpl(this._self, this._then);

  final CatalogLink _self;
  final $Res Function(CatalogLink) _then;

/// Create a copy of CatalogLink
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? matchConfidence = null,Object? matchMethod = null,Object? timeDiffSeconds = null,Object? distanceKm = freezed,}) {
  return _then(_self.copyWith(
matchConfidence: null == matchConfidence ? _self.matchConfidence : matchConfidence // ignore: cast_nullable_to_non_nullable
as num,matchMethod: null == matchMethod ? _self.matchMethod : matchMethod // ignore: cast_nullable_to_non_nullable
as CatalogLinkMatchMethod,timeDiffSeconds: null == timeDiffSeconds ? _self.timeDiffSeconds : timeDiffSeconds // ignore: cast_nullable_to_non_nullable
as num,distanceKm: freezed == distanceKm ? _self.distanceKm : distanceKm // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}

}


/// Adds pattern-matching-related methods to [CatalogLink].
extension CatalogLinkPatterns on CatalogLink {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CatalogLink value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CatalogLink() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CatalogLink value)  $default,){
final _that = this;
switch (_that) {
case _CatalogLink():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CatalogLink value)?  $default,){
final _that = this;
switch (_that) {
case _CatalogLink() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'match_confidence')  num matchConfidence, @JsonKey(name: 'match_method')  CatalogLinkMatchMethod matchMethod, @JsonKey(name: 'time_diff_seconds')  num timeDiffSeconds, @JsonKey(includeIfNull: true, name: 'distance_km')  num? distanceKm)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CatalogLink() when $default != null:
return $default(_that.matchConfidence,_that.matchMethod,_that.timeDiffSeconds,_that.distanceKm);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'match_confidence')  num matchConfidence, @JsonKey(name: 'match_method')  CatalogLinkMatchMethod matchMethod, @JsonKey(name: 'time_diff_seconds')  num timeDiffSeconds, @JsonKey(includeIfNull: true, name: 'distance_km')  num? distanceKm)  $default,) {final _that = this;
switch (_that) {
case _CatalogLink():
return $default(_that.matchConfidence,_that.matchMethod,_that.timeDiffSeconds,_that.distanceKm);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'match_confidence')  num matchConfidence, @JsonKey(name: 'match_method')  CatalogLinkMatchMethod matchMethod, @JsonKey(name: 'time_diff_seconds')  num timeDiffSeconds, @JsonKey(includeIfNull: true, name: 'distance_km')  num? distanceKm)?  $default,) {final _that = this;
switch (_that) {
case _CatalogLink() when $default != null:
return $default(_that.matchConfidence,_that.matchMethod,_that.timeDiffSeconds,_that.distanceKm);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CatalogLink implements CatalogLink {
  const _CatalogLink({@JsonKey(name: 'match_confidence') required this.matchConfidence, @JsonKey(name: 'match_method') required this.matchMethod, @JsonKey(name: 'time_diff_seconds') required this.timeDiffSeconds, @JsonKey(includeIfNull: true, name: 'distance_km') required this.distanceKm});
  factory _CatalogLink.fromJson(Map<String, dynamic> json) => _$CatalogLinkFromJson(json);

@override@JsonKey(name: 'match_confidence') final  num matchConfidence;
@override@JsonKey(name: 'match_method') final  CatalogLinkMatchMethod matchMethod;
@override@JsonKey(name: 'time_diff_seconds') final  num timeDiffSeconds;
@override@JsonKey(includeIfNull: true, name: 'distance_km') final  num? distanceKm;

/// Create a copy of CatalogLink
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CatalogLinkCopyWith<_CatalogLink> get copyWith => __$CatalogLinkCopyWithImpl<_CatalogLink>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CatalogLinkToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CatalogLink&&(identical(other.matchConfidence, matchConfidence) || other.matchConfidence == matchConfidence)&&(identical(other.matchMethod, matchMethod) || other.matchMethod == matchMethod)&&(identical(other.timeDiffSeconds, timeDiffSeconds) || other.timeDiffSeconds == timeDiffSeconds)&&(identical(other.distanceKm, distanceKm) || other.distanceKm == distanceKm));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,matchConfidence,matchMethod,timeDiffSeconds,distanceKm);

@override
String toString() {
  return 'CatalogLink(matchConfidence: $matchConfidence, matchMethod: $matchMethod, timeDiffSeconds: $timeDiffSeconds, distanceKm: $distanceKm)';
}


}

/// @nodoc
abstract mixin class _$CatalogLinkCopyWith<$Res> implements $CatalogLinkCopyWith<$Res> {
  factory _$CatalogLinkCopyWith(_CatalogLink value, $Res Function(_CatalogLink) _then) = __$CatalogLinkCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'match_confidence') num matchConfidence,@JsonKey(name: 'match_method') CatalogLinkMatchMethod matchMethod,@JsonKey(name: 'time_diff_seconds') num timeDiffSeconds,@JsonKey(includeIfNull: true, name: 'distance_km') num? distanceKm
});




}
/// @nodoc
class __$CatalogLinkCopyWithImpl<$Res>
    implements _$CatalogLinkCopyWith<$Res> {
  __$CatalogLinkCopyWithImpl(this._self, this._then);

  final _CatalogLink _self;
  final $Res Function(_CatalogLink) _then;

/// Create a copy of CatalogLink
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? matchConfidence = null,Object? matchMethod = null,Object? timeDiffSeconds = null,Object? distanceKm = freezed,}) {
  return _then(_CatalogLink(
matchConfidence: null == matchConfidence ? _self.matchConfidence : matchConfidence // ignore: cast_nullable_to_non_nullable
as num,matchMethod: null == matchMethod ? _self.matchMethod : matchMethod // ignore: cast_nullable_to_non_nullable
as CatalogLinkMatchMethod,timeDiffSeconds: null == timeDiffSeconds ? _self.timeDiffSeconds : timeDiffSeconds // ignore: cast_nullable_to_non_nullable
as num,distanceKm: freezed == distanceKm ? _self.distanceKm : distanceKm // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}


}

// dart format on
