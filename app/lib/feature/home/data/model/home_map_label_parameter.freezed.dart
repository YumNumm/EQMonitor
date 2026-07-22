// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_map_label_parameter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HomeMapLabelParameter {

 bool get showRegionLabel; bool get showCityLabel; double get regionLabelMinZoom; double get cityLabelMinZoom; double get regionTextSize; double get cityTextSize; double get textHaloWidth;
/// Create a copy of HomeMapLabelParameter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeMapLabelParameterCopyWith<HomeMapLabelParameter> get copyWith => _$HomeMapLabelParameterCopyWithImpl<HomeMapLabelParameter>(this as HomeMapLabelParameter, _$identity);

  /// Serializes this HomeMapLabelParameter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeMapLabelParameter&&(identical(other.showRegionLabel, showRegionLabel) || other.showRegionLabel == showRegionLabel)&&(identical(other.showCityLabel, showCityLabel) || other.showCityLabel == showCityLabel)&&(identical(other.regionLabelMinZoom, regionLabelMinZoom) || other.regionLabelMinZoom == regionLabelMinZoom)&&(identical(other.cityLabelMinZoom, cityLabelMinZoom) || other.cityLabelMinZoom == cityLabelMinZoom)&&(identical(other.regionTextSize, regionTextSize) || other.regionTextSize == regionTextSize)&&(identical(other.cityTextSize, cityTextSize) || other.cityTextSize == cityTextSize)&&(identical(other.textHaloWidth, textHaloWidth) || other.textHaloWidth == textHaloWidth));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,showRegionLabel,showCityLabel,regionLabelMinZoom,cityLabelMinZoom,regionTextSize,cityTextSize,textHaloWidth);

@override
String toString() {
  return 'HomeMapLabelParameter(showRegionLabel: $showRegionLabel, showCityLabel: $showCityLabel, regionLabelMinZoom: $regionLabelMinZoom, cityLabelMinZoom: $cityLabelMinZoom, regionTextSize: $regionTextSize, cityTextSize: $cityTextSize, textHaloWidth: $textHaloWidth)';
}


}

/// @nodoc
abstract mixin class $HomeMapLabelParameterCopyWith<$Res>  {
  factory $HomeMapLabelParameterCopyWith(HomeMapLabelParameter value, $Res Function(HomeMapLabelParameter) _then) = _$HomeMapLabelParameterCopyWithImpl;
@useResult
$Res call({
 bool showRegionLabel, bool showCityLabel, double regionLabelMinZoom, double cityLabelMinZoom, double regionTextSize, double cityTextSize, double textHaloWidth
});




}
/// @nodoc
class _$HomeMapLabelParameterCopyWithImpl<$Res>
    implements $HomeMapLabelParameterCopyWith<$Res> {
  _$HomeMapLabelParameterCopyWithImpl(this._self, this._then);

  final HomeMapLabelParameter _self;
  final $Res Function(HomeMapLabelParameter) _then;

/// Create a copy of HomeMapLabelParameter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? showRegionLabel = null,Object? showCityLabel = null,Object? regionLabelMinZoom = null,Object? cityLabelMinZoom = null,Object? regionTextSize = null,Object? cityTextSize = null,Object? textHaloWidth = null,}) {
  return _then(_self.copyWith(
showRegionLabel: null == showRegionLabel ? _self.showRegionLabel : showRegionLabel // ignore: cast_nullable_to_non_nullable
as bool,showCityLabel: null == showCityLabel ? _self.showCityLabel : showCityLabel // ignore: cast_nullable_to_non_nullable
as bool,regionLabelMinZoom: null == regionLabelMinZoom ? _self.regionLabelMinZoom : regionLabelMinZoom // ignore: cast_nullable_to_non_nullable
as double,cityLabelMinZoom: null == cityLabelMinZoom ? _self.cityLabelMinZoom : cityLabelMinZoom // ignore: cast_nullable_to_non_nullable
as double,regionTextSize: null == regionTextSize ? _self.regionTextSize : regionTextSize // ignore: cast_nullable_to_non_nullable
as double,cityTextSize: null == cityTextSize ? _self.cityTextSize : cityTextSize // ignore: cast_nullable_to_non_nullable
as double,textHaloWidth: null == textHaloWidth ? _self.textHaloWidth : textHaloWidth // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeMapLabelParameter].
extension HomeMapLabelParameterPatterns on HomeMapLabelParameter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeMapLabelParameter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeMapLabelParameter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeMapLabelParameter value)  $default,){
final _that = this;
switch (_that) {
case _HomeMapLabelParameter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeMapLabelParameter value)?  $default,){
final _that = this;
switch (_that) {
case _HomeMapLabelParameter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool showRegionLabel,  bool showCityLabel,  double regionLabelMinZoom,  double cityLabelMinZoom,  double regionTextSize,  double cityTextSize,  double textHaloWidth)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeMapLabelParameter() when $default != null:
return $default(_that.showRegionLabel,_that.showCityLabel,_that.regionLabelMinZoom,_that.cityLabelMinZoom,_that.regionTextSize,_that.cityTextSize,_that.textHaloWidth);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool showRegionLabel,  bool showCityLabel,  double regionLabelMinZoom,  double cityLabelMinZoom,  double regionTextSize,  double cityTextSize,  double textHaloWidth)  $default,) {final _that = this;
switch (_that) {
case _HomeMapLabelParameter():
return $default(_that.showRegionLabel,_that.showCityLabel,_that.regionLabelMinZoom,_that.cityLabelMinZoom,_that.regionTextSize,_that.cityTextSize,_that.textHaloWidth);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool showRegionLabel,  bool showCityLabel,  double regionLabelMinZoom,  double cityLabelMinZoom,  double regionTextSize,  double cityTextSize,  double textHaloWidth)?  $default,) {final _that = this;
switch (_that) {
case _HomeMapLabelParameter() when $default != null:
return $default(_that.showRegionLabel,_that.showCityLabel,_that.regionLabelMinZoom,_that.cityLabelMinZoom,_that.regionTextSize,_that.cityTextSize,_that.textHaloWidth);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HomeMapLabelParameter implements HomeMapLabelParameter {
  const _HomeMapLabelParameter({this.showRegionLabel = false, this.showCityLabel = false, this.regionLabelMinZoom = 5.0, this.cityLabelMinZoom = 9.0, this.regionTextSize = 14, this.cityTextSize = 12, this.textHaloWidth = 1.0});
  factory _HomeMapLabelParameter.fromJson(Map<String, dynamic> json) => _$HomeMapLabelParameterFromJson(json);

@override@JsonKey() final  bool showRegionLabel;
@override@JsonKey() final  bool showCityLabel;
@override@JsonKey() final  double regionLabelMinZoom;
@override@JsonKey() final  double cityLabelMinZoom;
@override@JsonKey() final  double regionTextSize;
@override@JsonKey() final  double cityTextSize;
@override@JsonKey() final  double textHaloWidth;

/// Create a copy of HomeMapLabelParameter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeMapLabelParameterCopyWith<_HomeMapLabelParameter> get copyWith => __$HomeMapLabelParameterCopyWithImpl<_HomeMapLabelParameter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HomeMapLabelParameterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeMapLabelParameter&&(identical(other.showRegionLabel, showRegionLabel) || other.showRegionLabel == showRegionLabel)&&(identical(other.showCityLabel, showCityLabel) || other.showCityLabel == showCityLabel)&&(identical(other.regionLabelMinZoom, regionLabelMinZoom) || other.regionLabelMinZoom == regionLabelMinZoom)&&(identical(other.cityLabelMinZoom, cityLabelMinZoom) || other.cityLabelMinZoom == cityLabelMinZoom)&&(identical(other.regionTextSize, regionTextSize) || other.regionTextSize == regionTextSize)&&(identical(other.cityTextSize, cityTextSize) || other.cityTextSize == cityTextSize)&&(identical(other.textHaloWidth, textHaloWidth) || other.textHaloWidth == textHaloWidth));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,showRegionLabel,showCityLabel,regionLabelMinZoom,cityLabelMinZoom,regionTextSize,cityTextSize,textHaloWidth);

@override
String toString() {
  return 'HomeMapLabelParameter(showRegionLabel: $showRegionLabel, showCityLabel: $showCityLabel, regionLabelMinZoom: $regionLabelMinZoom, cityLabelMinZoom: $cityLabelMinZoom, regionTextSize: $regionTextSize, cityTextSize: $cityTextSize, textHaloWidth: $textHaloWidth)';
}


}

/// @nodoc
abstract mixin class _$HomeMapLabelParameterCopyWith<$Res> implements $HomeMapLabelParameterCopyWith<$Res> {
  factory _$HomeMapLabelParameterCopyWith(_HomeMapLabelParameter value, $Res Function(_HomeMapLabelParameter) _then) = __$HomeMapLabelParameterCopyWithImpl;
@override @useResult
$Res call({
 bool showRegionLabel, bool showCityLabel, double regionLabelMinZoom, double cityLabelMinZoom, double regionTextSize, double cityTextSize, double textHaloWidth
});




}
/// @nodoc
class __$HomeMapLabelParameterCopyWithImpl<$Res>
    implements _$HomeMapLabelParameterCopyWith<$Res> {
  __$HomeMapLabelParameterCopyWithImpl(this._self, this._then);

  final _HomeMapLabelParameter _self;
  final $Res Function(_HomeMapLabelParameter) _then;

/// Create a copy of HomeMapLabelParameter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? showRegionLabel = null,Object? showCityLabel = null,Object? regionLabelMinZoom = null,Object? cityLabelMinZoom = null,Object? regionTextSize = null,Object? cityTextSize = null,Object? textHaloWidth = null,}) {
  return _then(_HomeMapLabelParameter(
showRegionLabel: null == showRegionLabel ? _self.showRegionLabel : showRegionLabel // ignore: cast_nullable_to_non_nullable
as bool,showCityLabel: null == showCityLabel ? _self.showCityLabel : showCityLabel // ignore: cast_nullable_to_non_nullable
as bool,regionLabelMinZoom: null == regionLabelMinZoom ? _self.regionLabelMinZoom : regionLabelMinZoom // ignore: cast_nullable_to_non_nullable
as double,cityLabelMinZoom: null == cityLabelMinZoom ? _self.cityLabelMinZoom : cityLabelMinZoom // ignore: cast_nullable_to_non_nullable
as double,regionTextSize: null == regionTextSize ? _self.regionTextSize : regionTextSize // ignore: cast_nullable_to_non_nullable
as double,cityTextSize: null == cityTextSize ? _self.cityTextSize : cityTextSize // ignore: cast_nullable_to_non_nullable
as double,textHaloWidth: null == textHaloWidth ? _self.textHaloWidth : textHaloWidth // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
