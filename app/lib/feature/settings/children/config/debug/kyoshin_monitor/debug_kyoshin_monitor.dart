import 'dart:convert';
import 'dart:typed_data';

import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_notifier.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_timer_notifier.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_maintenance_provider.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_settings.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_timer_stream.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DebugKyoshinMonitorPage extends StatelessWidget {
  const DebugKyoshinMonitorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'KyoshinMonitor',
            style: TextStyle(fontFamily: FontFamily.notoSansMono),
          ),
          actions: const [],
        ),
        body: const SingleChildScrollView(
          primary: true,
          child: SafeArea(child: _Body()),
        ),
      ),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;

    final titleTextStyle = textTheme.titleMedium!.copyWith(
      fontWeight: FontWeight.bold,
      fontFamily: FontFamily.notoSansMono,
      fontFamilyFallback: [FontFamily.notoSansJP],
    );

    final bodyTextStyle = textTheme.bodySmall!.copyWith(
      fontWeight: FontWeight.w400,
      fontFamily: FontFamily.notoSansMono,
      fontFamilyFallback: [FontFamily.notoSansJP],
    );

    final kyoshinMonitorTimerState = ref.watch(
      kyoshinMonitorTimerProvider,
    );

    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BorderedContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('KyoshinMonitorTimerNotifier', style: titleTextStyle),
              Text(switch (kyoshinMonitorTimerState) {
                AsyncData(:final value) =>
                  const JsonEncoder.withIndent(
                    '  ',
                  ).convert({
                    ...value.toJson(),
                    'delay_from_device': value.delayFromDevice.toString(),
                  }),
                AsyncError(:final error) => error.toString(),
                _ => 'Loading...',
              }, style: bodyTextStyle),
            ],
          ),
        ),
        BorderedContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('KyoshinMonitorTimerStream', style: titleTextStyle),
              Text(switch (ref.watch(kyoshinMonitorTimerStreamProvider)) {
                AsyncData(:final value) => value.toString(),
                AsyncError(:final error) => error.toString(),
                _ => 'Loading...',
              }, style: bodyTextStyle),
            ],
          ),
        ),
        BorderedContainer(
          child: () {
            final state = ref.watch(kyoshinMonitorProvider);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('KyoshinMonitorNotifier', style: titleTextStyle),
                    if (state.isLoading) const Icon(Icons.refresh, size: 16),
                  ],
                ),
                Text(switch (state) {
                  AsyncData(:final value) =>
                    const JsonEncoder.withIndent(
                      '  ',
                    ).convert({
                      ...() {
                        final j = Map<String, dynamic>.from(value.toJson())
                          ..remove('geo_json');
                        return j;
                      }(),
                      'geo_json_bytes': value.geoJson?.length,
                      'analyzed_points_count': value.analyzedPointsCount,
                      'last_image_fetch_duration': switch (value
                          .lastImageFetchDuration
                          ?.inMicroseconds) {
                        final int v => '${v / 1000}ms',
                        null => 'null',
                      },
                      'current_image_raw': value.currentImageRaw?.length,
                    }),
                  AsyncError(:final error) => error.toString(),
                  _ => 'Loading...',
                }, style: bodyTextStyle),
                if (state.value?.currentImageRaw != null)
                  ColoredBox(
                    color: Colors.white,
                    child: Image.memory(
                      Uint8List.fromList(state.value!.currentImageRaw!),
                      height: 200,
                      width: 200,
                    ),
                  )
                else
                  const ColoredBox(
                    color: Colors.white,
                    child: SizedBox(height: 200, width: 200),
                  ),
              ],
            );
          }(),
        ),
        BorderedContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('KyoshinMonitorMaintenance', style: titleTextStyle),
              Text(switch (ref.watch(kyoshinMonitorMaintenanceProvider)) {
                AsyncData(:final value) => const JsonEncoder.withIndent(
                  '  ',
                ).convert(value.toJson()),
                AsyncError(:final error) => error.toString(),
                _ => 'Loading...',
              }, style: bodyTextStyle),
            ],
          ),
        ),
        BorderedContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('KyoshinMonitorSettings', style: titleTextStyle),
              Text(
                const JsonEncoder.withIndent(
                  '  ',
                ).convert(ref.watch(kyoshinMonitorSettingsProvider).requireValue.toJson()),
                style: bodyTextStyle,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
