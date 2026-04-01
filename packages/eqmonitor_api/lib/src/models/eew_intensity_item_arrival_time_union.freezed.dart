// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eew_intensity_item_arrival_time_union.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
EewIntensityItemArrivalTimeUnion _$EewIntensityItemArrivalTimeUnionFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'eewIntensityRegionArrivalTimeTime':
          return EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeTime.fromJson(
            json
          );
                case 'eewIntensityRegionArrivalTimeArrived':
          return EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeArrived.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'EewIntensityItemArrivalTimeUnion',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$EewIntensityItemArrivalTimeUnion {

 dynamic get type;
/// Create a copy of EewIntensityItemArrivalTimeUnion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewIntensityItemArrivalTimeUnionCopyWith<EewIntensityItemArrivalTimeUnion> get copyWith => _$EewIntensityItemArrivalTimeUnionCopyWithImpl<EewIntensityItemArrivalTimeUnion>(this as EewIntensityItemArrivalTimeUnion, _$identity);

  /// Serializes this EewIntensityItemArrivalTimeUnion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewIntensityItemArrivalTimeUnion&&const DeepCollectionEquality().equals(other.type, type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(type));

@override
String toString() {
  return 'EewIntensityItemArrivalTimeUnion(type: $type)';
}


}

/// @nodoc
abstract mixin class $EewIntensityItemArrivalTimeUnionCopyWith<$Res>  {
  factory $EewIntensityItemArrivalTimeUnionCopyWith(EewIntensityItemArrivalTimeUnion value, $Res Function(EewIntensityItemArrivalTimeUnion) _then) = _$EewIntensityItemArrivalTimeUnionCopyWithImpl;
@useResult
$Res call({
 dynamic type
});




}
/// @nodoc
class _$EewIntensityItemArrivalTimeUnionCopyWithImpl<$Res>
    implements $EewIntensityItemArrivalTimeUnionCopyWith<$Res> {
  _$EewIntensityItemArrivalTimeUnionCopyWithImpl(this._self, this._then);

  final EewIntensityItemArrivalTimeUnion _self;
  final $Res Function(EewIntensityItemArrivalTimeUnion) _then;

/// Create a copy of EewIntensityItemArrivalTimeUnion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = freezed,}) {
  return _then(_self.copyWith(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}

}


/// Adds pattern-matching-related methods to [EewIntensityItemArrivalTimeUnion].
extension EewIntensityItemArrivalTimeUnionPatterns on EewIntensityItemArrivalTimeUnion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeTime value)?  eewIntensityRegionArrivalTimeTime,TResult Function( EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeArrived value)?  eewIntensityRegionArrivalTimeArrived,required TResult orElse(),}){
final _that = this;
switch (_that) {
case EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeTime() when eewIntensityRegionArrivalTimeTime != null:
return eewIntensityRegionArrivalTimeTime(_that);case EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeArrived() when eewIntensityRegionArrivalTimeArrived != null:
return eewIntensityRegionArrivalTimeArrived(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeTime value)  eewIntensityRegionArrivalTimeTime,required TResult Function( EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeArrived value)  eewIntensityRegionArrivalTimeArrived,}){
final _that = this;
switch (_that) {
case EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeTime():
return eewIntensityRegionArrivalTimeTime(_that);case EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeArrived():
return eewIntensityRegionArrivalTimeArrived(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeTime value)?  eewIntensityRegionArrivalTimeTime,TResult? Function( EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeArrived value)?  eewIntensityRegionArrivalTimeArrived,}){
final _that = this;
switch (_that) {
case EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeTime() when eewIntensityRegionArrivalTimeTime != null:
return eewIntensityRegionArrivalTimeTime(_that);case EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeArrived() when eewIntensityRegionArrivalTimeArrived != null:
return eewIntensityRegionArrivalTimeArrived(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( dynamic type,  DateTime value)?  eewIntensityRegionArrivalTimeTime,TResult Function( dynamic type)?  eewIntensityRegionArrivalTimeArrived,required TResult orElse(),}) {final _that = this;
switch (_that) {
case EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeTime() when eewIntensityRegionArrivalTimeTime != null:
return eewIntensityRegionArrivalTimeTime(_that.type,_that.value);case EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeArrived() when eewIntensityRegionArrivalTimeArrived != null:
return eewIntensityRegionArrivalTimeArrived(_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( dynamic type,  DateTime value)  eewIntensityRegionArrivalTimeTime,required TResult Function( dynamic type)  eewIntensityRegionArrivalTimeArrived,}) {final _that = this;
switch (_that) {
case EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeTime():
return eewIntensityRegionArrivalTimeTime(_that.type,_that.value);case EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeArrived():
return eewIntensityRegionArrivalTimeArrived(_that.type);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( dynamic type,  DateTime value)?  eewIntensityRegionArrivalTimeTime,TResult? Function( dynamic type)?  eewIntensityRegionArrivalTimeArrived,}) {final _that = this;
switch (_that) {
case EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeTime() when eewIntensityRegionArrivalTimeTime != null:
return eewIntensityRegionArrivalTimeTime(_that.type,_that.value);case EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeArrived() when eewIntensityRegionArrivalTimeArrived != null:
return eewIntensityRegionArrivalTimeArrived(_that.type);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable()
class EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeTime implements EewIntensityItemArrivalTimeUnion {
  const EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeTime({required this.type, required this.value, final  String? $type}): $type = $type ?? 'eewIntensityRegionArrivalTimeTime';
  factory EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeTime.fromJson(Map<String, dynamic> json) => _$EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeTimeFromJson(json);

@override final  dynamic type;
 final  DateTime value;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of EewIntensityItemArrivalTimeUnion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeTimeCopyWith<EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeTime> get copyWith => _$EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeTimeCopyWithImpl<EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeTime>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeTimeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeTime&&const DeepCollectionEquality().equals(other.type, type)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(type),value);

@override
String toString() {
  return 'EewIntensityItemArrivalTimeUnion.eewIntensityRegionArrivalTimeTime(type: $type, value: $value)';
}


}

/// @nodoc
abstract mixin class $EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeTimeCopyWith<$Res> implements $EewIntensityItemArrivalTimeUnionCopyWith<$Res> {
  factory $EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeTimeCopyWith(EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeTime value, $Res Function(EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeTime) _then) = _$EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeTimeCopyWithImpl;
@override @useResult
$Res call({
 dynamic type, DateTime value
});




}
/// @nodoc
class _$EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeTimeCopyWithImpl<$Res>
    implements $EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeTimeCopyWith<$Res> {
  _$EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeTimeCopyWithImpl(this._self, this._then);

  final EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeTime _self;
  final $Res Function(EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeTime) _then;

/// Create a copy of EewIntensityItemArrivalTimeUnion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = freezed,Object? value = null,}) {
  return _then(EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeTime(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as dynamic,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc

@JsonSerializable()
class EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeArrived implements EewIntensityItemArrivalTimeUnion {
  const EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeArrived({required this.type, final  String? $type}): $type = $type ?? 'eewIntensityRegionArrivalTimeArrived';
  factory EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeArrived.fromJson(Map<String, dynamic> json) => _$EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeArrivedFromJson(json);

@override final  dynamic type;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of EewIntensityItemArrivalTimeUnion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeArrivedCopyWith<EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeArrived> get copyWith => _$EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeArrivedCopyWithImpl<EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeArrived>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeArrivedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeArrived&&const DeepCollectionEquality().equals(other.type, type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(type));

@override
String toString() {
  return 'EewIntensityItemArrivalTimeUnion.eewIntensityRegionArrivalTimeArrived(type: $type)';
}


}

/// @nodoc
abstract mixin class $EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeArrivedCopyWith<$Res> implements $EewIntensityItemArrivalTimeUnionCopyWith<$Res> {
  factory $EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeArrivedCopyWith(EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeArrived value, $Res Function(EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeArrived) _then) = _$EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeArrivedCopyWithImpl;
@override @useResult
$Res call({
 dynamic type
});




}
/// @nodoc
class _$EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeArrivedCopyWithImpl<$Res>
    implements $EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeArrivedCopyWith<$Res> {
  _$EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeArrivedCopyWithImpl(this._self, this._then);

  final EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeArrived _self;
  final $Res Function(EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeArrived) _then;

/// Create a copy of EewIntensityItemArrivalTimeUnion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = freezed,}) {
  return _then(EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeArrived(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}

// dart format on
