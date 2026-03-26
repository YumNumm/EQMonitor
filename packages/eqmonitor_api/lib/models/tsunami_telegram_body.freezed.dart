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

@JsonKey(includeIfNull: false) List<TsunamiForecast>? get forecasts;@JsonKey(includeIfNull: false) List<TsunamiObservation>? get observations;@JsonKey(includeIfNull: false) List<TsunamiEstimation>? get estimations;@JsonKey(includeIfNull: false) List<TsunamiEarthquake>? get earthquakes;@JsonKey(includeIfNull: false) String? get text;@JsonKey(includeIfNull: false) TsunamiComments? get comments;
/// Create a copy of TsunamiTelegramBody
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiTelegramBodyCopyWith<TsunamiTelegramBody> get copyWith => _$TsunamiTelegramBodyCopyWithImpl<TsunamiTelegramBody>(this as TsunamiTelegramBody, _$identity);

  /// Serializes this TsunamiTelegramBody to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiTelegramBody&&const DeepCollectionEquality().equals(other.forecasts, forecasts)&&const DeepCollectionEquality().equals(other.observations, observations)&&const DeepCollectionEquality().equals(other.estimations, estimations)&&const DeepCollectionEquality().equals(other.earthquakes, earthquakes)&&(identical(other.text, text) || other.text == text)&&(identical(other.comments, comments) || other.comments == comments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(forecasts),const DeepCollectionEquality().hash(observations),const DeepCollectionEquality().hash(estimations),const DeepCollectionEquality().hash(earthquakes),text,comments);

@override
String toString() {
  return 'TsunamiTelegramBody(forecasts: $forecasts, observations: $observations, estimations: $estimations, earthquakes: $earthquakes, text: $text, comments: $comments)';
}


}

/// @nodoc
abstract mixin class $TsunamiTelegramBodyCopyWith<$Res>  {
  factory $TsunamiTelegramBodyCopyWith(TsunamiTelegramBody value, $Res Function(TsunamiTelegramBody) _then) = _$TsunamiTelegramBodyCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeIfNull: false) List<TsunamiForecast>? forecasts,@JsonKey(includeIfNull: false) List<TsunamiObservation>? observations,@JsonKey(includeIfNull: false) List<TsunamiEstimation>? estimations,@JsonKey(includeIfNull: false) List<TsunamiEarthquake>? earthquakes,@JsonKey(includeIfNull: false) String? text,@JsonKey(includeIfNull: false) TsunamiComments? comments
});


$TsunamiCommentsCopyWith<$Res>? get comments;

}
/// @nodoc
class _$TsunamiTelegramBodyCopyWithImpl<$Res>
    implements $TsunamiTelegramBodyCopyWith<$Res> {
  _$TsunamiTelegramBodyCopyWithImpl(this._self, this._then);

  final TsunamiTelegramBody _self;
  final $Res Function(TsunamiTelegramBody) _then;

/// Create a copy of TsunamiTelegramBody
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? forecasts = freezed,Object? observations = freezed,Object? estimations = freezed,Object? earthquakes = freezed,Object? text = freezed,Object? comments = freezed,}) {
  return _then(_self.copyWith(
forecasts: freezed == forecasts ? _self.forecasts : forecasts // ignore: cast_nullable_to_non_nullable
as List<TsunamiForecast>?,observations: freezed == observations ? _self.observations : observations // ignore: cast_nullable_to_non_nullable
as List<TsunamiObservation>?,estimations: freezed == estimations ? _self.estimations : estimations // ignore: cast_nullable_to_non_nullable
as List<TsunamiEstimation>?,earthquakes: freezed == earthquakes ? _self.earthquakes : earthquakes // ignore: cast_nullable_to_non_nullable
as List<TsunamiEarthquake>?,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,comments: freezed == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as TsunamiComments?,
  ));
}
/// Create a copy of TsunamiTelegramBody
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiCommentsCopyWith<$Res>? get comments {
    if (_self.comments == null) {
    return null;
  }

  return $TsunamiCommentsCopyWith<$Res>(_self.comments!, (value) {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false)  List<TsunamiForecast>? forecasts, @JsonKey(includeIfNull: false)  List<TsunamiObservation>? observations, @JsonKey(includeIfNull: false)  List<TsunamiEstimation>? estimations, @JsonKey(includeIfNull: false)  List<TsunamiEarthquake>? earthquakes, @JsonKey(includeIfNull: false)  String? text, @JsonKey(includeIfNull: false)  TsunamiComments? comments)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiTelegramBody() when $default != null:
return $default(_that.forecasts,_that.observations,_that.estimations,_that.earthquakes,_that.text,_that.comments);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false)  List<TsunamiForecast>? forecasts, @JsonKey(includeIfNull: false)  List<TsunamiObservation>? observations, @JsonKey(includeIfNull: false)  List<TsunamiEstimation>? estimations, @JsonKey(includeIfNull: false)  List<TsunamiEarthquake>? earthquakes, @JsonKey(includeIfNull: false)  String? text, @JsonKey(includeIfNull: false)  TsunamiComments? comments)  $default,) {final _that = this;
switch (_that) {
case _TsunamiTelegramBody():
return $default(_that.forecasts,_that.observations,_that.estimations,_that.earthquakes,_that.text,_that.comments);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeIfNull: false)  List<TsunamiForecast>? forecasts, @JsonKey(includeIfNull: false)  List<TsunamiObservation>? observations, @JsonKey(includeIfNull: false)  List<TsunamiEstimation>? estimations, @JsonKey(includeIfNull: false)  List<TsunamiEarthquake>? earthquakes, @JsonKey(includeIfNull: false)  String? text, @JsonKey(includeIfNull: false)  TsunamiComments? comments)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiTelegramBody() when $default != null:
return $default(_that.forecasts,_that.observations,_that.estimations,_that.earthquakes,_that.text,_that.comments);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TsunamiTelegramBody implements TsunamiTelegramBody {
  const _TsunamiTelegramBody({@JsonKey(includeIfNull: false) final  List<TsunamiForecast>? forecasts, @JsonKey(includeIfNull: false) final  List<TsunamiObservation>? observations, @JsonKey(includeIfNull: false) final  List<TsunamiEstimation>? estimations, @JsonKey(includeIfNull: false) final  List<TsunamiEarthquake>? earthquakes, @JsonKey(includeIfNull: false) this.text, @JsonKey(includeIfNull: false) this.comments}): _forecasts = forecasts,_observations = observations,_estimations = estimations,_earthquakes = earthquakes;
  factory _TsunamiTelegramBody.fromJson(Map<String, dynamic> json) => _$TsunamiTelegramBodyFromJson(json);

 final  List<TsunamiForecast>? _forecasts;
@override@JsonKey(includeIfNull: false) List<TsunamiForecast>? get forecasts {
  final value = _forecasts;
  if (value == null) return null;
  if (_forecasts is EqualUnmodifiableListView) return _forecasts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<TsunamiObservation>? _observations;
@override@JsonKey(includeIfNull: false) List<TsunamiObservation>? get observations {
  final value = _observations;
  if (value == null) return null;
  if (_observations is EqualUnmodifiableListView) return _observations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<TsunamiEstimation>? _estimations;
@override@JsonKey(includeIfNull: false) List<TsunamiEstimation>? get estimations {
  final value = _estimations;
  if (value == null) return null;
  if (_estimations is EqualUnmodifiableListView) return _estimations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<TsunamiEarthquake>? _earthquakes;
@override@JsonKey(includeIfNull: false) List<TsunamiEarthquake>? get earthquakes {
  final value = _earthquakes;
  if (value == null) return null;
  if (_earthquakes is EqualUnmodifiableListView) return _earthquakes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(includeIfNull: false) final  String? text;
@override@JsonKey(includeIfNull: false) final  TsunamiComments? comments;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiTelegramBody&&const DeepCollectionEquality().equals(other._forecasts, _forecasts)&&const DeepCollectionEquality().equals(other._observations, _observations)&&const DeepCollectionEquality().equals(other._estimations, _estimations)&&const DeepCollectionEquality().equals(other._earthquakes, _earthquakes)&&(identical(other.text, text) || other.text == text)&&(identical(other.comments, comments) || other.comments == comments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_forecasts),const DeepCollectionEquality().hash(_observations),const DeepCollectionEquality().hash(_estimations),const DeepCollectionEquality().hash(_earthquakes),text,comments);

@override
String toString() {
  return 'TsunamiTelegramBody(forecasts: $forecasts, observations: $observations, estimations: $estimations, earthquakes: $earthquakes, text: $text, comments: $comments)';
}


}

/// @nodoc
abstract mixin class _$TsunamiTelegramBodyCopyWith<$Res> implements $TsunamiTelegramBodyCopyWith<$Res> {
  factory _$TsunamiTelegramBodyCopyWith(_TsunamiTelegramBody value, $Res Function(_TsunamiTelegramBody) _then) = __$TsunamiTelegramBodyCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeIfNull: false) List<TsunamiForecast>? forecasts,@JsonKey(includeIfNull: false) List<TsunamiObservation>? observations,@JsonKey(includeIfNull: false) List<TsunamiEstimation>? estimations,@JsonKey(includeIfNull: false) List<TsunamiEarthquake>? earthquakes,@JsonKey(includeIfNull: false) String? text,@JsonKey(includeIfNull: false) TsunamiComments? comments
});


@override $TsunamiCommentsCopyWith<$Res>? get comments;

}
/// @nodoc
class __$TsunamiTelegramBodyCopyWithImpl<$Res>
    implements _$TsunamiTelegramBodyCopyWith<$Res> {
  __$TsunamiTelegramBodyCopyWithImpl(this._self, this._then);

  final _TsunamiTelegramBody _self;
  final $Res Function(_TsunamiTelegramBody) _then;

/// Create a copy of TsunamiTelegramBody
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? forecasts = freezed,Object? observations = freezed,Object? estimations = freezed,Object? earthquakes = freezed,Object? text = freezed,Object? comments = freezed,}) {
  return _then(_TsunamiTelegramBody(
forecasts: freezed == forecasts ? _self._forecasts : forecasts // ignore: cast_nullable_to_non_nullable
as List<TsunamiForecast>?,observations: freezed == observations ? _self._observations : observations // ignore: cast_nullable_to_non_nullable
as List<TsunamiObservation>?,estimations: freezed == estimations ? _self._estimations : estimations // ignore: cast_nullable_to_non_nullable
as List<TsunamiEstimation>?,earthquakes: freezed == earthquakes ? _self._earthquakes : earthquakes // ignore: cast_nullable_to_non_nullable
as List<TsunamiEarthquake>?,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,comments: freezed == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as TsunamiComments?,
  ));
}

/// Create a copy of TsunamiTelegramBody
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiCommentsCopyWith<$Res>? get comments {
    if (_self.comments == null) {
    return null;
  }

  return $TsunamiCommentsCopyWith<$Res>(_self.comments!, (value) {
    return _then(_self.copyWith(comments: value));
  });
}
}

// dart format on
