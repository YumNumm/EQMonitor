// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'telegram_url_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TelegramUrlModel {

 String get restApiUrl; String get wsApiUrl; String? get apiAuthorization;
/// Create a copy of TelegramUrlModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TelegramUrlModelCopyWith<TelegramUrlModel> get copyWith => _$TelegramUrlModelCopyWithImpl<TelegramUrlModel>(this as TelegramUrlModel, _$identity);

  /// Serializes this TelegramUrlModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TelegramUrlModel&&(identical(other.restApiUrl, restApiUrl) || other.restApiUrl == restApiUrl)&&(identical(other.wsApiUrl, wsApiUrl) || other.wsApiUrl == wsApiUrl)&&(identical(other.apiAuthorization, apiAuthorization) || other.apiAuthorization == apiAuthorization));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,restApiUrl,wsApiUrl,apiAuthorization);

@override
String toString() {
  return 'TelegramUrlModel(restApiUrl: $restApiUrl, wsApiUrl: $wsApiUrl, apiAuthorization: $apiAuthorization)';
}


}

/// @nodoc
abstract mixin class $TelegramUrlModelCopyWith<$Res>  {
  factory $TelegramUrlModelCopyWith(TelegramUrlModel value, $Res Function(TelegramUrlModel) _then) = _$TelegramUrlModelCopyWithImpl;
@useResult
$Res call({
 String restApiUrl, String wsApiUrl, String? apiAuthorization
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
@pragma('vm:prefer-inline') @override $Res call({Object? restApiUrl = null,Object? wsApiUrl = null,Object? apiAuthorization = freezed,}) {
  return _then(_self.copyWith(
restApiUrl: null == restApiUrl ? _self.restApiUrl : restApiUrl // ignore: cast_nullable_to_non_nullable
as String,wsApiUrl: null == wsApiUrl ? _self.wsApiUrl : wsApiUrl // ignore: cast_nullable_to_non_nullable
as String,apiAuthorization: freezed == apiAuthorization ? _self.apiAuthorization : apiAuthorization // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _TelegramUrlModel implements TelegramUrlModel {
  const _TelegramUrlModel({required this.restApiUrl, required this.wsApiUrl, required this.apiAuthorization});
  factory _TelegramUrlModel.fromJson(Map<String, dynamic> json) => _$TelegramUrlModelFromJson(json);

@override final  String restApiUrl;
@override final  String wsApiUrl;
@override final  String? apiAuthorization;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TelegramUrlModel&&(identical(other.restApiUrl, restApiUrl) || other.restApiUrl == restApiUrl)&&(identical(other.wsApiUrl, wsApiUrl) || other.wsApiUrl == wsApiUrl)&&(identical(other.apiAuthorization, apiAuthorization) || other.apiAuthorization == apiAuthorization));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,restApiUrl,wsApiUrl,apiAuthorization);

@override
String toString() {
  return 'TelegramUrlModel(restApiUrl: $restApiUrl, wsApiUrl: $wsApiUrl, apiAuthorization: $apiAuthorization)';
}


}

/// @nodoc
abstract mixin class _$TelegramUrlModelCopyWith<$Res> implements $TelegramUrlModelCopyWith<$Res> {
  factory _$TelegramUrlModelCopyWith(_TelegramUrlModel value, $Res Function(_TelegramUrlModel) _then) = __$TelegramUrlModelCopyWithImpl;
@override @useResult
$Res call({
 String restApiUrl, String wsApiUrl, String? apiAuthorization
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
@override @pragma('vm:prefer-inline') $Res call({Object? restApiUrl = null,Object? wsApiUrl = null,Object? apiAuthorization = freezed,}) {
  return _then(_TelegramUrlModel(
restApiUrl: null == restApiUrl ? _self.restApiUrl : restApiUrl // ignore: cast_nullable_to_non_nullable
as String,wsApiUrl: null == wsApiUrl ? _self.wsApiUrl : wsApiUrl // ignore: cast_nullable_to_non_nullable
as String,apiAuthorization: freezed == apiAuthorization ? _self.apiAuthorization : apiAuthorization // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
