// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'upsert_singleton_slot_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UpsertSingletonSlotRequest {

@JsonKey(includeIfNull: false, name: 'eew_enabled') bool? get eewEnabled;@JsonKey(includeIfNull: false, name: 'eew_min_intensity') JmaIntensity? get eewMinIntensity;@JsonKey(includeIfNull: false, name: 'eew_overrides') List<SlotOverride>? get eewOverrides;@JsonKey(includeIfNull: false, name: 'earthquake_enabled') bool? get earthquakeEnabled;@JsonKey(includeIfNull: false, name: 'earthquake_min_intensity') JmaIntensity? get earthquakeMinIntensity;@JsonKey(includeIfNull: false, name: 'earthquake_overrides') List<SlotOverride>? get earthquakeOverrides;
/// Create a copy of UpsertSingletonSlotRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpsertSingletonSlotRequestCopyWith<UpsertSingletonSlotRequest> get copyWith => _$UpsertSingletonSlotRequestCopyWithImpl<UpsertSingletonSlotRequest>(this as UpsertSingletonSlotRequest, _$identity);

  /// Serializes this UpsertSingletonSlotRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpsertSingletonSlotRequest&&(identical(other.eewEnabled, eewEnabled) || other.eewEnabled == eewEnabled)&&(identical(other.eewMinIntensity, eewMinIntensity) || other.eewMinIntensity == eewMinIntensity)&&const DeepCollectionEquality().equals(other.eewOverrides, eewOverrides)&&(identical(other.earthquakeEnabled, earthquakeEnabled) || other.earthquakeEnabled == earthquakeEnabled)&&(identical(other.earthquakeMinIntensity, earthquakeMinIntensity) || other.earthquakeMinIntensity == earthquakeMinIntensity)&&const DeepCollectionEquality().equals(other.earthquakeOverrides, earthquakeOverrides));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eewEnabled,eewMinIntensity,const DeepCollectionEquality().hash(eewOverrides),earthquakeEnabled,earthquakeMinIntensity,const DeepCollectionEquality().hash(earthquakeOverrides));

@override
String toString() {
  return 'UpsertSingletonSlotRequest(eewEnabled: $eewEnabled, eewMinIntensity: $eewMinIntensity, eewOverrides: $eewOverrides, earthquakeEnabled: $earthquakeEnabled, earthquakeMinIntensity: $earthquakeMinIntensity, earthquakeOverrides: $earthquakeOverrides)';
}


}

/// @nodoc
abstract mixin class $UpsertSingletonSlotRequestCopyWith<$Res>  {
  factory $UpsertSingletonSlotRequestCopyWith(UpsertSingletonSlotRequest value, $Res Function(UpsertSingletonSlotRequest) _then) = _$UpsertSingletonSlotRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeIfNull: false, name: 'eew_enabled') bool? eewEnabled,@JsonKey(includeIfNull: false, name: 'eew_min_intensity') JmaIntensity? eewMinIntensity,@JsonKey(includeIfNull: false, name: 'eew_overrides') List<SlotOverride>? eewOverrides,@JsonKey(includeIfNull: false, name: 'earthquake_enabled') bool? earthquakeEnabled,@JsonKey(includeIfNull: false, name: 'earthquake_min_intensity') JmaIntensity? earthquakeMinIntensity,@JsonKey(includeIfNull: false, name: 'earthquake_overrides') List<SlotOverride>? earthquakeOverrides
});




}
/// @nodoc
class _$UpsertSingletonSlotRequestCopyWithImpl<$Res>
    implements $UpsertSingletonSlotRequestCopyWith<$Res> {
  _$UpsertSingletonSlotRequestCopyWithImpl(this._self, this._then);

  final UpsertSingletonSlotRequest _self;
  final $Res Function(UpsertSingletonSlotRequest) _then;

/// Create a copy of UpsertSingletonSlotRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eewEnabled = freezed,Object? eewMinIntensity = freezed,Object? eewOverrides = freezed,Object? earthquakeEnabled = freezed,Object? earthquakeMinIntensity = freezed,Object? earthquakeOverrides = freezed,}) {
  return _then(UpsertSingletonSlotRequest(
eewEnabled: freezed == eewEnabled ? _self.eewEnabled : eewEnabled // ignore: cast_nullable_to_non_nullable
as bool?,eewMinIntensity: freezed == eewMinIntensity ? _self.eewMinIntensity : eewMinIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,eewOverrides: freezed == eewOverrides ? _self.eewOverrides : eewOverrides // ignore: cast_nullable_to_non_nullable
as List<SlotOverride>?,earthquakeEnabled: freezed == earthquakeEnabled ? _self.earthquakeEnabled : earthquakeEnabled // ignore: cast_nullable_to_non_nullable
as bool?,earthquakeMinIntensity: freezed == earthquakeMinIntensity ? _self.earthquakeMinIntensity : earthquakeMinIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,earthquakeOverrides: freezed == earthquakeOverrides ? _self.earthquakeOverrides : earthquakeOverrides // ignore: cast_nullable_to_non_nullable
as List<SlotOverride>?,
  ));
}

}


/// Adds pattern-matching-related methods to [UpsertSingletonSlotRequest].
extension UpsertSingletonSlotRequestPatterns on UpsertSingletonSlotRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpsertSingletonSlotRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpsertSingletonSlotRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpsertSingletonSlotRequest value)  $default,){
final _that = this;
switch (_that) {
case _UpsertSingletonSlotRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpsertSingletonSlotRequest value)?  $default,){
final _that = this;
switch (_that) {
case _UpsertSingletonSlotRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false, name: 'eew_enabled')  bool? eewEnabled, @JsonKey(includeIfNull: false, name: 'eew_min_intensity')  JmaIntensity? eewMinIntensity, @JsonKey(includeIfNull: false, name: 'eew_overrides')  List<SlotOverride>? eewOverrides, @JsonKey(includeIfNull: false, name: 'earthquake_enabled')  bool? earthquakeEnabled, @JsonKey(includeIfNull: false, name: 'earthquake_min_intensity')  JmaIntensity? earthquakeMinIntensity, @JsonKey(includeIfNull: false, name: 'earthquake_overrides')  List<SlotOverride>? earthquakeOverrides)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpsertSingletonSlotRequest() when $default != null:
return $default(_that.eewEnabled,_that.eewMinIntensity,_that.eewOverrides,_that.earthquakeEnabled,_that.earthquakeMinIntensity,_that.earthquakeOverrides);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false, name: 'eew_enabled')  bool? eewEnabled, @JsonKey(includeIfNull: false, name: 'eew_min_intensity')  JmaIntensity? eewMinIntensity, @JsonKey(includeIfNull: false, name: 'eew_overrides')  List<SlotOverride>? eewOverrides, @JsonKey(includeIfNull: false, name: 'earthquake_enabled')  bool? earthquakeEnabled, @JsonKey(includeIfNull: false, name: 'earthquake_min_intensity')  JmaIntensity? earthquakeMinIntensity, @JsonKey(includeIfNull: false, name: 'earthquake_overrides')  List<SlotOverride>? earthquakeOverrides)  $default,) {final _that = this;
switch (_that) {
case _UpsertSingletonSlotRequest():
return $default(_that.eewEnabled,_that.eewMinIntensity,_that.eewOverrides,_that.earthquakeEnabled,_that.earthquakeMinIntensity,_that.earthquakeOverrides);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeIfNull: false, name: 'eew_enabled')  bool? eewEnabled, @JsonKey(includeIfNull: false, name: 'eew_min_intensity')  JmaIntensity? eewMinIntensity, @JsonKey(includeIfNull: false, name: 'eew_overrides')  List<SlotOverride>? eewOverrides, @JsonKey(includeIfNull: false, name: 'earthquake_enabled')  bool? earthquakeEnabled, @JsonKey(includeIfNull: false, name: 'earthquake_min_intensity')  JmaIntensity? earthquakeMinIntensity, @JsonKey(includeIfNull: false, name: 'earthquake_overrides')  List<SlotOverride>? earthquakeOverrides)?  $default,) {final _that = this;
switch (_that) {
case _UpsertSingletonSlotRequest() when $default != null:
return $default(_that.eewEnabled,_that.eewMinIntensity,_that.eewOverrides,_that.earthquakeEnabled,_that.earthquakeMinIntensity,_that.earthquakeOverrides);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpsertSingletonSlotRequest implements UpsertSingletonSlotRequest {
  const _UpsertSingletonSlotRequest({@JsonKey(includeIfNull: false, name: 'eew_enabled') this.eewEnabled, @JsonKey(includeIfNull: false, name: 'eew_min_intensity') this.eewMinIntensity, @JsonKey(includeIfNull: false, name: 'eew_overrides')  List<SlotOverride>? eewOverrides, @JsonKey(includeIfNull: false, name: 'earthquake_enabled') this.earthquakeEnabled, @JsonKey(includeIfNull: false, name: 'earthquake_min_intensity') this.earthquakeMinIntensity, @JsonKey(includeIfNull: false, name: 'earthquake_overrides')  List<SlotOverride>? earthquakeOverrides}): _eewOverrides = eewOverrides,_earthquakeOverrides = earthquakeOverrides;
  factory _UpsertSingletonSlotRequest.fromJson(Map<String, dynamic> json) => _$UpsertSingletonSlotRequestFromJson(json);

@override@JsonKey(includeIfNull: false, name: 'eew_enabled') final  bool? eewEnabled;
@override@JsonKey(includeIfNull: false, name: 'eew_min_intensity') final  JmaIntensity? eewMinIntensity;
 final  List<SlotOverride>? _eewOverrides;
@override@JsonKey(includeIfNull: false, name: 'eew_overrides') List<SlotOverride>? get eewOverrides {
  final value = _eewOverrides;
  if (value == null) return null;
  if (_eewOverrides is EqualUnmodifiableListView) return _eewOverrides;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(includeIfNull: false, name: 'earthquake_enabled') final  bool? earthquakeEnabled;
@override@JsonKey(includeIfNull: false, name: 'earthquake_min_intensity') final  JmaIntensity? earthquakeMinIntensity;
 final  List<SlotOverride>? _earthquakeOverrides;
@override@JsonKey(includeIfNull: false, name: 'earthquake_overrides') List<SlotOverride>? get earthquakeOverrides {
  final value = _earthquakeOverrides;
  if (value == null) return null;
  if (_earthquakeOverrides is EqualUnmodifiableListView) return _earthquakeOverrides;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of UpsertSingletonSlotRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpsertSingletonSlotRequestCopyWith<_UpsertSingletonSlotRequest> get copyWith => __$UpsertSingletonSlotRequestCopyWithImpl<_UpsertSingletonSlotRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpsertSingletonSlotRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpsertSingletonSlotRequest&&(identical(other.eewEnabled, eewEnabled) || other.eewEnabled == eewEnabled)&&(identical(other.eewMinIntensity, eewMinIntensity) || other.eewMinIntensity == eewMinIntensity)&&const DeepCollectionEquality().equals(other._eewOverrides, _eewOverrides)&&(identical(other.earthquakeEnabled, earthquakeEnabled) || other.earthquakeEnabled == earthquakeEnabled)&&(identical(other.earthquakeMinIntensity, earthquakeMinIntensity) || other.earthquakeMinIntensity == earthquakeMinIntensity)&&const DeepCollectionEquality().equals(other._earthquakeOverrides, _earthquakeOverrides));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eewEnabled,eewMinIntensity,const DeepCollectionEquality().hash(_eewOverrides),earthquakeEnabled,earthquakeMinIntensity,const DeepCollectionEquality().hash(_earthquakeOverrides));

@override
String toString() {
  return 'UpsertSingletonSlotRequest(eewEnabled: $eewEnabled, eewMinIntensity: $eewMinIntensity, eewOverrides: $eewOverrides, earthquakeEnabled: $earthquakeEnabled, earthquakeMinIntensity: $earthquakeMinIntensity, earthquakeOverrides: $earthquakeOverrides)';
}


}

/// @nodoc
abstract mixin class _$UpsertSingletonSlotRequestCopyWith<$Res> implements $UpsertSingletonSlotRequestCopyWith<$Res> {
  factory _$UpsertSingletonSlotRequestCopyWith(_UpsertSingletonSlotRequest value, $Res Function(_UpsertSingletonSlotRequest) _then) = __$UpsertSingletonSlotRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeIfNull: false, name: 'eew_enabled') bool? eewEnabled,@JsonKey(includeIfNull: false, name: 'eew_min_intensity') JmaIntensity? eewMinIntensity,@JsonKey(includeIfNull: false, name: 'eew_overrides') List<SlotOverride>? eewOverrides,@JsonKey(includeIfNull: false, name: 'earthquake_enabled') bool? earthquakeEnabled,@JsonKey(includeIfNull: false, name: 'earthquake_min_intensity') JmaIntensity? earthquakeMinIntensity,@JsonKey(includeIfNull: false, name: 'earthquake_overrides') List<SlotOverride>? earthquakeOverrides
});




}
/// @nodoc
class __$UpsertSingletonSlotRequestCopyWithImpl<$Res>
    implements _$UpsertSingletonSlotRequestCopyWith<$Res> {
  __$UpsertSingletonSlotRequestCopyWithImpl(this._self, this._then);

  final _UpsertSingletonSlotRequest _self;
  final $Res Function(_UpsertSingletonSlotRequest) _then;

/// Create a copy of UpsertSingletonSlotRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eewEnabled = freezed,Object? eewMinIntensity = freezed,Object? eewOverrides = freezed,Object? earthquakeEnabled = freezed,Object? earthquakeMinIntensity = freezed,Object? earthquakeOverrides = freezed,}) {
  return _then(_UpsertSingletonSlotRequest(
eewEnabled: freezed == eewEnabled ? _self.eewEnabled : eewEnabled // ignore: cast_nullable_to_non_nullable
as bool?,eewMinIntensity: freezed == eewMinIntensity ? _self.eewMinIntensity : eewMinIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,eewOverrides: freezed == eewOverrides ? _self._eewOverrides : eewOverrides // ignore: cast_nullable_to_non_nullable
as List<SlotOverride>?,earthquakeEnabled: freezed == earthquakeEnabled ? _self.earthquakeEnabled : earthquakeEnabled // ignore: cast_nullable_to_non_nullable
as bool?,earthquakeMinIntensity: freezed == earthquakeMinIntensity ? _self.earthquakeMinIntensity : earthquakeMinIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,earthquakeOverrides: freezed == earthquakeOverrides ? _self._earthquakeOverrides : earthquakeOverrides // ignore: cast_nullable_to_non_nullable
as List<SlotOverride>?,
  ));
}


}

// dart format on
