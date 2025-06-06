import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 揺れ検知設定UI
class ShakeDetectionSettings extends ConsumerWidget {
  const ShakeDetectionSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return BorderedContainer(
      label: '揺れ検知設定',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 説明文
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 20,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '揺れ検知について',
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '緊急地震速報が発表される前に、強震モニターの観測点で揺れを検知した場合にお知らせします。'
                  'これは地震の発生を知らせるものではありません。',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // 検知方式の説明
          _buildDetectionMethodsCard(theme),
          
          const SizedBox(height: 16),
          
          // 設定項目
          _buildSettingsSection(theme),
        ],
      ),
    );
  }

  /// 検知方式カード
  Widget _buildDetectionMethodsCard(ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '検知方式',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            
            // サーバーサイド検知
            _buildDetectionMethodTile(
              theme,
              icon: Icons.cloud,
              title: '公式検知',
              description: 'サーバーで処理された高精度な揺れ検知',
              isEnabled: true,
              color: theme.colorScheme.secondary,
            ),
            
            const SizedBox(height: 12),
            
            // クライアントサイド検知
            _buildDetectionMethodTile(
              theme,
              icon: Icons.sensors,
              title: 'リアルタイム検知',
              description: 'デバイス上でのリアルタイム解析による早期検知',
              isEnabled: true,
              color: theme.colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }

  /// 検知方式タイル
  Widget _buildDetectionMethodTile(
    ThemeData theme, {
    required IconData icon,
    required String title,
    required String description,
    required bool isEnabled,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 24,
            color: color,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            isEnabled ? Icons.check_circle : Icons.radio_button_unchecked,
            color: isEnabled ? Colors.green : theme.colorScheme.outline,
          ),
        ],
      ),
    );
  }

  /// 設定セクション
  Widget _buildSettingsSection(ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '検知パラメータ',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            
            // 検知感度
            _buildSliderSetting(
              theme,
              title: '検知感度',
              description: '低い値ほど小さな揺れも検知します',
              value: 0.5,
              min: 0.1,
              max: 2.0,
              divisions: 19,
              valueFormatter: (value) => '${value.toStringAsFixed(1)} gal',
              onChanged: (value) {
                // TODO: 実装
              },
            ),
            
            const SizedBox(height: 16),
            
            // 最小観測点数
            _buildSliderSetting(
              theme,
              title: '最小観測点数',
              description: '検知に必要な最小観測点数',
              value: 3.0,
              min: 2.0,
              max: 10.0,
              divisions: 8,
              valueFormatter: (value) => '${value.round()} 点',
              onChanged: (value) {
                // TODO: 実装
              },
            ),
            
            const SizedBox(height: 16),
            
            // 近隣点検索半径
            _buildSliderSetting(
              theme,
              title: '近隣点検索半径',
              description: '揺れの空間的関連性を判定する範囲',
              value: 25.0,
              min: 10.0,
              max: 50.0,
              divisions: 8,
              valueFormatter: (value) => '${value.round()} km',
              onChanged: (value) {
                // TODO: 実装
              },
            ),
          ],
        ),
      ),
    );
  }

  /// スライダー設定ウィジェット
  Widget _buildSliderSetting(
    ThemeData theme, {
    required String title,
    required String description,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required String Function(double) valueFormatter,
    required ValueChanged<double> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                valueFormatter(value),
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 8),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: divisions,
          onChanged: onChanged,
        ),
      ],
    );
  }
}