// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'get_v2_subscription_me_response_union.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetV2SubscriptionMeResponseUnionSubscriptionActiveResponse
_$GetV2SubscriptionMeResponseUnionSubscriptionActiveResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'GetV2SubscriptionMeResponseUnionSubscriptionActiveResponse',
  json,
  ($checkedConvert) {
    final val = GetV2SubscriptionMeResponseUnionSubscriptionActiveResponse(
      status: $checkedConvert('status', (v) => v as String),
      productId: $checkedConvert('productId', (v) => v as String),
      expiresAt: $checkedConvert(
        'expiresAt',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      willRenew: $checkedConvert('willRenew', (v) => v as bool),
      $type: $checkedConvert('runtimeType', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {r'$type': 'runtimeType'},
);

Map<String, dynamic>
_$GetV2SubscriptionMeResponseUnionSubscriptionActiveResponseToJson(
  GetV2SubscriptionMeResponseUnionSubscriptionActiveResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'productId': instance.productId,
  'expiresAt': instance.expiresAt?.toIso8601String(),
  'willRenew': instance.willRenew,
  'runtimeType': instance.$type,
};

GetV2SubscriptionMeResponseUnionSubscriptionInactiveResponse
_$GetV2SubscriptionMeResponseUnionSubscriptionInactiveResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'GetV2SubscriptionMeResponseUnionSubscriptionInactiveResponse',
  json,
  ($checkedConvert) {
    final val = GetV2SubscriptionMeResponseUnionSubscriptionInactiveResponse(
      status: $checkedConvert('status', (v) => v as String),
      $type: $checkedConvert('runtimeType', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {r'$type': 'runtimeType'},
);

Map<String, dynamic>
_$GetV2SubscriptionMeResponseUnionSubscriptionInactiveResponseToJson(
  GetV2SubscriptionMeResponseUnionSubscriptionInactiveResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'runtimeType': instance.$type,
};
