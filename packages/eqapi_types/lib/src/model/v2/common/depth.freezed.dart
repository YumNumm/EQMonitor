// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'depth.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
Depth _$DepthFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'SHALLOW':
          return DepthShallow.fromJson(
            json
          );
                case 'NORMAL':
          return DepthNormal.fromJson(
            json
          );
                case 'OVER_700':
          return DepthOver700.fromJson(
            json
          );
                case 'UNKNOWN':
          return DepthUnknown.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'Depth',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$Depth {



  /// Serializes this Depth to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Depth);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Depth()';
}


}

/// @nodoc
class $DepthCopyWith<$Res>  {
$DepthCopyWith(Depth _, $Res Function(Depth) __);
}


/// Adds pattern-matching-related methods to [Depth].
extension DepthPatterns on Depth {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( DepthShallow value)?  shallow,TResult Function( DepthNormal value)?  normal,TResult Function( DepthOver700 value)?  over700,TResult Function( DepthUnknown value)?  unknown,required TResult orElse(),}){
final _that = this;
switch (_that) {
case DepthShallow() when shallow != null:
return shallow(_that);case DepthNormal() when normal != null:
return normal(_that);case DepthOver700() when over700 != null:
return over700(_that);case DepthUnknown() when unknown != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( DepthShallow value)  shallow,required TResult Function( DepthNormal value)  normal,required TResult Function( DepthOver700 value)  over700,required TResult Function( DepthUnknown value)  unknown,}){
final _that = this;
switch (_that) {
case DepthShallow():
return shallow(_that);case DepthNormal():
return normal(_that);case DepthOver700():
return over700(_that);case DepthUnknown():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( DepthShallow value)?  shallow,TResult? Function( DepthNormal value)?  normal,TResult? Function( DepthOver700 value)?  over700,TResult? Function( DepthUnknown value)?  unknown,}){
final _that = this;
switch (_that) {
case DepthShallow() when shallow != null:
return shallow(_that);case DepthNormal() when normal != null:
return normal(_that);case DepthOver700() when over700 != null:
return over700(_that);case DepthUnknown() when unknown != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  shallow,TResult Function( int value)?  normal,TResult Function()?  over700,TResult Function()?  unknown,required TResult orElse(),}) {final _that = this;
switch (_that) {
case DepthShallow() when shallow != null:
return shallow();case DepthNormal() when normal != null:
return normal(_that.value);case DepthOver700() when over700 != null:
return over700();case DepthUnknown() when unknown != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  shallow,required TResult Function( int value)  normal,required TResult Function()  over700,required TResult Function()  unknown,}) {final _that = this;
switch (_that) {
case DepthShallow():
return shallow();case DepthNormal():
return normal(_that.value);case DepthOver700():
return over700();case DepthUnknown():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  shallow,TResult? Function( int value)?  normal,TResult? Function()?  over700,TResult? Function()?  unknown,}) {final _that = this;
switch (_that) {
case DepthShallow() when shallow != null:
return shallow();case DepthNormal() when normal != null:
return normal(_that.value);case DepthOver700() when over700 != null:
return over700();case DepthUnknown() when unknown != null:
return unknown();case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class DepthShallow implements Depth {
  const DepthShallow({final  String? $type}): $type = $type ?? 'SHALLOW';
  factory DepthShallow.fromJson(Map<String, dynamic> json) => _$DepthShallowFromJson(json);



@JsonKey(name: 'type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$DepthShallowToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DepthShallow);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Depth.shallow()';
}


}




/// @nodoc
@JsonSerializable()

class DepthNormal implements Depth {
  const DepthNormal({required this.value, final  String? $type}): $type = $type ?? 'NORMAL';
  factory DepthNormal.fromJson(Map<String, dynamic> json) => _$DepthNormalFromJson(json);

 final  int value;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Depth
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DepthNormalCopyWith<DepthNormal> get copyWith => _$DepthNormalCopyWithImpl<DepthNormal>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DepthNormalToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DepthNormal&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'Depth.normal(value: $value)';
}


}

/// @nodoc
abstract mixin class $DepthNormalCopyWith<$Res> implements $DepthCopyWith<$Res> {
  factory $DepthNormalCopyWith(DepthNormal value, $Res Function(DepthNormal) _then) = _$DepthNormalCopyWithImpl;
@useResult
$Res call({
 int value
});




}
/// @nodoc
class _$DepthNormalCopyWithImpl<$Res>
    implements $DepthNormalCopyWith<$Res> {
  _$DepthNormalCopyWithImpl(this._self, this._then);

  final DepthNormal _self;
  final $Res Function(DepthNormal) _then;

/// Create a copy of Depth
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(DepthNormal(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
@JsonSerializable()

class DepthOver700 implements Depth {
  const DepthOver700({final  String? $type}): $type = $type ?? 'OVER_700';
  factory DepthOver700.fromJson(Map<String, dynamic> json) => _$DepthOver700FromJson(json);



@JsonKey(name: 'type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$DepthOver700ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DepthOver700);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Depth.over700()';
}


}




/// @nodoc
@JsonSerializable()

class DepthUnknown implements Depth {
  const DepthUnknown({final  String? $type}): $type = $type ?? 'UNKNOWN';
  factory DepthUnknown.fromJson(Map<String, dynamic> json) => _$DepthUnknownFromJson(json);



@JsonKey(name: 'type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$DepthUnknownToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DepthUnknown);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Depth.unknown()';
}


}




// dart format on
