// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'store_url_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StoreUrlModel {

 String get ios; String get android;
/// Create a copy of StoreUrlModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StoreUrlModelCopyWith<StoreUrlModel> get copyWith => _$StoreUrlModelCopyWithImpl<StoreUrlModel>(this as StoreUrlModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StoreUrlModel&&(identical(other.ios, ios) || other.ios == ios)&&(identical(other.android, android) || other.android == android));
}


@override
int get hashCode => Object.hash(runtimeType,ios,android);

@override
String toString() {
  return 'StoreUrlModel(ios: $ios, android: $android)';
}


}

/// @nodoc
abstract mixin class $StoreUrlModelCopyWith<$Res>  {
  factory $StoreUrlModelCopyWith(StoreUrlModel value, $Res Function(StoreUrlModel) _then) = _$StoreUrlModelCopyWithImpl;
@useResult
$Res call({
 String ios, String android
});




}
/// @nodoc
class _$StoreUrlModelCopyWithImpl<$Res>
    implements $StoreUrlModelCopyWith<$Res> {
  _$StoreUrlModelCopyWithImpl(this._self, this._then);

  final StoreUrlModel _self;
  final $Res Function(StoreUrlModel) _then;

/// Create a copy of StoreUrlModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ios = null,Object? android = null,}) {
  return _then(StoreUrlModel(
ios: null == ios ? _self.ios : ios // ignore: cast_nullable_to_non_nullable
as String,android: null == android ? _self.android : android // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [StoreUrlModel].
extension StoreUrlModelPatterns on StoreUrlModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StoreUrlModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StoreUrlModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StoreUrlModel value)  $default,){
final _that = this;
switch (_that) {
case _StoreUrlModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StoreUrlModel value)?  $default,){
final _that = this;
switch (_that) {
case _StoreUrlModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String ios,  String android)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StoreUrlModel() when $default != null:
return $default(_that.ios,_that.android);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String ios,  String android)  $default,) {final _that = this;
switch (_that) {
case _StoreUrlModel():
return $default(_that.ios,_that.android);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String ios,  String android)?  $default,) {final _that = this;
switch (_that) {
case _StoreUrlModel() when $default != null:
return $default(_that.ios,_that.android);case _:
  return null;

}
}

}

/// @nodoc


class _StoreUrlModel implements StoreUrlModel {
  const _StoreUrlModel({required this.ios, required this.android});
  

@override final  String ios;
@override final  String android;

/// Create a copy of StoreUrlModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StoreUrlModelCopyWith<_StoreUrlModel> get copyWith => __$StoreUrlModelCopyWithImpl<_StoreUrlModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StoreUrlModel&&(identical(other.ios, ios) || other.ios == ios)&&(identical(other.android, android) || other.android == android));
}


@override
int get hashCode => Object.hash(runtimeType,ios,android);

@override
String toString() {
  return 'StoreUrlModel(ios: $ios, android: $android)';
}


}

/// @nodoc
abstract mixin class _$StoreUrlModelCopyWith<$Res> implements $StoreUrlModelCopyWith<$Res> {
  factory _$StoreUrlModelCopyWith(_StoreUrlModel value, $Res Function(_StoreUrlModel) _then) = __$StoreUrlModelCopyWithImpl;
@override @useResult
$Res call({
 String ios, String android
});




}
/// @nodoc
class __$StoreUrlModelCopyWithImpl<$Res>
    implements _$StoreUrlModelCopyWith<$Res> {
  __$StoreUrlModelCopyWithImpl(this._self, this._then);

  final _StoreUrlModel _self;
  final $Res Function(_StoreUrlModel) _then;

/// Create a copy of StoreUrlModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ios = null,Object? android = null,}) {
  return _then(_StoreUrlModel(
ios: null == ios ? _self.ios : ios // ignore: cast_nullable_to_non_nullable
as String,android: null == android ? _self.android : android // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
