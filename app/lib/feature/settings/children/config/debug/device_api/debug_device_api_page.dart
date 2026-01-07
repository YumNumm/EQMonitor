import 'dart:convert';

import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/api/eq_api.dart';
import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/provider/notification_token.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DebugDeviceApiPage extends HookConsumerWidget {
  const DebugDeviceApiPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceIdController = useTextEditingController();
    final fcmTokenController = useTextEditingController();
    final apnsTokenController = useTextEditingController();
    final apnsTokenTypeController = useTextEditingController(
      text: 'NOTIFICATION',
    );

    final deviceState = useState<AsyncValue<Device>?>(null);
    final apnsTokensState = useState<AsyncValue<List<ApnsToken>>?>(null);
    final apnsTokenState = useState<AsyncValue<ApnsToken>?>(null);
    final fcmTokenState = useState<AsyncValue<FcmToken?>?>(null);

    final notificationToken = ref.watch(notificationTokenProvider).value;
    useEffect(() {
      if (fcmTokenController.text.isEmpty &&
          notificationToken?.fcmToken != null) {
        fcmTokenController.text = notificationToken!.fcmToken!;
      }
      if (apnsTokenController.text.isEmpty &&
          notificationToken?.apnsToken != null) {
        apnsTokenController.text = notificationToken!.apnsToken!;
      }
      return null;
    }, [notificationToken]);

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
                                    deviceState.value = AsyncValue.data(device);
                                  } catch (e, s) {
                                    deviceState.value =
                                        AsyncValue<Device>.error(e, s);
                                  }
                                },
                          child: const Text('Get Device'),
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
                              AsyncError(:final error) => error.toString(),
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
                              AsyncError(:final error) => error.toString(),
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
                              AsyncError(:final error) => error.toString(),
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
                              AsyncError(:final error) => error.toString(),
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
