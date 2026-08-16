// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ntp_config_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NtpConfigModel {

 String get lookUpAddress; Duration get timeout; Duration get interval;
/// Create a copy of NtpConfigModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NtpConfigModelCopyWith<NtpConfigModel> get copyWith => _$NtpConfigModelCopyWithImpl<NtpConfigModel>(this as NtpConfigModel, _$identity);

  /// Serializes this NtpConfigModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NtpConfigModel&&(identical(other.lookUpAddress, lookUpAddress) || other.lookUpAddress == lookUpAddress)&&(identical(other.timeout, timeout) || other.timeout == timeout)&&(identical(other.interval, interval) || other.interval == interval));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lookUpAddress,timeout,interval);

@override
String toString() {
  return 'NtpConfigModel(lookUpAddress: $lookUpAddress, timeout: $timeout, interval: $interval)';
}


}

/// @nodoc
abstract mixin class $NtpConfigModelCopyWith<$Res>  {
  factory $NtpConfigModelCopyWith(NtpConfigModel value, $Res Function(NtpConfigModel) _then) = _$NtpConfigModelCopyWithImpl;
@useResult
$Res call({
 String lookUpAddress, Duration timeout, Duration interval
});




}
/// @nodoc
class _$NtpConfigModelCopyWithImpl<$Res>
    implements $NtpConfigModelCopyWith<$Res> {
  _$NtpConfigModelCopyWithImpl(this._self, this._then);

  final NtpConfigModel _self;
  final $Res Function(NtpConfigModel) _then;

/// Create a copy of NtpConfigModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lookUpAddress = null,Object? timeout = null,Object? interval = null,}) {
  return _then(NtpConfigModel(
lookUpAddress: null == lookUpAddress ? _self.lookUpAddress : lookUpAddress // ignore: cast_nullable_to_non_nullable
as String,timeout: null == timeout ? _self.timeout : timeout // ignore: cast_nullable_to_non_nullable
as Duration,interval: null == interval ? _self.interval : interval // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}

}


/// Adds pattern-matching-related methods to [NtpConfigModel].
extension NtpConfigModelPatterns on NtpConfigModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NtpConfigModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NtpConfigModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NtpConfigModel value)  $default,){
final _that = this;
switch (_that) {
case _NtpConfigModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NtpConfigModel value)?  $default,){
final _that = this;
switch (_that) {
case _NtpConfigModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String lookUpAddress,  Duration timeout,  Duration interval)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NtpConfigModel() when $default != null:
return $default(_that.lookUpAddress,_that.timeout,_that.interval);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String lookUpAddress,  Duration timeout,  Duration interval)  $default,) {final _that = this;
switch (_that) {
case _NtpConfigModel():
return $default(_that.lookUpAddress,_that.timeout,_that.interval);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String lookUpAddress,  Duration timeout,  Duration interval)?  $default,) {final _that = this;
switch (_that) {
case _NtpConfigModel() when $default != null:
return $default(_that.lookUpAddress,_that.timeout,_that.interval);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NtpConfigModel implements NtpConfigModel {
  const _NtpConfigModel({this.lookUpAddress = 'ntp.nict.jp', this.timeout = const Duration(seconds: 10), this.interval = const Duration(minutes: 30)});
  factory _NtpConfigModel.fromJson(Map<String, dynamic> json) => _$NtpConfigModelFromJson(json);

@override@JsonKey() final  String lookUpAddress;
@override@JsonKey() final  Duration timeout;
@override@JsonKey() final  Duration interval;

/// Create a copy of NtpConfigModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NtpConfigModelCopyWith<_NtpConfigModel> get copyWith => __$NtpConfigModelCopyWithImpl<_NtpConfigModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NtpConfigModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NtpConfigModel&&(identical(other.lookUpAddress, lookUpAddress) || other.lookUpAddress == lookUpAddress)&&(identical(other.timeout, timeout) || other.timeout == timeout)&&(identical(other.interval, interval) || other.interval == interval));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lookUpAddress,timeout,interval);

@override
String toString() {
  return 'NtpConfigModel(lookUpAddress: $lookUpAddress, timeout: $timeout, interval: $interval)';
}


}

/// @nodoc
abstract mixin class _$NtpConfigModelCopyWith<$Res> implements $NtpConfigModelCopyWith<$Res> {
  factory _$NtpConfigModelCopyWith(_NtpConfigModel value, $Res Function(_NtpConfigModel) _then) = __$NtpConfigModelCopyWithImpl;
@override @useResult
$Res call({
 String lookUpAddress, Duration timeout, Duration interval
});




}
/// @nodoc
class __$NtpConfigModelCopyWithImpl<$Res>
    implements _$NtpConfigModelCopyWith<$Res> {
  __$NtpConfigModelCopyWithImpl(this._self, this._then);

  final _NtpConfigModel _self;
  final $Res Function(_NtpConfigModel) _then;

/// Create a copy of NtpConfigModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lookUpAddress = null,Object? timeout = null,Object? interval = null,}) {
  return _then(_NtpConfigModel(
lookUpAddress: null == lookUpAddress ? _self.lookUpAddress : lookUpAddress // ignore: cast_nullable_to_non_nullable
as String,timeout: null == timeout ? _self.timeout : timeout // ignore: cast_nullable_to_non_nullable
as Duration,interval: null == interval ? _self.interval : interval // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}


}

// dart format on
