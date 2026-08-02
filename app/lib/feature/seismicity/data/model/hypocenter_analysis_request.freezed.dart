// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hypocenter_analysis_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HypocenterAnalysisRequest {

 List<HypocenterArchive> get archives; SeismicityBounds get bounds;
/// Create a copy of HypocenterAnalysisRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HypocenterAnalysisRequestCopyWith<HypocenterAnalysisRequest> get copyWith => _$HypocenterAnalysisRequestCopyWithImpl<HypocenterAnalysisRequest>(this as HypocenterAnalysisRequest, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HypocenterAnalysisRequest&&const DeepCollectionEquality().equals(other.archives, archives)&&(identical(other.bounds, bounds) || other.bounds == bounds));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(archives),bounds);

@override
String toString() {
  return 'HypocenterAnalysisRequest(archives: $archives, bounds: $bounds)';
}


}

/// @nodoc
abstract mixin class $HypocenterAnalysisRequestCopyWith<$Res>  {
  factory $HypocenterAnalysisRequestCopyWith(HypocenterAnalysisRequest value, $Res Function(HypocenterAnalysisRequest) _then) = _$HypocenterAnalysisRequestCopyWithImpl;
@useResult
$Res call({
 List<HypocenterArchive> archives, SeismicityBounds bounds
});


$SeismicityBoundsCopyWith<$Res> get bounds;

}
/// @nodoc
class _$HypocenterAnalysisRequestCopyWithImpl<$Res>
    implements $HypocenterAnalysisRequestCopyWith<$Res> {
  _$HypocenterAnalysisRequestCopyWithImpl(this._self, this._then);

  final HypocenterAnalysisRequest _self;
  final $Res Function(HypocenterAnalysisRequest) _then;

/// Create a copy of HypocenterAnalysisRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? archives = null,Object? bounds = null,}) {
  return _then(_self.copyWith(
archives: null == archives ? _self.archives : archives // ignore: cast_nullable_to_non_nullable
as List<HypocenterArchive>,bounds: null == bounds ? _self.bounds : bounds // ignore: cast_nullable_to_non_nullable
as SeismicityBounds,
  ));
}
/// Create a copy of HypocenterAnalysisRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SeismicityBoundsCopyWith<$Res> get bounds {

  return $SeismicityBoundsCopyWith<$Res>(_self.bounds, (value) {
    return _then(_self.copyWith(bounds: value));
  });
}
}


/// Adds pattern-matching-related methods to [HypocenterAnalysisRequest].
extension HypocenterAnalysisRequestPatterns on HypocenterAnalysisRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HypocenterAnalysisRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HypocenterAnalysisRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HypocenterAnalysisRequest value)  $default,){
final _that = this;
switch (_that) {
case _HypocenterAnalysisRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HypocenterAnalysisRequest value)?  $default,){
final _that = this;
switch (_that) {
case _HypocenterAnalysisRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<HypocenterArchive> archives,  SeismicityBounds bounds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HypocenterAnalysisRequest() when $default != null:
return $default(_that.archives,_that.bounds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<HypocenterArchive> archives,  SeismicityBounds bounds)  $default,) {final _that = this;
switch (_that) {
case _HypocenterAnalysisRequest():
return $default(_that.archives,_that.bounds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<HypocenterArchive> archives,  SeismicityBounds bounds)?  $default,) {final _that = this;
switch (_that) {
case _HypocenterAnalysisRequest() when $default != null:
return $default(_that.archives,_that.bounds);case _:
  return null;

}
}

}

/// @nodoc


class _HypocenterAnalysisRequest implements HypocenterAnalysisRequest {
  const _HypocenterAnalysisRequest({required final  List<HypocenterArchive> archives, required this.bounds}): _archives = archives;


 final  List<HypocenterArchive> _archives;
@override List<HypocenterArchive> get archives {
  if (_archives is EqualUnmodifiableListView) return _archives;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_archives);
}

@override final  SeismicityBounds bounds;

/// Create a copy of HypocenterAnalysisRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HypocenterAnalysisRequestCopyWith<_HypocenterAnalysisRequest> get copyWith => __$HypocenterAnalysisRequestCopyWithImpl<_HypocenterAnalysisRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HypocenterAnalysisRequest&&const DeepCollectionEquality().equals(other._archives, _archives)&&(identical(other.bounds, bounds) || other.bounds == bounds));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_archives),bounds);

@override
String toString() {
  return 'HypocenterAnalysisRequest(archives: $archives, bounds: $bounds)';
}


}

/// @nodoc
abstract mixin class _$HypocenterAnalysisRequestCopyWith<$Res> implements $HypocenterAnalysisRequestCopyWith<$Res> {
  factory _$HypocenterAnalysisRequestCopyWith(_HypocenterAnalysisRequest value, $Res Function(_HypocenterAnalysisRequest) _then) = __$HypocenterAnalysisRequestCopyWithImpl;
@override @useResult
$Res call({
 List<HypocenterArchive> archives, SeismicityBounds bounds
});


@override $SeismicityBoundsCopyWith<$Res> get bounds;

}
/// @nodoc
class __$HypocenterAnalysisRequestCopyWithImpl<$Res>
    implements _$HypocenterAnalysisRequestCopyWith<$Res> {
  __$HypocenterAnalysisRequestCopyWithImpl(this._self, this._then);

  final _HypocenterAnalysisRequest _self;
  final $Res Function(_HypocenterAnalysisRequest) _then;

/// Create a copy of HypocenterAnalysisRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? archives = null,Object? bounds = null,}) {
  return _then(_HypocenterAnalysisRequest(
archives: null == archives ? _self._archives : archives // ignore: cast_nullable_to_non_nullable
as List<HypocenterArchive>,bounds: null == bounds ? _self.bounds : bounds // ignore: cast_nullable_to_non_nullable
as SeismicityBounds,
  ));
}

/// Create a copy of HypocenterAnalysisRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SeismicityBoundsCopyWith<$Res> get bounds {

  return $SeismicityBoundsCopyWith<$Res>(_self.bounds, (value) {
    return _then(_self.copyWith(bounds: value));
  });
}
}

// dart format on
