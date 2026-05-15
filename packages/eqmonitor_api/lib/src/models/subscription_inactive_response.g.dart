// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'subscription_inactive_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SubscriptionInactiveResponse _$SubscriptionInactiveResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_SubscriptionInactiveResponse', json, ($checkedConvert) {
  final val = _SubscriptionInactiveResponse(
    status: $checkedConvert('status', (v) => v),
  );
  return val;
});

Map<String, dynamic> _$SubscriptionInactiveResponseToJson(
  _SubscriptionInactiveResponse instance,
) => <String, dynamic>{'status': instance.status};
