import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/api/eq_api.dart';
import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/provider/device_id.dart';
import 'package:eqmonitor/core/provider/notification_token.dart';
import 'package:eqmonitor/core/provider/user_id.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// エラーメッセージをフォーマットするヘルパー関数
String _formatError(Object error) {
  if (error is DioException) {
    final buffer = StringBuffer();
    buffer.writeln('Error: ${error.type}');

    if (error.response != null) {
      final response = error.response!;
      buffer.writeln('Status Code: ${response.statusCode}');
      buffer.writeln('Status Message: ${response.statusMessage ?? 'N/A'}');

      if (response.data != null) {
        buffer.writeln('Response Body:');
        try {
          if (response.data is Map || response.data is List) {
            buffer.write(
              const JsonEncoder.withIndent('  ').convert(response.data),
            );
          } else {
            buffer.write(response.data.toString());
          }
        } catch (e) {
          buffer.write(response.data.toString());
        }
      }
    } else {
      buffer.writeln('Message: ${error.message}');
    }

    return buffer.toString();
  }
  return error.toString();
}

class DebugDeviceApiPage extends HookConsumerWidget {
  const DebugDeviceApiPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceIdController = useTextEditingController();
    final userIdController = useTextEditingController();
    final fcmTokenController = useTextEditingController();
    final apnsTokenController = useTextEditingController();
    final apnsTokenTypeController = useTextEditingController(
      text: 'NOTIFICATION',
    );

    final deviceState = useState<AsyncValue<Device>?>(null);
    final apnsTokensState = useState<AsyncValue<List<ApnsToken>>?>(null);
    final apnsTokenState = useState<AsyncValue<ApnsToken>?>(null);
    final fcmTokenState = useState<AsyncValue<FcmToken?>?>(null);
    final deviceTypeState = useState<DeviceType>(DeviceType.ios);
    final userState = useState<AsyncValue<User>?>(null);

    final notificationToken = ref.watch(notificationTokenProvider).value;
    final deviceIdAsync = ref.watch(deviceIdProvider);
    final userIdAsync = ref.watch(userIdProvider);
    useEffect(() {
      deviceIdAsync.whenData((deviceId) {
        if (deviceIdController.text.isEmpty) {
          deviceIdController.text = deviceId;
        }
      });
      userIdAsync.whenData((userId) {
        if (userId != null && userIdController.text.isEmpty) {
          userIdController.text = userId;
        }
      });
      if (fcmTokenController.text.isEmpty &&
          notificationToken?.fcmToken != null) {
        fcmTokenController.text = notificationToken!.fcmToken!;
      }
      if (apnsTokenController.text.isEmpty &&
          notificationToken?.apnsToken != null) {
        apnsTokenController.text = notificationToken!.apnsToken!;
      }
      return null;
    }, [notificationToken, deviceIdAsync, userIdAsync]);

    return DefaultTextStyle.merge(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Device API',
            style: TextStyle(fontFamily: FontFamily.notoSansMono),
          ),
        ),
        body: SingleChildScrollView(
          primary: true,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BorderedContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'User',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: FontFamily.notoSansMono,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: userIdController,
                          decoration: const InputDecoration(
                            hintText: 'Enter user ID (UUID)',
                            border: OutlineInputBorder(),
                            labelText: 'User ID',
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                userState.value =
                                    const AsyncValue<User>.loading();
                                try {
                                  final user = await ref
                                      .read(eqApiProvider)
                                      .user
                                      .createUser();
                                  userState.value = AsyncValue.data(user);
                                  await ref
                                      .read(userIdProvider.notifier)
                                      .save(user.id);
                                  userIdController.text = user.id;
                                } catch (e, s) {
                                  userState.value =
                                      AsyncValue<User>.error(e, s);
                                }
                              },
                              child: const Text('Create User'),
                            ),
                            ElevatedButton(
                              onPressed: userIdController.text.isEmpty
                                  ? null
                                  : () async {
                                      userState.value =
                                          const AsyncValue<User>.loading();
                                      try {
                                        final user = await ref
                                            .read(eqApiProvider)
                                            .user
                                            .getUser(
                                              userId: userIdController.text,
                                            );
                                        userState.value = AsyncValue.data(user);
                                      } catch (e, s) {
                                        userState.value =
                                            AsyncValue<User>.error(e, s);
                                      }
                                    },
                              child: const Text('Get User'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        if (userState.value != null)
                          Text(
                            switch (userState.value!) {
                              AsyncData(:final value) =>
                                const JsonEncoder.withIndent('  ').convert({
                                  'id': value.id,
                                }),
                              AsyncError(:final error) => _formatError(error),
                              _ => 'Loading...',
                            },
                            style: const TextStyle(
                              fontFamily: FontFamily.notoSansMono,
                              fontSize: 12,
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  BorderedContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Device ID',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: FontFamily.notoSansMono,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: deviceIdController,
                          decoration: const InputDecoration(
                            hintText: 'Enter device ID',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  BorderedContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Device Info',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: FontFamily.notoSansMono,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: userIdController,
                          decoration: const InputDecoration(
                            hintText: 'Enter user ID (UUID)',
                            border: OutlineInputBorder(),
                            labelText: 'User ID',
                          ),
                        ),
                        const SizedBox(height: 8),
                        SegmentedButton<DeviceType>(
                          segments: const [
                            ButtonSegment<DeviceType>(
                              value: DeviceType.ios,
                              label: Text('iOS'),
                            ),
                            ButtonSegment<DeviceType>(
                              value: DeviceType.android,
                              label: Text('Android'),
                            ),
                          ],
                          selected: {deviceTypeState.value},
                          onSelectionChanged: (Set<DeviceType> newSelection) {
                            deviceTypeState.value = newSelection.first;
                          },
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            ElevatedButton(
                              onPressed: deviceIdController.text.isEmpty
                                  ? null
                                  : () async {
                                      deviceState.value =
                                          const AsyncValue<Device>.loading();
                                      try {
                                        final device = await ref
                                            .read(eqApiProvider)
                                            .device
                                            .getDevice(
                                              deviceId: deviceIdController.text,
                                            );
                                        deviceState.value =
                                            AsyncValue.data(device);
                                      } catch (e, s) {
                                        deviceState.value =
                                            AsyncValue<Device>.error(e, s);
                                      }
                                    },
                              child: const Text('Get Device'),
                            ),
                            ElevatedButton(
                              onPressed: deviceIdController.text.isEmpty ||
                                      userIdController.text.isEmpty
                                  ? null
                                  : () async {
                                      deviceState.value =
                                          const AsyncValue<Device>.loading();
                                      try {
                                        final device = await ref
                                            .read(eqApiProvider)
                                            .device
                                            .upsertDevice(
                                              deviceId: deviceIdController.text,
                                              request: DeviceUpsertRequest(
                                                type: deviceTypeState.value,
                                                userId: userIdController.text,
                                              ),
                                            );
                                        deviceState.value =
                                            AsyncValue.data(device);
                                      } catch (e, s) {
                                        deviceState.value =
                                            AsyncValue<Device>.error(e, s);
                                      }
                                    },
                              child: const Text('Register/Update Device'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        if (deviceState.value != null)
                          Text(
                            switch (deviceState.value!) {
                              AsyncData(:final value) =>
                                const JsonEncoder.withIndent('  ').convert({
                                  'id': value.id,
                                  'type': value.type.value,
                                  'userId': value.userId,
                                  'createdAt': value.createdAt,
                                  'updatedAt': value.updatedAt,
                                }),
                              AsyncError(:final error) => _formatError(error),
                              _ => 'Loading...',
                            },
                            style: const TextStyle(
                              fontFamily: FontFamily.notoSansMono,
                              fontSize: 12,
                            ),
                          ),
                      ],
                    ),
                  ),
                  BorderedContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'FCM Token',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: FontFamily.notoSansMono,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: fcmTokenController,
                          decoration: const InputDecoration(
                            hintText: 'Enter FCM token',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            ElevatedButton(
                              onPressed: deviceIdController.text.isEmpty
                                  ? null
                                  : () async {
                                      fcmTokenState.value =
                                          const AsyncValue<FcmToken?>.loading();
                                      try {
                                        final token = await ref
                                            .read(eqApiProvider)
                                            .device
                                            .getFcmToken(
                                              deviceId: deviceIdController.text,
                                            );
                                        fcmTokenState.value = AsyncValue.data(
                                          token,
                                        );
                                      } catch (e, s) {
                                        fcmTokenState.value =
                                            AsyncValue<FcmToken?>.error(e, s);
                                      }
                                    },
                              child: const Text('Get'),
                            ),
                            ElevatedButton(
                              onPressed:
                                  deviceIdController.text.isEmpty ||
                                      fcmTokenController.text.isEmpty
                                  ? null
                                  : () async {
                                      fcmTokenState.value =
                                          const AsyncValue<FcmToken?>.loading();
                                      try {
                                        final token = await ref
                                            .read(eqApiProvider)
                                            .device
                                            .updateFcmToken(
                                              deviceId: deviceIdController.text,
                                              request: FcmTokenRequest(
                                                token: fcmTokenController.text,
                                              ),
                                            );
                                        fcmTokenState.value = AsyncValue.data(
                                          token,
                                        );
                                      } catch (e, s) {
                                        fcmTokenState.value =
                                            AsyncValue<FcmToken?>.error(e, s);
                                      }
                                    },
                              child: const Text('Update'),
                            ),
                            ElevatedButton(
                              onPressed: deviceIdController.text.isEmpty
                                  ? null
                                  : () async {
                                      fcmTokenState.value =
                                          const AsyncValue<FcmToken?>.loading();
                                      try {
                                        await ref
                                            .read(eqApiProvider)
                                            .device
                                            .deleteFcmToken(
                                              deviceId: deviceIdController.text,
                                            );
                                        fcmTokenState.value =
                                            const AsyncValue.data(null);
                                      } catch (e, s) {
                                        fcmTokenState.value =
                                            AsyncValue<FcmToken?>.error(e, s);
                                      }
                                    },
                              child: const Text('Delete'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        if (fcmTokenState.value != null)
                          Text(
                            switch (fcmTokenState.value!) {
                              AsyncData(:final value) =>
                                value == null
                                    ? 'null'
                                    : const JsonEncoder.withIndent(
                                        '  ',
                                      ).convert({'token': value.token}),
                              AsyncError(:final error) => _formatError(error),
                              _ => 'Loading...',
                            },
                            style: const TextStyle(
                              fontFamily: FontFamily.notoSansMono,
                              fontSize: 12,
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  BorderedContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'APNs Tokens',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: FontFamily.notoSansMono,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            ElevatedButton(
                              onPressed: deviceIdController.text.isEmpty
                                  ? null
                                  : () async {
                                      apnsTokensState.value =
                                          const AsyncValue<
                                            List<ApnsToken>
                                          >.loading();
                                      try {
                                        final tokens = await ref
                                            .read(eqApiProvider)
                                            .device
                                            .getApnsTokens(
                                              deviceId: deviceIdController.text,
                                            );
                                        apnsTokensState.value = AsyncValue.data(
                                          tokens,
                                        );
                                      } catch (e, s) {
                                        apnsTokensState.value =
                                            AsyncValue<List<ApnsToken>>.error(
                                              e,
                                              s,
                                            );
                                      }
                                    },
                              child: const Text('Get All'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const SizedBox(height: 8),
                        if (apnsTokensState.value != null)
                          Text(
                            switch (apnsTokensState.value!) {
                              AsyncData(:final value) =>
                                const JsonEncoder.withIndent('  ').convert(
                                  value
                                      .map(
                                        (e) => {
                                          'type': e.type.value,
                                          'token': e.token,
                                        },
                                      )
                                      .toList(),
                                ),
                              AsyncError(:final error) => _formatError(error),
                              _ => 'Loading...',
                            },
                            style: const TextStyle(
                              fontFamily: FontFamily.notoSansMono,
                              fontSize: 12,
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  BorderedContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'APNs Token (Specific Type)',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: FontFamily.notoSansMono,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: apnsTokenTypeController,
                          decoration: const InputDecoration(
                            hintText: 'NOTIFICATION or LIVE_ACTIVITY_START',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        TextField(
                          controller: apnsTokenController,
                          decoration: const InputDecoration(
                            hintText: 'Enter APNs token',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            ElevatedButton(
                              onPressed:
                                  deviceIdController.text.isEmpty ||
                                      apnsTokenTypeController.text.isEmpty
                                  ? null
                                  : () async {
                                      apnsTokenState.value =
                                          const AsyncValue<ApnsToken>.loading();
                                      try {
                                        final token = await ref
                                            .read(eqApiProvider)
                                            .device
                                            .getApnsToken(
                                              deviceId: deviceIdController.text,
                                              tokenType:
                                                  apnsTokenTypeController.text,
                                            );
                                        apnsTokenState.value = AsyncValue.data(
                                          token,
                                        );
                                      } catch (e, s) {
                                        apnsTokenState.value =
                                            AsyncValue<ApnsToken>.error(e, s);
                                      }
                                    },
                              child: const Text('Get'),
                            ),
                            ElevatedButton(
                              onPressed:
                                  deviceIdController.text.isEmpty ||
                                      apnsTokenTypeController.text.isEmpty ||
                                      apnsTokenController.text.isEmpty
                                  ? null
                                  : () async {
                                      apnsTokenState.value =
                                          const AsyncValue<ApnsToken>.loading();
                                      try {
                                        final token = await ref
                                            .read(eqApiProvider)
                                            .device
                                            .updateApnsToken(
                                              deviceId: deviceIdController.text,
                                              tokenType:
                                                  apnsTokenTypeController.text,
                                              request: ApnsTokenRequest(
                                                token: apnsTokenController.text,
                                              ),
                                            );
                                        apnsTokenState.value = AsyncValue.data(
                                          token,
                                        );
                                      } catch (e, s) {
                                        apnsTokenState.value =
                                            AsyncValue<ApnsToken>.error(e, s);
                                      }
                                    },
                              child: const Text('Update'),
                            ),
                            ElevatedButton(
                              onPressed:
                                  deviceIdController.text.isEmpty ||
                                      apnsTokenTypeController.text.isEmpty
                                  ? null
                                  : () async {
                                      apnsTokenState.value =
                                          const AsyncValue<ApnsToken>.loading();
                                      try {
                                        await ref
                                            .read(eqApiProvider)
                                            .device
                                            .deleteApnsToken(
                                              deviceId: deviceIdController.text,
                                              tokenType:
                                                  apnsTokenTypeController.text,
                                            );
                                        apnsTokenState.value = null;
                                      } catch (e, s) {
                                        apnsTokenState.value =
                                            AsyncValue<ApnsToken>.error(e, s);
                                      }
                                    },
                              child: const Text('Delete'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        if (apnsTokenState.value != null)
                          Text(
                            switch (apnsTokenState.value!) {
                              AsyncData(:final value) =>
                                const JsonEncoder.withIndent('  ').convert({
                                  'type': value.type.value,
                                  'token': value.token,
                                }),
                              AsyncError(:final error) => _formatError(error),
                              _ => 'Loading...',
                            },
                            style: const TextStyle(
                              fontFamily: FontFamily.notoSansMono,
                              fontSize: 12,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
