// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'forced_update_info_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ForcedUpdateInfoModel {

 List<RequiredVersionModel> get requiredVersions; StoreUrlModel get storeUrl;
/// Create a copy of ForcedUpdateInfoModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ForcedUpdateInfoModelCopyWith<ForcedUpdateInfoModel> get copyWith => _$ForcedUpdateInfoModelCopyWithImpl<ForcedUpdateInfoModel>(this as ForcedUpdateInfoModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForcedUpdateInfoModel&&const DeepCollectionEquality().equals(other.requiredVersions, requiredVersions)&&(identical(other.storeUrl, storeUrl) || other.storeUrl == storeUrl));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(requiredVersions),storeUrl);

@override
String toString() {
  return 'ForcedUpdateInfoModel(requiredVersions: $requiredVersions, storeUrl: $storeUrl)';
}


}

/// @nodoc
abstract mixin class $ForcedUpdateInfoModelCopyWith<$Res>  {
  factory $ForcedUpdateInfoModelCopyWith(ForcedUpdateInfoModel value, $Res Function(ForcedUpdateInfoModel) _then) = _$ForcedUpdateInfoModelCopyWithImpl;
@useResult
$Res call({
 List<RequiredVersionModel> requiredVersions, StoreUrlModel storeUrl
});


$StoreUrlModelCopyWith<$Res> get storeUrl;

}
/// @nodoc
class _$ForcedUpdateInfoModelCopyWithImpl<$Res>
    implements $ForcedUpdateInfoModelCopyWith<$Res> {
  _$ForcedUpdateInfoModelCopyWithImpl(this._self, this._then);

  final ForcedUpdateInfoModel _self;
  final $Res Function(ForcedUpdateInfoModel) _then;

/// Create a copy of ForcedUpdateInfoModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? requiredVersions = null,Object? storeUrl = null,}) {
  return _then(ForcedUpdateInfoModel(
requiredVersions: null == requiredVersions ? _self.requiredVersions : requiredVersions // ignore: cast_nullable_to_non_nullable
as List<RequiredVersionModel>,storeUrl: null == storeUrl ? _self.storeUrl : storeUrl // ignore: cast_nullable_to_non_nullable
as StoreUrlModel,
  ));
}
/// Create a copy of ForcedUpdateInfoModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StoreUrlModelCopyWith<$Res> get storeUrl {
  
  return $StoreUrlModelCopyWith<$Res>(_self.storeUrl, (value) {
    return _then(_self.copyWith(storeUrl: value));
  });
}
}


/// Adds pattern-matching-related methods to [ForcedUpdateInfoModel].
extension ForcedUpdateInfoModelPatterns on ForcedUpdateInfoModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ForcedUpdateInfoModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ForcedUpdateInfoModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ForcedUpdateInfoModel value)  $default,){
final _that = this;
switch (_that) {
case _ForcedUpdateInfoModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ForcedUpdateInfoModel value)?  $default,){
final _that = this;
switch (_that) {
case _ForcedUpdateInfoModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<RequiredVersionModel> requiredVersions,  StoreUrlModel storeUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ForcedUpdateInfoModel() when $default != null:
return $default(_that.requiredVersions,_that.storeUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<RequiredVersionModel> requiredVersions,  StoreUrlModel storeUrl)  $default,) {final _that = this;
switch (_that) {
case _ForcedUpdateInfoModel():
return $default(_that.requiredVersions,_that.storeUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<RequiredVersionModel> requiredVersions,  StoreUrlModel storeUrl)?  $default,) {final _that = this;
switch (_that) {
case _ForcedUpdateInfoModel() when $default != null:
return $default(_that.requiredVersions,_that.storeUrl);case _:
  return null;

}
}

}

/// @nodoc


class _ForcedUpdateInfoModel implements ForcedUpdateInfoModel {
  const _ForcedUpdateInfoModel({required  List<RequiredVersionModel> requiredVersions, required this.storeUrl}): _requiredVersions = requiredVersions;
  

 final  List<RequiredVersionModel> _requiredVersions;
@override List<RequiredVersionModel> get requiredVersions {
  if (_requiredVersions is EqualUnmodifiableListView) return _requiredVersions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_requiredVersions);
}

@override final  StoreUrlModel storeUrl;

/// Create a copy of ForcedUpdateInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ForcedUpdateInfoModelCopyWith<_ForcedUpdateInfoModel> get copyWith => __$ForcedUpdateInfoModelCopyWithImpl<_ForcedUpdateInfoModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ForcedUpdateInfoModel&&const DeepCollectionEquality().equals(other._requiredVersions, _requiredVersions)&&(identical(other.storeUrl, storeUrl) || other.storeUrl == storeUrl));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_requiredVersions),storeUrl);

@override
String toString() {
  return 'ForcedUpdateInfoModel(requiredVersions: $requiredVersions, storeUrl: $storeUrl)';
}


}

/// @nodoc
abstract mixin class _$ForcedUpdateInfoModelCopyWith<$Res> implements $ForcedUpdateInfoModelCopyWith<$Res> {
  factory _$ForcedUpdateInfoModelCopyWith(_ForcedUpdateInfoModel value, $Res Function(_ForcedUpdateInfoModel) _then) = __$ForcedUpdateInfoModelCopyWithImpl;
@override @useResult
$Res call({
 List<RequiredVersionModel> requiredVersions, StoreUrlModel storeUrl
});


@override $StoreUrlModelCopyWith<$Res> get storeUrl;

}
/// @nodoc
class __$ForcedUpdateInfoModelCopyWithImpl<$Res>
    implements _$ForcedUpdateInfoModelCopyWith<$Res> {
  __$ForcedUpdateInfoModelCopyWithImpl(this._self, this._then);

  final _ForcedUpdateInfoModel _self;
  final $Res Function(_ForcedUpdateInfoModel) _then;

/// Create a copy of ForcedUpdateInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? requiredVersions = null,Object? storeUrl = null,}) {
  return _then(_ForcedUpdateInfoModel(
requiredVersions: null == requiredVersions ? _self._requiredVersions : requiredVersions // ignore: cast_nullable_to_non_nullable
as List<RequiredVersionModel>,storeUrl: null == storeUrl ? _self.storeUrl : storeUrl // ignore: cast_nullable_to_non_nullable
as StoreUrlModel,
  ));
}

/// Create a copy of ForcedUpdateInfoModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StoreUrlModelCopyWith<$Res> get storeUrl {
  
  return $StoreUrlModelCopyWith<$Res>(_self.storeUrl, (value) {
    return _then(_self.copyWith(storeUrl: value));
  });
}
}

// dart format on
