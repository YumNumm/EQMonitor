import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/home/ui/component/shake_detection/shake_detection_card.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// デバッグ用。ホーム画面と同じ [ShakeDetectionCard] の見た目を、
/// パラメータ操作で検証する。
class DebugShakeDetectionCardPage extends HookConsumerWidget {
  const DebugShakeDetectionCardPage({super.key});

  static const _paramLabelStyle = TextStyle(fontSize: 11);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final level = useState(ShakeDetectionLevel.medium);
    final createdAt = useState(DateTime.now());

    // バウンディングボックス（岩手県付近をデフォルト）
    final minLat = useState(38.9);
    final maxLat = useState(40.5);
    final minLng = useState(140.5);
    final maxLng = useState(141.8);

    ShakeDetectionEvent buildEvent() => ShakeDetectionEvent(
      eventId: 'debug-shake-1',
      createdAt: createdAt.value,
      level: level.value,
      isReplay: false,
      pointCount: 42,
      minLat: minLat.value,
      maxLat: maxLat.value,
      minLng: minLng.value,
      maxLng: maxLng.value,
      changeReasons: const ['new_event'],
    );

    return Scaffold(
      appBar: AppBar(title: const Text('揺れ検知 Card デバッグ')),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Text(
              'パラメータ（下記はいずれも検証用の表示です。実データではありません）',
              style: _paramLabelStyle.copyWith(
                color: context.designSystem.colorTheme.onSurfaceVariant,
              ),
            ),
          ),
          _ParamSection(
            title: 'レベル',
            child: Wrap(
              spacing: 6,
              runSpacing: 6,
              children: ShakeDetectionLevel.values
                  .map(
                    (e) => FilterChip(
                      label: Text(e.name, style: _paramLabelStyle),
                      selected: level.value == e,
                      onSelected: (_) => level.value = e,
                    ),
                  )
                  .toList(),
            ),
          ),
          _ParamSection(
            title: '検知時刻',
            child: OutlinedButton(
              onPressed: () async {
                final base = createdAt.value;
                final d = await showDatePicker(
                  context: context,
                  initialDate: base,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d == null || !context.mounted) {
                  return;
                }
                final t = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.fromDateTime(base),
                );
                if (t == null) {
                  return;
                }
                createdAt.value = DateTime(
                  d.year,
                  d.month,
                  d.day,
                  t.hour,
                  t.minute,
                  base.second,
                );
              },
              child: Text(
                createdAt.value.toLocal().toString(),
                style: _paramLabelStyle,
              ),
            ),
          ),
          _ParamSection(
            title: 'バウンディングボックス（緯度・経度）',
            child: Column(
              children: [
                _SliderRow(
                  label: 'minLat: ${minLat.value.toStringAsFixed(2)}°N',
                  value: minLat.value,
                  min: 24,
                  max: 46,
                  onChanged: (v) => minLat.value = v,
                ),
                _SliderRow(
                  label: 'maxLat: ${maxLat.value.toStringAsFixed(2)}°N',
                  value: maxLat.value,
                  min: 24,
                  max: 46,
                  onChanged: (v) => maxLat.value = v,
                ),
                _SliderRow(
                  label: 'minLng: ${minLng.value.toStringAsFixed(2)}°E',
                  value: minLng.value,
                  min: 122,
                  max: 154,
                  onChanged: (v) => minLng.value = v,
                ),
                _SliderRow(
                  label: 'maxLng: ${maxLng.value.toStringAsFixed(2)}°E',
                  value: maxLng.value,
                  min: 122,
                  max: 154,
                  onChanged: (v) => maxLng.value = v,
                ),
              ],
            ),
          ),
          const Divider(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text('プレビュー', style: Theme.of(context).textTheme.titleSmall),
          ),
          const SizedBox(height: 8),
          ShakeDetectionCard(event: buildEvent()),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              'サンプル一覧（レベル別・岩手県付近の固定エリア）',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              'よく使う組み合わせを並べています。上のパラメータとは独立です。',
              style: _paramLabelStyle.copyWith(
                color: context.designSystem.colorTheme.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(height: 8),
          ..._kSampleEvents.map((e) => ShakeDetectionCard(event: e)),
        ],
      ),
    );
  }
}

// 岩手県付近のバウンディングボックス
final List<ShakeDetectionEvent> _kSampleEvents = ShakeDetectionLevel.values
    .map(
      (level) => ShakeDetectionEvent(
        eventId: 'sample-${level.name}',
        createdAt: DateTime(2024, 1, 1, 12),
        level: level,
        isReplay: false,
        pointCount: 30,
        minLat: 38.9,
        maxLat: 40.5,
        minLng: 140.5,
        maxLng: 141.8,
        changeReasons: const ['new_event'],
      ),
    )
    .toList();

class _ParamSection extends StatelessWidget {
  const _ParamSection({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            child,
          ],
        ),
      ),
    );
  }
}

class _SliderRow extends StatelessWidget {
  const _SliderRow({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  final String label;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 160,
          child: Text(
            label,
            style: DebugShakeDetectionCardPage._paramLabelStyle,
          ),
        ),
        Expanded(
          child: Slider(
            value: value.clamp(min, max),
            min: min,
            max: max,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
