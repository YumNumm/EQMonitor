// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_forecast.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TsunamiForecast {

 String get code; String get name; TsunamiWarningKind get kind;@JsonKey(name: 'last_kind') TsunamiWarningKind get lastKind;@JsonKey(includeIfNull: false, name: 'first_height') TsunamiForecastFirstHeight? get firstHeight;@JsonKey(includeIfNull: false, name: 'max_height') TsunamiForecastMaxHeight? get maxHeight;@JsonKey(includeIfNull: false) List<TsunamiForecastStation>? get stations;
/// Create a copy of TsunamiForecast
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiForecastCopyWith<TsunamiForecast> get copyWith => _$TsunamiForecastCopyWithImpl<TsunamiForecast>(this as TsunamiForecast, _$identity);

  /// Serializes this TsunamiForecast to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiForecast&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.lastKind, lastKind) || other.lastKind == lastKind)&&(identical(other.firstHeight, firstHeight) || other.firstHeight == firstHeight)&&(identical(other.maxHeight, maxHeight) || other.maxHeight == maxHeight)&&const DeepCollectionEquality().equals(other.stations, stations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,kind,lastKind,firstHeight,maxHeight,const DeepCollectionEquality().hash(stations));

@override
String toString() {
  return 'TsunamiForecast(code: $code, name: $name, kind: $kind, lastKind: $lastKind, firstHeight: $firstHeight, maxHeight: $maxHeight, stations: $stations)';
}


}

/// @nodoc
abstract mixin class $TsunamiForecastCopyWith<$Res>  {
  factory $TsunamiForecastCopyWith(TsunamiForecast value, $Res Function(TsunamiForecast) _then) = _$TsunamiForecastCopyWithImpl;
@useResult
$Res call({
 String code, String name, TsunamiWarningKind kind,@JsonKey(name: 'last_kind') TsunamiWarningKind lastKind,@JsonKey(includeIfNull: false, name: 'first_height') TsunamiForecastFirstHeight? firstHeight,@JsonKey(includeIfNull: false, name: 'max_height') TsunamiForecastMaxHeight? maxHeight,@JsonKey(includeIfNull: false) List<TsunamiForecastStation>? stations
});


$TsunamiForecastFirstHeightCopyWith<$Res>? get firstHeight;$TsunamiForecastMaxHeightCopyWith<$Res>? get maxHeight;

}
/// @nodoc
class _$TsunamiForecastCopyWithImpl<$Res>
    implements $TsunamiForecastCopyWith<$Res> {
  _$TsunamiForecastCopyWithImpl(this._self, this._then);

  final TsunamiForecast _self;
  final $Res Function(TsunamiForecast) _then;

/// Create a copy of TsunamiForecast
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? kind = null,Object? lastKind = null,Object? firstHeight = freezed,Object? maxHeight = freezed,Object? stations = freezed,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as TsunamiWarningKind,lastKind: null == lastKind ? _self.lastKind : lastKind // ignore: cast_nullable_to_non_nullable
as TsunamiWarningKind,firstHeight: freezed == firstHeight ? _self.firstHeight : firstHeight // ignore: cast_nullable_to_non_nullable
as TsunamiForecastFirstHeight?,maxHeight: freezed == maxHeight ? _self.maxHeight : maxHeight // ignore: cast_nullable_to_non_nullable
as TsunamiForecastMaxHeight?,stations: freezed == stations ? _self.stations : stations // ignore: cast_nullable_to_non_nullable
as List<TsunamiForecastStation>?,
  ));
}
/// Create a copy of TsunamiForecast
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiForecastFirstHeightCopyWith<$Res>? get firstHeight {
    if (_self.firstHeight == null) {
    return null;
  }

  return $TsunamiForecastFirstHeightCopyWith<$Res>(_self.firstHeight!, (value) {
    return _then(_self.copyWith(firstHeight: value));
  });
}/// Create a copy of TsunamiForecast
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiForecastMaxHeightCopyWith<$Res>? get maxHeight {
    if (_self.maxHeight == null) {
    return null;
  }

  return $TsunamiForecastMaxHeightCopyWith<$Res>(_self.maxHeight!, (value) {
    return _then(_self.copyWith(maxHeight: value));
  });
}
}


/// Adds pattern-matching-related methods to [TsunamiForecast].
extension TsunamiForecastPatterns on TsunamiForecast {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiForecast value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiForecast() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiForecast value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiForecast():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiForecast value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiForecast() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String name,  TsunamiWarningKind kind, @JsonKey(name: 'last_kind')  TsunamiWarningKind lastKind, @JsonKey(includeIfNull: false, name: 'first_height')  TsunamiForecastFirstHeight? firstHeight, @JsonKey(includeIfNull: false, name: 'max_height')  TsunamiForecastMaxHeight? maxHeight, @JsonKey(includeIfNull: false)  List<TsunamiForecastStation>? stations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiForecast() when $default != null:
return $default(_that.code,_that.name,_that.kind,_that.lastKind,_that.firstHeight,_that.maxHeight,_that.stations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String name,  TsunamiWarningKind kind, @JsonKey(name: 'last_kind')  TsunamiWarningKind lastKind, @JsonKey(includeIfNull: false, name: 'first_height')  TsunamiForecastFirstHeight? firstHeight, @JsonKey(includeIfNull: false, name: 'max_height')  TsunamiForecastMaxHeight? maxHeight, @JsonKey(includeIfNull: false)  List<TsunamiForecastStation>? stations)  $default,) {final _that = this;
switch (_that) {
case _TsunamiForecast():
return $default(_that.code,_that.name,_that.kind,_that.lastKind,_that.firstHeight,_that.maxHeight,_that.stations);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String name,  TsunamiWarningKind kind, @JsonKey(name: 'last_kind')  TsunamiWarningKind lastKind, @JsonKey(includeIfNull: false, name: 'first_height')  TsunamiForecastFirstHeight? firstHeight, @JsonKey(includeIfNull: false, name: 'max_height')  TsunamiForecastMaxHeight? maxHeight, @JsonKey(includeIfNull: false)  List<TsunamiForecastStation>? stations)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiForecast() when $default != null:
return $default(_that.code,_that.name,_that.kind,_that.lastKind,_that.firstHeight,_that.maxHeight,_that.stations);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TsunamiForecast implements TsunamiForecast {
  const _TsunamiForecast({required this.code, required this.name, required this.kind, @JsonKey(name: 'last_kind') required this.lastKind, @JsonKey(includeIfNull: false, name: 'first_height') this.firstHeight, @JsonKey(includeIfNull: false, name: 'max_height') this.maxHeight, @JsonKey(includeIfNull: false) final  List<TsunamiForecastStation>? stations}): _stations = stations;
  factory _TsunamiForecast.fromJson(Map<String, dynamic> json) => _$TsunamiForecastFromJson(json);

@override final  String code;
@override final  String name;
@override final  TsunamiWarningKind kind;
@override@JsonKey(name: 'last_kind') final  TsunamiWarningKind lastKind;
@override@JsonKey(includeIfNull: false, name: 'first_height') final  TsunamiForecastFirstHeight? firstHeight;
@override@JsonKey(includeIfNull: false, name: 'max_height') final  TsunamiForecastMaxHeight? maxHeight;
 final  List<TsunamiForecastStation>? _stations;
@override@JsonKey(includeIfNull: false) List<TsunamiForecastStation>? get stations {
  final value = _stations;
  if (value == null) return null;
  if (_stations is EqualUnmodifiableListView) return _stations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of TsunamiForecast
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiForecastCopyWith<_TsunamiForecast> get copyWith => __$TsunamiForecastCopyWithImpl<_TsunamiForecast>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiForecastToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiForecast&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.lastKind, lastKind) || other.lastKind == lastKind)&&(identical(other.firstHeight, firstHeight) || other.firstHeight == firstHeight)&&(identical(other.maxHeight, maxHeight) || other.maxHeight == maxHeight)&&const DeepCollectionEquality().equals(other._stations, _stations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,kind,lastKind,firstHeight,maxHeight,const DeepCollectionEquality().hash(_stations));

@override
String toString() {
  return 'TsunamiForecast(code: $code, name: $name, kind: $kind, lastKind: $lastKind, firstHeight: $firstHeight, maxHeight: $maxHeight, stations: $stations)';
}


}

/// @nodoc
abstract mixin class _$TsunamiForecastCopyWith<$Res> implements $TsunamiForecastCopyWith<$Res> {
  factory _$TsunamiForecastCopyWith(_TsunamiForecast value, $Res Function(_TsunamiForecast) _then) = __$TsunamiForecastCopyWithImpl;
@override @useResult
$Res call({
 String code, String name, TsunamiWarningKind kind,@JsonKey(name: 'last_kind') TsunamiWarningKind lastKind,@JsonKey(includeIfNull: false, name: 'first_height') TsunamiForecastFirstHeight? firstHeight,@JsonKey(includeIfNull: false, name: 'max_height') TsunamiForecastMaxHeight? maxHeight,@JsonKey(includeIfNull: false) List<TsunamiForecastStation>? stations
});


@override $TsunamiForecastFirstHeightCopyWith<$Res>? get firstHeight;@override $TsunamiForecastMaxHeightCopyWith<$Res>? get maxHeight;

}
/// @nodoc
class __$TsunamiForecastCopyWithImpl<$Res>
    implements _$TsunamiForecastCopyWith<$Res> {
  __$TsunamiForecastCopyWithImpl(this._self, this._then);

  final _TsunamiForecast _self;
  final $Res Function(_TsunamiForecast) _then;

/// Create a copy of TsunamiForecast
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? kind = null,Object? lastKind = null,Object? firstHeight = freezed,Object? maxHeight = freezed,Object? stations = freezed,}) {
  return _then(_TsunamiForecast(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as TsunamiWarningKind,lastKind: null == lastKind ? _self.lastKind : lastKind // ignore: cast_nullable_to_non_nullable
as TsunamiWarningKind,firstHeight: freezed == firstHeight ? _self.firstHeight : firstHeight // ignore: cast_nullable_to_non_nullable
as TsunamiForecastFirstHeight?,maxHeight: freezed == maxHeight ? _self.maxHeight : maxHeight // ignore: cast_nullable_to_non_nullable
as TsunamiForecastMaxHeight?,stations: freezed == stations ? _self._stations : stations // ignore: cast_nullable_to_non_nullable
as List<TsunamiForecastStation>?,
  ));
}

/// Create a copy of TsunamiForecast
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiForecastFirstHeightCopyWith<$Res>? get firstHeight {
    if (_self.firstHeight == null) {
    return null;
  }

  return $TsunamiForecastFirstHeightCopyWith<$Res>(_self.firstHeight!, (value) {
    return _then(_self.copyWith(firstHeight: value));
  });
}/// Create a copy of TsunamiForecast
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiForecastMaxHeightCopyWith<$Res>? get maxHeight {
    if (_self.maxHeight == null) {
    return null;
  }

  return $TsunamiForecastMaxHeightCopyWith<$Res>(_self.maxHeight!, (value) {
    return _then(_self.copyWith(maxHeight: value));
  });
}
}

// dart format on
