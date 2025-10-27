// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_token.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationTokenModel implements DiagnosticableTreeMixin {

 String? get fcmToken; String? get apnsToken;
/// Create a copy of NotificationTokenModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationTokenModelCopyWith<NotificationTokenModel> get copyWith => _$NotificationTokenModelCopyWithImpl<NotificationTokenModel>(this as NotificationTokenModel, _$identity);

  /// Serializes this NotificationTokenModel to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'NotificationTokenModel'))
    ..add(DiagnosticsProperty('fcmToken', fcmToken))..add(DiagnosticsProperty('apnsToken', apnsToken));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationTokenModel&&(identical(other.fcmToken, fcmToken) || other.fcmToken == fcmToken)&&(identical(other.apnsToken, apnsToken) || other.apnsToken == apnsToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fcmToken,apnsToken);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'NotificationTokenModel(fcmToken: $fcmToken, apnsToken: $apnsToken)';
}


}

/// @nodoc
abstract mixin class $NotificationTokenModelCopyWith<$Res>  {
  factory $NotificationTokenModelCopyWith(NotificationTokenModel value, $Res Function(NotificationTokenModel) _then) = _$NotificationTokenModelCopyWithImpl;
@useResult
$Res call({
 String? fcmToken, String? apnsToken
});




}
/// @nodoc
class _$NotificationTokenModelCopyWithImpl<$Res>
    implements $NotificationTokenModelCopyWith<$Res> {
  _$NotificationTokenModelCopyWithImpl(this._self, this._then);

  final NotificationTokenModel _self;
  final $Res Function(NotificationTokenModel) _then;

/// Create a copy of NotificationTokenModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fcmToken = freezed,Object? apnsToken = freezed,}) {
  return _then(_self.copyWith(
fcmToken: freezed == fcmToken ? _self.fcmToken : fcmToken // ignore: cast_nullable_to_non_nullable
as String?,apnsToken: freezed == apnsToken ? _self.apnsToken : apnsToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationTokenModel].
extension NotificationTokenModelPatterns on NotificationTokenModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationTokenModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationTokenModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationTokenModel value)  $default,){
final _that = this;
switch (_that) {
case _NotificationTokenModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationTokenModel value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationTokenModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? fcmToken,  String? apnsToken)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationTokenModel() when $default != null:
return $default(_that.fcmToken,_that.apnsToken);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? fcmToken,  String? apnsToken)  $default,) {final _that = this;
switch (_that) {
case _NotificationTokenModel():
return $default(_that.fcmToken,_that.apnsToken);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? fcmToken,  String? apnsToken)?  $default,) {final _that = this;
switch (_that) {
case _NotificationTokenModel() when $default != null:
return $default(_that.fcmToken,_that.apnsToken);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationTokenModel with DiagnosticableTreeMixin implements NotificationTokenModel {
  const _NotificationTokenModel({required this.fcmToken, required this.apnsToken});
  factory _NotificationTokenModel.fromJson(Map<String, dynamic> json) => _$NotificationTokenModelFromJson(json);

@override final  String? fcmToken;
@override final  String? apnsToken;

/// Create a copy of NotificationTokenModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationTokenModelCopyWith<_NotificationTokenModel> get copyWith => __$NotificationTokenModelCopyWithImpl<_NotificationTokenModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationTokenModelToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'NotificationTokenModel'))
    ..add(DiagnosticsProperty('fcmToken', fcmToken))..add(DiagnosticsProperty('apnsToken', apnsToken));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationTokenModel&&(identical(other.fcmToken, fcmToken) || other.fcmToken == fcmToken)&&(identical(other.apnsToken, apnsToken) || other.apnsToken == apnsToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fcmToken,apnsToken);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'NotificationTokenModel(fcmToken: $fcmToken, apnsToken: $apnsToken)';
}


}

/// @nodoc
abstract mixin class _$NotificationTokenModelCopyWith<$Res> implements $NotificationTokenModelCopyWith<$Res> {
  factory _$NotificationTokenModelCopyWith(_NotificationTokenModel value, $Res Function(_NotificationTokenModel) _then) = __$NotificationTokenModelCopyWithImpl;
@override @useResult
$Res call({
 String? fcmToken, String? apnsToken
});




}
/// @nodoc
class __$NotificationTokenModelCopyWithImpl<$Res>
    implements _$NotificationTokenModelCopyWith<$Res> {
  __$NotificationTokenModelCopyWithImpl(this._self, this._then);

  final _NotificationTokenModel _self;
  final $Res Function(_NotificationTokenModel) _then;

/// Create a copy of NotificationTokenModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fcmToken = freezed,Object? apnsToken = freezed,}) {
  return _then(_NotificationTokenModel(
fcmToken: freezed == fcmToken ? _self.fcmToken : fcmToken // ignore: cast_nullable_to_non_nullable
as String?,apnsToken: freezed == apnsToken ? _self.apnsToken : apnsToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
