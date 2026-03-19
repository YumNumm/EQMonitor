// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_telegram_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TsunamiTelegramBody {

 List<TsunamiForecast> get forecasts; List<TsunamiObservation> get observations; List<TsunamiEstimation> get estimations; List<TsunamiEarthquake> get earthquakes; TsunamiComments get comments;@JsonKey(includeIfNull: false) String? get text;
/// Create a copy of TsunamiTelegramBody
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiTelegramBodyCopyWith<TsunamiTelegramBody> get copyWith => _$TsunamiTelegramBodyCopyWithImpl<TsunamiTelegramBody>(this as TsunamiTelegramBody, _$identity);

  /// Serializes this TsunamiTelegramBody to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiTelegramBody&&const DeepCollectionEquality().equals(other.forecasts, forecasts)&&const DeepCollectionEquality().equals(other.observations, observations)&&const DeepCollectionEquality().equals(other.estimations, estimations)&&const DeepCollectionEquality().equals(other.earthquakes, earthquakes)&&(identical(other.comments, comments) || other.comments == comments)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(forecasts),const DeepCollectionEquality().hash(observations),const DeepCollectionEquality().hash(estimations),const DeepCollectionEquality().hash(earthquakes),comments,text);

@override
String toString() {
  return 'TsunamiTelegramBody(forecasts: $forecasts, observations: $observations, estimations: $estimations, earthquakes: $earthquakes, comments: $comments, text: $text)';
}


}

/// @nodoc
abstract mixin class $TsunamiTelegramBodyCopyWith<$Res>  {
  factory $TsunamiTelegramBodyCopyWith(TsunamiTelegramBody value, $Res Function(TsunamiTelegramBody) _then) = _$TsunamiTelegramBodyCopyWithImpl;
@useResult
$Res call({
 List<TsunamiForecast> forecasts, List<TsunamiObservation> observations, List<TsunamiEstimation> estimations, List<TsunamiEarthquake> earthquakes, TsunamiComments comments,@JsonKey(includeIfNull: false) String? text
});


$TsunamiCommentsCopyWith<$Res> get comments;

}
/// @nodoc
class _$TsunamiTelegramBodyCopyWithImpl<$Res>
    implements $TsunamiTelegramBodyCopyWith<$Res> {
  _$TsunamiTelegramBodyCopyWithImpl(this._self, this._then);

  final TsunamiTelegramBody _self;
  final $Res Function(TsunamiTelegramBody) _then;

/// Create a copy of TsunamiTelegramBody
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? forecasts = null,Object? observations = null,Object? estimations = null,Object? earthquakes = null,Object? comments = null,Object? text = freezed,}) {
  return _then(_self.copyWith(
forecasts: null == forecasts ? _self.forecasts : forecasts // ignore: cast_nullable_to_non_nullable
as List<TsunamiForecast>,observations: null == observations ? _self.observations : observations // ignore: cast_nullable_to_non_nullable
as List<TsunamiObservation>,estimations: null == estimations ? _self.estimations : estimations // ignore: cast_nullable_to_non_nullable
as List<TsunamiEstimation>,earthquakes: null == earthquakes ? _self.earthquakes : earthquakes // ignore: cast_nullable_to_non_nullable
as List<TsunamiEarthquake>,comments: null == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as TsunamiComments,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of TsunamiTelegramBody
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiCommentsCopyWith<$Res> get comments {
  
  return $TsunamiCommentsCopyWith<$Res>(_self.comments, (value) {
    return _then(_self.copyWith(comments: value));
  });
}
}


/// Adds pattern-matching-related methods to [TsunamiTelegramBody].
extension TsunamiTelegramBodyPatterns on TsunamiTelegramBody {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiTelegramBody value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiTelegramBody() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiTelegramBody value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiTelegramBody():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiTelegramBody value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiTelegramBody() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<TsunamiForecast> forecasts,  List<TsunamiObservation> observations,  List<TsunamiEstimation> estimations,  List<TsunamiEarthquake> earthquakes,  TsunamiComments comments, @JsonKey(includeIfNull: false)  String? text)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiTelegramBody() when $default != null:
return $default(_that.forecasts,_that.observations,_that.estimations,_that.earthquakes,_that.comments,_that.text);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<TsunamiForecast> forecasts,  List<TsunamiObservation> observations,  List<TsunamiEstimation> estimations,  List<TsunamiEarthquake> earthquakes,  TsunamiComments comments, @JsonKey(includeIfNull: false)  String? text)  $default,) {final _that = this;
switch (_that) {
case _TsunamiTelegramBody():
return $default(_that.forecasts,_that.observations,_that.estimations,_that.earthquakes,_that.comments,_that.text);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<TsunamiForecast> forecasts,  List<TsunamiObservation> observations,  List<TsunamiEstimation> estimations,  List<TsunamiEarthquake> earthquakes,  TsunamiComments comments, @JsonKey(includeIfNull: false)  String? text)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiTelegramBody() when $default != null:
return $default(_that.forecasts,_that.observations,_that.estimations,_that.earthquakes,_that.comments,_that.text);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TsunamiTelegramBody implements TsunamiTelegramBody {
  const _TsunamiTelegramBody({required final  List<TsunamiForecast> forecasts, required final  List<TsunamiObservation> observations, required final  List<TsunamiEstimation> estimations, required final  List<TsunamiEarthquake> earthquakes, required this.comments, @JsonKey(includeIfNull: false) this.text}): _forecasts = forecasts,_observations = observations,_estimations = estimations,_earthquakes = earthquakes;
  factory _TsunamiTelegramBody.fromJson(Map<String, dynamic> json) => _$TsunamiTelegramBodyFromJson(json);

 final  List<TsunamiForecast> _forecasts;
@override List<TsunamiForecast> get forecasts {
  if (_forecasts is EqualUnmodifiableListView) return _forecasts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_forecasts);
}

 final  List<TsunamiObservation> _observations;
@override List<TsunamiObservation> get observations {
  if (_observations is EqualUnmodifiableListView) return _observations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_observations);
}

 final  List<TsunamiEstimation> _estimations;
@override List<TsunamiEstimation> get estimations {
  if (_estimations is EqualUnmodifiableListView) return _estimations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_estimations);
}

 final  List<TsunamiEarthquake> _earthquakes;
@override List<TsunamiEarthquake> get earthquakes {
  if (_earthquakes is EqualUnmodifiableListView) return _earthquakes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_earthquakes);
}

@override final  TsunamiComments comments;
@override@JsonKey(includeIfNull: false) final  String? text;

/// Create a copy of TsunamiTelegramBody
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiTelegramBodyCopyWith<_TsunamiTelegramBody> get copyWith => __$TsunamiTelegramBodyCopyWithImpl<_TsunamiTelegramBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiTelegramBodyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiTelegramBody&&const DeepCollectionEquality().equals(other._forecasts, _forecasts)&&const DeepCollectionEquality().equals(other._observations, _observations)&&const DeepCollectionEquality().equals(other._estimations, _estimations)&&const DeepCollectionEquality().equals(other._earthquakes, _earthquakes)&&(identical(other.comments, comments) || other.comments == comments)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_forecasts),const DeepCollectionEquality().hash(_observations),const DeepCollectionEquality().hash(_estimations),const DeepCollectionEquality().hash(_earthquakes),comments,text);

@override
String toString() {
  return 'TsunamiTelegramBody(forecasts: $forecasts, observations: $observations, estimations: $estimations, earthquakes: $earthquakes, comments: $comments, text: $text)';
}


}

/// @nodoc
abstract mixin class _$TsunamiTelegramBodyCopyWith<$Res> implements $TsunamiTelegramBodyCopyWith<$Res> {
  factory _$TsunamiTelegramBodyCopyWith(_TsunamiTelegramBody value, $Res Function(_TsunamiTelegramBody) _then) = __$TsunamiTelegramBodyCopyWithImpl;
@override @useResult
$Res call({
 List<TsunamiForecast> forecasts, List<TsunamiObservation> observations, List<TsunamiEstimation> estimations, List<TsunamiEarthquake> earthquakes, TsunamiComments comments,@JsonKey(includeIfNull: false) String? text
});


@override $TsunamiCommentsCopyWith<$Res> get comments;

}
/// @nodoc
class __$TsunamiTelegramBodyCopyWithImpl<$Res>
    implements _$TsunamiTelegramBodyCopyWith<$Res> {
  __$TsunamiTelegramBodyCopyWithImpl(this._self, this._then);

  final _TsunamiTelegramBody _self;
  final $Res Function(_TsunamiTelegramBody) _then;

/// Create a copy of TsunamiTelegramBody
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? forecasts = null,Object? observations = null,Object? estimations = null,Object? earthquakes = null,Object? comments = null,Object? text = freezed,}) {
  return _then(_TsunamiTelegramBody(
forecasts: null == forecasts ? _self._forecasts : forecasts // ignore: cast_nullable_to_non_nullable
as List<TsunamiForecast>,observations: null == observations ? _self._observations : observations // ignore: cast_nullable_to_non_nullable
as List<TsunamiObservation>,estimations: null == estimations ? _self._estimations : estimations // ignore: cast_nullable_to_non_nullable
as List<TsunamiEstimation>,earthquakes: null == earthquakes ? _self._earthquakes : earthquakes // ignore: cast_nullable_to_non_nullable
as List<TsunamiEarthquake>,comments: null == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as TsunamiComments,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of TsunamiTelegramBody
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiCommentsCopyWith<$Res> get comments {
  
  return $TsunamiCommentsCopyWith<$Res>(_self.comments, (value) {
    return _then(_self.copyWith(comments: value));
  });
}
}

// dart format on
