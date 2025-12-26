// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eew_intensity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EewIntensityValue {

 IntensityValue get value; bool get isOver;
/// Create a copy of EewIntensityValue
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewIntensityValueCopyWith<EewIntensityValue> get copyWith => _$EewIntensityValueCopyWithImpl<EewIntensityValue>(this as EewIntensityValue, _$identity);

  /// Serializes this EewIntensityValue to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewIntensityValue&&(identical(other.value, value) || other.value == value)&&(identical(other.isOver, isOver) || other.isOver == isOver));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,isOver);

@override
String toString() {
  return 'EewIntensityValue(value: $value, isOver: $isOver)';
}


}

/// @nodoc
abstract mixin class $EewIntensityValueCopyWith<$Res>  {
  factory $EewIntensityValueCopyWith(EewIntensityValue value, $Res Function(EewIntensityValue) _then) = _$EewIntensityValueCopyWithImpl;
@useResult
$Res call({
 IntensityValue value, bool isOver
});




}
/// @nodoc
class _$EewIntensityValueCopyWithImpl<$Res>
    implements $EewIntensityValueCopyWith<$Res> {
  _$EewIntensityValueCopyWithImpl(this._self, this._then);

  final EewIntensityValue _self;
  final $Res Function(EewIntensityValue) _then;

/// Create a copy of EewIntensityValue
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,Object? isOver = null,}) {
  return _then(_self.copyWith(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as IntensityValue,isOver: null == isOver ? _self.isOver : isOver // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [EewIntensityValue].
extension EewIntensityValuePatterns on EewIntensityValue {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EewIntensityValue value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EewIntensityValue() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EewIntensityValue value)  $default,){
final _that = this;
switch (_that) {
case _EewIntensityValue():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EewIntensityValue value)?  $default,){
final _that = this;
switch (_that) {
case _EewIntensityValue() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( IntensityValue value,  bool isOver)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EewIntensityValue() when $default != null:
return $default(_that.value,_that.isOver);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( IntensityValue value,  bool isOver)  $default,) {final _that = this;
switch (_that) {
case _EewIntensityValue():
return $default(_that.value,_that.isOver);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( IntensityValue value,  bool isOver)?  $default,) {final _that = this;
switch (_that) {
case _EewIntensityValue() when $default != null:
return $default(_that.value,_that.isOver);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EewIntensityValue implements EewIntensityValue {
  const _EewIntensityValue({required this.value, required this.isOver});
  factory _EewIntensityValue.fromJson(Map<String, dynamic> json) => _$EewIntensityValueFromJson(json);

@override final  IntensityValue value;
@override final  bool isOver;

/// Create a copy of EewIntensityValue
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EewIntensityValueCopyWith<_EewIntensityValue> get copyWith => __$EewIntensityValueCopyWithImpl<_EewIntensityValue>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EewIntensityValueToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EewIntensityValue&&(identical(other.value, value) || other.value == value)&&(identical(other.isOver, isOver) || other.isOver == isOver));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,isOver);

@override
String toString() {
  return 'EewIntensityValue(value: $value, isOver: $isOver)';
}


}

/// @nodoc
abstract mixin class _$EewIntensityValueCopyWith<$Res> implements $EewIntensityValueCopyWith<$Res> {
  factory _$EewIntensityValueCopyWith(_EewIntensityValue value, $Res Function(_EewIntensityValue) _then) = __$EewIntensityValueCopyWithImpl;
@override @useResult
$Res call({
 IntensityValue value, bool isOver
});




}
/// @nodoc
class __$EewIntensityValueCopyWithImpl<$Res>
    implements _$EewIntensityValueCopyWith<$Res> {
  __$EewIntensityValueCopyWithImpl(this._self, this._then);

  final _EewIntensityValue _self;
  final $Res Function(_EewIntensityValue) _then;

/// Create a copy of EewIntensityValue
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,Object? isOver = null,}) {
  return _then(_EewIntensityValue(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as IntensityValue,isOver: null == isOver ? _self.isOver : isOver // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$EewIntensityLpgmValue {

 LpgmIntensityValue get value; bool get isOver;
/// Create a copy of EewIntensityLpgmValue
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewIntensityLpgmValueCopyWith<EewIntensityLpgmValue> get copyWith => _$EewIntensityLpgmValueCopyWithImpl<EewIntensityLpgmValue>(this as EewIntensityLpgmValue, _$identity);

  /// Serializes this EewIntensityLpgmValue to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewIntensityLpgmValue&&(identical(other.value, value) || other.value == value)&&(identical(other.isOver, isOver) || other.isOver == isOver));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,isOver);

@override
String toString() {
  return 'EewIntensityLpgmValue(value: $value, isOver: $isOver)';
}


}

/// @nodoc
abstract mixin class $EewIntensityLpgmValueCopyWith<$Res>  {
  factory $EewIntensityLpgmValueCopyWith(EewIntensityLpgmValue value, $Res Function(EewIntensityLpgmValue) _then) = _$EewIntensityLpgmValueCopyWithImpl;
@useResult
$Res call({
 LpgmIntensityValue value, bool isOver
});




}
/// @nodoc
class _$EewIntensityLpgmValueCopyWithImpl<$Res>
    implements $EewIntensityLpgmValueCopyWith<$Res> {
  _$EewIntensityLpgmValueCopyWithImpl(this._self, this._then);

  final EewIntensityLpgmValue _self;
  final $Res Function(EewIntensityLpgmValue) _then;

/// Create a copy of EewIntensityLpgmValue
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,Object? isOver = null,}) {
  return _then(_self.copyWith(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as LpgmIntensityValue,isOver: null == isOver ? _self.isOver : isOver // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [EewIntensityLpgmValue].
extension EewIntensityLpgmValuePatterns on EewIntensityLpgmValue {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EewIntensityLpgmValue value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EewIntensityLpgmValue() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EewIntensityLpgmValue value)  $default,){
final _that = this;
switch (_that) {
case _EewIntensityLpgmValue():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EewIntensityLpgmValue value)?  $default,){
final _that = this;
switch (_that) {
case _EewIntensityLpgmValue() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LpgmIntensityValue value,  bool isOver)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EewIntensityLpgmValue() when $default != null:
return $default(_that.value,_that.isOver);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LpgmIntensityValue value,  bool isOver)  $default,) {final _that = this;
switch (_that) {
case _EewIntensityLpgmValue():
return $default(_that.value,_that.isOver);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LpgmIntensityValue value,  bool isOver)?  $default,) {final _that = this;
switch (_that) {
case _EewIntensityLpgmValue() when $default != null:
return $default(_that.value,_that.isOver);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EewIntensityLpgmValue implements EewIntensityLpgmValue {
  const _EewIntensityLpgmValue({required this.value, required this.isOver});
  factory _EewIntensityLpgmValue.fromJson(Map<String, dynamic> json) => _$EewIntensityLpgmValueFromJson(json);

@override final  LpgmIntensityValue value;
@override final  bool isOver;

/// Create a copy of EewIntensityLpgmValue
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EewIntensityLpgmValueCopyWith<_EewIntensityLpgmValue> get copyWith => __$EewIntensityLpgmValueCopyWithImpl<_EewIntensityLpgmValue>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EewIntensityLpgmValueToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EewIntensityLpgmValue&&(identical(other.value, value) || other.value == value)&&(identical(other.isOver, isOver) || other.isOver == isOver));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,isOver);

@override
String toString() {
  return 'EewIntensityLpgmValue(value: $value, isOver: $isOver)';
}


}

/// @nodoc
abstract mixin class _$EewIntensityLpgmValueCopyWith<$Res> implements $EewIntensityLpgmValueCopyWith<$Res> {
  factory _$EewIntensityLpgmValueCopyWith(_EewIntensityLpgmValue value, $Res Function(_EewIntensityLpgmValue) _then) = __$EewIntensityLpgmValueCopyWithImpl;
@override @useResult
$Res call({
 LpgmIntensityValue value, bool isOver
});




}
/// @nodoc
class __$EewIntensityLpgmValueCopyWithImpl<$Res>
    implements _$EewIntensityLpgmValueCopyWith<$Res> {
  __$EewIntensityLpgmValueCopyWithImpl(this._self, this._then);

  final _EewIntensityLpgmValue _self;
  final $Res Function(_EewIntensityLpgmValue) _then;

/// Create a copy of EewIntensityLpgmValue
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,Object? isOver = null,}) {
  return _then(_EewIntensityLpgmValue(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as LpgmIntensityValue,isOver: null == isOver ? _self.isOver : isOver // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

EewArrivalTime _$EewArrivalTimeFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'TIME':
          return EewArrivalTimeTime.fromJson(
            json
          );
                case 'ARRIVED':
          return EewArrivalTimeArrived.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'EewArrivalTime',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$EewArrivalTime {



  /// Serializes this EewArrivalTime to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewArrivalTime);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EewArrivalTime()';
}


}

/// @nodoc
class $EewArrivalTimeCopyWith<$Res>  {
$EewArrivalTimeCopyWith(EewArrivalTime _, $Res Function(EewArrivalTime) __);
}


/// Adds pattern-matching-related methods to [EewArrivalTime].
extension EewArrivalTimePatterns on EewArrivalTime {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( EewArrivalTimeTime value)?  time,TResult Function( EewArrivalTimeArrived value)?  arrived,required TResult orElse(),}){
final _that = this;
switch (_that) {
case EewArrivalTimeTime() when time != null:
return time(_that);case EewArrivalTimeArrived() when arrived != null:
return arrived(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( EewArrivalTimeTime value)  time,required TResult Function( EewArrivalTimeArrived value)  arrived,}){
final _that = this;
switch (_that) {
case EewArrivalTimeTime():
return time(_that);case EewArrivalTimeArrived():
return arrived(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( EewArrivalTimeTime value)?  time,TResult? Function( EewArrivalTimeArrived value)?  arrived,}){
final _that = this;
switch (_that) {
case EewArrivalTimeTime() when time != null:
return time(_that);case EewArrivalTimeArrived() when arrived != null:
return arrived(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( DateTime value)?  time,TResult Function()?  arrived,required TResult orElse(),}) {final _that = this;
switch (_that) {
case EewArrivalTimeTime() when time != null:
return time(_that.value);case EewArrivalTimeArrived() when arrived != null:
return arrived();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( DateTime value)  time,required TResult Function()  arrived,}) {final _that = this;
switch (_that) {
case EewArrivalTimeTime():
return time(_that.value);case EewArrivalTimeArrived():
return arrived();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( DateTime value)?  time,TResult? Function()?  arrived,}) {final _that = this;
switch (_that) {
case EewArrivalTimeTime() when time != null:
return time(_that.value);case EewArrivalTimeArrived() when arrived != null:
return arrived();case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class EewArrivalTimeTime implements EewArrivalTime {
  const EewArrivalTimeTime({required this.value, final  String? $type}): $type = $type ?? 'TIME';
  factory EewArrivalTimeTime.fromJson(Map<String, dynamic> json) => _$EewArrivalTimeTimeFromJson(json);

 final  DateTime value;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of EewArrivalTime
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewArrivalTimeTimeCopyWith<EewArrivalTimeTime> get copyWith => _$EewArrivalTimeTimeCopyWithImpl<EewArrivalTimeTime>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EewArrivalTimeTimeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewArrivalTimeTime&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'EewArrivalTime.time(value: $value)';
}


}

/// @nodoc
abstract mixin class $EewArrivalTimeTimeCopyWith<$Res> implements $EewArrivalTimeCopyWith<$Res> {
  factory $EewArrivalTimeTimeCopyWith(EewArrivalTimeTime value, $Res Function(EewArrivalTimeTime) _then) = _$EewArrivalTimeTimeCopyWithImpl;
@useResult
$Res call({
 DateTime value
});




}
/// @nodoc
class _$EewArrivalTimeTimeCopyWithImpl<$Res>
    implements $EewArrivalTimeTimeCopyWith<$Res> {
  _$EewArrivalTimeTimeCopyWithImpl(this._self, this._then);

  final EewArrivalTimeTime _self;
  final $Res Function(EewArrivalTimeTime) _then;

/// Create a copy of EewArrivalTime
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(EewArrivalTimeTime(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc
@JsonSerializable()

class EewArrivalTimeArrived implements EewArrivalTime {
  const EewArrivalTimeArrived({final  String? $type}): $type = $type ?? 'ARRIVED';
  factory EewArrivalTimeArrived.fromJson(Map<String, dynamic> json) => _$EewArrivalTimeArrivedFromJson(json);



@JsonKey(name: 'type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$EewArrivalTimeArrivedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewArrivalTimeArrived);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EewArrivalTime.arrived()';
}


}





/// @nodoc
mixin _$EewIntensityItem {

 CodeName get value; bool get isPlum; bool get isWarning; EewIntensityValue get intensity; EewIntensityLpgmValue? get lpgmIntensity; EewArrivalTime get arrivalTime;
/// Create a copy of EewIntensityItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewIntensityItemCopyWith<EewIntensityItem> get copyWith => _$EewIntensityItemCopyWithImpl<EewIntensityItem>(this as EewIntensityItem, _$identity);

  /// Serializes this EewIntensityItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewIntensityItem&&(identical(other.value, value) || other.value == value)&&(identical(other.isPlum, isPlum) || other.isPlum == isPlum)&&(identical(other.isWarning, isWarning) || other.isWarning == isWarning)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.lpgmIntensity, lpgmIntensity) || other.lpgmIntensity == lpgmIntensity)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,isPlum,isWarning,intensity,lpgmIntensity,arrivalTime);

@override
String toString() {
  return 'EewIntensityItem(value: $value, isPlum: $isPlum, isWarning: $isWarning, intensity: $intensity, lpgmIntensity: $lpgmIntensity, arrivalTime: $arrivalTime)';
}


}

/// @nodoc
abstract mixin class $EewIntensityItemCopyWith<$Res>  {
  factory $EewIntensityItemCopyWith(EewIntensityItem value, $Res Function(EewIntensityItem) _then) = _$EewIntensityItemCopyWithImpl;
@useResult
$Res call({
 CodeName value, bool isPlum, bool isWarning, EewIntensityValue intensity, EewIntensityLpgmValue? lpgmIntensity, EewArrivalTime arrivalTime
});


$CodeNameCopyWith<$Res> get value;$EewIntensityValueCopyWith<$Res> get intensity;$EewIntensityLpgmValueCopyWith<$Res>? get lpgmIntensity;$EewArrivalTimeCopyWith<$Res> get arrivalTime;

}
/// @nodoc
class _$EewIntensityItemCopyWithImpl<$Res>
    implements $EewIntensityItemCopyWith<$Res> {
  _$EewIntensityItemCopyWithImpl(this._self, this._then);

  final EewIntensityItem _self;
  final $Res Function(EewIntensityItem) _then;

/// Create a copy of EewIntensityItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,Object? isPlum = null,Object? isWarning = null,Object? intensity = null,Object? lpgmIntensity = freezed,Object? arrivalTime = null,}) {
  return _then(_self.copyWith(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as CodeName,isPlum: null == isPlum ? _self.isPlum : isPlum // ignore: cast_nullable_to_non_nullable
as bool,isWarning: null == isWarning ? _self.isWarning : isWarning // ignore: cast_nullable_to_non_nullable
as bool,intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as EewIntensityValue,lpgmIntensity: freezed == lpgmIntensity ? _self.lpgmIntensity : lpgmIntensity // ignore: cast_nullable_to_non_nullable
as EewIntensityLpgmValue?,arrivalTime: null == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as EewArrivalTime,
  ));
}
/// Create a copy of EewIntensityItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CodeNameCopyWith<$Res> get value {
  
  return $CodeNameCopyWith<$Res>(_self.value, (value) {
    return _then(_self.copyWith(value: value));
  });
}/// Create a copy of EewIntensityItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EewIntensityValueCopyWith<$Res> get intensity {
  
  return $EewIntensityValueCopyWith<$Res>(_self.intensity, (value) {
    return _then(_self.copyWith(intensity: value));
  });
}/// Create a copy of EewIntensityItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EewIntensityLpgmValueCopyWith<$Res>? get lpgmIntensity {
    if (_self.lpgmIntensity == null) {
    return null;
  }

  return $EewIntensityLpgmValueCopyWith<$Res>(_self.lpgmIntensity!, (value) {
    return _then(_self.copyWith(lpgmIntensity: value));
  });
}/// Create a copy of EewIntensityItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EewArrivalTimeCopyWith<$Res> get arrivalTime {
  
  return $EewArrivalTimeCopyWith<$Res>(_self.arrivalTime, (value) {
    return _then(_self.copyWith(arrivalTime: value));
  });
}
}


/// Adds pattern-matching-related methods to [EewIntensityItem].
extension EewIntensityItemPatterns on EewIntensityItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EewIntensityItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EewIntensityItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EewIntensityItem value)  $default,){
final _that = this;
switch (_that) {
case _EewIntensityItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EewIntensityItem value)?  $default,){
final _that = this;
switch (_that) {
case _EewIntensityItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CodeName value,  bool isPlum,  bool isWarning,  EewIntensityValue intensity,  EewIntensityLpgmValue? lpgmIntensity,  EewArrivalTime arrivalTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EewIntensityItem() when $default != null:
return $default(_that.value,_that.isPlum,_that.isWarning,_that.intensity,_that.lpgmIntensity,_that.arrivalTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CodeName value,  bool isPlum,  bool isWarning,  EewIntensityValue intensity,  EewIntensityLpgmValue? lpgmIntensity,  EewArrivalTime arrivalTime)  $default,) {final _that = this;
switch (_that) {
case _EewIntensityItem():
return $default(_that.value,_that.isPlum,_that.isWarning,_that.intensity,_that.lpgmIntensity,_that.arrivalTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CodeName value,  bool isPlum,  bool isWarning,  EewIntensityValue intensity,  EewIntensityLpgmValue? lpgmIntensity,  EewArrivalTime arrivalTime)?  $default,) {final _that = this;
switch (_that) {
case _EewIntensityItem() when $default != null:
return $default(_that.value,_that.isPlum,_that.isWarning,_that.intensity,_that.lpgmIntensity,_that.arrivalTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EewIntensityItem implements EewIntensityItem {
  const _EewIntensityItem({required this.value, required this.isPlum, required this.isWarning, required this.intensity, this.lpgmIntensity, required this.arrivalTime});
  factory _EewIntensityItem.fromJson(Map<String, dynamic> json) => _$EewIntensityItemFromJson(json);

@override final  CodeName value;
@override final  bool isPlum;
@override final  bool isWarning;
@override final  EewIntensityValue intensity;
@override final  EewIntensityLpgmValue? lpgmIntensity;
@override final  EewArrivalTime arrivalTime;

/// Create a copy of EewIntensityItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EewIntensityItemCopyWith<_EewIntensityItem> get copyWith => __$EewIntensityItemCopyWithImpl<_EewIntensityItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EewIntensityItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EewIntensityItem&&(identical(other.value, value) || other.value == value)&&(identical(other.isPlum, isPlum) || other.isPlum == isPlum)&&(identical(other.isWarning, isWarning) || other.isWarning == isWarning)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.lpgmIntensity, lpgmIntensity) || other.lpgmIntensity == lpgmIntensity)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,isPlum,isWarning,intensity,lpgmIntensity,arrivalTime);

@override
String toString() {
  return 'EewIntensityItem(value: $value, isPlum: $isPlum, isWarning: $isWarning, intensity: $intensity, lpgmIntensity: $lpgmIntensity, arrivalTime: $arrivalTime)';
}


}

/// @nodoc
abstract mixin class _$EewIntensityItemCopyWith<$Res> implements $EewIntensityItemCopyWith<$Res> {
  factory _$EewIntensityItemCopyWith(_EewIntensityItem value, $Res Function(_EewIntensityItem) _then) = __$EewIntensityItemCopyWithImpl;
@override @useResult
$Res call({
 CodeName value, bool isPlum, bool isWarning, EewIntensityValue intensity, EewIntensityLpgmValue? lpgmIntensity, EewArrivalTime arrivalTime
});


@override $CodeNameCopyWith<$Res> get value;@override $EewIntensityValueCopyWith<$Res> get intensity;@override $EewIntensityLpgmValueCopyWith<$Res>? get lpgmIntensity;@override $EewArrivalTimeCopyWith<$Res> get arrivalTime;

}
/// @nodoc
class __$EewIntensityItemCopyWithImpl<$Res>
    implements _$EewIntensityItemCopyWith<$Res> {
  __$EewIntensityItemCopyWithImpl(this._self, this._then);

  final _EewIntensityItem _self;
  final $Res Function(_EewIntensityItem) _then;

/// Create a copy of EewIntensityItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,Object? isPlum = null,Object? isWarning = null,Object? intensity = null,Object? lpgmIntensity = freezed,Object? arrivalTime = null,}) {
  return _then(_EewIntensityItem(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as CodeName,isPlum: null == isPlum ? _self.isPlum : isPlum // ignore: cast_nullable_to_non_nullable
as bool,isWarning: null == isWarning ? _self.isWarning : isWarning // ignore: cast_nullable_to_non_nullable
as bool,intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as EewIntensityValue,lpgmIntensity: freezed == lpgmIntensity ? _self.lpgmIntensity : lpgmIntensity // ignore: cast_nullable_to_non_nullable
as EewIntensityLpgmValue?,arrivalTime: null == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as EewArrivalTime,
  ));
}

/// Create a copy of EewIntensityItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CodeNameCopyWith<$Res> get value {
  
  return $CodeNameCopyWith<$Res>(_self.value, (value) {
    return _then(_self.copyWith(value: value));
  });
}/// Create a copy of EewIntensityItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EewIntensityValueCopyWith<$Res> get intensity {
  
  return $EewIntensityValueCopyWith<$Res>(_self.intensity, (value) {
    return _then(_self.copyWith(intensity: value));
  });
}/// Create a copy of EewIntensityItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EewIntensityLpgmValueCopyWith<$Res>? get lpgmIntensity {
    if (_self.lpgmIntensity == null) {
    return null;
  }

  return $EewIntensityLpgmValueCopyWith<$Res>(_self.lpgmIntensity!, (value) {
    return _then(_self.copyWith(lpgmIntensity: value));
  });
}/// Create a copy of EewIntensityItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EewArrivalTimeCopyWith<$Res> get arrivalTime {
  
  return $EewArrivalTimeCopyWith<$Res>(_self.arrivalTime, (value) {
    return _then(_self.copyWith(arrivalTime: value));
  });
}
}


/// @nodoc
mixin _$EewIntensity {

 EewIntensityValue? get maxIntensity; EewIntensityLpgmValue? get maxLpgmIntensity; List<EewIntensityItem> get regions;
/// Create a copy of EewIntensity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewIntensityCopyWith<EewIntensity> get copyWith => _$EewIntensityCopyWithImpl<EewIntensity>(this as EewIntensity, _$identity);

  /// Serializes this EewIntensity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewIntensity&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&(identical(other.maxLpgmIntensity, maxLpgmIntensity) || other.maxLpgmIntensity == maxLpgmIntensity)&&const DeepCollectionEquality().equals(other.regions, regions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,maxIntensity,maxLpgmIntensity,const DeepCollectionEquality().hash(regions));

@override
String toString() {
  return 'EewIntensity(maxIntensity: $maxIntensity, maxLpgmIntensity: $maxLpgmIntensity, regions: $regions)';
}


}

/// @nodoc
abstract mixin class $EewIntensityCopyWith<$Res>  {
  factory $EewIntensityCopyWith(EewIntensity value, $Res Function(EewIntensity) _then) = _$EewIntensityCopyWithImpl;
@useResult
$Res call({
 EewIntensityValue? maxIntensity, EewIntensityLpgmValue? maxLpgmIntensity, List<EewIntensityItem> regions
});


$EewIntensityValueCopyWith<$Res>? get maxIntensity;$EewIntensityLpgmValueCopyWith<$Res>? get maxLpgmIntensity;

}
/// @nodoc
class _$EewIntensityCopyWithImpl<$Res>
    implements $EewIntensityCopyWith<$Res> {
  _$EewIntensityCopyWithImpl(this._self, this._then);

  final EewIntensity _self;
  final $Res Function(EewIntensity) _then;

/// Create a copy of EewIntensity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? maxIntensity = freezed,Object? maxLpgmIntensity = freezed,Object? regions = null,}) {
  return _then(_self.copyWith(
maxIntensity: freezed == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as EewIntensityValue?,maxLpgmIntensity: freezed == maxLpgmIntensity ? _self.maxLpgmIntensity : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
as EewIntensityLpgmValue?,regions: null == regions ? _self.regions : regions // ignore: cast_nullable_to_non_nullable
as List<EewIntensityItem>,
  ));
}
/// Create a copy of EewIntensity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EewIntensityValueCopyWith<$Res>? get maxIntensity {
    if (_self.maxIntensity == null) {
    return null;
  }

  return $EewIntensityValueCopyWith<$Res>(_self.maxIntensity!, (value) {
    return _then(_self.copyWith(maxIntensity: value));
  });
}/// Create a copy of EewIntensity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EewIntensityLpgmValueCopyWith<$Res>? get maxLpgmIntensity {
    if (_self.maxLpgmIntensity == null) {
    return null;
  }

  return $EewIntensityLpgmValueCopyWith<$Res>(_self.maxLpgmIntensity!, (value) {
    return _then(_self.copyWith(maxLpgmIntensity: value));
  });
}
}


/// Adds pattern-matching-related methods to [EewIntensity].
extension EewIntensityPatterns on EewIntensity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EewIntensity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EewIntensity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EewIntensity value)  $default,){
final _that = this;
switch (_that) {
case _EewIntensity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EewIntensity value)?  $default,){
final _that = this;
switch (_that) {
case _EewIntensity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( EewIntensityValue? maxIntensity,  EewIntensityLpgmValue? maxLpgmIntensity,  List<EewIntensityItem> regions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EewIntensity() when $default != null:
return $default(_that.maxIntensity,_that.maxLpgmIntensity,_that.regions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( EewIntensityValue? maxIntensity,  EewIntensityLpgmValue? maxLpgmIntensity,  List<EewIntensityItem> regions)  $default,) {final _that = this;
switch (_that) {
case _EewIntensity():
return $default(_that.maxIntensity,_that.maxLpgmIntensity,_that.regions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( EewIntensityValue? maxIntensity,  EewIntensityLpgmValue? maxLpgmIntensity,  List<EewIntensityItem> regions)?  $default,) {final _that = this;
switch (_that) {
case _EewIntensity() when $default != null:
return $default(_that.maxIntensity,_that.maxLpgmIntensity,_that.regions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EewIntensity implements EewIntensity {
  const _EewIntensity({this.maxIntensity, this.maxLpgmIntensity, required final  List<EewIntensityItem> regions}): _regions = regions;
  factory _EewIntensity.fromJson(Map<String, dynamic> json) => _$EewIntensityFromJson(json);

@override final  EewIntensityValue? maxIntensity;
@override final  EewIntensityLpgmValue? maxLpgmIntensity;
 final  List<EewIntensityItem> _regions;
@override List<EewIntensityItem> get regions {
  if (_regions is EqualUnmodifiableListView) return _regions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_regions);
}


/// Create a copy of EewIntensity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EewIntensityCopyWith<_EewIntensity> get copyWith => __$EewIntensityCopyWithImpl<_EewIntensity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EewIntensityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EewIntensity&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&(identical(other.maxLpgmIntensity, maxLpgmIntensity) || other.maxLpgmIntensity == maxLpgmIntensity)&&const DeepCollectionEquality().equals(other._regions, _regions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,maxIntensity,maxLpgmIntensity,const DeepCollectionEquality().hash(_regions));

@override
String toString() {
  return 'EewIntensity(maxIntensity: $maxIntensity, maxLpgmIntensity: $maxLpgmIntensity, regions: $regions)';
}


}

/// @nodoc
abstract mixin class _$EewIntensityCopyWith<$Res> implements $EewIntensityCopyWith<$Res> {
  factory _$EewIntensityCopyWith(_EewIntensity value, $Res Function(_EewIntensity) _then) = __$EewIntensityCopyWithImpl;
@override @useResult
$Res call({
 EewIntensityValue? maxIntensity, EewIntensityLpgmValue? maxLpgmIntensity, List<EewIntensityItem> regions
});


@override $EewIntensityValueCopyWith<$Res>? get maxIntensity;@override $EewIntensityLpgmValueCopyWith<$Res>? get maxLpgmIntensity;

}
/// @nodoc
class __$EewIntensityCopyWithImpl<$Res>
    implements _$EewIntensityCopyWith<$Res> {
  __$EewIntensityCopyWithImpl(this._self, this._then);

  final _EewIntensity _self;
  final $Res Function(_EewIntensity) _then;

/// Create a copy of EewIntensity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? maxIntensity = freezed,Object? maxLpgmIntensity = freezed,Object? regions = null,}) {
  return _then(_EewIntensity(
maxIntensity: freezed == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as EewIntensityValue?,maxLpgmIntensity: freezed == maxLpgmIntensity ? _self.maxLpgmIntensity : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
as EewIntensityLpgmValue?,regions: null == regions ? _self._regions : regions // ignore: cast_nullable_to_non_nullable
as List<EewIntensityItem>,
  ));
}

/// Create a copy of EewIntensity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EewIntensityValueCopyWith<$Res>? get maxIntensity {
    if (_self.maxIntensity == null) {
    return null;
  }

  return $EewIntensityValueCopyWith<$Res>(_self.maxIntensity!, (value) {
    return _then(_self.copyWith(maxIntensity: value));
  });
}/// Create a copy of EewIntensity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EewIntensityLpgmValueCopyWith<$Res>? get maxLpgmIntensity {
    if (_self.maxLpgmIntensity == null) {
    return null;
  }

  return $EewIntensityLpgmValueCopyWith<$Res>(_self.maxLpgmIntensity!, (value) {
    return _then(_self.copyWith(maxLpgmIntensity: value));
  });
}
}

// dart format on
