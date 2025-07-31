import 'package:eqmonitor/feature/tsunami_history/models/tsunami_models.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class TsunamiDetailsPage extends HookConsumerWidget {
  const TsunamiDetailsPage({
    required this.event,
    super.key,
  });

  final TsunamiEvent event;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // 津波警報レベルを取得
    final warningLevel = event.highestWarning;
    final warningColor = _getWarningColor(
      warningLevel?.color ?? TsunamiWarningColor.grey,
    );

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          // AppBar
          SliverAppBar(
            title: const Text('津波情報'),
            backgroundColor: warningColor,
            foregroundColor: Colors.white,
            pinned: true,
            expandedHeight: 120,
            flexibleSpace: FlexibleSpaceBar(
              background: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      warningColor,
                      warningColor.withValues(alpha: 0.8),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 60, 16, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${_formatDateTime(event.pressAt)} 発表',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white.withValues(alpha: 0.9),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          event.headline ?? 'ヘッドラインなし',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // 詳細情報
          SliverToBoxAdapter(
            child: Column(
              children: [
                // 基本情報カード
                _buildInfoCard(
                  context,
                  title: '基本情報',
                  initiallyExpanded: true,
                  children: [
                    _buildInfoRow('イベントID', event.eventId),
                    _buildInfoRow('情報種別', event.infoType),
                    _buildInfoRow('状態', event.status),
                    _buildInfoRow('発表時刻', _formatDateTime(event.pressAt)),
                    _buildInfoRow('報告時刻', _formatDateTime(event.reportAt)),
                    if (event.validAt != null)
                      _buildInfoRow(
                        '有効期限',
                        '${_formatDateTime(event.validAt!)}${event.isExpired ? ' (期限切れ)' : ''}',
                      ),
                  ],
                ),

                // 津波情報（統合）
                if (event.info != null)
                  _buildTsunamiInfoCard(context, event.info!),

                // 沖合観測情報
                if (event.observationInfo != null)
                  _buildObservationInfoCard(context, event.observationInfo!),

                const SizedBox(height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required String title,
    required List<Widget> children,
    bool isExpansionTile = false,
    bool initiallyExpanded = false,
  }) {
    if (isExpansionTile) {
      return Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: ExpansionTile(
          title: Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          initiallyExpanded: initiallyExpanded,
          childrenPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          children: children,
        ),
      );
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTsunamiInfoCard(BuildContext context, TsunamiInfo info) {
    return _buildInfoCard(
      context,
      title: '津波情報',
      isExpansionTile: true,
      children: [
        if (info.areas.isNotEmpty) ...[
          const Text(
            '地域別津波情報',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          const SizedBox(height: 6),
          ...info.areas.map(_buildAreaItem),
        ],
        if (info.observations?.isNotEmpty ?? false) ...[
          const SizedBox(height: 12),
          const Text(
            '津波観測（観測値 + 警報情報）',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          const SizedBox(height: 6),
          ...info.observations!.map(
            (obs) => _buildObservationItem(obs, info.areas),
          ),
        ],
      ],
    );
  }

  Widget _buildObservationInfoCard(
    BuildContext context,
    TsunamiObservationInfo info,
  ) {
    return _buildInfoCard(
      context,
      title: '沖合の津波観測',
      isExpansionTile: true,
      children: [
        if (info.observations?.isNotEmpty ?? false) ...[
          const Text(
            '沖合観測データ',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          const SizedBox(height: 6),
          ...info.observations!.map((obs) => _buildObservationItem(obs, [])),
        ],
        if (info.estimations?.isNotEmpty ?? false) ...[
          const SizedBox(height: 12),
          const Text(
            '津波推定',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          const SizedBox(height: 6),
          ...info.estimations!.map(_buildEstimationItem),
        ],
      ],
    );
  }

  Widget _buildAreaItem(TsunamiArea area) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: area.warning != null
            ? _getWarningColor(area.warning!.color).withValues(alpha: 0.1)
            : Colors.grey.withValues(alpha: 0.1),
        border: Border.all(
          color: area.warning != null
              ? _getWarningColor(area.warning!.color).withValues(alpha: 0.3)
              : Colors.grey.withValues(alpha: 0.3),
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (area.warning != null) ...[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: _getWarningColor(area.warning!.color),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Text(
                    area.warning!.displayName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
              ],
              Expanded(
                child: Text(
                  area.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          if (area.maxHeight != null) ...[
            Row(
              children: [
                const Text('津波の高さ: ', style: TextStyle(color: Colors.grey)),
                Text(
                  area.maxHeight!.displayText,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
          if (area.firstHeight?.arrivalTime != null) ...[
            Row(
              children: [
                const Text('到達予想時刻: ', style: TextStyle(color: Colors.grey)),
                Text(
                  _formatDateTime(area.firstHeight!.arrivalTime!),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
          if (area.firstHeight?.situation != null) ...[
            Row(
              children: [
                const Text('状況: ', style: TextStyle(color: Colors.grey)),
                Text(
                  area.firstHeight!.situation!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildObservationItem(
    TsunamiObservation observation,
    List<TsunamiArea> areas,
  ) {
    // 観測地域に対応する警報情報を検索
    final correspondingArea = _findCorrespondingArea(observation, areas);
    // 警報レベルに応じた色を設定
    final warningColor = correspondingArea?.warning != null
        ? _getWarningColor(correspondingArea!.warning!.color)
        : Colors.blue;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: warningColor.withValues(alpha: 0.1),
        border: Border.all(color: warningColor.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ヘッダー部分（観測地域名と警報情報）
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (observation.name != null) ...[
                      Text(
                        observation.name!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                    // 対応する警報情報の表示
                    if (correspondingArea != null) ...[
                      const SizedBox(height: 4),
                      _buildWarningInfoSection(correspondingArea),
                    ],
                  ],
                ),
              ),
              // 警報レベルバッジ
              if (correspondingArea?.warning != null) ...[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: warningColor,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Text(
                    correspondingArea!.warning!.displayName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 8),
          // 観測地点データ
          ...observation.stations.map(_buildObservationStationItem),
        ],
      ),
    );
  }

  Widget _buildObservationStationItem(TsunamiObservationStation station) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            station.name,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 3),
          if (station.firstHeight?.arrivalTime != null) ...[
            Row(
              children: [
                const Text(
                  '第一波到達時刻: ',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Text(
                  _formatDateTime(station.firstHeight!.arrivalTime!),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
          if (station.maxHeight?.displayText != null) ...[
            Row(
              children: [
                const Text(
                  '最大波: ',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Text(
                  station.maxHeight!.displayText!,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
          if (station.condition != null) ...[
            Text(
              station.condition!,
              style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildEstimationItem(TsunamiEstimation estimation) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.blue.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            estimation.name,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 3),
          if (estimation.firstHeight?.arrivalTime != null) ...[
            Row(
              children: [
                const Text(
                  '第一波到達予想時刻: ',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Text(
                  _formatDateTime(estimation.firstHeight!.arrivalTime!),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
          if (estimation.maxHeight?.displayText != null) ...[
            Row(
              children: [
                const Text(
                  '最大波予想高さ: ',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Text(
                  estimation.maxHeight!.displayText,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
          if (estimation.revise != null) ...[
            Text(
              '${estimation.revise}',
              style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            ),
          ],
        ],
      ),
    );
  }

  Color _getWarningColor(TsunamiWarningColor warningColor) {
    return switch (warningColor) {
      TsunamiWarningColor.purple => Colors.purple,
      TsunamiWarningColor.red => Colors.red,
      TsunamiWarningColor.yellow => Colors.orange,
      TsunamiWarningColor.blue => Colors.blue,
      TsunamiWarningColor.grey => Colors.grey,
    };
  }

  String _formatDateTime(DateTime dateTime) {
    final local = dateTime.toLocal();
    return DateFormat('M/d HH:mm').format(local);
  }

  /// 観測地域に対応する警報地域を検索
  TsunamiArea? _findCorrespondingArea(
    TsunamiObservation observation,
    List<TsunamiArea> areas,
  ) {
    if (observation.code != null) {
      // コードが一致する地域を検索
      final matchingAreas = areas.where(
        (area) => area.code == observation.code,
      );
      if (matchingAreas.isNotEmpty) {
        return matchingAreas.first;
      }
    }

    if (observation.name != null) {
      // 名前が部分一致する地域を検索
      final matchingAreas = areas.where(
        (area) =>
            area.name.contains(observation.name!) ||
            observation.name!.contains(area.name),
      );
      if (matchingAreas.isNotEmpty) {
        return matchingAreas.first;
      }
    }

    return null;
  }

  /// 警報情報セクションの構築
  Widget _buildWarningInfoSection(TsunamiArea area) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (area.maxHeight != null) ...[
          Row(
            children: [
              const Text(
                '予想高さ: ',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              Text(
                area.maxHeight!.displayText,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
        if (area.firstHeight?.arrivalTime != null) ...[
          const SizedBox(height: 2),
          Row(
            children: [
              const Text(
                '到達予想: ',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              Text(
                _formatDateTime(area.firstHeight!.arrivalTime!),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
        if (area.firstHeight?.situation != null) ...[
          const SizedBox(height: 2),
          Row(
            children: [
              const Text(
                '状況: ',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              Flexible(
                child: Text(
                  area.firstHeight!.situation!,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
