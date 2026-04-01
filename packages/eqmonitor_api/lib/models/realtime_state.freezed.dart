// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'realtime_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RealtimeState {

 num get revision; DateTime get updatedAt; List<Shakes> get shakes; List<Eews> get eews; List<EarthquakePartial> get earthquakes; List<TsunamiListItem> get tsunamis;
/// Create a copy of RealtimeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RealtimeStateCopyWith<RealtimeState> get copyWith => _$RealtimeStateCopyWithImpl<RealtimeState>(this as RealtimeState, _$identity);

  /// Serializes this RealtimeState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RealtimeState&&(identical(other.revision, revision) || other.revision == revision)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.shakes, shakes)&&const DeepCollectionEquality().equals(other.eews, eews)&&const DeepCollectionEquality().equals(other.earthquakes, earthquakes)&&const DeepCollectionEquality().equals(other.tsunamis, tsunamis));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,revision,updatedAt,const DeepCollectionEquality().hash(shakes),const DeepCollectionEquality().hash(eews),const DeepCollectionEquality().hash(earthquakes),const DeepCollectionEquality().hash(tsunamis));

@override
String toString() {
  return 'RealtimeState(revision: $revision, updatedAt: $updatedAt, shakes: $shakes, eews: $eews, earthquakes: $earthquakes, tsunamis: $tsunamis)';
}


}

/// @nodoc
abstract mixin class $RealtimeStateCopyWith<$Res>  {
  factory $RealtimeStateCopyWith(RealtimeState value, $Res Function(RealtimeState) _then) = _$RealtimeStateCopyWithImpl;
@useResult
$Res call({
 num revision, DateTime updatedAt, List<Shakes> shakes, List<Eews> eews, List<EarthquakePartial> earthquakes, List<TsunamiListItem> tsunamis
});




}
/// @nodoc
class _$RealtimeStateCopyWithImpl<$Res>
    implements $RealtimeStateCopyWith<$Res> {
  _$RealtimeStateCopyWithImpl(this._self, this._then);

  final RealtimeState _self;
  final $Res Function(RealtimeState) _then;

/// Create a copy of RealtimeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? revision = null,Object? updatedAt = null,Object? shakes = null,Object? eews = null,Object? earthquakes = null,Object? tsunamis = null,}) {
  return _then(_self.copyWith(
revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as num,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,shakes: null == shakes ? _self.shakes : shakes // ignore: cast_nullable_to_non_nullable
as List<Shakes>,eews: null == eews ? _self.eews : eews // ignore: cast_nullable_to_non_nullable
as List<Eews>,earthquakes: null == earthquakes ? _self.earthquakes : earthquakes // ignore: cast_nullable_to_non_nullable
as List<EarthquakePartial>,tsunamis: null == tsunamis ? _self.tsunamis : tsunamis // ignore: cast_nullable_to_non_nullable
as List<TsunamiListItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [RealtimeState].
extension RealtimeStatePatterns on RealtimeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RealtimeState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RealtimeState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RealtimeState value)  $default,){
final _that = this;
switch (_that) {
case _RealtimeState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RealtimeState value)?  $default,){
final _that = this;
switch (_that) {
case _RealtimeState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( num revision,  DateTime updatedAt,  List<Shakes> shakes,  List<Eews> eews,  List<EarthquakePartial> earthquakes,  List<TsunamiListItem> tsunamis)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RealtimeState() when $default != null:
return $default(_that.revision,_that.updatedAt,_that.shakes,_that.eews,_that.earthquakes,_that.tsunamis);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( num revision,  DateTime updatedAt,  List<Shakes> shakes,  List<Eews> eews,  List<EarthquakePartial> earthquakes,  List<TsunamiListItem> tsunamis)  $default,) {final _that = this;
switch (_that) {
case _RealtimeState():
return $default(_that.revision,_that.updatedAt,_that.shakes,_that.eews,_that.earthquakes,_that.tsunamis);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( num revision,  DateTime updatedAt,  List<Shakes> shakes,  List<Eews> eews,  List<EarthquakePartial> earthquakes,  List<TsunamiListItem> tsunamis)?  $default,) {final _that = this;
switch (_that) {
case _RealtimeState() when $default != null:
return $default(_that.revision,_that.updatedAt,_that.shakes,_that.eews,_that.earthquakes,_that.tsunamis);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RealtimeState implements RealtimeState {
  const _RealtimeState({required this.revision, required this.updatedAt, required final  List<Shakes> shakes, required final  List<Eews> eews, required final  List<EarthquakePartial> earthquakes, required final  List<TsunamiListItem> tsunamis}): _shakes = shakes,_eews = eews,_earthquakes = earthquakes,_tsunamis = tsunamis;
  factory _RealtimeState.fromJson(Map<String, dynamic> json) => _$RealtimeStateFromJson(json);

@override final  num revision;
@override final  DateTime updatedAt;
 final  List<Shakes> _shakes;
@override List<Shakes> get shakes {
  if (_shakes is EqualUnmodifiableListView) return _shakes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_shakes);
}

 final  List<Eews> _eews;
@override List<Eews> get eews {
  if (_eews is EqualUnmodifiableListView) return _eews;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_eews);
}

 final  List<EarthquakePartial> _earthquakes;
@override List<EarthquakePartial> get earthquakes {
  if (_earthquakes is EqualUnmodifiableListView) return _earthquakes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_earthquakes);
}

 final  List<TsunamiListItem> _tsunamis;
@override List<TsunamiListItem> get tsunamis {
  if (_tsunamis is EqualUnmodifiableListView) return _tsunamis;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tsunamis);
}


/// Create a copy of RealtimeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RealtimeStateCopyWith<_RealtimeState> get copyWith => __$RealtimeStateCopyWithImpl<_RealtimeState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RealtimeStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RealtimeState&&(identical(other.revision, revision) || other.revision == revision)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._shakes, _shakes)&&const DeepCollectionEquality().equals(other._eews, _eews)&&const DeepCollectionEquality().equals(other._earthquakes, _earthquakes)&&const DeepCollectionEquality().equals(other._tsunamis, _tsunamis));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,revision,updatedAt,const DeepCollectionEquality().hash(_shakes),const DeepCollectionEquality().hash(_eews),const DeepCollectionEquality().hash(_earthquakes),const DeepCollectionEquality().hash(_tsunamis));

@override
String toString() {
  return 'RealtimeState(revision: $revision, updatedAt: $updatedAt, shakes: $shakes, eews: $eews, earthquakes: $earthquakes, tsunamis: $tsunamis)';
}


}

/// @nodoc
abstract mixin class _$RealtimeStateCopyWith<$Res> implements $RealtimeStateCopyWith<$Res> {
  factory _$RealtimeStateCopyWith(_RealtimeState value, $Res Function(_RealtimeState) _then) = __$RealtimeStateCopyWithImpl;
@override @useResult
$Res call({
 num revision, DateTime updatedAt, List<Shakes> shakes, List<Eews> eews, List<EarthquakePartial> earthquakes, List<TsunamiListItem> tsunamis
});




}
/// @nodoc
class __$RealtimeStateCopyWithImpl<$Res>
    implements _$RealtimeStateCopyWith<$Res> {
  __$RealtimeStateCopyWithImpl(this._self, this._then);

  final _RealtimeState _self;
  final $Res Function(_RealtimeState) _then;

/// Create a copy of RealtimeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? revision = null,Object? updatedAt = null,Object? shakes = null,Object? eews = null,Object? earthquakes = null,Object? tsunamis = null,}) {
  return _then(_RealtimeState(
revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as num,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,shakes: null == shakes ? _self._shakes : shakes // ignore: cast_nullable_to_non_nullable
as List<Shakes>,eews: null == eews ? _self._eews : eews // ignore: cast_nullable_to_non_nullable
as List<Eews>,earthquakes: null == earthquakes ? _self._earthquakes : earthquakes // ignore: cast_nullable_to_non_nullable
as List<EarthquakePartial>,tsunamis: null == tsunamis ? _self._tsunamis : tsunamis // ignore: cast_nullable_to_non_nullable
as List<TsunamiListItem>,
  ));
}


}

// dart format on
