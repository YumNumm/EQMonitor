// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tracked_offshore_station.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TrackedOffshoreStation {

 String get code; String get name; Tracked<TsunamiObservationFirstHeight> get firstHeight; Tracked<TsunamiObservationMaxHeight?> get maxHeight;
/// Create a copy of TrackedOffshoreStation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrackedOffshoreStationCopyWith<TrackedOffshoreStation> get copyWith => _$TrackedOffshoreStationCopyWithImpl<TrackedOffshoreStation>(this as TrackedOffshoreStation, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrackedOffshoreStation&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.firstHeight, firstHeight)&&const DeepCollectionEquality().equals(other.maxHeight, maxHeight));
}


@override
int get hashCode => Object.hash(runtimeType,code,name,const DeepCollectionEquality().hash(firstHeight),const DeepCollectionEquality().hash(maxHeight));

@override
String toString() {
  return 'TrackedOffshoreStation(code: $code, name: $name, firstHeight: $firstHeight, maxHeight: $maxHeight)';
}


}

/// @nodoc
abstract mixin class $TrackedOffshoreStationCopyWith<$Res>  {
  factory $TrackedOffshoreStationCopyWith(TrackedOffshoreStation value, $Res Function(TrackedOffshoreStation) _then) = _$TrackedOffshoreStationCopyWithImpl;
@useResult
$Res call({
 String code, String name, Tracked<TsunamiObservationFirstHeight> firstHeight, Tracked<TsunamiObservationMaxHeight?> maxHeight
});




}
/// @nodoc
class _$TrackedOffshoreStationCopyWithImpl<$Res>
    implements $TrackedOffshoreStationCopyWith<$Res> {
  _$TrackedOffshoreStationCopyWithImpl(this._self, this._then);

  final TrackedOffshoreStation _self;
  final $Res Function(TrackedOffshoreStation) _then;

/// Create a copy of TrackedOffshoreStation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? firstHeight = null,Object? maxHeight = null,}) {
  return _then(TrackedOffshoreStation(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,firstHeight: null == firstHeight ? _self.firstHeight : firstHeight // ignore: cast_nullable_to_non_nullable
as Tracked<TsunamiObservationFirstHeight>,maxHeight: null == maxHeight ? _self.maxHeight : maxHeight // ignore: cast_nullable_to_non_nullable
as Tracked<TsunamiObservationMaxHeight?>,
  ));
}

}


/// Adds pattern-matching-related methods to [TrackedOffshoreStation].
extension TrackedOffshoreStationPatterns on TrackedOffshoreStation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrackedOffshoreStation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrackedOffshoreStation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrackedOffshoreStation value)  $default,){
final _that = this;
switch (_that) {
case _TrackedOffshoreStation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrackedOffshoreStation value)?  $default,){
final _that = this;
switch (_that) {
case _TrackedOffshoreStation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String name,  Tracked<TsunamiObservationFirstHeight> firstHeight,  Tracked<TsunamiObservationMaxHeight?> maxHeight)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrackedOffshoreStation() when $default != null:
return $default(_that.code,_that.name,_that.firstHeight,_that.maxHeight);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String name,  Tracked<TsunamiObservationFirstHeight> firstHeight,  Tracked<TsunamiObservationMaxHeight?> maxHeight)  $default,) {final _that = this;
switch (_that) {
case _TrackedOffshoreStation():
return $default(_that.code,_that.name,_that.firstHeight,_that.maxHeight);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String name,  Tracked<TsunamiObservationFirstHeight> firstHeight,  Tracked<TsunamiObservationMaxHeight?> maxHeight)?  $default,) {final _that = this;
switch (_that) {
case _TrackedOffshoreStation() when $default != null:
return $default(_that.code,_that.name,_that.firstHeight,_that.maxHeight);case _:
  return null;

}
}

}

/// @nodoc


class _TrackedOffshoreStation implements TrackedOffshoreStation {
  const _TrackedOffshoreStation({required this.code, required this.name, required  Tracked<TsunamiObservationFirstHeight> firstHeight, required  Tracked<TsunamiObservationMaxHeight?> maxHeight}): _firstHeight = firstHeight,_maxHeight = maxHeight;
  

@override final  String code;
@override final  String name;
 final  Tracked<TsunamiObservationFirstHeight> _firstHeight;
@override Tracked<TsunamiObservationFirstHeight> get firstHeight {
  if (_firstHeight is EqualUnmodifiableListView) return _firstHeight;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_firstHeight);
}

 final  Tracked<TsunamiObservationMaxHeight?> _maxHeight;
@override Tracked<TsunamiObservationMaxHeight?> get maxHeight {
  if (_maxHeight is EqualUnmodifiableListView) return _maxHeight;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_maxHeight);
}


/// Create a copy of TrackedOffshoreStation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrackedOffshoreStationCopyWith<_TrackedOffshoreStation> get copyWith => __$TrackedOffshoreStationCopyWithImpl<_TrackedOffshoreStation>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrackedOffshoreStation&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._firstHeight, _firstHeight)&&const DeepCollectionEquality().equals(other._maxHeight, _maxHeight));
}


@override
int get hashCode => Object.hash(runtimeType,code,name,const DeepCollectionEquality().hash(_firstHeight),const DeepCollectionEquality().hash(_maxHeight));

@override
String toString() {
  return 'TrackedOffshoreStation(code: $code, name: $name, firstHeight: $firstHeight, maxHeight: $maxHeight)';
}


}

/// @nodoc
abstract mixin class _$TrackedOffshoreStationCopyWith<$Res> implements $TrackedOffshoreStationCopyWith<$Res> {
  factory _$TrackedOffshoreStationCopyWith(_TrackedOffshoreStation value, $Res Function(_TrackedOffshoreStation) _then) = __$TrackedOffshoreStationCopyWithImpl;
@override @useResult
$Res call({
 String code, String name, Tracked<TsunamiObservationFirstHeight> firstHeight, Tracked<TsunamiObservationMaxHeight?> maxHeight
});




}
/// @nodoc
class __$TrackedOffshoreStationCopyWithImpl<$Res>
    implements _$TrackedOffshoreStationCopyWith<$Res> {
  __$TrackedOffshoreStationCopyWithImpl(this._self, this._then);

  final _TrackedOffshoreStation _self;
  final $Res Function(_TrackedOffshoreStation) _then;

/// Create a copy of TrackedOffshoreStation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? firstHeight = null,Object? maxHeight = null,}) {
  return _then(_TrackedOffshoreStation(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,firstHeight: null == firstHeight ? _self._firstHeight : firstHeight // ignore: cast_nullable_to_non_nullable
as Tracked<TsunamiObservationFirstHeight>,maxHeight: null == maxHeight ? _self._maxHeight : maxHeight // ignore: cast_nullable_to_non_nullable
as Tracked<TsunamiObservationMaxHeight?>,
  ));
}


}

// dart format on
