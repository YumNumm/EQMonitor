// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'required_version_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RequiredVersionModel {

 String? get version; int? get buildNumber; String? get message;
/// Create a copy of RequiredVersionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RequiredVersionModelCopyWith<RequiredVersionModel> get copyWith => _$RequiredVersionModelCopyWithImpl<RequiredVersionModel>(this as RequiredVersionModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RequiredVersionModel&&(identical(other.version, version) || other.version == version)&&(identical(other.buildNumber, buildNumber) || other.buildNumber == buildNumber)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,version,buildNumber,message);

@override
String toString() {
  return 'RequiredVersionModel(version: $version, buildNumber: $buildNumber, message: $message)';
}


}

/// @nodoc
abstract mixin class $RequiredVersionModelCopyWith<$Res>  {
  factory $RequiredVersionModelCopyWith(RequiredVersionModel value, $Res Function(RequiredVersionModel) _then) = _$RequiredVersionModelCopyWithImpl;
@useResult
$Res call({
 String? version, int? buildNumber, String? message
});




}
/// @nodoc
class _$RequiredVersionModelCopyWithImpl<$Res>
    implements $RequiredVersionModelCopyWith<$Res> {
  _$RequiredVersionModelCopyWithImpl(this._self, this._then);

  final RequiredVersionModel _self;
  final $Res Function(RequiredVersionModel) _then;

/// Create a copy of RequiredVersionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? version = freezed,Object? buildNumber = freezed,Object? message = freezed,}) {
  return _then(RequiredVersionModel(
version: freezed == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String?,buildNumber: freezed == buildNumber ? _self.buildNumber : buildNumber // ignore: cast_nullable_to_non_nullable
as int?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RequiredVersionModel].
extension RequiredVersionModelPatterns on RequiredVersionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RequiredVersionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RequiredVersionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RequiredVersionModel value)  $default,){
final _that = this;
switch (_that) {
case _RequiredVersionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RequiredVersionModel value)?  $default,){
final _that = this;
switch (_that) {
case _RequiredVersionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? version,  int? buildNumber,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RequiredVersionModel() when $default != null:
return $default(_that.version,_that.buildNumber,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? version,  int? buildNumber,  String? message)  $default,) {final _that = this;
switch (_that) {
case _RequiredVersionModel():
return $default(_that.version,_that.buildNumber,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? version,  int? buildNumber,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _RequiredVersionModel() when $default != null:
return $default(_that.version,_that.buildNumber,_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _RequiredVersionModel implements RequiredVersionModel {
  const _RequiredVersionModel({this.version, this.buildNumber, this.message});
  

@override final  String? version;
@override final  int? buildNumber;
@override final  String? message;

/// Create a copy of RequiredVersionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RequiredVersionModelCopyWith<_RequiredVersionModel> get copyWith => __$RequiredVersionModelCopyWithImpl<_RequiredVersionModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RequiredVersionModel&&(identical(other.version, version) || other.version == version)&&(identical(other.buildNumber, buildNumber) || other.buildNumber == buildNumber)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,version,buildNumber,message);

@override
String toString() {
  return 'RequiredVersionModel(version: $version, buildNumber: $buildNumber, message: $message)';
}


}

/// @nodoc
abstract mixin class _$RequiredVersionModelCopyWith<$Res> implements $RequiredVersionModelCopyWith<$Res> {
  factory _$RequiredVersionModelCopyWith(_RequiredVersionModel value, $Res Function(_RequiredVersionModel) _then) = __$RequiredVersionModelCopyWithImpl;
@override @useResult
$Res call({
 String? version, int? buildNumber, String? message
});




}
/// @nodoc
class __$RequiredVersionModelCopyWithImpl<$Res>
    implements _$RequiredVersionModelCopyWith<$Res> {
  __$RequiredVersionModelCopyWithImpl(this._self, this._then);

  final _RequiredVersionModel _self;
  final $Res Function(_RequiredVersionModel) _then;

/// Create a copy of RequiredVersionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? version = freezed,Object? buildNumber = freezed,Object? message = freezed,}) {
  return _then(_RequiredVersionModel(
version: freezed == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String?,buildNumber: freezed == buildNumber ? _self.buildNumber : buildNumber // ignore: cast_nullable_to_non_nullable
as int?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
