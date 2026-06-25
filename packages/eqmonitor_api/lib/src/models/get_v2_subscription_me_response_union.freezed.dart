// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_v2_subscription_me_response_union.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
GetV2SubscriptionMeResponseUnion _$GetV2SubscriptionMeResponseUnionFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'subscriptionActiveResponse':
          return GetV2SubscriptionMeResponseUnionSubscriptionActiveResponse.fromJson(
            json
          );
                case 'subscriptionInactiveResponse':
          return GetV2SubscriptionMeResponseUnionSubscriptionInactiveResponse.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'GetV2SubscriptionMeResponseUnion',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$GetV2SubscriptionMeResponseUnion {

 String get status;
/// Create a copy of GetV2SubscriptionMeResponseUnion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetV2SubscriptionMeResponseUnionCopyWith<GetV2SubscriptionMeResponseUnion> get copyWith => _$GetV2SubscriptionMeResponseUnionCopyWithImpl<GetV2SubscriptionMeResponseUnion>(this as GetV2SubscriptionMeResponseUnion, _$identity);

  /// Serializes this GetV2SubscriptionMeResponseUnion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetV2SubscriptionMeResponseUnion&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status);

@override
String toString() {
  return 'GetV2SubscriptionMeResponseUnion(status: $status)';
}


}

/// @nodoc
abstract mixin class $GetV2SubscriptionMeResponseUnionCopyWith<$Res>  {
  factory $GetV2SubscriptionMeResponseUnionCopyWith(GetV2SubscriptionMeResponseUnion value, $Res Function(GetV2SubscriptionMeResponseUnion) _then) = _$GetV2SubscriptionMeResponseUnionCopyWithImpl;
@useResult
$Res call({
 String status
});




}
/// @nodoc
class _$GetV2SubscriptionMeResponseUnionCopyWithImpl<$Res>
    implements $GetV2SubscriptionMeResponseUnionCopyWith<$Res> {
  _$GetV2SubscriptionMeResponseUnionCopyWithImpl(this._self, this._then);

  final GetV2SubscriptionMeResponseUnion _self;
  final $Res Function(GetV2SubscriptionMeResponseUnion) _then;

/// Create a copy of GetV2SubscriptionMeResponseUnion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [GetV2SubscriptionMeResponseUnion].
extension GetV2SubscriptionMeResponseUnionPatterns on GetV2SubscriptionMeResponseUnion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( GetV2SubscriptionMeResponseUnionSubscriptionActiveResponse value)?  subscriptionActiveResponse,TResult Function( GetV2SubscriptionMeResponseUnionSubscriptionInactiveResponse value)?  subscriptionInactiveResponse,required TResult orElse(),}){
final _that = this;
switch (_that) {
case GetV2SubscriptionMeResponseUnionSubscriptionActiveResponse() when subscriptionActiveResponse != null:
return subscriptionActiveResponse(_that);case GetV2SubscriptionMeResponseUnionSubscriptionInactiveResponse() when subscriptionInactiveResponse != null:
return subscriptionInactiveResponse(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( GetV2SubscriptionMeResponseUnionSubscriptionActiveResponse value)  subscriptionActiveResponse,required TResult Function( GetV2SubscriptionMeResponseUnionSubscriptionInactiveResponse value)  subscriptionInactiveResponse,}){
final _that = this;
switch (_that) {
case GetV2SubscriptionMeResponseUnionSubscriptionActiveResponse():
return subscriptionActiveResponse(_that);case GetV2SubscriptionMeResponseUnionSubscriptionInactiveResponse():
return subscriptionInactiveResponse(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( GetV2SubscriptionMeResponseUnionSubscriptionActiveResponse value)?  subscriptionActiveResponse,TResult? Function( GetV2SubscriptionMeResponseUnionSubscriptionInactiveResponse value)?  subscriptionInactiveResponse,}){
final _that = this;
switch (_that) {
case GetV2SubscriptionMeResponseUnionSubscriptionActiveResponse() when subscriptionActiveResponse != null:
return subscriptionActiveResponse(_that);case GetV2SubscriptionMeResponseUnionSubscriptionInactiveResponse() when subscriptionInactiveResponse != null:
return subscriptionInactiveResponse(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String status,  String productId, @JsonKey(includeIfNull: true)  DateTime? expiresAt,  bool willRenew)?  subscriptionActiveResponse,TResult Function( String status)?  subscriptionInactiveResponse,required TResult orElse(),}) {final _that = this;
switch (_that) {
case GetV2SubscriptionMeResponseUnionSubscriptionActiveResponse() when subscriptionActiveResponse != null:
return subscriptionActiveResponse(_that.status,_that.productId,_that.expiresAt,_that.willRenew);case GetV2SubscriptionMeResponseUnionSubscriptionInactiveResponse() when subscriptionInactiveResponse != null:
return subscriptionInactiveResponse(_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String status,  String productId, @JsonKey(includeIfNull: true)  DateTime? expiresAt,  bool willRenew)  subscriptionActiveResponse,required TResult Function( String status)  subscriptionInactiveResponse,}) {final _that = this;
switch (_that) {
case GetV2SubscriptionMeResponseUnionSubscriptionActiveResponse():
return subscriptionActiveResponse(_that.status,_that.productId,_that.expiresAt,_that.willRenew);case GetV2SubscriptionMeResponseUnionSubscriptionInactiveResponse():
return subscriptionInactiveResponse(_that.status);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String status,  String productId, @JsonKey(includeIfNull: true)  DateTime? expiresAt,  bool willRenew)?  subscriptionActiveResponse,TResult? Function( String status)?  subscriptionInactiveResponse,}) {final _that = this;
switch (_that) {
case GetV2SubscriptionMeResponseUnionSubscriptionActiveResponse() when subscriptionActiveResponse != null:
return subscriptionActiveResponse(_that.status,_that.productId,_that.expiresAt,_that.willRenew);case GetV2SubscriptionMeResponseUnionSubscriptionInactiveResponse() when subscriptionInactiveResponse != null:
return subscriptionInactiveResponse(_that.status);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable()
class GetV2SubscriptionMeResponseUnionSubscriptionActiveResponse implements GetV2SubscriptionMeResponseUnion {
  const GetV2SubscriptionMeResponseUnionSubscriptionActiveResponse({required this.status, required this.productId, @JsonKey(includeIfNull: true) required this.expiresAt, required this.willRenew, final  String? $type}): $type = $type ?? 'subscriptionActiveResponse';
  factory GetV2SubscriptionMeResponseUnionSubscriptionActiveResponse.fromJson(Map<String, dynamic> json) => _$GetV2SubscriptionMeResponseUnionSubscriptionActiveResponseFromJson(json);

@override final  String status;
 final  String productId;
@JsonKey(includeIfNull: true) final  DateTime? expiresAt;
 final  bool willRenew;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of GetV2SubscriptionMeResponseUnion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetV2SubscriptionMeResponseUnionSubscriptionActiveResponseCopyWith<GetV2SubscriptionMeResponseUnionSubscriptionActiveResponse> get copyWith => _$GetV2SubscriptionMeResponseUnionSubscriptionActiveResponseCopyWithImpl<GetV2SubscriptionMeResponseUnionSubscriptionActiveResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GetV2SubscriptionMeResponseUnionSubscriptionActiveResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetV2SubscriptionMeResponseUnionSubscriptionActiveResponse&&(identical(other.status, status) || other.status == status)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.willRenew, willRenew) || other.willRenew == willRenew));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,productId,expiresAt,willRenew);

@override
String toString() {
  return 'GetV2SubscriptionMeResponseUnion.subscriptionActiveResponse(status: $status, productId: $productId, expiresAt: $expiresAt, willRenew: $willRenew)';
}


}

/// @nodoc
abstract mixin class $GetV2SubscriptionMeResponseUnionSubscriptionActiveResponseCopyWith<$Res> implements $GetV2SubscriptionMeResponseUnionCopyWith<$Res> {
  factory $GetV2SubscriptionMeResponseUnionSubscriptionActiveResponseCopyWith(GetV2SubscriptionMeResponseUnionSubscriptionActiveResponse value, $Res Function(GetV2SubscriptionMeResponseUnionSubscriptionActiveResponse) _then) = _$GetV2SubscriptionMeResponseUnionSubscriptionActiveResponseCopyWithImpl;
@override @useResult
$Res call({
 String status, String productId,@JsonKey(includeIfNull: true) DateTime? expiresAt, bool willRenew
});




}
/// @nodoc
class _$GetV2SubscriptionMeResponseUnionSubscriptionActiveResponseCopyWithImpl<$Res>
    implements $GetV2SubscriptionMeResponseUnionSubscriptionActiveResponseCopyWith<$Res> {
  _$GetV2SubscriptionMeResponseUnionSubscriptionActiveResponseCopyWithImpl(this._self, this._then);

  final GetV2SubscriptionMeResponseUnionSubscriptionActiveResponse _self;
  final $Res Function(GetV2SubscriptionMeResponseUnionSubscriptionActiveResponse) _then;

/// Create a copy of GetV2SubscriptionMeResponseUnion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? productId = null,Object? expiresAt = freezed,Object? willRenew = null,}) {
  return _then(GetV2SubscriptionMeResponseUnionSubscriptionActiveResponse(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,willRenew: null == willRenew ? _self.willRenew : willRenew // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc

@JsonSerializable()
class GetV2SubscriptionMeResponseUnionSubscriptionInactiveResponse implements GetV2SubscriptionMeResponseUnion {
  const GetV2SubscriptionMeResponseUnionSubscriptionInactiveResponse({required this.status, final  String? $type}): $type = $type ?? 'subscriptionInactiveResponse';
  factory GetV2SubscriptionMeResponseUnionSubscriptionInactiveResponse.fromJson(Map<String, dynamic> json) => _$GetV2SubscriptionMeResponseUnionSubscriptionInactiveResponseFromJson(json);

@override final  String status;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of GetV2SubscriptionMeResponseUnion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetV2SubscriptionMeResponseUnionSubscriptionInactiveResponseCopyWith<GetV2SubscriptionMeResponseUnionSubscriptionInactiveResponse> get copyWith => _$GetV2SubscriptionMeResponseUnionSubscriptionInactiveResponseCopyWithImpl<GetV2SubscriptionMeResponseUnionSubscriptionInactiveResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GetV2SubscriptionMeResponseUnionSubscriptionInactiveResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetV2SubscriptionMeResponseUnionSubscriptionInactiveResponse&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status);

@override
String toString() {
  return 'GetV2SubscriptionMeResponseUnion.subscriptionInactiveResponse(status: $status)';
}


}

/// @nodoc
abstract mixin class $GetV2SubscriptionMeResponseUnionSubscriptionInactiveResponseCopyWith<$Res> implements $GetV2SubscriptionMeResponseUnionCopyWith<$Res> {
  factory $GetV2SubscriptionMeResponseUnionSubscriptionInactiveResponseCopyWith(GetV2SubscriptionMeResponseUnionSubscriptionInactiveResponse value, $Res Function(GetV2SubscriptionMeResponseUnionSubscriptionInactiveResponse) _then) = _$GetV2SubscriptionMeResponseUnionSubscriptionInactiveResponseCopyWithImpl;
@override @useResult
$Res call({
 String status
});




}
/// @nodoc
class _$GetV2SubscriptionMeResponseUnionSubscriptionInactiveResponseCopyWithImpl<$Res>
    implements $GetV2SubscriptionMeResponseUnionSubscriptionInactiveResponseCopyWith<$Res> {
  _$GetV2SubscriptionMeResponseUnionSubscriptionInactiveResponseCopyWithImpl(this._self, this._then);

  final GetV2SubscriptionMeResponseUnionSubscriptionInactiveResponse _self;
  final $Res Function(GetV2SubscriptionMeResponseUnionSubscriptionInactiveResponse) _then;

/// Create a copy of GetV2SubscriptionMeResponseUnion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,}) {
  return _then(GetV2SubscriptionMeResponseUnionSubscriptionInactiveResponse(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
