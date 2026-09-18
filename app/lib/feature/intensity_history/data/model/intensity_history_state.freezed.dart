// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'intensity_history_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$IntensityHistoryState {

/// 選択中の市区町村。未選択なら `null`。
 IntensityHistorySelectedCity? get selectedCity;
/// Create a copy of IntensityHistoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntensityHistoryStateCopyWith<IntensityHistoryState> get copyWith => _$IntensityHistoryStateCopyWithImpl<IntensityHistoryState>(this as IntensityHistoryState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntensityHistoryState&&(identical(other.selectedCity, selectedCity) || other.selectedCity == selectedCity));
}


@override
int get hashCode => Object.hash(runtimeType,selectedCity);

@override
String toString() {
  return 'IntensityHistoryState(selectedCity: $selectedCity)';
}


}

/// @nodoc
abstract mixin class $IntensityHistoryStateCopyWith<$Res>  {
  factory $IntensityHistoryStateCopyWith(IntensityHistoryState value, $Res Function(IntensityHistoryState) _then) = _$IntensityHistoryStateCopyWithImpl;
@useResult
$Res call({
 IntensityHistorySelectedCity? selectedCity
});


$IntensityHistorySelectedCityCopyWith<$Res>? get selectedCity;

}
/// @nodoc
class _$IntensityHistoryStateCopyWithImpl<$Res>
    implements $IntensityHistoryStateCopyWith<$Res> {
  _$IntensityHistoryStateCopyWithImpl(this._self, this._then);

  final IntensityHistoryState _self;
  final $Res Function(IntensityHistoryState) _then;

/// Create a copy of IntensityHistoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? selectedCity = freezed,}) {
  return _then(IntensityHistoryState(
selectedCity: freezed == selectedCity ? _self.selectedCity : selectedCity // ignore: cast_nullable_to_non_nullable
as IntensityHistorySelectedCity?,
  ));
}
/// Create a copy of IntensityHistoryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IntensityHistorySelectedCityCopyWith<$Res>? get selectedCity {
    if (_self.selectedCity == null) {
    return null;
  }

  return $IntensityHistorySelectedCityCopyWith<$Res>(_self.selectedCity!, (value) {
    return _then(_self.copyWith(selectedCity: value));
  });
}
}


/// Adds pattern-matching-related methods to [IntensityHistoryState].
extension IntensityHistoryStatePatterns on IntensityHistoryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IntensityHistoryState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IntensityHistoryState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IntensityHistoryState value)  $default,){
final _that = this;
switch (_that) {
case _IntensityHistoryState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IntensityHistoryState value)?  $default,){
final _that = this;
switch (_that) {
case _IntensityHistoryState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( IntensityHistorySelectedCity? selectedCity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IntensityHistoryState() when $default != null:
return $default(_that.selectedCity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( IntensityHistorySelectedCity? selectedCity)  $default,) {final _that = this;
switch (_that) {
case _IntensityHistoryState():
return $default(_that.selectedCity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( IntensityHistorySelectedCity? selectedCity)?  $default,) {final _that = this;
switch (_that) {
case _IntensityHistoryState() when $default != null:
return $default(_that.selectedCity);case _:
  return null;

}
}

}

/// @nodoc


class _IntensityHistoryState implements IntensityHistoryState {
  const _IntensityHistoryState({this.selectedCity});
  

/// 選択中の市区町村。未選択なら `null`。
@override final  IntensityHistorySelectedCity? selectedCity;

/// Create a copy of IntensityHistoryState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntensityHistoryStateCopyWith<_IntensityHistoryState> get copyWith => __$IntensityHistoryStateCopyWithImpl<_IntensityHistoryState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntensityHistoryState&&(identical(other.selectedCity, selectedCity) || other.selectedCity == selectedCity));
}


@override
int get hashCode => Object.hash(runtimeType,selectedCity);

@override
String toString() {
  return 'IntensityHistoryState(selectedCity: $selectedCity)';
}


}

/// @nodoc
abstract mixin class _$IntensityHistoryStateCopyWith<$Res> implements $IntensityHistoryStateCopyWith<$Res> {
  factory _$IntensityHistoryStateCopyWith(_IntensityHistoryState value, $Res Function(_IntensityHistoryState) _then) = __$IntensityHistoryStateCopyWithImpl;
@override @useResult
$Res call({
 IntensityHistorySelectedCity? selectedCity
});


@override $IntensityHistorySelectedCityCopyWith<$Res>? get selectedCity;

}
/// @nodoc
class __$IntensityHistoryStateCopyWithImpl<$Res>
    implements _$IntensityHistoryStateCopyWith<$Res> {
  __$IntensityHistoryStateCopyWithImpl(this._self, this._then);

  final _IntensityHistoryState _self;
  final $Res Function(_IntensityHistoryState) _then;

/// Create a copy of IntensityHistoryState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? selectedCity = freezed,}) {
  return _then(_IntensityHistoryState(
selectedCity: freezed == selectedCity ? _self.selectedCity : selectedCity // ignore: cast_nullable_to_non_nullable
as IntensityHistorySelectedCity?,
  ));
}

/// Create a copy of IntensityHistoryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IntensityHistorySelectedCityCopyWith<$Res>? get selectedCity {
    if (_self.selectedCity == null) {
    return null;
  }

  return $IntensityHistorySelectedCityCopyWith<$Res>(_self.selectedCity!, (value) {
    return _then(_self.copyWith(selectedCity: value));
  });
}
}

/// @nodoc
mixin _$IntensityHistorySelectedCity {

/// 気象庁防災情報XMLフォーマットの市区町村コード(7桁)。
 String get code; String get name;/// 所属都道府県名。パネル・モーダルの親ラベルに使う。
 String get prefectureName;
/// Create a copy of IntensityHistorySelectedCity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntensityHistorySelectedCityCopyWith<IntensityHistorySelectedCity> get copyWith => _$IntensityHistorySelectedCityCopyWithImpl<IntensityHistorySelectedCity>(this as IntensityHistorySelectedCity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntensityHistorySelectedCity&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.prefectureName, prefectureName) || other.prefectureName == prefectureName));
}


@override
int get hashCode => Object.hash(runtimeType,code,name,prefectureName);

@override
String toString() {
  return 'IntensityHistorySelectedCity(code: $code, name: $name, prefectureName: $prefectureName)';
}


}

/// @nodoc
abstract mixin class $IntensityHistorySelectedCityCopyWith<$Res>  {
  factory $IntensityHistorySelectedCityCopyWith(IntensityHistorySelectedCity value, $Res Function(IntensityHistorySelectedCity) _then) = _$IntensityHistorySelectedCityCopyWithImpl;
@useResult
$Res call({
 String code, String name, String prefectureName
});




}
/// @nodoc
class _$IntensityHistorySelectedCityCopyWithImpl<$Res>
    implements $IntensityHistorySelectedCityCopyWith<$Res> {
  _$IntensityHistorySelectedCityCopyWithImpl(this._self, this._then);

  final IntensityHistorySelectedCity _self;
  final $Res Function(IntensityHistorySelectedCity) _then;

/// Create a copy of IntensityHistorySelectedCity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? prefectureName = null,}) {
  return _then(IntensityHistorySelectedCity(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,prefectureName: null == prefectureName ? _self.prefectureName : prefectureName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [IntensityHistorySelectedCity].
extension IntensityHistorySelectedCityPatterns on IntensityHistorySelectedCity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IntensityHistorySelectedCity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IntensityHistorySelectedCity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IntensityHistorySelectedCity value)  $default,){
final _that = this;
switch (_that) {
case _IntensityHistorySelectedCity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IntensityHistorySelectedCity value)?  $default,){
final _that = this;
switch (_that) {
case _IntensityHistorySelectedCity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String name,  String prefectureName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IntensityHistorySelectedCity() when $default != null:
return $default(_that.code,_that.name,_that.prefectureName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String name,  String prefectureName)  $default,) {final _that = this;
switch (_that) {
case _IntensityHistorySelectedCity():
return $default(_that.code,_that.name,_that.prefectureName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String name,  String prefectureName)?  $default,) {final _that = this;
switch (_that) {
case _IntensityHistorySelectedCity() when $default != null:
return $default(_that.code,_that.name,_that.prefectureName);case _:
  return null;

}
}

}

/// @nodoc


class _IntensityHistorySelectedCity implements IntensityHistorySelectedCity {
  const _IntensityHistorySelectedCity({required this.code, required this.name, required this.prefectureName});
  

/// 気象庁防災情報XMLフォーマットの市区町村コード(7桁)。
@override final  String code;
@override final  String name;
/// 所属都道府県名。パネル・モーダルの親ラベルに使う。
@override final  String prefectureName;

/// Create a copy of IntensityHistorySelectedCity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntensityHistorySelectedCityCopyWith<_IntensityHistorySelectedCity> get copyWith => __$IntensityHistorySelectedCityCopyWithImpl<_IntensityHistorySelectedCity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntensityHistorySelectedCity&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.prefectureName, prefectureName) || other.prefectureName == prefectureName));
}


@override
int get hashCode => Object.hash(runtimeType,code,name,prefectureName);

@override
String toString() {
  return 'IntensityHistorySelectedCity(code: $code, name: $name, prefectureName: $prefectureName)';
}


}

/// @nodoc
abstract mixin class _$IntensityHistorySelectedCityCopyWith<$Res> implements $IntensityHistorySelectedCityCopyWith<$Res> {
  factory _$IntensityHistorySelectedCityCopyWith(_IntensityHistorySelectedCity value, $Res Function(_IntensityHistorySelectedCity) _then) = __$IntensityHistorySelectedCityCopyWithImpl;
@override @useResult
$Res call({
 String code, String name, String prefectureName
});




}
/// @nodoc
class __$IntensityHistorySelectedCityCopyWithImpl<$Res>
    implements _$IntensityHistorySelectedCityCopyWith<$Res> {
  __$IntensityHistorySelectedCityCopyWithImpl(this._self, this._then);

  final _IntensityHistorySelectedCity _self;
  final $Res Function(_IntensityHistorySelectedCity) _then;

/// Create a copy of IntensityHistorySelectedCity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? prefectureName = null,}) {
  return _then(_IntensityHistorySelectedCity(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,prefectureName: null == prefectureName ? _self.prefectureName : prefectureName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
