// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ntp_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
NtpState _$NtpStateFromJson(
  Map<String, dynamic> json
) {
    return _NtpStateModel.fromJson(
      json
    );
}

/// @nodoc
mixin _$NtpState {

 int? get offset; DateTime? get updatedAt;
/// Create a copy of NtpState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NtpStateCopyWith<NtpState> get copyWith => _$NtpStateCopyWithImpl<NtpState>(this as NtpState, _$identity);

  /// Serializes this NtpState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NtpState&&(identical(other.offset, offset) || other.offset == offset)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,offset,updatedAt);

@override
String toString() {
  return 'NtpState(offset: $offset, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $NtpStateCopyWith<$Res>  {
  factory $NtpStateCopyWith(NtpState value, $Res Function(NtpState) _then) = _$NtpStateCopyWithImpl;
@useResult
$Res call({
 int? offset, DateTime? updatedAt
});




}
/// @nodoc
class _$NtpStateCopyWithImpl<$Res>
    implements $NtpStateCopyWith<$Res> {
  _$NtpStateCopyWithImpl(this._self, this._then);

  final NtpState _self;
  final $Res Function(NtpState) _then;

/// Create a copy of NtpState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? offset = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
offset: freezed == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as int?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [NtpState].
extension NtpStatePatterns on NtpState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NtpStateModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NtpStateModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NtpStateModel value)  $default,){
final _that = this;
switch (_that) {
case _NtpStateModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NtpStateModel value)?  $default,){
final _that = this;
switch (_that) {
case _NtpStateModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? offset,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NtpStateModel() when $default != null:
return $default(_that.offset,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? offset,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _NtpStateModel():
return $default(_that.offset,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? offset,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _NtpStateModel() when $default != null:
return $default(_that.offset,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NtpStateModel implements NtpState {
  const _NtpStateModel({this.offset, this.updatedAt});
  factory _NtpStateModel.fromJson(Map<String, dynamic> json) => _$NtpStateModelFromJson(json);

@override final  int? offset;
@override final  DateTime? updatedAt;

/// Create a copy of NtpState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NtpStateModelCopyWith<_NtpStateModel> get copyWith => __$NtpStateModelCopyWithImpl<_NtpStateModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NtpStateModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NtpStateModel&&(identical(other.offset, offset) || other.offset == offset)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,offset,updatedAt);

@override
String toString() {
  return 'NtpState(offset: $offset, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$NtpStateModelCopyWith<$Res> implements $NtpStateCopyWith<$Res> {
  factory _$NtpStateModelCopyWith(_NtpStateModel value, $Res Function(_NtpStateModel) _then) = __$NtpStateModelCopyWithImpl;
@override @useResult
$Res call({
 int? offset, DateTime? updatedAt
});




}
/// @nodoc
class __$NtpStateModelCopyWithImpl<$Res>
    implements _$NtpStateModelCopyWith<$Res> {
  __$NtpStateModelCopyWithImpl(this._self, this._then);

  final _NtpStateModel _self;
  final $Res Function(_NtpStateModel) _then;

/// Create a copy of NtpState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? offset = freezed,Object? updatedAt = freezed,}) {
  return _then(_NtpStateModel(
offset: freezed == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as int?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
