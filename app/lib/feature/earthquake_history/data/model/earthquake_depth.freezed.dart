// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_depth.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
EarthquakeDepth _$EarthquakeDepthFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'shallow':
          return EarthquakeDepthShallow.fromJson(
            json
          );
                case 'value':
          return EarthquakeDepthValue.fromJson(
            json
          );
                case 'over700km':
          return EarthquakeDepthOver700km.fromJson(
            json
          );
                case 'unknown':
          return EarthquakeDepthUnknown.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'EarthquakeDepth',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$EarthquakeDepth {



  /// Serializes this EarthquakeDepth to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeDepth);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EarthquakeDepth()';
}


}

/// @nodoc
class $EarthquakeDepthCopyWith<$Res>  {
$EarthquakeDepthCopyWith(EarthquakeDepth _, $Res Function(EarthquakeDepth) __);
}


/// Adds pattern-matching-related methods to [EarthquakeDepth].
extension EarthquakeDepthPatterns on EarthquakeDepth {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( EarthquakeDepthShallow value)?  shallow,TResult Function( EarthquakeDepthValue value)?  value,TResult Function( EarthquakeDepthOver700km value)?  over700km,TResult Function( EarthquakeDepthUnknown value)?  unknown,required TResult orElse(),}){
final _that = this;
switch (_that) {
case EarthquakeDepthShallow() when shallow != null:
return shallow(_that);case EarthquakeDepthValue() when value != null:
return value(_that);case EarthquakeDepthOver700km() when over700km != null:
return over700km(_that);case EarthquakeDepthUnknown() when unknown != null:
return unknown(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( EarthquakeDepthShallow value)  shallow,required TResult Function( EarthquakeDepthValue value)  value,required TResult Function( EarthquakeDepthOver700km value)  over700km,required TResult Function( EarthquakeDepthUnknown value)  unknown,}){
final _that = this;
switch (_that) {
case EarthquakeDepthShallow():
return shallow(_that);case EarthquakeDepthValue():
return value(_that);case EarthquakeDepthOver700km():
return over700km(_that);case EarthquakeDepthUnknown():
return unknown(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( EarthquakeDepthShallow value)?  shallow,TResult? Function( EarthquakeDepthValue value)?  value,TResult? Function( EarthquakeDepthOver700km value)?  over700km,TResult? Function( EarthquakeDepthUnknown value)?  unknown,}){
final _that = this;
switch (_that) {
case EarthquakeDepthShallow() when shallow != null:
return shallow(_that);case EarthquakeDepthValue() when value != null:
return value(_that);case EarthquakeDepthOver700km() when over700km != null:
return over700km(_that);case EarthquakeDepthUnknown() when unknown != null:
return unknown(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  shallow,TResult Function( int value)?  value,TResult Function()?  over700km,TResult Function()?  unknown,required TResult orElse(),}) {final _that = this;
switch (_that) {
case EarthquakeDepthShallow() when shallow != null:
return shallow();case EarthquakeDepthValue() when value != null:
return value(_that.value);case EarthquakeDepthOver700km() when over700km != null:
return over700km();case EarthquakeDepthUnknown() when unknown != null:
return unknown();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  shallow,required TResult Function( int value)  value,required TResult Function()  over700km,required TResult Function()  unknown,}) {final _that = this;
switch (_that) {
case EarthquakeDepthShallow():
return shallow();case EarthquakeDepthValue():
return value(_that.value);case EarthquakeDepthOver700km():
return over700km();case EarthquakeDepthUnknown():
return unknown();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  shallow,TResult? Function( int value)?  value,TResult? Function()?  over700km,TResult? Function()?  unknown,}) {final _that = this;
switch (_that) {
case EarthquakeDepthShallow() when shallow != null:
return shallow();case EarthquakeDepthValue() when value != null:
return value(_that.value);case EarthquakeDepthOver700km() when over700km != null:
return over700km();case EarthquakeDepthUnknown() when unknown != null:
return unknown();case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class EarthquakeDepthShallow implements EarthquakeDepth {
  const EarthquakeDepthShallow({ String? $type}): $type = $type ?? 'shallow';
  factory EarthquakeDepthShallow.fromJson(Map<String, dynamic> json) => _$EarthquakeDepthShallowFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$EarthquakeDepthShallowToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeDepthShallow);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EarthquakeDepth.shallow()';
}


}




/// @nodoc
@JsonSerializable()

class EarthquakeDepthValue implements EarthquakeDepth {
  const EarthquakeDepthValue({required this.value,  String? $type}): $type = $type ?? 'value';
  factory EarthquakeDepthValue.fromJson(Map<String, dynamic> json) => _$EarthquakeDepthValueFromJson(json);

 final  int value;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of EarthquakeDepth
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeDepthValueCopyWith<EarthquakeDepthValue> get copyWith => _$EarthquakeDepthValueCopyWithImpl<EarthquakeDepthValue>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeDepthValueToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeDepthValue&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'EarthquakeDepth.value(value: $value)';
}


}

/// @nodoc
abstract mixin class $EarthquakeDepthValueCopyWith<$Res> implements $EarthquakeDepthCopyWith<$Res> {
  factory $EarthquakeDepthValueCopyWith(EarthquakeDepthValue value, $Res Function(EarthquakeDepthValue) _then) = _$EarthquakeDepthValueCopyWithImpl;
@useResult
$Res call({
 int value
});




}
/// @nodoc
class _$EarthquakeDepthValueCopyWithImpl<$Res>
    implements $EarthquakeDepthValueCopyWith<$Res> {
  _$EarthquakeDepthValueCopyWithImpl(this._self, this._then);

  final EarthquakeDepthValue _self;
  final $Res Function(EarthquakeDepthValue) _then;

/// Create a copy of EarthquakeDepth
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(EarthquakeDepthValue(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
@JsonSerializable()

class EarthquakeDepthOver700km implements EarthquakeDepth {
  const EarthquakeDepthOver700km({ String? $type}): $type = $type ?? 'over700km';
  factory EarthquakeDepthOver700km.fromJson(Map<String, dynamic> json) => _$EarthquakeDepthOver700kmFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$EarthquakeDepthOver700kmToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeDepthOver700km);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EarthquakeDepth.over700km()';
}


}




/// @nodoc
@JsonSerializable()

class EarthquakeDepthUnknown implements EarthquakeDepth {
  const EarthquakeDepthUnknown({ String? $type}): $type = $type ?? 'unknown';
  factory EarthquakeDepthUnknown.fromJson(Map<String, dynamic> json) => _$EarthquakeDepthUnknownFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$EarthquakeDepthUnknownToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeDepthUnknown);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EarthquakeDepth.unknown()';
}


}




// dart format on
