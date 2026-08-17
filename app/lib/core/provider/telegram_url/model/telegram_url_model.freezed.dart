// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'telegram_url_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TelegramUrlModel {

 String get restApiUrl; String get wsApiUrl;
/// Create a copy of TelegramUrlModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TelegramUrlModelCopyWith<TelegramUrlModel> get copyWith => _$TelegramUrlModelCopyWithImpl<TelegramUrlModel>(this as TelegramUrlModel, _$identity);

  /// Serializes this TelegramUrlModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TelegramUrlModel&&(identical(other.restApiUrl, restApiUrl) || other.restApiUrl == restApiUrl)&&(identical(other.wsApiUrl, wsApiUrl) || other.wsApiUrl == wsApiUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,restApiUrl,wsApiUrl);

@override
String toString() {
  return 'TelegramUrlModel(restApiUrl: $restApiUrl, wsApiUrl: $wsApiUrl)';
}


}

/// @nodoc
abstract mixin class $TelegramUrlModelCopyWith<$Res>  {
  factory $TelegramUrlModelCopyWith(TelegramUrlModel value, $Res Function(TelegramUrlModel) _then) = _$TelegramUrlModelCopyWithImpl;
@useResult
$Res call({
 String restApiUrl, String wsApiUrl
});




}
/// @nodoc
class _$TelegramUrlModelCopyWithImpl<$Res>
    implements $TelegramUrlModelCopyWith<$Res> {
  _$TelegramUrlModelCopyWithImpl(this._self, this._then);

  final TelegramUrlModel _self;
  final $Res Function(TelegramUrlModel) _then;

/// Create a copy of TelegramUrlModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? restApiUrl = null,Object? wsApiUrl = null,}) {
  return _then(TelegramUrlModel(
restApiUrl: null == restApiUrl ? _self.restApiUrl : restApiUrl // ignore: cast_nullable_to_non_nullable
as String,wsApiUrl: null == wsApiUrl ? _self.wsApiUrl : wsApiUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TelegramUrlModel].
extension TelegramUrlModelPatterns on TelegramUrlModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TelegramUrlModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TelegramUrlModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TelegramUrlModel value)  $default,){
final _that = this;
switch (_that) {
case _TelegramUrlModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TelegramUrlModel value)?  $default,){
final _that = this;
switch (_that) {
case _TelegramUrlModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String restApiUrl,  String wsApiUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TelegramUrlModel() when $default != null:
return $default(_that.restApiUrl,_that.wsApiUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String restApiUrl,  String wsApiUrl)  $default,) {final _that = this;
switch (_that) {
case _TelegramUrlModel():
return $default(_that.restApiUrl,_that.wsApiUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String restApiUrl,  String wsApiUrl)?  $default,) {final _that = this;
switch (_that) {
case _TelegramUrlModel() when $default != null:
return $default(_that.restApiUrl,_that.wsApiUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TelegramUrlModel implements TelegramUrlModel {
  const _TelegramUrlModel({required this.restApiUrl, required this.wsApiUrl});
  factory _TelegramUrlModel.fromJson(Map<String, dynamic> json) => _$TelegramUrlModelFromJson(json);

@override final  String restApiUrl;
@override final  String wsApiUrl;

/// Create a copy of TelegramUrlModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TelegramUrlModelCopyWith<_TelegramUrlModel> get copyWith => __$TelegramUrlModelCopyWithImpl<_TelegramUrlModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TelegramUrlModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TelegramUrlModel&&(identical(other.restApiUrl, restApiUrl) || other.restApiUrl == restApiUrl)&&(identical(other.wsApiUrl, wsApiUrl) || other.wsApiUrl == wsApiUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,restApiUrl,wsApiUrl);

@override
String toString() {
  return 'TelegramUrlModel(restApiUrl: $restApiUrl, wsApiUrl: $wsApiUrl)';
}


}

/// @nodoc
abstract mixin class _$TelegramUrlModelCopyWith<$Res> implements $TelegramUrlModelCopyWith<$Res> {
  factory _$TelegramUrlModelCopyWith(_TelegramUrlModel value, $Res Function(_TelegramUrlModel) _then) = __$TelegramUrlModelCopyWithImpl;
@override @useResult
$Res call({
 String restApiUrl, String wsApiUrl
});




}
/// @nodoc
class __$TelegramUrlModelCopyWithImpl<$Res>
    implements _$TelegramUrlModelCopyWith<$Res> {
  __$TelegramUrlModelCopyWithImpl(this._self, this._then);

  final _TelegramUrlModel _self;
  final $Res Function(_TelegramUrlModel) _then;

/// Create a copy of TelegramUrlModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? restApiUrl = null,Object? wsApiUrl = null,}) {
  return _then(_TelegramUrlModel(
restApiUrl: null == restApiUrl ? _self.restApiUrl : restApiUrl // ignore: cast_nullable_to_non_nullable
as String,wsApiUrl: null == wsApiUrl ? _self.wsApiUrl : wsApiUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
