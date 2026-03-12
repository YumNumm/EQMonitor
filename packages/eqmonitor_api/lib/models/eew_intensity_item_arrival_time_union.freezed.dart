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
                  case 'eewArrivalTimeTime':
          return EewIntensityItemArrivalTimeUnionEewArrivalTimeTime.fromJson(
            json
          );
                case 'eewArrivalTimeArrived':
          return EewIntensityItemArrivalTimeUnionEewArrivalTimeArrived.fromJson(
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( EewIntensityItemArrivalTimeUnionEewArrivalTimeTime value)?  eewArrivalTimeTime,TResult Function( EewIntensityItemArrivalTimeUnionEewArrivalTimeArrived value)?  eewArrivalTimeArrived,required TResult orElse(),}){
final _that = this;
switch (_that) {
case EewIntensityItemArrivalTimeUnionEewArrivalTimeTime() when eewArrivalTimeTime != null:
return eewArrivalTimeTime(_that);case EewIntensityItemArrivalTimeUnionEewArrivalTimeArrived() when eewArrivalTimeArrived != null:
return eewArrivalTimeArrived(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( EewIntensityItemArrivalTimeUnionEewArrivalTimeTime value)  eewArrivalTimeTime,required TResult Function( EewIntensityItemArrivalTimeUnionEewArrivalTimeArrived value)  eewArrivalTimeArrived,}){
final _that = this;
switch (_that) {
case EewIntensityItemArrivalTimeUnionEewArrivalTimeTime():
return eewArrivalTimeTime(_that);case EewIntensityItemArrivalTimeUnionEewArrivalTimeArrived():
return eewArrivalTimeArrived(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( EewIntensityItemArrivalTimeUnionEewArrivalTimeTime value)?  eewArrivalTimeTime,TResult? Function( EewIntensityItemArrivalTimeUnionEewArrivalTimeArrived value)?  eewArrivalTimeArrived,}){
final _that = this;
switch (_that) {
case EewIntensityItemArrivalTimeUnionEewArrivalTimeTime() when eewArrivalTimeTime != null:
return eewArrivalTimeTime(_that);case EewIntensityItemArrivalTimeUnionEewArrivalTimeArrived() when eewArrivalTimeArrived != null:
return eewArrivalTimeArrived(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( dynamic type,  DateTime value)?  eewArrivalTimeTime,TResult Function( dynamic type)?  eewArrivalTimeArrived,required TResult orElse(),}) {final _that = this;
switch (_that) {
case EewIntensityItemArrivalTimeUnionEewArrivalTimeTime() when eewArrivalTimeTime != null:
return eewArrivalTimeTime(_that.type,_that.value);case EewIntensityItemArrivalTimeUnionEewArrivalTimeArrived() when eewArrivalTimeArrived != null:
return eewArrivalTimeArrived(_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( dynamic type,  DateTime value)  eewArrivalTimeTime,required TResult Function( dynamic type)  eewArrivalTimeArrived,}) {final _that = this;
switch (_that) {
case EewIntensityItemArrivalTimeUnionEewArrivalTimeTime():
return eewArrivalTimeTime(_that.type,_that.value);case EewIntensityItemArrivalTimeUnionEewArrivalTimeArrived():
return eewArrivalTimeArrived(_that.type);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( dynamic type,  DateTime value)?  eewArrivalTimeTime,TResult? Function( dynamic type)?  eewArrivalTimeArrived,}) {final _that = this;
switch (_that) {
case EewIntensityItemArrivalTimeUnionEewArrivalTimeTime() when eewArrivalTimeTime != null:
return eewArrivalTimeTime(_that.type,_that.value);case EewIntensityItemArrivalTimeUnionEewArrivalTimeArrived() when eewArrivalTimeArrived != null:
return eewArrivalTimeArrived(_that.type);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable()
class EewIntensityItemArrivalTimeUnionEewArrivalTimeTime implements EewIntensityItemArrivalTimeUnion {
  const EewIntensityItemArrivalTimeUnionEewArrivalTimeTime({required this.type, required this.value, final  String? $type}): $type = $type ?? 'eewArrivalTimeTime';
  factory EewIntensityItemArrivalTimeUnionEewArrivalTimeTime.fromJson(Map<String, dynamic> json) => _$EewIntensityItemArrivalTimeUnionEewArrivalTimeTimeFromJson(json);

@override final  dynamic type;
 final  DateTime value;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of EewIntensityItemArrivalTimeUnion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewIntensityItemArrivalTimeUnionEewArrivalTimeTimeCopyWith<EewIntensityItemArrivalTimeUnionEewArrivalTimeTime> get copyWith => _$EewIntensityItemArrivalTimeUnionEewArrivalTimeTimeCopyWithImpl<EewIntensityItemArrivalTimeUnionEewArrivalTimeTime>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EewIntensityItemArrivalTimeUnionEewArrivalTimeTimeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewIntensityItemArrivalTimeUnionEewArrivalTimeTime&&const DeepCollectionEquality().equals(other.type, type)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(type),value);

@override
String toString() {
  return 'EewIntensityItemArrivalTimeUnion.eewArrivalTimeTime(type: $type, value: $value)';
}


}

/// @nodoc
abstract mixin class $EewIntensityItemArrivalTimeUnionEewArrivalTimeTimeCopyWith<$Res> implements $EewIntensityItemArrivalTimeUnionCopyWith<$Res> {
  factory $EewIntensityItemArrivalTimeUnionEewArrivalTimeTimeCopyWith(EewIntensityItemArrivalTimeUnionEewArrivalTimeTime value, $Res Function(EewIntensityItemArrivalTimeUnionEewArrivalTimeTime) _then) = _$EewIntensityItemArrivalTimeUnionEewArrivalTimeTimeCopyWithImpl;
@override @useResult
$Res call({
 dynamic type, DateTime value
});




}
/// @nodoc
class _$EewIntensityItemArrivalTimeUnionEewArrivalTimeTimeCopyWithImpl<$Res>
    implements $EewIntensityItemArrivalTimeUnionEewArrivalTimeTimeCopyWith<$Res> {
  _$EewIntensityItemArrivalTimeUnionEewArrivalTimeTimeCopyWithImpl(this._self, this._then);

  final EewIntensityItemArrivalTimeUnionEewArrivalTimeTime _self;
  final $Res Function(EewIntensityItemArrivalTimeUnionEewArrivalTimeTime) _then;

/// Create a copy of EewIntensityItemArrivalTimeUnion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = freezed,Object? value = null,}) {
  return _then(EewIntensityItemArrivalTimeUnionEewArrivalTimeTime(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as dynamic,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc

@JsonSerializable()
class EewIntensityItemArrivalTimeUnionEewArrivalTimeArrived implements EewIntensityItemArrivalTimeUnion {
  const EewIntensityItemArrivalTimeUnionEewArrivalTimeArrived({required this.type, final  String? $type}): $type = $type ?? 'eewArrivalTimeArrived';
  factory EewIntensityItemArrivalTimeUnionEewArrivalTimeArrived.fromJson(Map<String, dynamic> json) => _$EewIntensityItemArrivalTimeUnionEewArrivalTimeArrivedFromJson(json);

@override final  dynamic type;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of EewIntensityItemArrivalTimeUnion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewIntensityItemArrivalTimeUnionEewArrivalTimeArrivedCopyWith<EewIntensityItemArrivalTimeUnionEewArrivalTimeArrived> get copyWith => _$EewIntensityItemArrivalTimeUnionEewArrivalTimeArrivedCopyWithImpl<EewIntensityItemArrivalTimeUnionEewArrivalTimeArrived>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EewIntensityItemArrivalTimeUnionEewArrivalTimeArrivedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewIntensityItemArrivalTimeUnionEewArrivalTimeArrived&&const DeepCollectionEquality().equals(other.type, type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(type));

@override
String toString() {
  return 'EewIntensityItemArrivalTimeUnion.eewArrivalTimeArrived(type: $type)';
}


}

/// @nodoc
abstract mixin class $EewIntensityItemArrivalTimeUnionEewArrivalTimeArrivedCopyWith<$Res> implements $EewIntensityItemArrivalTimeUnionCopyWith<$Res> {
  factory $EewIntensityItemArrivalTimeUnionEewArrivalTimeArrivedCopyWith(EewIntensityItemArrivalTimeUnionEewArrivalTimeArrived value, $Res Function(EewIntensityItemArrivalTimeUnionEewArrivalTimeArrived) _then) = _$EewIntensityItemArrivalTimeUnionEewArrivalTimeArrivedCopyWithImpl;
@override @useResult
$Res call({
 dynamic type
});




}
/// @nodoc
class _$EewIntensityItemArrivalTimeUnionEewArrivalTimeArrivedCopyWithImpl<$Res>
    implements $EewIntensityItemArrivalTimeUnionEewArrivalTimeArrivedCopyWith<$Res> {
  _$EewIntensityItemArrivalTimeUnionEewArrivalTimeArrivedCopyWithImpl(this._self, this._then);

  final EewIntensityItemArrivalTimeUnionEewArrivalTimeArrived _self;
  final $Res Function(EewIntensityItemArrivalTimeUnionEewArrivalTimeArrived) _then;

/// Create a copy of EewIntensityItemArrivalTimeUnion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = freezed,}) {
  return _then(EewIntensityItemArrivalTimeUnionEewArrivalTimeArrived(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}

// dart format on
