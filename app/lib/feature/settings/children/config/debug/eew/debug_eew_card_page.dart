import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_info_type.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/home/ui/component/eew/eew_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// デバッグ用。ホーム画面と同じ [EewWidget] の見た目を、パラメータ操作で検証する。
class DebugEewCardPage extends HookConsumerWidget {
  const DebugEewCardPage({super.key});

  static const _paramLabelStyle = TextStyle(fontSize: 11);
  static const _paramValueStyle = TextStyle(fontSize: 11);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventId = useTextEditingController(text: 'debug-event-1');
    final headline = useTextEditingController();
    final hypocenterName = useTextEditingController(text: '三陸沖');
    final stackIndexLabel = useTextEditingController(text: '1');

    useListenable(eventId);
    useListenable(headline);
    useListenable(hypocenterName);
    useListenable(stackIndexLabel);

    final status = useState(TelegramStatus.normal);
    final infoType = useState(TelegramInfoType.publication);
    final serialNo = useState(3);
    final isCanceled = useState(false);
    final isLastInfo = useState(false);
    final isPlum = useState(false);
    final isWarning = useState<bool?>(false);

    final originTime = useState<DateTime?>(
      DateTime.utc(2024, 3, 11, 5, 46, 24),
    );
    final useOriginTime = useState(true);

    final magnitude = useState<double?>(7.2);
    final depth = useState<int?>(24);

    final maxIntensity = useState(JmaIntensity.fiveUpper);
    final maxIntensityIsOver = useState(false);

    final maxLpgm = useState<JmaLpgmIntensity?>(JmaLpgmIntensity.two);
    final maxLpgmIsOver = useState(false);
    final showLpgmSection = useState(false);

    final showStackIndex = useState(false);

    EewTelegramItem buildEew() {
      final now = DateTime.now().toUtc();
      final mag = magnitude.value;
      final dep = depth.value;
      final hypo = EewHypocenterInfo(
        code: '001',
        name: hypocenterName.text.isEmpty ? '不明' : hypocenterName.text,
        hasLatLng: true,
        latitude: 38,
        longitude: 142,
        magnitude: mag,
        depth: dep,
      );

      var lpgm = maxLpgm.value;
      if (!showLpgmSection.value) {
        lpgm = null;
      } else if (lpgm == null || lpgm == JmaLpgmIntensity.zero) {
        lpgm = JmaLpgmIntensity.zero;
      }

      final forecast = EewForecastIntensityInfo(
        regions: const [],
        maxIntensity: maxIntensity.value,
        maxIntensityIsOver: maxIntensityIsOver.value,
        maxLpgmIntensity: lpgm,
        maxLpgmIntensityIsOver: maxLpgmIsOver.value,
      );

      final h = headline.text.trim();
      final t = originTime.value ?? DateTime.now().toUtc();
      return EewTelegramItem(
        eventId: eventId.text.trim().isEmpty ? 'debug' : eventId.text.trim(),
        status: status.value,
        infoType: infoType.value,
        serialNo: serialNo.value,
        isCanceled: isCanceled.value,
        isLastInfo: isLastInfo.value,
        reportTime: now,
        isPlum: isPlum.value,
        headline: h.isEmpty ? null : h,
        isWarning: isWarning.value,
        originTime: useOriginTime.value ? t : null,
        arrivalTime: useOriginTime.value ? null : t,
        editorialOffice: '気象庁',
        hypocenter: hypo,
        forecastIntensity: isCanceled.value ? null : forecast,
      );
    }

    final eew = buildEew();

    return Scaffold(
      appBar: AppBar(title: const Text('EEW Card デバッグ')),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Text(
              'パラメータ（下記はいずれも検証用の表示です。実データではありません）',
              style: _paramLabelStyle.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          _ParamSection(
            title: 'ステータス・種別',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _LabeledRow(
                  label: 'TelegramStatus',
                  child: SegmentedButton<TelegramStatus>(
                    showSelectedIcon: false,
                    segments: TelegramStatus.values
                        .map(
                          (e) => ButtonSegment(
                            value: e,
                            label: Text(e.name, style: _paramValueStyle),
                          ),
                        )
                        .toList(),
                    selected: {status.value},
                    onSelectionChanged: (s) => status.value = s.first,
                  ),
                ),
                const SizedBox(height: 8),
                _LabeledRow(
                  label: 'InfoType',
                  child: Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: TelegramInfoType.values
                        .map(
                          (e) => FilterChip(
                            label: Text(e.name, style: _paramValueStyle),
                            selected: infoType.value == e,
                            onSelected: (_) => infoType.value = e,
                          ),
                        )
                        .toList(),
                  ),
                ),
                const SizedBox(height: 8),
                _SmallField(
                  label: 'eventId',
                  controller: eventId,
                  hint: 'イベントID',
                ),
                _LabeledRow(
                  label: 'serialNo（報数）',
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove, size: 18),
                        onPressed: () =>
                            serialNo.value = (serialNo.value - 1).clamp(1, 999),
                      ),
                      Text('${serialNo.value}', style: _paramValueStyle),
                      IconButton(
                        icon: const Icon(Icons.add, size: 18),
                        onPressed: () =>
                            serialNo.value = (serialNo.value + 1).clamp(1, 999),
                      ),
                    ],
                  ),
                ),
                _BoolRow(
                  label: 'isCanceled（取消）',
                  value: isCanceled.value,
                  onChanged: (v) => isCanceled.value = v,
                ),
                _BoolRow(
                  label: 'isLastInfo（最終）',
                  value: isLastInfo.value,
                  onChanged: (v) => isLastInfo.value = v,
                ),
                _BoolRow(
                  label: 'isPlum（PLUM法）',
                  value: isPlum.value,
                  onChanged: (v) => isPlum.value = v,
                ),
                _LabeledRow(
                  label: 'isWarning（nullは headline 由来にフォールバック）',
                  child: SegmentedButton<bool?>(
                    showSelectedIcon: false,
                    segments: const [
                      ButtonSegment(value: false, label: Text('false')),
                      ButtonSegment(value: null, label: Text('null')),
                      ButtonSegment(value: true, label: Text('true')),
                    ],
                    selected: {isWarning.value},
                    onSelectionChanged: (s) => isWarning.value = s.first,
                  ),
                ),
                _SmallField(
                  label: 'headline（取消文・注記など）',
                  controller: headline,
                  hint: '空なら未設定',
                  maxLines: 2,
                ),
              ],
            ),
          ),
          _ParamSection(
            title: '時刻・震源',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _BoolRow(
                  label: 'originTime を使う（OFFで arrival のみ＝検知扱い）',
                  value: useOriginTime.value,
                  onChanged: (v) => useOriginTime.value = v,
                ),
                _LabeledRow(
                  label: '発生/検知時刻（ローカル表示）',
                  child: OutlinedButton(
                    onPressed: () async {
                      final base = originTime.value ?? DateTime.now();
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
                      if (t == null || !context.mounted) {
                        return;
                      }
                      originTime.value = DateTime(
                        d.year,
                        d.month,
                        d.day,
                        t.hour,
                        t.minute,
                        base.second,
                      );
                    },
                    child: Text(
                      originTime.value?.toLocal().toString() ?? '未設定',
                      style: _paramValueStyle,
                    ),
                  ),
                ),
                _SmallField(
                  label: '震央名',
                  controller: hypocenterName,
                  hint: '震源地/検知観測点のラベル',
                ),
                _LabeledRow(
                  label: 'M（nullで不明表示）',
                  child: Row(
                    children: [
                      Expanded(
                        child: Slider(
                          value: magnitude.value ?? 7.2,
                          max: 9.5,
                          divisions: 95,
                          label: magnitude.value?.toStringAsFixed(1) ?? 'null',
                          onChanged: (v) => magnitude.value = v,
                        ),
                      ),
                      TextButton(
                        onPressed: () => magnitude.value =
                            magnitude.value == null ? 7.2 : null,
                        child: Text(
                          magnitude.value == null ? '設定' : '不明(null)',
                          style: _paramValueStyle,
                        ),
                      ),
                    ],
                  ),
                ),
                _LabeledRow(
                  label: '深さ km（nullで不明）',
                  child: Row(
                    children: [
                      Expanded(
                        child: Slider(
                          value: (depth.value ?? 24).toDouble(),
                          max: 700,
                          divisions: 70,
                          label: '${depth.value ?? "null"} km',
                          onChanged: (v) => depth.value = v.round(),
                        ),
                      ),
                      TextButton(
                        onPressed: () =>
                            depth.value = depth.value == null ? 24 : null,
                        child: Text(
                          depth.value == null ? '設定' : '不明(null)',
                          style: _paramValueStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _ParamSection(
            title: '予想震度・長周期',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _LabeledRow(
                  label: 'maxIntensity',
                  child: DropdownButton<JmaIntensity>(
                    isExpanded: true,
                    value: maxIntensity.value,
                    style: _paramValueStyle,
                    items: JmaIntensity.values
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.label, style: _paramValueStyle),
                          ),
                        )
                        .toList(),
                    onChanged: (v) {
                      if (v != null) {
                        maxIntensity.value = v;
                      }
                    },
                  ),
                ),
                _BoolRow(
                  label: 'maxIntensityIsOver',
                  value: maxIntensityIsOver.value,
                  onChanged: (v) => maxIntensityIsOver.value = v,
                ),
                _BoolRow(
                  label: 'LPGM 行を表示',
                  value: showLpgmSection.value,
                  onChanged: (v) => showLpgmSection.value = v,
                ),
                if (showLpgmSection.value) ...[
                  _LabeledRow(
                    label: 'maxLpgmIntensity',
                    child: DropdownButton<JmaLpgmIntensity?>(
                      isExpanded: true,
                      value: maxLpgm.value,
                      style: _paramValueStyle,
                      items: [
                        const DropdownMenuItem<JmaLpgmIntensity?>(
                          child: Text('null', style: _paramValueStyle),
                        ),
                        ...JmaLpgmIntensity.values.map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.label, style: _paramValueStyle),
                          ),
                        ),
                      ],
                      onChanged: (v) => maxLpgm.value = v,
                    ),
                  ),
                  _BoolRow(
                    label: 'maxLpgmIntensityIsOver',
                    value: maxLpgmIsOver.value,
                    onChanged: (v) => maxLpgmIsOver.value = v,
                  ),
                ],
              ],
            ),
          ),
          _ParamSection(
            title: '表示オプション',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _BoolRow(
                  label: '複数件時のインデックス（透かし数字）',
                  value: showStackIndex.value,
                  onChanged: (v) => showStackIndex.value = v,
                ),
                if (showStackIndex.value)
                  _SmallField(
                    label: 'インデックス文字',
                    controller: stackIndexLabel,
                    hint: '1, 2, ...',
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
          EewWidget(
            eew: eew,
            index: showStackIndex.value
                ? (stackIndexLabel.text.trim().isEmpty
                      ? null
                      : stackIndexLabel.text.trim())
                : null,
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              'サンプル一覧',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              'よく使う組み合わせを並べています。上のパラメータとは独立です。',
              style: _paramLabelStyle.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          ..._kSampleEews.asMap().entries.map(
            (e) => EewWidget(
              eew: e.value,
              index: '${e.key + 1}',
            ),
          ),
        ],
      ),
    );
  }
}

/// 検証用の固定サンプル（実データではない）
final _kSampleEews = <EewTelegramItem>[
  EewTelegramItem(
    eventId: 'sample-1',
    status: TelegramStatus.normal,
    infoType: TelegramInfoType.publication,
    serialNo: 1,
    isCanceled: false,
    isLastInfo: false,
    reportTime: DateTime.utc(2024, 1, 1, 12),
    isPlum: false,
    isWarning: false,
    originTime: DateTime.utc(2024, 1, 1, 11, 59, 50),
    hypocenter: const EewHypocenterInfo(
      code: 's1',
      name: '東京湾',
      hasLatLng: true,
      magnitude: 5.4,
      depth: 80,
    ),
    forecastIntensity: const EewForecastIntensityInfo(
      regions: [],
      maxIntensity: JmaIntensity.four,
    ),
  ),
  EewTelegramItem(
    eventId: 'sample-2',
    status: TelegramStatus.normal,
    infoType: TelegramInfoType.publication,
    serialNo: 8,
    isCanceled: false,
    isLastInfo: true,
    reportTime: DateTime.utc(2024, 1, 1, 12, 5),
    isPlum: false,
    isWarning: true,
    originTime: DateTime.utc(2024, 1, 1, 11, 59, 50),
    hypocenter: const EewHypocenterInfo(
      code: 's2',
      name: '南海トラフ付近',
      hasLatLng: true,
      magnitude: 8.4,
      depth: 10,
    ),
    forecastIntensity: const EewForecastIntensityInfo(
      regions: [],
      maxIntensity: JmaIntensity.sixUpper,
      maxIntensityIsOver: true,
    ),
  ),
  EewTelegramItem(
    eventId: 'sample-plum',
    status: TelegramStatus.normal,
    infoType: TelegramInfoType.publication,
    serialNo: 2,
    isCanceled: false,
    isLastInfo: false,
    reportTime: DateTime.utc(2024, 1, 1, 12, 1),
    isPlum: true,
    isWarning: false,
    arrivalTime: DateTime.utc(2024, 1, 1, 12, 0, 30),
    hypocenter: const EewHypocenterInfo(
      code: 's3',
      name: '青森県東方沖',
      hasLatLng: true,
    ),
    forecastIntensity: const EewForecastIntensityInfo(
      regions: [],
      maxIntensity: JmaIntensity.fiveLower,
    ),
  ),
  EewTelegramItem(
    eventId: 'sample-cancel',
    status: TelegramStatus.normal,
    infoType: TelegramInfoType.cancellation,
    serialNo: 4,
    isCanceled: true,
    isLastInfo: true,
    reportTime: DateTime.utc(2024, 1, 1, 12, 10),
    isPlum: false,
    headline: '先ほどの緊急地震速報は取り消されました',
    isWarning: false,
    originTime: DateTime.utc(2024, 1, 1, 11, 59, 50),
    hypocenter: const EewHypocenterInfo(
      code: 's4',
      name: '取消テスト',
      hasLatLng: true,
      magnitude: 3,
      depth: 10,
    ),
  ),
  EewTelegramItem(
    eventId: 'sample-test',
    status: TelegramStatus.test,
    infoType: TelegramInfoType.publication,
    serialNo: 1,
    isCanceled: false,
    isLastInfo: false,
    reportTime: DateTime.utc(2024, 1, 2, 10),
    isPlum: false,
    isWarning: false,
    originTime: DateTime.utc(2024, 1, 2, 9, 59, 50),
    hypocenter: const EewHypocenterInfo(
      code: 's6',
      name: 'テスト電文',
      hasLatLng: true,
      magnitude: 4.5,
      depth: 12,
    ),
    forecastIntensity: const EewForecastIntensityInfo(
      regions: [],
      maxIntensity: JmaIntensity.three,
    ),
  ),
  EewTelegramItem(
    eventId: 'sample-train',
    status: TelegramStatus.training,
    infoType: TelegramInfoType.publication,
    serialNo: 1,
    isCanceled: false,
    isLastInfo: false,
    reportTime: DateTime.utc(2024, 1, 1, 9),
    isPlum: false,
    isWarning: false,
    originTime: DateTime.utc(2024, 1, 1, 8, 59, 40),
    hypocenter: const EewHypocenterInfo(
      code: 's5',
      name: '訓練',
      hasLatLng: true,
      magnitude: 6,
      depth: 20,
    ),
    forecastIntensity: const EewForecastIntensityInfo(
      regions: [],
      maxIntensity: JmaIntensity.fiveUpper,
    ),
  ),
];

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

class _LabeledRow extends StatelessWidget {
  const _LabeledRow({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: DebugEewCardPage._paramLabelStyle),
          child,
        ],
      ),
    );
  }
}

class _BoolRow extends StatelessWidget {
  const _BoolRow({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      title: Text(label, style: DebugEewCardPage._paramLabelStyle),
      value: value,
      onChanged: onChanged,
    );
  }
}

class _SmallField extends StatelessWidget {
  const _SmallField({
    required this.label,
    this.controller,
    this.child,
    this.hint,
    this.maxLines = 1,
  }) : assert(
         controller != null || child != null,
         'controller or child',
       );

  final String label;
  final TextEditingController? controller;
  final Widget? child;
  final String? hint;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: DebugEewCardPage._paramLabelStyle),
          if (child != null)
            child!
          else
            TextField(
              controller: controller,
              maxLines: maxLines,
              style: DebugEewCardPage._paramValueStyle,
              decoration: InputDecoration(
                isDense: true,
                hintText: hint,
                hintStyle: DebugEewCardPage._paramLabelStyle,
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 8,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
