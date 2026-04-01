// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_estimation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TsunamiEstimation {

 String get code; String get name;@JsonKey(name: 'first_height') TsunamiEstimationFirstHeight get firstHeight;@JsonKey(name: 'max_height') TsunamiEstimationMaxHeight get maxHeight;
/// Create a copy of TsunamiEstimation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiEstimationCopyWith<TsunamiEstimation> get copyWith => _$TsunamiEstimationCopyWithImpl<TsunamiEstimation>(this as TsunamiEstimation, _$identity);

  /// Serializes this TsunamiEstimation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiEstimation&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.firstHeight, firstHeight) || other.firstHeight == firstHeight)&&(identical(other.maxHeight, maxHeight) || other.maxHeight == maxHeight));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,firstHeight,maxHeight);

@override
String toString() {
  return 'TsunamiEstimation(code: $code, name: $name, firstHeight: $firstHeight, maxHeight: $maxHeight)';
}


}

/// @nodoc
abstract mixin class $TsunamiEstimationCopyWith<$Res>  {
  factory $TsunamiEstimationCopyWith(TsunamiEstimation value, $Res Function(TsunamiEstimation) _then) = _$TsunamiEstimationCopyWithImpl;
@useResult
$Res call({
 String code, String name,@JsonKey(name: 'first_height') TsunamiEstimationFirstHeight firstHeight,@JsonKey(name: 'max_height') TsunamiEstimationMaxHeight maxHeight
});


$TsunamiEstimationFirstHeightCopyWith<$Res> get firstHeight;$TsunamiEstimationMaxHeightCopyWith<$Res> get maxHeight;

}
/// @nodoc
class _$TsunamiEstimationCopyWithImpl<$Res>
    implements $TsunamiEstimationCopyWith<$Res> {
  _$TsunamiEstimationCopyWithImpl(this._self, this._then);

  final TsunamiEstimation _self;
  final $Res Function(TsunamiEstimation) _then;

/// Create a copy of TsunamiEstimation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? firstHeight = null,Object? maxHeight = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,firstHeight: null == firstHeight ? _self.firstHeight : firstHeight // ignore: cast_nullable_to_non_nullable
as TsunamiEstimationFirstHeight,maxHeight: null == maxHeight ? _self.maxHeight : maxHeight // ignore: cast_nullable_to_non_nullable
as TsunamiEstimationMaxHeight,
  ));
}
/// Create a copy of TsunamiEstimation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiEstimationFirstHeightCopyWith<$Res> get firstHeight {
  
  return $TsunamiEstimationFirstHeightCopyWith<$Res>(_self.firstHeight, (value) {
    return _then(_self.copyWith(firstHeight: value));
  });
}/// Create a copy of TsunamiEstimation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiEstimationMaxHeightCopyWith<$Res> get maxHeight {
  
  return $TsunamiEstimationMaxHeightCopyWith<$Res>(_self.maxHeight, (value) {
    return _then(_self.copyWith(maxHeight: value));
  });
}
}


/// Adds pattern-matching-related methods to [TsunamiEstimation].
extension TsunamiEstimationPatterns on TsunamiEstimation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiEstimation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiEstimation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiEstimation value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiEstimation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiEstimation value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiEstimation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String name, @JsonKey(name: 'first_height')  TsunamiEstimationFirstHeight firstHeight, @JsonKey(name: 'max_height')  TsunamiEstimationMaxHeight maxHeight)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiEstimation() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String name, @JsonKey(name: 'first_height')  TsunamiEstimationFirstHeight firstHeight, @JsonKey(name: 'max_height')  TsunamiEstimationMaxHeight maxHeight)  $default,) {final _that = this;
switch (_that) {
case _TsunamiEstimation():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String name, @JsonKey(name: 'first_height')  TsunamiEstimationFirstHeight firstHeight, @JsonKey(name: 'max_height')  TsunamiEstimationMaxHeight maxHeight)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiEstimation() when $default != null:
return $default(_that.code,_that.name,_that.firstHeight,_that.maxHeight);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TsunamiEstimation implements TsunamiEstimation {
  const _TsunamiEstimation({required this.code, required this.name, @JsonKey(name: 'first_height') required this.firstHeight, @JsonKey(name: 'max_height') required this.maxHeight});
  factory _TsunamiEstimation.fromJson(Map<String, dynamic> json) => _$TsunamiEstimationFromJson(json);

@override final  String code;
@override final  String name;
@override@JsonKey(name: 'first_height') final  TsunamiEstimationFirstHeight firstHeight;
@override@JsonKey(name: 'max_height') final  TsunamiEstimationMaxHeight maxHeight;

/// Create a copy of TsunamiEstimation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiEstimationCopyWith<_TsunamiEstimation> get copyWith => __$TsunamiEstimationCopyWithImpl<_TsunamiEstimation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiEstimationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiEstimation&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.firstHeight, firstHeight) || other.firstHeight == firstHeight)&&(identical(other.maxHeight, maxHeight) || other.maxHeight == maxHeight));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,firstHeight,maxHeight);

@override
String toString() {
  return 'TsunamiEstimation(code: $code, name: $name, firstHeight: $firstHeight, maxHeight: $maxHeight)';
}


}

/// @nodoc
abstract mixin class _$TsunamiEstimationCopyWith<$Res> implements $TsunamiEstimationCopyWith<$Res> {
  factory _$TsunamiEstimationCopyWith(_TsunamiEstimation value, $Res Function(_TsunamiEstimation) _then) = __$TsunamiEstimationCopyWithImpl;
@override @useResult
$Res call({
 String code, String name,@JsonKey(name: 'first_height') TsunamiEstimationFirstHeight firstHeight,@JsonKey(name: 'max_height') TsunamiEstimationMaxHeight maxHeight
});


@override $TsunamiEstimationFirstHeightCopyWith<$Res> get firstHeight;@override $TsunamiEstimationMaxHeightCopyWith<$Res> get maxHeight;

}
/// @nodoc
class __$TsunamiEstimationCopyWithImpl<$Res>
    implements _$TsunamiEstimationCopyWith<$Res> {
  __$TsunamiEstimationCopyWithImpl(this._self, this._then);

  final _TsunamiEstimation _self;
  final $Res Function(_TsunamiEstimation) _then;

/// Create a copy of TsunamiEstimation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? firstHeight = null,Object? maxHeight = null,}) {
  return _then(_TsunamiEstimation(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,firstHeight: null == firstHeight ? _self.firstHeight : firstHeight // ignore: cast_nullable_to_non_nullable
as TsunamiEstimationFirstHeight,maxHeight: null == maxHeight ? _self.maxHeight : maxHeight // ignore: cast_nullable_to_non_nullable
as TsunamiEstimationMaxHeight,
  ));
}

/// Create a copy of TsunamiEstimation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiEstimationFirstHeightCopyWith<$Res> get firstHeight {
  
  return $TsunamiEstimationFirstHeightCopyWith<$Res>(_self.firstHeight, (value) {
    return _then(_self.copyWith(firstHeight: value));
  });
}/// Create a copy of TsunamiEstimation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiEstimationMaxHeightCopyWith<$Res> get maxHeight {
  
  return $TsunamiEstimationMaxHeightCopyWith<$Res>(_self.maxHeight, (value) {
    return _then(_self.copyWith(maxHeight: value));
  });
}
}

// dart format on
