// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kyoshin_monitor_image_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$KyoshinMonitorImageRequest {

 RealtimeLayer get layer; KyoshinMonitorSource get source; KyoshinMonitorDelayProfile get delayProfile; bool get canSelectRealtimeLayer;
/// Create a copy of KyoshinMonitorImageRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KyoshinMonitorImageRequestCopyWith<KyoshinMonitorImageRequest> get copyWith => _$KyoshinMonitorImageRequestCopyWithImpl<KyoshinMonitorImageRequest>(this as KyoshinMonitorImageRequest, _$identity);

  /// Serializes this KyoshinMonitorImageRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KyoshinMonitorImageRequest&&(identical(other.layer, layer) || other.layer == layer)&&(identical(other.source, source) || other.source == source)&&(identical(other.delayProfile, delayProfile) || other.delayProfile == delayProfile)&&(identical(other.canSelectRealtimeLayer, canSelectRealtimeLayer) || other.canSelectRealtimeLayer == canSelectRealtimeLayer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,layer,source,delayProfile,canSelectRealtimeLayer);

@override
String toString() {
  return 'KyoshinMonitorImageRequest(layer: $layer, source: $source, delayProfile: $delayProfile, canSelectRealtimeLayer: $canSelectRealtimeLayer)';
}


}

/// @nodoc
abstract mixin class $KyoshinMonitorImageRequestCopyWith<$Res>  {
  factory $KyoshinMonitorImageRequestCopyWith(KyoshinMonitorImageRequest value, $Res Function(KyoshinMonitorImageRequest) _then) = _$KyoshinMonitorImageRequestCopyWithImpl;
@useResult
$Res call({
 RealtimeLayer layer, KyoshinMonitorSource source, KyoshinMonitorDelayProfile delayProfile, bool canSelectRealtimeLayer
});




}
/// @nodoc
class _$KyoshinMonitorImageRequestCopyWithImpl<$Res>
    implements $KyoshinMonitorImageRequestCopyWith<$Res> {
  _$KyoshinMonitorImageRequestCopyWithImpl(this._self, this._then);

  final KyoshinMonitorImageRequest _self;
  final $Res Function(KyoshinMonitorImageRequest) _then;

/// Create a copy of KyoshinMonitorImageRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? layer = null,Object? source = null,Object? delayProfile = null,Object? canSelectRealtimeLayer = null,}) {
  return _then(KyoshinMonitorImageRequest(
layer: null == layer ? _self.layer : layer // ignore: cast_nullable_to_non_nullable
as RealtimeLayer,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as KyoshinMonitorSource,delayProfile: null == delayProfile ? _self.delayProfile : delayProfile // ignore: cast_nullable_to_non_nullable
as KyoshinMonitorDelayProfile,canSelectRealtimeLayer: null == canSelectRealtimeLayer ? _self.canSelectRealtimeLayer : canSelectRealtimeLayer // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [KyoshinMonitorImageRequest].
extension KyoshinMonitorImageRequestPatterns on KyoshinMonitorImageRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KyoshinMonitorImageRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KyoshinMonitorImageRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KyoshinMonitorImageRequest value)  $default,){
final _that = this;
switch (_that) {
case _KyoshinMonitorImageRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KyoshinMonitorImageRequest value)?  $default,){
final _that = this;
switch (_that) {
case _KyoshinMonitorImageRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RealtimeLayer layer,  KyoshinMonitorSource source,  KyoshinMonitorDelayProfile delayProfile,  bool canSelectRealtimeLayer)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KyoshinMonitorImageRequest() when $default != null:
return $default(_that.layer,_that.source,_that.delayProfile,_that.canSelectRealtimeLayer);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RealtimeLayer layer,  KyoshinMonitorSource source,  KyoshinMonitorDelayProfile delayProfile,  bool canSelectRealtimeLayer)  $default,) {final _that = this;
switch (_that) {
case _KyoshinMonitorImageRequest():
return $default(_that.layer,_that.source,_that.delayProfile,_that.canSelectRealtimeLayer);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RealtimeLayer layer,  KyoshinMonitorSource source,  KyoshinMonitorDelayProfile delayProfile,  bool canSelectRealtimeLayer)?  $default,) {final _that = this;
switch (_that) {
case _KyoshinMonitorImageRequest() when $default != null:
return $default(_that.layer,_that.source,_that.delayProfile,_that.canSelectRealtimeLayer);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _KyoshinMonitorImageRequest implements KyoshinMonitorImageRequest {
  const _KyoshinMonitorImageRequest({required this.layer, required this.source, required this.delayProfile, required this.canSelectRealtimeLayer});
  factory _KyoshinMonitorImageRequest.fromJson(Map<String, dynamic> json) => _$KyoshinMonitorImageRequestFromJson(json);

@override final  RealtimeLayer layer;
@override final  KyoshinMonitorSource source;
@override final  KyoshinMonitorDelayProfile delayProfile;
@override final  bool canSelectRealtimeLayer;

/// Create a copy of KyoshinMonitorImageRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KyoshinMonitorImageRequestCopyWith<_KyoshinMonitorImageRequest> get copyWith => __$KyoshinMonitorImageRequestCopyWithImpl<_KyoshinMonitorImageRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KyoshinMonitorImageRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KyoshinMonitorImageRequest&&(identical(other.layer, layer) || other.layer == layer)&&(identical(other.source, source) || other.source == source)&&(identical(other.delayProfile, delayProfile) || other.delayProfile == delayProfile)&&(identical(other.canSelectRealtimeLayer, canSelectRealtimeLayer) || other.canSelectRealtimeLayer == canSelectRealtimeLayer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,layer,source,delayProfile,canSelectRealtimeLayer);

@override
String toString() {
  return 'KyoshinMonitorImageRequest(layer: $layer, source: $source, delayProfile: $delayProfile, canSelectRealtimeLayer: $canSelectRealtimeLayer)';
}


}

/// @nodoc
abstract mixin class _$KyoshinMonitorImageRequestCopyWith<$Res> implements $KyoshinMonitorImageRequestCopyWith<$Res> {
  factory _$KyoshinMonitorImageRequestCopyWith(_KyoshinMonitorImageRequest value, $Res Function(_KyoshinMonitorImageRequest) _then) = __$KyoshinMonitorImageRequestCopyWithImpl;
@override @useResult
$Res call({
 RealtimeLayer layer, KyoshinMonitorSource source, KyoshinMonitorDelayProfile delayProfile, bool canSelectRealtimeLayer
});




}
/// @nodoc
class __$KyoshinMonitorImageRequestCopyWithImpl<$Res>
    implements _$KyoshinMonitorImageRequestCopyWith<$Res> {
  __$KyoshinMonitorImageRequestCopyWithImpl(this._self, this._then);

  final _KyoshinMonitorImageRequest _self;
  final $Res Function(_KyoshinMonitorImageRequest) _then;

/// Create a copy of KyoshinMonitorImageRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? layer = null,Object? source = null,Object? delayProfile = null,Object? canSelectRealtimeLayer = null,}) {
  return _then(_KyoshinMonitorImageRequest(
layer: null == layer ? _self.layer : layer // ignore: cast_nullable_to_non_nullable
as RealtimeLayer,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as KyoshinMonitorSource,delayProfile: null == delayProfile ? _self.delayProfile : delayProfile // ignore: cast_nullable_to_non_nullable
as KyoshinMonitorDelayProfile,canSelectRealtimeLayer: null == canSelectRealtimeLayer ? _self.canSelectRealtimeLayer : canSelectRealtimeLayer // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
