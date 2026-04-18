// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_configuration_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HomeConfigurationModel {

/// 位置情報を表示するかどうか
 bool get showLocation;/// ホーム地震履歴の表示スコープ
 HomeEarthquakeHistoryScope get earthquakeHistoryScope;
/// Create a copy of HomeConfigurationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeConfigurationModelCopyWith<HomeConfigurationModel> get copyWith => _$HomeConfigurationModelCopyWithImpl<HomeConfigurationModel>(this as HomeConfigurationModel, _$identity);

  /// Serializes this HomeConfigurationModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeConfigurationModel&&(identical(other.showLocation, showLocation) || other.showLocation == showLocation)&&(identical(other.earthquakeHistoryScope, earthquakeHistoryScope) || other.earthquakeHistoryScope == earthquakeHistoryScope));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,showLocation,earthquakeHistoryScope);

@override
String toString() {
  return 'HomeConfigurationModel(showLocation: $showLocation, earthquakeHistoryScope: $earthquakeHistoryScope)';
}


}

/// @nodoc
abstract mixin class $HomeConfigurationModelCopyWith<$Res>  {
  factory $HomeConfigurationModelCopyWith(HomeConfigurationModel value, $Res Function(HomeConfigurationModel) _then) = _$HomeConfigurationModelCopyWithImpl;
@useResult
$Res call({
 bool showLocation, HomeEarthquakeHistoryScope earthquakeHistoryScope
});




}
/// @nodoc
class _$HomeConfigurationModelCopyWithImpl<$Res>
    implements $HomeConfigurationModelCopyWith<$Res> {
  _$HomeConfigurationModelCopyWithImpl(this._self, this._then);

  final HomeConfigurationModel _self;
  final $Res Function(HomeConfigurationModel) _then;

/// Create a copy of HomeConfigurationModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? showLocation = null,Object? earthquakeHistoryScope = null,}) {
  return _then(_self.copyWith(
showLocation: null == showLocation ? _self.showLocation : showLocation // ignore: cast_nullable_to_non_nullable
as bool,earthquakeHistoryScope: null == earthquakeHistoryScope ? _self.earthquakeHistoryScope : earthquakeHistoryScope // ignore: cast_nullable_to_non_nullable
as HomeEarthquakeHistoryScope,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeConfigurationModel].
extension HomeConfigurationModelPatterns on HomeConfigurationModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeConfigurationModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeConfigurationModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeConfigurationModel value)  $default,){
final _that = this;
switch (_that) {
case _HomeConfigurationModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeConfigurationModel value)?  $default,){
final _that = this;
switch (_that) {
case _HomeConfigurationModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool showLocation,  HomeEarthquakeHistoryScope earthquakeHistoryScope)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeConfigurationModel() when $default != null:
return $default(_that.showLocation,_that.earthquakeHistoryScope);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool showLocation,  HomeEarthquakeHistoryScope earthquakeHistoryScope)  $default,) {final _that = this;
switch (_that) {
case _HomeConfigurationModel():
return $default(_that.showLocation,_that.earthquakeHistoryScope);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool showLocation,  HomeEarthquakeHistoryScope earthquakeHistoryScope)?  $default,) {final _that = this;
switch (_that) {
case _HomeConfigurationModel() when $default != null:
return $default(_that.showLocation,_that.earthquakeHistoryScope);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HomeConfigurationModel implements HomeConfigurationModel {
  const _HomeConfigurationModel({this.showLocation = false, this.earthquakeHistoryScope = HomeEarthquakeHistoryScope.nationwide});
  factory _HomeConfigurationModel.fromJson(Map<String, dynamic> json) => _$HomeConfigurationModelFromJson(json);

/// 位置情報を表示するかどうか
@override@JsonKey() final  bool showLocation;
/// ホーム地震履歴の表示スコープ
@override@JsonKey() final  HomeEarthquakeHistoryScope earthquakeHistoryScope;

/// Create a copy of HomeConfigurationModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeConfigurationModelCopyWith<_HomeConfigurationModel> get copyWith => __$HomeConfigurationModelCopyWithImpl<_HomeConfigurationModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HomeConfigurationModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeConfigurationModel&&(identical(other.showLocation, showLocation) || other.showLocation == showLocation)&&(identical(other.earthquakeHistoryScope, earthquakeHistoryScope) || other.earthquakeHistoryScope == earthquakeHistoryScope));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,showLocation,earthquakeHistoryScope);

@override
String toString() {
  return 'HomeConfigurationModel(showLocation: $showLocation, earthquakeHistoryScope: $earthquakeHistoryScope)';
}


}

/// @nodoc
abstract mixin class _$HomeConfigurationModelCopyWith<$Res> implements $HomeConfigurationModelCopyWith<$Res> {
  factory _$HomeConfigurationModelCopyWith(_HomeConfigurationModel value, $Res Function(_HomeConfigurationModel) _then) = __$HomeConfigurationModelCopyWithImpl;
@override @useResult
$Res call({
 bool showLocation, HomeEarthquakeHistoryScope earthquakeHistoryScope
});




}
/// @nodoc
class __$HomeConfigurationModelCopyWithImpl<$Res>
    implements _$HomeConfigurationModelCopyWith<$Res> {
  __$HomeConfigurationModelCopyWithImpl(this._self, this._then);

  final _HomeConfigurationModel _self;
  final $Res Function(_HomeConfigurationModel) _then;

/// Create a copy of HomeConfigurationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? showLocation = null,Object? earthquakeHistoryScope = null,}) {
  return _then(_HomeConfigurationModel(
showLocation: null == showLocation ? _self.showLocation : showLocation // ignore: cast_nullable_to_non_nullable
as bool,earthquakeHistoryScope: null == earthquakeHistoryScope ? _self.earthquakeHistoryScope : earthquakeHistoryScope // ignore: cast_nullable_to_non_nullable
as HomeEarthquakeHistoryScope,
  ));
}


}

// dart format on
