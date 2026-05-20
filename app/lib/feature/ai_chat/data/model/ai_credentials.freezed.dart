// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_credentials.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AiCredentials {

 AiProvider get provider; String get model; String get apiKey;
/// Create a copy of AiCredentials
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiCredentialsCopyWith<AiCredentials> get copyWith => _$AiCredentialsCopyWithImpl<AiCredentials>(this as AiCredentials, _$identity);

  /// Serializes this AiCredentials to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiCredentials&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.model, model) || other.model == model)&&(identical(other.apiKey, apiKey) || other.apiKey == apiKey));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,provider,model,apiKey);

@override
String toString() {
  return 'AiCredentials(provider: $provider, model: $model, apiKey: $apiKey)';
}


}

/// @nodoc
abstract mixin class $AiCredentialsCopyWith<$Res>  {
  factory $AiCredentialsCopyWith(AiCredentials value, $Res Function(AiCredentials) _then) = _$AiCredentialsCopyWithImpl;
@useResult
$Res call({
 AiProvider provider, String model, String apiKey
});




}
/// @nodoc
class _$AiCredentialsCopyWithImpl<$Res>
    implements $AiCredentialsCopyWith<$Res> {
  _$AiCredentialsCopyWithImpl(this._self, this._then);

  final AiCredentials _self;
  final $Res Function(AiCredentials) _then;

/// Create a copy of AiCredentials
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? provider = null,Object? model = null,Object? apiKey = null,}) {
  return _then(_self.copyWith(
provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as AiProvider,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,apiKey: null == apiKey ? _self.apiKey : apiKey // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AiCredentials].
extension AiCredentialsPatterns on AiCredentials {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiCredentials value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiCredentials() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiCredentials value)  $default,){
final _that = this;
switch (_that) {
case _AiCredentials():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiCredentials value)?  $default,){
final _that = this;
switch (_that) {
case _AiCredentials() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AiProvider provider,  String model,  String apiKey)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiCredentials() when $default != null:
return $default(_that.provider,_that.model,_that.apiKey);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AiProvider provider,  String model,  String apiKey)  $default,) {final _that = this;
switch (_that) {
case _AiCredentials():
return $default(_that.provider,_that.model,_that.apiKey);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AiProvider provider,  String model,  String apiKey)?  $default,) {final _that = this;
switch (_that) {
case _AiCredentials() when $default != null:
return $default(_that.provider,_that.model,_that.apiKey);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AiCredentials implements AiCredentials {
  const _AiCredentials({required this.provider, required this.model, required this.apiKey});
  factory _AiCredentials.fromJson(Map<String, dynamic> json) => _$AiCredentialsFromJson(json);

@override final  AiProvider provider;
@override final  String model;
@override final  String apiKey;

/// Create a copy of AiCredentials
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiCredentialsCopyWith<_AiCredentials> get copyWith => __$AiCredentialsCopyWithImpl<_AiCredentials>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AiCredentialsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiCredentials&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.model, model) || other.model == model)&&(identical(other.apiKey, apiKey) || other.apiKey == apiKey));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,provider,model,apiKey);

@override
String toString() {
  return 'AiCredentials(provider: $provider, model: $model, apiKey: $apiKey)';
}


}

/// @nodoc
abstract mixin class _$AiCredentialsCopyWith<$Res> implements $AiCredentialsCopyWith<$Res> {
  factory _$AiCredentialsCopyWith(_AiCredentials value, $Res Function(_AiCredentials) _then) = __$AiCredentialsCopyWithImpl;
@override @useResult
$Res call({
 AiProvider provider, String model, String apiKey
});




}
/// @nodoc
class __$AiCredentialsCopyWithImpl<$Res>
    implements _$AiCredentialsCopyWith<$Res> {
  __$AiCredentialsCopyWithImpl(this._self, this._then);

  final _AiCredentials _self;
  final $Res Function(_AiCredentials) _then;

/// Create a copy of AiCredentials
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? provider = null,Object? model = null,Object? apiKey = null,}) {
  return _then(_AiCredentials(
provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as AiProvider,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,apiKey: null == apiKey ? _self.apiKey : apiKey // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$AiCredentialsStore {

 AiProvider get selectedProvider; Map<AiProvider, AiCredentials> get credentials;
/// Create a copy of AiCredentialsStore
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiCredentialsStoreCopyWith<AiCredentialsStore> get copyWith => _$AiCredentialsStoreCopyWithImpl<AiCredentialsStore>(this as AiCredentialsStore, _$identity);

  /// Serializes this AiCredentialsStore to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiCredentialsStore&&(identical(other.selectedProvider, selectedProvider) || other.selectedProvider == selectedProvider)&&const DeepCollectionEquality().equals(other.credentials, credentials));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,selectedProvider,const DeepCollectionEquality().hash(credentials));

@override
String toString() {
  return 'AiCredentialsStore(selectedProvider: $selectedProvider, credentials: $credentials)';
}


}

/// @nodoc
abstract mixin class $AiCredentialsStoreCopyWith<$Res>  {
  factory $AiCredentialsStoreCopyWith(AiCredentialsStore value, $Res Function(AiCredentialsStore) _then) = _$AiCredentialsStoreCopyWithImpl;
@useResult
$Res call({
 AiProvider selectedProvider, Map<AiProvider, AiCredentials> credentials
});




}
/// @nodoc
class _$AiCredentialsStoreCopyWithImpl<$Res>
    implements $AiCredentialsStoreCopyWith<$Res> {
  _$AiCredentialsStoreCopyWithImpl(this._self, this._then);

  final AiCredentialsStore _self;
  final $Res Function(AiCredentialsStore) _then;

/// Create a copy of AiCredentialsStore
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? selectedProvider = null,Object? credentials = null,}) {
  return _then(_self.copyWith(
selectedProvider: null == selectedProvider ? _self.selectedProvider : selectedProvider // ignore: cast_nullable_to_non_nullable
as AiProvider,credentials: null == credentials ? _self.credentials : credentials // ignore: cast_nullable_to_non_nullable
as Map<AiProvider, AiCredentials>,
  ));
}

}


/// Adds pattern-matching-related methods to [AiCredentialsStore].
extension AiCredentialsStorePatterns on AiCredentialsStore {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiCredentialsStore value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiCredentialsStore() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiCredentialsStore value)  $default,){
final _that = this;
switch (_that) {
case _AiCredentialsStore():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiCredentialsStore value)?  $default,){
final _that = this;
switch (_that) {
case _AiCredentialsStore() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AiProvider selectedProvider,  Map<AiProvider, AiCredentials> credentials)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiCredentialsStore() when $default != null:
return $default(_that.selectedProvider,_that.credentials);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AiProvider selectedProvider,  Map<AiProvider, AiCredentials> credentials)  $default,) {final _that = this;
switch (_that) {
case _AiCredentialsStore():
return $default(_that.selectedProvider,_that.credentials);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AiProvider selectedProvider,  Map<AiProvider, AiCredentials> credentials)?  $default,) {final _that = this;
switch (_that) {
case _AiCredentialsStore() when $default != null:
return $default(_that.selectedProvider,_that.credentials);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AiCredentialsStore extends AiCredentialsStore {
  const _AiCredentialsStore({required this.selectedProvider, final  Map<AiProvider, AiCredentials> credentials = const {}}): _credentials = credentials,super._();
  factory _AiCredentialsStore.fromJson(Map<String, dynamic> json) => _$AiCredentialsStoreFromJson(json);

@override final  AiProvider selectedProvider;
 final  Map<AiProvider, AiCredentials> _credentials;
@override@JsonKey() Map<AiProvider, AiCredentials> get credentials {
  if (_credentials is EqualUnmodifiableMapView) return _credentials;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_credentials);
}


/// Create a copy of AiCredentialsStore
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiCredentialsStoreCopyWith<_AiCredentialsStore> get copyWith => __$AiCredentialsStoreCopyWithImpl<_AiCredentialsStore>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AiCredentialsStoreToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiCredentialsStore&&(identical(other.selectedProvider, selectedProvider) || other.selectedProvider == selectedProvider)&&const DeepCollectionEquality().equals(other._credentials, _credentials));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,selectedProvider,const DeepCollectionEquality().hash(_credentials));

@override
String toString() {
  return 'AiCredentialsStore(selectedProvider: $selectedProvider, credentials: $credentials)';
}


}

/// @nodoc
abstract mixin class _$AiCredentialsStoreCopyWith<$Res> implements $AiCredentialsStoreCopyWith<$Res> {
  factory _$AiCredentialsStoreCopyWith(_AiCredentialsStore value, $Res Function(_AiCredentialsStore) _then) = __$AiCredentialsStoreCopyWithImpl;
@override @useResult
$Res call({
 AiProvider selectedProvider, Map<AiProvider, AiCredentials> credentials
});




}
/// @nodoc
class __$AiCredentialsStoreCopyWithImpl<$Res>
    implements _$AiCredentialsStoreCopyWith<$Res> {
  __$AiCredentialsStoreCopyWithImpl(this._self, this._then);

  final _AiCredentialsStore _self;
  final $Res Function(_AiCredentialsStore) _then;

/// Create a copy of AiCredentialsStore
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? selectedProvider = null,Object? credentials = null,}) {
  return _then(_AiCredentialsStore(
selectedProvider: null == selectedProvider ? _self.selectedProvider : selectedProvider // ignore: cast_nullable_to_non_nullable
as AiProvider,credentials: null == credentials ? _self._credentials : credentials // ignore: cast_nullable_to_non_nullable
as Map<AiProvider, AiCredentials>,
  ));
}


}

// dart format on
