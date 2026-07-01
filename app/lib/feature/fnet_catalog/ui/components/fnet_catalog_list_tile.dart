import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nied_api_client/nied_api_client.dart';

/// F-netカタログのリストタイル
class FnetCatalogListTile extends StatelessWidget {
  const FnetCatalogListTile({
    required this.event,
    super.key,
  });

  final FnetEvent event;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('yyyy/MM/dd HH:mm:ss');

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: InkWell(
        onTap: () {
          // 詳細画面への遷移（後で実装）
          _showDetails(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event.regionName.replaceAll('_', ' '),
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          dateFormat.format(event.originTime.toLocal()),
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _MagnitudeChip(
                        label: 'M${event.jmaMagnitude.toStringAsFixed(1)}',
                        magnitude: event.jmaMagnitude,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Mw${event.momentMagnitude.toStringAsFixed(1)}',
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _InfoItem(
                    label: '深さ',
                    value: '${event.jmaDepth.toStringAsFixed(1)} km',
                  ),
                  _InfoItem(
                    label: '緯度/経度',
                    value:
                        '${event.latitude.toStringAsFixed(2)}°/${event.longitude.toStringAsFixed(2)}°',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDetails(BuildContext context) => showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return _DetailSheet(
          event: event,
          scrollController: scrollController,
        );
      },
    ),
  );
}

class _MagnitudeChip extends StatelessWidget {
  const _MagnitudeChip({
    required this.label,
    required this.magnitude,
  });

  final String label;
  final double magnitude;

  @override
  Widget build(BuildContext context) {
    final color = _getMagnitudeColor(magnitude);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Color _getMagnitudeColor(double magnitude) {
    if (magnitude >= 7.0) {
      return Colors.purple;
    }
    if (magnitude >= 6.0) {
      return Colors.red;
    }
    if (magnitude >= 5.0) {
      return Colors.orange;
    }
    if (magnitude >= 4.0) {
      return Colors.yellow[700]!;
    }
    return Colors.green;
  }
}

class _InfoItem extends StatelessWidget {
  const _InfoItem({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: context.designSystem.colorTheme.onSurfaceVariant,
          ),
        ),
        Text(
          value,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _DetailSheet extends StatelessWidget {
  const _DetailSheet({
    required this.event,
    required this.scrollController,
  });

  final FnetEvent event;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('yyyy/MM/dd HH:mm:ss.SSS');

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: context.designSystem.colorTheme.onSurfaceVariant.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Expanded(
            child: ListView(
              controller: scrollController,
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  event.regionName.replaceAll('_', ' '),
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '発生時刻: ${dateFormat.format(event.originTime.toLocal())} (UTC)',
                  style: theme.textTheme.bodyMedium,
                ),
                const Divider(height: 32),
                _Section(
                  title: '基本情報',
                  children: [
                    _InfoRow(
                      label: '緯度',
                      value: '${event.latitude.toStringAsFixed(4)}°',
                    ),
                    _InfoRow(
                      label: '経度',
                      value: '${event.longitude.toStringAsFixed(4)}°',
                    ),
                    _InfoRow(
                      label: 'JMA震源深さ',
                      value: '${event.jmaDepth.toStringAsFixed(2)} km',
                    ),
                    _InfoRow(
                      label: 'JMAマグニチュード',
                      value: event.jmaMagnitude.toStringAsFixed(1),
                    ),
                    _InfoRow(
                      label: 'MT震源深さ',
                      value: '${event.mtDepth.toStringAsFixed(2)} km',
                    ),
                    _InfoRow(
                      label: 'モーメントマグニチュード',
                      value: event.momentMagnitude.toStringAsFixed(1),
                    ),
                    _InfoRow(
                      label: '地震モーメント',
                      value:
                          '${event.seismicMoment.toStringAsExponential(2)} Nm',
                    ),
                    _InfoRow(
                      label: 'バリアンス・リダクション',
                      value: '${event.varianceReduction.toStringAsFixed(2)}%',
                    ),
                    _InfoRow(
                      label: '使用観測点数',
                      value: '${event.numberOfStations}',
                    ),
                  ],
                ),
                const Divider(height: 32),
                _Section(
                  title: '断層パラメータ',
                  children: [
                    _InfoRow(
                      label: '走向 (Strike)',
                      value:
                          '${event.strike.plane1.toStringAsFixed(0)}° / ${event.strike.plane2.toStringAsFixed(0)}°',
                    ),
                    _InfoRow(
                      label: '傾斜角 (Dip)',
                      value:
                          '${event.dip.plane1.toStringAsFixed(0)}° / ${event.dip.plane2.toStringAsFixed(0)}°',
                    ),
                    _InfoRow(
                      label: 'すべり角 (Rake)',
                      value:
                          '${event.rake.plane1.toStringAsFixed(0)}° / ${event.rake.plane2.toStringAsFixed(0)}°',
                    ),
                  ],
                ),
                const Divider(height: 32),
                _Section(
                  title: 'モーメントテンソル成分',
                  children: [
                    _InfoRow(
                      label: 'Mxx',
                      value:
                          '${event.momentTensor.mxx.toStringAsFixed(4)} × ${event.unit.toStringAsExponential(0)} Nm',
                    ),
                    _InfoRow(
                      label: 'Mxy',
                      value:
                          '${event.momentTensor.mxy.toStringAsFixed(4)} × ${event.unit.toStringAsExponential(0)} Nm',
                    ),
                    _InfoRow(
                      label: 'Mxz',
                      value:
                          '${event.momentTensor.mxz.toStringAsFixed(4)} × ${event.unit.toStringAsExponential(0)} Nm',
                    ),
                    _InfoRow(
                      label: 'Myy',
                      value:
                          '${event.momentTensor.myy.toStringAsFixed(4)} × ${event.unit.toStringAsExponential(0)} Nm',
                    ),
                    _InfoRow(
                      label: 'Myz',
                      value:
                          '${event.momentTensor.myz.toStringAsFixed(4)} × ${event.unit.toStringAsExponential(0)} Nm',
                    ),
                    _InfoRow(
                      label: 'Mzz',
                      value:
                          '${event.momentTensor.mzz.toStringAsFixed(4)} × ${event.unit.toStringAsExponential(0)} Nm',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
