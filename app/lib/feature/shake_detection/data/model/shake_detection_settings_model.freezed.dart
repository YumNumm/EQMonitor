// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shake_detection_settings_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ShakeDetectionSettingsModel {

/// 端末内で揺れ検知を行うかどうか
 bool get isEnabled;/// 検知の履歴が途切れたとき、直近のフレームを裏で取得して履歴を作り直すかどうか
 bool get isBackfillEnabled;/// `ShakeDetectionTunable.name` をキーとする、初期値から変更したパラメータ
 Map<String, double> get parameterOverrides;
/// Create a copy of ShakeDetectionSettingsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShakeDetectionSettingsModelCopyWith<ShakeDetectionSettingsModel> get copyWith => _$ShakeDetectionSettingsModelCopyWithImpl<ShakeDetectionSettingsModel>(this as ShakeDetectionSettingsModel, _$identity);

  /// Serializes this ShakeDetectionSettingsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShakeDetectionSettingsModel&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled)&&(identical(other.isBackfillEnabled, isBackfillEnabled) || other.isBackfillEnabled == isBackfillEnabled)&&const DeepCollectionEquality().equals(other.parameterOverrides, parameterOverrides));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isEnabled,isBackfillEnabled,const DeepCollectionEquality().hash(parameterOverrides));

@override
String toString() {
  return 'ShakeDetectionSettingsModel(isEnabled: $isEnabled, isBackfillEnabled: $isBackfillEnabled, parameterOverrides: $parameterOverrides)';
}


}

/// @nodoc
abstract mixin class $ShakeDetectionSettingsModelCopyWith<$Res>  {
  factory $ShakeDetectionSettingsModelCopyWith(ShakeDetectionSettingsModel value, $Res Function(ShakeDetectionSettingsModel) _then) = _$ShakeDetectionSettingsModelCopyWithImpl;
@useResult
$Res call({
 bool isEnabled, bool isBackfillEnabled, Map<String, double> parameterOverrides
});




}
/// @nodoc
class _$ShakeDetectionSettingsModelCopyWithImpl<$Res>
    implements $ShakeDetectionSettingsModelCopyWith<$Res> {
  _$ShakeDetectionSettingsModelCopyWithImpl(this._self, this._then);

  final ShakeDetectionSettingsModel _self;
  final $Res Function(ShakeDetectionSettingsModel) _then;

/// Create a copy of ShakeDetectionSettingsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isEnabled = null,Object? isBackfillEnabled = null,Object? parameterOverrides = null,}) {
  return _then(ShakeDetectionSettingsModel(
isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,isBackfillEnabled: null == isBackfillEnabled ? _self.isBackfillEnabled : isBackfillEnabled // ignore: cast_nullable_to_non_nullable
as bool,parameterOverrides: null == parameterOverrides ? _self.parameterOverrides : parameterOverrides // ignore: cast_nullable_to_non_nullable
as Map<String, double>,
  ));
}

}


/// Adds pattern-matching-related methods to [ShakeDetectionSettingsModel].
extension ShakeDetectionSettingsModelPatterns on ShakeDetectionSettingsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShakeDetectionSettingsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShakeDetectionSettingsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShakeDetectionSettingsModel value)  $default,){
final _that = this;
switch (_that) {
case _ShakeDetectionSettingsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShakeDetectionSettingsModel value)?  $default,){
final _that = this;
switch (_that) {
case _ShakeDetectionSettingsModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isEnabled,  bool isBackfillEnabled,  Map<String, double> parameterOverrides)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShakeDetectionSettingsModel() when $default != null:
return $default(_that.isEnabled,_that.isBackfillEnabled,_that.parameterOverrides);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isEnabled,  bool isBackfillEnabled,  Map<String, double> parameterOverrides)  $default,) {final _that = this;
switch (_that) {
case _ShakeDetectionSettingsModel():
return $default(_that.isEnabled,_that.isBackfillEnabled,_that.parameterOverrides);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isEnabled,  bool isBackfillEnabled,  Map<String, double> parameterOverrides)?  $default,) {final _that = this;
switch (_that) {
case _ShakeDetectionSettingsModel() when $default != null:
return $default(_that.isEnabled,_that.isBackfillEnabled,_that.parameterOverrides);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ShakeDetectionSettingsModel implements ShakeDetectionSettingsModel {
  const _ShakeDetectionSettingsModel({this.isEnabled = true, this.isBackfillEnabled = true,  Map<String, double> parameterOverrides = const <String, double>{}}): _parameterOverrides = parameterOverrides;
  factory _ShakeDetectionSettingsModel.fromJson(Map<String, dynamic> json) => _$ShakeDetectionSettingsModelFromJson(json);

/// 端末内で揺れ検知を行うかどうか
@override@JsonKey() final  bool isEnabled;
/// 検知の履歴が途切れたとき、直近のフレームを裏で取得して履歴を作り直すかどうか
@override@JsonKey() final  bool isBackfillEnabled;
/// `ShakeDetectionTunable.name` をキーとする、初期値から変更したパラメータ
 final  Map<String, double> _parameterOverrides;
/// `ShakeDetectionTunable.name` をキーとする、初期値から変更したパラメータ
@override@JsonKey() Map<String, double> get parameterOverrides {
  if (_parameterOverrides is EqualUnmodifiableMapView) return _parameterOverrides;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_parameterOverrides);
}


/// Create a copy of ShakeDetectionSettingsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShakeDetectionSettingsModelCopyWith<_ShakeDetectionSettingsModel> get copyWith => __$ShakeDetectionSettingsModelCopyWithImpl<_ShakeDetectionSettingsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShakeDetectionSettingsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShakeDetectionSettingsModel&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled)&&(identical(other.isBackfillEnabled, isBackfillEnabled) || other.isBackfillEnabled == isBackfillEnabled)&&const DeepCollectionEquality().equals(other._parameterOverrides, _parameterOverrides));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isEnabled,isBackfillEnabled,const DeepCollectionEquality().hash(_parameterOverrides));

@override
String toString() {
  return 'ShakeDetectionSettingsModel(isEnabled: $isEnabled, isBackfillEnabled: $isBackfillEnabled, parameterOverrides: $parameterOverrides)';
}


}

/// @nodoc
abstract mixin class _$ShakeDetectionSettingsModelCopyWith<$Res> implements $ShakeDetectionSettingsModelCopyWith<$Res> {
  factory _$ShakeDetectionSettingsModelCopyWith(_ShakeDetectionSettingsModel value, $Res Function(_ShakeDetectionSettingsModel) _then) = __$ShakeDetectionSettingsModelCopyWithImpl;
@override @useResult
$Res call({
 bool isEnabled, bool isBackfillEnabled, Map<String, double> parameterOverrides
});




}
/// @nodoc
class __$ShakeDetectionSettingsModelCopyWithImpl<$Res>
    implements _$ShakeDetectionSettingsModelCopyWith<$Res> {
  __$ShakeDetectionSettingsModelCopyWithImpl(this._self, this._then);

  final _ShakeDetectionSettingsModel _self;
  final $Res Function(_ShakeDetectionSettingsModel) _then;

/// Create a copy of ShakeDetectionSettingsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isEnabled = null,Object? isBackfillEnabled = null,Object? parameterOverrides = null,}) {
  return _then(_ShakeDetectionSettingsModel(
isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,isBackfillEnabled: null == isBackfillEnabled ? _self.isBackfillEnabled : isBackfillEnabled // ignore: cast_nullable_to_non_nullable
as bool,parameterOverrides: null == parameterOverrides ? _self._parameterOverrides : parameterOverrides // ignore: cast_nullable_to_non_nullable
as Map<String, double>,
  ));
}


}

// dart format on
