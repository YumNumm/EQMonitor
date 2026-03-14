// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_magnitude.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
EarthquakeMagnitude _$EarthquakeMagnitudeFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'value':
          return EarthquakeMagnitudeValue.fromJson(
            json
          );
                case 'unknown':
          return EarthquakeMagnitudeUnknown.fromJson(
            json
          );
                case 'overM8':
          return EarthquakeMagnitudeOverM8.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'EarthquakeMagnitude',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$EarthquakeMagnitude {



  /// Serializes this EarthquakeMagnitude to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeMagnitude);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EarthquakeMagnitude()';
}


}

/// @nodoc
class $EarthquakeMagnitudeCopyWith<$Res>  {
$EarthquakeMagnitudeCopyWith(EarthquakeMagnitude _, $Res Function(EarthquakeMagnitude) __);
}


/// Adds pattern-matching-related methods to [EarthquakeMagnitude].
extension EarthquakeMagnitudePatterns on EarthquakeMagnitude {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( EarthquakeMagnitudeValue value)?  value,TResult Function( EarthquakeMagnitudeUnknown value)?  unknown,TResult Function( EarthquakeMagnitudeOverM8 value)?  overM8,required TResult orElse(),}){
final _that = this;
switch (_that) {
case EarthquakeMagnitudeValue() when value != null:
return value(_that);case EarthquakeMagnitudeUnknown() when unknown != null:
return unknown(_that);case EarthquakeMagnitudeOverM8() when overM8 != null:
return overM8(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( EarthquakeMagnitudeValue value)  value,required TResult Function( EarthquakeMagnitudeUnknown value)  unknown,required TResult Function( EarthquakeMagnitudeOverM8 value)  overM8,}){
final _that = this;
switch (_that) {
case EarthquakeMagnitudeValue():
return value(_that);case EarthquakeMagnitudeUnknown():
return unknown(_that);case EarthquakeMagnitudeOverM8():
return overM8(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( EarthquakeMagnitudeValue value)?  value,TResult? Function( EarthquakeMagnitudeUnknown value)?  unknown,TResult? Function( EarthquakeMagnitudeOverM8 value)?  overM8,}){
final _that = this;
switch (_that) {
case EarthquakeMagnitudeValue() when value != null:
return value(_that);case EarthquakeMagnitudeUnknown() when unknown != null:
return unknown(_that);case EarthquakeMagnitudeOverM8() when overM8 != null:
return overM8(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( double value)?  value,TResult Function()?  unknown,TResult Function()?  overM8,required TResult orElse(),}) {final _that = this;
switch (_that) {
case EarthquakeMagnitudeValue() when value != null:
return value(_that.value);case EarthquakeMagnitudeUnknown() when unknown != null:
return unknown();case EarthquakeMagnitudeOverM8() when overM8 != null:
return overM8();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( double value)  value,required TResult Function()  unknown,required TResult Function()  overM8,}) {final _that = this;
switch (_that) {
case EarthquakeMagnitudeValue():
return value(_that.value);case EarthquakeMagnitudeUnknown():
return unknown();case EarthquakeMagnitudeOverM8():
return overM8();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( double value)?  value,TResult? Function()?  unknown,TResult? Function()?  overM8,}) {final _that = this;
switch (_that) {
case EarthquakeMagnitudeValue() when value != null:
return value(_that.value);case EarthquakeMagnitudeUnknown() when unknown != null:
return unknown();case EarthquakeMagnitudeOverM8() when overM8 != null:
return overM8();case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class EarthquakeMagnitudeValue implements EarthquakeMagnitude {
  const EarthquakeMagnitudeValue({required this.value, final  String? $type}): $type = $type ?? 'value';
  factory EarthquakeMagnitudeValue.fromJson(Map<String, dynamic> json) => _$EarthquakeMagnitudeValueFromJson(json);

 final  double value;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of EarthquakeMagnitude
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeMagnitudeValueCopyWith<EarthquakeMagnitudeValue> get copyWith => _$EarthquakeMagnitudeValueCopyWithImpl<EarthquakeMagnitudeValue>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeMagnitudeValueToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeMagnitudeValue&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'EarthquakeMagnitude.value(value: $value)';
}


}

/// @nodoc
abstract mixin class $EarthquakeMagnitudeValueCopyWith<$Res> implements $EarthquakeMagnitudeCopyWith<$Res> {
  factory $EarthquakeMagnitudeValueCopyWith(EarthquakeMagnitudeValue value, $Res Function(EarthquakeMagnitudeValue) _then) = _$EarthquakeMagnitudeValueCopyWithImpl;
@useResult
$Res call({
 double value
});




}
/// @nodoc
class _$EarthquakeMagnitudeValueCopyWithImpl<$Res>
    implements $EarthquakeMagnitudeValueCopyWith<$Res> {
  _$EarthquakeMagnitudeValueCopyWithImpl(this._self, this._then);

  final EarthquakeMagnitudeValue _self;
  final $Res Function(EarthquakeMagnitudeValue) _then;

/// Create a copy of EarthquakeMagnitude
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(EarthquakeMagnitudeValue(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
@JsonSerializable()

class EarthquakeMagnitudeUnknown implements EarthquakeMagnitude {
  const EarthquakeMagnitudeUnknown({final  String? $type}): $type = $type ?? 'unknown';
  factory EarthquakeMagnitudeUnknown.fromJson(Map<String, dynamic> json) => _$EarthquakeMagnitudeUnknownFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$EarthquakeMagnitudeUnknownToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeMagnitudeUnknown);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EarthquakeMagnitude.unknown()';
}


}




/// @nodoc
@JsonSerializable()

class EarthquakeMagnitudeOverM8 implements EarthquakeMagnitude {
  const EarthquakeMagnitudeOverM8({final  String? $type}): $type = $type ?? 'overM8';
  factory EarthquakeMagnitudeOverM8.fromJson(Map<String, dynamic> json) => _$EarthquakeMagnitudeOverM8FromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$EarthquakeMagnitudeOverM8ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeMagnitudeOverM8);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EarthquakeMagnitude.overM8()';
}


}




// dart format on
