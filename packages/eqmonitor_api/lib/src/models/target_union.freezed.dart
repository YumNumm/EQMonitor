// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'target_union.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
TargetUnion _$TargetUnionFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'variant1':
          return TargetUnionVariant1.fromJson(
            json
          );
                case 'variant2':
          return TargetUnionVariant2.fromJson(
            json
          );

          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'TargetUnion',
  'Invalid union type "${json['runtimeType']}"!'
);
        }

}

/// @nodoc
mixin _$TargetUnion {

/// const: "DEVICE_ID"
 String get type;
/// Create a copy of TargetUnion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TargetUnionCopyWith<TargetUnion> get copyWith => _$TargetUnionCopyWithImpl<TargetUnion>(this as TargetUnion, _$identity);

  /// Serializes this TargetUnion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TargetUnion&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type);

@override
String toString() {
  return 'TargetUnion(type: $type)';
}


}

/// @nodoc
abstract mixin class $TargetUnionCopyWith<$Res>  {
  factory $TargetUnionCopyWith(TargetUnion value, $Res Function(TargetUnion) _then) = _$TargetUnionCopyWithImpl;
@useResult
$Res call({
 String type
});




}
/// @nodoc
class _$TargetUnionCopyWithImpl<$Res>
    implements $TargetUnionCopyWith<$Res> {
  _$TargetUnionCopyWithImpl(this._self, this._then);

  final TargetUnion _self;
  final $Res Function(TargetUnion) _then;

/// Create a copy of TargetUnion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TargetUnion].
extension TargetUnionPatterns on TargetUnion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( TargetUnionVariant1 value)?  variant1,TResult Function( TargetUnionVariant2 value)?  variant2,required TResult orElse(),}){
final _that = this;
switch (_that) {
case TargetUnionVariant1() when variant1 != null:
return variant1(_that);case TargetUnionVariant2() when variant2 != null:
return variant2(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( TargetUnionVariant1 value)  variant1,required TResult Function( TargetUnionVariant2 value)  variant2,}){
final _that = this;
switch (_that) {
case TargetUnionVariant1():
return variant1(_that);case TargetUnionVariant2():
return variant2(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( TargetUnionVariant1 value)?  variant1,TResult? Function( TargetUnionVariant2 value)?  variant2,}){
final _that = this;
switch (_that) {
case TargetUnionVariant1() when variant1 != null:
return variant1(_that);case TargetUnionVariant2() when variant2 != null:
return variant2(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String type,  String deviceId)?  variant1,TResult Function( String type,  String token,  Environment environment)?  variant2,required TResult orElse(),}) {final _that = this;
switch (_that) {
case TargetUnionVariant1() when variant1 != null:
return variant1(_that.type,_that.deviceId);case TargetUnionVariant2() when variant2 != null:
return variant2(_that.type,_that.token,_that.environment);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String type,  String deviceId)  variant1,required TResult Function( String type,  String token,  Environment environment)  variant2,}) {final _that = this;
switch (_that) {
case TargetUnionVariant1():
return variant1(_that.type,_that.deviceId);case TargetUnionVariant2():
return variant2(_that.type,_that.token,_that.environment);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String type,  String deviceId)?  variant1,TResult? Function( String type,  String token,  Environment environment)?  variant2,}) {final _that = this;
switch (_that) {
case TargetUnionVariant1() when variant1 != null:
return variant1(_that.type,_that.deviceId);case TargetUnionVariant2() when variant2 != null:
return variant2(_that.type,_that.token,_that.environment);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable()
class TargetUnionVariant1 implements TargetUnion {
  const TargetUnionVariant1({required this.type, required this.deviceId,  String? $type}): $type = $type ?? 'variant1';
  factory TargetUnionVariant1.fromJson(Map<String, dynamic> json) => _$TargetUnionVariant1FromJson(json);

/// const: "DEVICE_ID"
@override final  String type;
 final  String deviceId;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of TargetUnion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TargetUnionVariant1CopyWith<TargetUnionVariant1> get copyWith => _$TargetUnionVariant1CopyWithImpl<TargetUnionVariant1>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TargetUnionVariant1ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TargetUnionVariant1&&(identical(other.type, type) || other.type == type)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,deviceId);

@override
String toString() {
  return 'TargetUnion.variant1(type: $type, deviceId: $deviceId)';
}


}

/// @nodoc
abstract mixin class $TargetUnionVariant1CopyWith<$Res> implements $TargetUnionCopyWith<$Res> {
  factory $TargetUnionVariant1CopyWith(TargetUnionVariant1 value, $Res Function(TargetUnionVariant1) _then) = _$TargetUnionVariant1CopyWithImpl;
@override @useResult
$Res call({
 String type, String deviceId
});




}
/// @nodoc
class _$TargetUnionVariant1CopyWithImpl<$Res>
    implements $TargetUnionVariant1CopyWith<$Res> {
  _$TargetUnionVariant1CopyWithImpl(this._self, this._then);

  final TargetUnionVariant1 _self;
  final $Res Function(TargetUnionVariant1) _then;

/// Create a copy of TargetUnion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? deviceId = null,}) {
  return _then(TargetUnionVariant1(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc

@JsonSerializable()
class TargetUnionVariant2 implements TargetUnion {
  const TargetUnionVariant2({required this.type, required this.token, required this.environment,  String? $type}): $type = $type ?? 'variant2';
  factory TargetUnionVariant2.fromJson(Map<String, dynamic> json) => _$TargetUnionVariant2FromJson(json);

/// const: "PUSH_TO_START_TOKEN"
@override final  String type;
 final  String token;
 final  Environment environment;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of TargetUnion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TargetUnionVariant2CopyWith<TargetUnionVariant2> get copyWith => _$TargetUnionVariant2CopyWithImpl<TargetUnionVariant2>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TargetUnionVariant2ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TargetUnionVariant2&&(identical(other.type, type) || other.type == type)&&(identical(other.token, token) || other.token == token)&&(identical(other.environment, environment) || other.environment == environment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,token,environment);

@override
String toString() {
  return 'TargetUnion.variant2(type: $type, token: $token, environment: $environment)';
}


}

/// @nodoc
abstract mixin class $TargetUnionVariant2CopyWith<$Res> implements $TargetUnionCopyWith<$Res> {
  factory $TargetUnionVariant2CopyWith(TargetUnionVariant2 value, $Res Function(TargetUnionVariant2) _then) = _$TargetUnionVariant2CopyWithImpl;
@override @useResult
$Res call({
 String type, String token, Environment environment
});




}
/// @nodoc
class _$TargetUnionVariant2CopyWithImpl<$Res>
    implements $TargetUnionVariant2CopyWith<$Res> {
  _$TargetUnionVariant2CopyWithImpl(this._self, this._then);

  final TargetUnionVariant2 _self;
  final $Res Function(TargetUnionVariant2) _then;

/// Create a copy of TargetUnion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? token = null,Object? environment = null,}) {
  return _then(TargetUnionVariant2(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,environment: null == environment ? _self.environment : environment // ignore: cast_nullable_to_non_nullable
as Environment,
  ));
}


}

// dart format on
