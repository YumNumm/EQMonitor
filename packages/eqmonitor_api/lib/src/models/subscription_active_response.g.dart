// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'subscription_active_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SubscriptionActiveResponse _$SubscriptionActiveResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_SubscriptionActiveResponse', json, ($checkedConvert) {
  final val = _SubscriptionActiveResponse(
    status: $checkedConvert('status', (v) => v),
    productId: $checkedConvert('productId', (v) => v as String),
    expiresAt: $checkedConvert(
      'expiresAt',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
    willRenew: $checkedConvert('willRenew', (v) => v as bool),
  );
  return val;
});

Map<String, dynamic> _$SubscriptionActiveResponseToJson(
  _SubscriptionActiveResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'productId': instance.productId,
  'expiresAt': instance.expiresAt?.toIso8601String(),
  'willRenew': instance.willRenew,
};
