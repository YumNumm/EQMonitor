// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'intensity_history_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$IntensityHistoryState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntensityHistoryState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'IntensityHistoryState()';
}


}

/// @nodoc
class $IntensityHistoryStateCopyWith<$Res>  {
$IntensityHistoryStateCopyWith(IntensityHistoryState _, $Res Function(IntensityHistoryState) __);
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( IntensityHistoryStatePrefecture value)?  prefecture,TResult Function( IntensityHistoryStateCity value)?  city,required TResult orElse(),}){
final _that = this;
switch (_that) {
case IntensityHistoryStatePrefecture() when prefecture != null:
return prefecture(_that);case IntensityHistoryStateCity() when city != null:
return city(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( IntensityHistoryStatePrefecture value)  prefecture,required TResult Function( IntensityHistoryStateCity value)  city,}){
final _that = this;
switch (_that) {
case IntensityHistoryStatePrefecture():
return prefecture(_that);case IntensityHistoryStateCity():
return city(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( IntensityHistoryStatePrefecture value)?  prefecture,TResult? Function( IntensityHistoryStateCity value)?  city,}){
final _that = this;
switch (_that) {
case IntensityHistoryStatePrefecture() when prefecture != null:
return prefecture(_that);case IntensityHistoryStateCity() when city != null:
return city(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  prefecture,TResult Function( String prefectureCode,  String prefectureName,  String? selectedCityCode,  String? selectedCityName)?  city,required TResult orElse(),}) {final _that = this;
switch (_that) {
case IntensityHistoryStatePrefecture() when prefecture != null:
return prefecture();case IntensityHistoryStateCity() when city != null:
return city(_that.prefectureCode,_that.prefectureName,_that.selectedCityCode,_that.selectedCityName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  prefecture,required TResult Function( String prefectureCode,  String prefectureName,  String? selectedCityCode,  String? selectedCityName)  city,}) {final _that = this;
switch (_that) {
case IntensityHistoryStatePrefecture():
return prefecture();case IntensityHistoryStateCity():
return city(_that.prefectureCode,_that.prefectureName,_that.selectedCityCode,_that.selectedCityName);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  prefecture,TResult? Function( String prefectureCode,  String prefectureName,  String? selectedCityCode,  String? selectedCityName)?  city,}) {final _that = this;
switch (_that) {
case IntensityHistoryStatePrefecture() when prefecture != null:
return prefecture();case IntensityHistoryStateCity() when city != null:
return city(_that.prefectureCode,_that.prefectureName,_that.selectedCityCode,_that.selectedCityName);case _:
  return null;

}
}

}

/// @nodoc


class IntensityHistoryStatePrefecture implements IntensityHistoryState {
  const IntensityHistoryStatePrefecture();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntensityHistoryStatePrefecture);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'IntensityHistoryState.prefecture()';
}


}




/// @nodoc


class IntensityHistoryStateCity implements IntensityHistoryState {
  const IntensityHistoryStateCity({required this.prefectureCode, required this.prefectureName, this.selectedCityCode, this.selectedCityName});
  

 final  String prefectureCode;
 final  String prefectureName;
 final  String? selectedCityCode;
 final  String? selectedCityName;

/// Create a copy of IntensityHistoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntensityHistoryStateCityCopyWith<IntensityHistoryStateCity> get copyWith => _$IntensityHistoryStateCityCopyWithImpl<IntensityHistoryStateCity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntensityHistoryStateCity&&(identical(other.prefectureCode, prefectureCode) || other.prefectureCode == prefectureCode)&&(identical(other.prefectureName, prefectureName) || other.prefectureName == prefectureName)&&(identical(other.selectedCityCode, selectedCityCode) || other.selectedCityCode == selectedCityCode)&&(identical(other.selectedCityName, selectedCityName) || other.selectedCityName == selectedCityName));
}


@override
int get hashCode => Object.hash(runtimeType,prefectureCode,prefectureName,selectedCityCode,selectedCityName);

@override
String toString() {
  return 'IntensityHistoryState.city(prefectureCode: $prefectureCode, prefectureName: $prefectureName, selectedCityCode: $selectedCityCode, selectedCityName: $selectedCityName)';
}


}

/// @nodoc
abstract mixin class $IntensityHistoryStateCityCopyWith<$Res> implements $IntensityHistoryStateCopyWith<$Res> {
  factory $IntensityHistoryStateCityCopyWith(IntensityHistoryStateCity value, $Res Function(IntensityHistoryStateCity) _then) = _$IntensityHistoryStateCityCopyWithImpl;
@useResult
$Res call({
 String prefectureCode, String prefectureName, String? selectedCityCode, String? selectedCityName
});




}
/// @nodoc
class _$IntensityHistoryStateCityCopyWithImpl<$Res>
    implements $IntensityHistoryStateCityCopyWith<$Res> {
  _$IntensityHistoryStateCityCopyWithImpl(this._self, this._then);

  final IntensityHistoryStateCity _self;
  final $Res Function(IntensityHistoryStateCity) _then;

/// Create a copy of IntensityHistoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? prefectureCode = null,Object? prefectureName = null,Object? selectedCityCode = freezed,Object? selectedCityName = freezed,}) {
  return _then(IntensityHistoryStateCity(
prefectureCode: null == prefectureCode ? _self.prefectureCode : prefectureCode // ignore: cast_nullable_to_non_nullable
as String,prefectureName: null == prefectureName ? _self.prefectureName : prefectureName // ignore: cast_nullable_to_non_nullable
as String,selectedCityCode: freezed == selectedCityCode ? _self.selectedCityCode : selectedCityCode // ignore: cast_nullable_to_non_nullable
as String?,selectedCityName: freezed == selectedCityName ? _self.selectedCityName : selectedCityName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
