// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'notification_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationTokenModel _$NotificationTokenModelFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_NotificationTokenModel',
  json,
  ($checkedConvert) {
    final val = _NotificationTokenModel(
      fcmToken: $checkedConvert('fcm_token', (v) => v as String?),
      apnsToken: $checkedConvert('apns_token', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {'fcmToken': 'fcm_token', 'apnsToken': 'apns_token'},
);

Map<String, dynamic> _$NotificationTokenModelToJson(
  _NotificationTokenModel instance,
) => <String, dynamic>{
  'fcm_token': instance.fcmToken,
  'apns_token': instance.apnsToken,
};

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(notificationToken)
const notificationTokenProvider = NotificationTokenProvider._();

final class NotificationTokenProvider
    extends
        $FunctionalProvider<
          AsyncValue<NotificationTokenModel>,
          FutureOr<NotificationTokenModel>
        >
    with
        $FutureModifier<NotificationTokenModel>,
        $FutureProvider<NotificationTokenModel> {
  const NotificationTokenProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationTokenProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationTokenHash();

  @$internal
  @override
  $FutureProviderElement<NotificationTokenModel> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<NotificationTokenModel> create(Ref ref) {
    return notificationToken(ref);
  }
}

String _$notificationTokenHash() => r'1d7efa28d4e4401069a1a4426fdbbd4b04239c5e';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
