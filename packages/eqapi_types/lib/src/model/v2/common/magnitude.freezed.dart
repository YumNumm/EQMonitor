// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'magnitude.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
Magnitude _$MagnitudeFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'NORMAL':
          return MagnitudeNormal.fromJson(
            json
          );
                case 'UNKNOWN':
          return MagnitudeUnknown.fromJson(
            json
          );
                case 'OVER_M8':
          return MagnitudeOverM8.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'Magnitude',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$Magnitude {



  /// Serializes this Magnitude to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Magnitude);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Magnitude()';
}


}

/// @nodoc
class $MagnitudeCopyWith<$Res>  {
$MagnitudeCopyWith(Magnitude _, $Res Function(Magnitude) __);
}


/// Adds pattern-matching-related methods to [Magnitude].
extension MagnitudePatterns on Magnitude {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( MagnitudeNormal value)?  normal,TResult Function( MagnitudeUnknown value)?  unknown,TResult Function( MagnitudeOverM8 value)?  overM8,required TResult orElse(),}){
final _that = this;
switch (_that) {
case MagnitudeNormal() when normal != null:
return normal(_that);case MagnitudeUnknown() when unknown != null:
return unknown(_that);case MagnitudeOverM8() when overM8 != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( MagnitudeNormal value)  normal,required TResult Function( MagnitudeUnknown value)  unknown,required TResult Function( MagnitudeOverM8 value)  overM8,}){
final _that = this;
switch (_that) {
case MagnitudeNormal():
return normal(_that);case MagnitudeUnknown():
return unknown(_that);case MagnitudeOverM8():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( MagnitudeNormal value)?  normal,TResult? Function( MagnitudeUnknown value)?  unknown,TResult? Function( MagnitudeOverM8 value)?  overM8,}){
final _that = this;
switch (_that) {
case MagnitudeNormal() when normal != null:
return normal(_that);case MagnitudeUnknown() when unknown != null:
return unknown(_that);case MagnitudeOverM8() when overM8 != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( double value)?  normal,TResult Function()?  unknown,TResult Function()?  overM8,required TResult orElse(),}) {final _that = this;
switch (_that) {
case MagnitudeNormal() when normal != null:
return normal(_that.value);case MagnitudeUnknown() when unknown != null:
return unknown();case MagnitudeOverM8() when overM8 != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( double value)  normal,required TResult Function()  unknown,required TResult Function()  overM8,}) {final _that = this;
switch (_that) {
case MagnitudeNormal():
return normal(_that.value);case MagnitudeUnknown():
return unknown();case MagnitudeOverM8():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( double value)?  normal,TResult? Function()?  unknown,TResult? Function()?  overM8,}) {final _that = this;
switch (_that) {
case MagnitudeNormal() when normal != null:
return normal(_that.value);case MagnitudeUnknown() when unknown != null:
return unknown();case MagnitudeOverM8() when overM8 != null:
return overM8();case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class MagnitudeNormal implements Magnitude {
  const MagnitudeNormal({required this.value, final  String? $type}): $type = $type ?? 'NORMAL';
  factory MagnitudeNormal.fromJson(Map<String, dynamic> json) => _$MagnitudeNormalFromJson(json);

 final  double value;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Magnitude
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MagnitudeNormalCopyWith<MagnitudeNormal> get copyWith => _$MagnitudeNormalCopyWithImpl<MagnitudeNormal>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MagnitudeNormalToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MagnitudeNormal&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'Magnitude.normal(value: $value)';
}


}

/// @nodoc
abstract mixin class $MagnitudeNormalCopyWith<$Res> implements $MagnitudeCopyWith<$Res> {
  factory $MagnitudeNormalCopyWith(MagnitudeNormal value, $Res Function(MagnitudeNormal) _then) = _$MagnitudeNormalCopyWithImpl;
@useResult
$Res call({
 double value
});




}
/// @nodoc
class _$MagnitudeNormalCopyWithImpl<$Res>
    implements $MagnitudeNormalCopyWith<$Res> {
  _$MagnitudeNormalCopyWithImpl(this._self, this._then);

  final MagnitudeNormal _self;
  final $Res Function(MagnitudeNormal) _then;

/// Create a copy of Magnitude
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(MagnitudeNormal(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
@JsonSerializable()

class MagnitudeUnknown implements Magnitude {
  const MagnitudeUnknown({final  String? $type}): $type = $type ?? 'UNKNOWN';
  factory MagnitudeUnknown.fromJson(Map<String, dynamic> json) => _$MagnitudeUnknownFromJson(json);



@JsonKey(name: 'type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$MagnitudeUnknownToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MagnitudeUnknown);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Magnitude.unknown()';
}


}




/// @nodoc
@JsonSerializable()

class MagnitudeOverM8 implements Magnitude {
  const MagnitudeOverM8({final  String? $type}): $type = $type ?? 'OVER_M8';
  factory MagnitudeOverM8.fromJson(Map<String, dynamic> json) => _$MagnitudeOverM8FromJson(json);



@JsonKey(name: 'type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$MagnitudeOverM8ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MagnitudeOverM8);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Magnitude.overM8()';
}


}




// dart format on
