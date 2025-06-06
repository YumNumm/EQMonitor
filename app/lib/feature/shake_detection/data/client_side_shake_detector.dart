import 'dart:math';

import 'package:eqapi_types/eqapi_types.dart';
import 'package:kyoshin_monitor_image_parser/kyoshin_monitor_image_parser.dart';
import 'package:kyoshin_observation_point_types/kyoshin_observation_point.pb.dart';

/// クライアントサイド揺れ検知アルゴリズム
/// サーバーサイド検知の補完として動作
class ClientSideShakeDetector {
  ClientSideShakeDetector({
    this.spatialNeighborRadius = 25.0, // km
    this.intensityThreshold = 0.5, // gal above baseline
    this.minimumClusterSize = 3,
    this.temporalBaselineSeconds = 30,
  });

  /// 近隣点の検索半径 (km)
  final double spatialNeighborRadius;

  /// 検知しきい値 (gal, ベースライン比)
  final double intensityThreshold;

  /// 最小クラスターサイズ
  final int minimumClusterSize;

  /// 時間的ベースライン計算期間 (秒)
  final int temporalBaselineSeconds;

  /// 過去の観測データ履歴
  final Map<String, List<_HistoricalIntensityData>> _history = {};

  /// 地震波の到達予測に使用する標準速度 (km/s)
  static const double _pWaveVelocity = 6.0; // P波速度
  static const double _sWaveVelocity = 3.5; // S波速度

  /// 揺れ検知を実行
  List<ClientShakeDetectionEvent> detectShaking(
    List<KyoshinMonitorImageParseObservationPoint> currentPoints,
    DateTime timestamp,
  ) {
    final detectionResults = <_DetectionResult>[];

    // 各観測点の解析
    for (final point in currentPoints) {
      final result = _analyzeObservationPoint(point, timestamp);
      if (result != null) {
        detectionResults.add(result);
      }
    }

    // 空間的クラスタリング
    final clusters = _performSpatialClustering(detectionResults);

    // イベントに変換
    return _createDetectionEvents(clusters, timestamp);
  }

  /// 観測点の解析
  _DetectionResult? _analyzeObservationPoint(
    KyoshinMonitorImageParseObservationPoint point,
    DateTime timestamp,
  ) {
    final code = point.point.code;
    final currentIntensity = _extractIntensityValue(point.observation);

    // 履歴データに追加
    _addToHistory(code, currentIntensity, timestamp);

    // ベースライン計算
    final baseline = _calculateBaseline(code);
    if (baseline == null) return null;

    // しきい値チェック
    final intensityDiff = currentIntensity - baseline;
    if (intensityDiff < intensityThreshold) return null;

    // 近隣点との比較
    final isValidated = _validateWithNeighbors(point, intensityDiff);
    if (!isValidated) return null;

    return _DetectionResult(
      point: point,
      intensityDiff: intensityDiff,
      baseline: baseline,
      timestamp: timestamp,
    );
  }

  /// 震度値の抽出
  double _extractIntensityValue(
    KyoshinMonitorObservationAnalyzedPoint observation,
  ) {
    // 震度またはPGA値を取得
    if (observation.intensity case final intensity?) {
      return _jmaIntensityToGal(intensity);
    }
    if (observation.pgaValue case final pga?) {
      return pga;
    }
    return 0.0;
  }

  /// JMA震度をgal相当値に変換
  double _jmaIntensityToGal(JmaForecastIntensity intensity) => switch (intensity) {
    JmaForecastIntensity.zero => 0.5,
    JmaForecastIntensity.one => 1.4,
    JmaForecastIntensity.two => 4.5,
    JmaForecastIntensity.three => 14.0,
    JmaForecastIntensity.four => 45.0,
    JmaForecastIntensity.fiveLower => 80.0,
    JmaForecastIntensity.fiveUpper => 140.0,
    JmaForecastIntensity.sixLower => 250.0,
    JmaForecastIntensity.sixUpper => 400.0,
    JmaForecastIntensity.seven => 600.0,
    JmaForecastIntensity.unknown => 0.0,
  };

  /// 履歴データに追加
  void _addToHistory(String code, double intensity, DateTime timestamp) {
    _history[code] ??= [];
    final history = _history[code]!;

    history.add(_HistoricalIntensityData(intensity, timestamp));

    // 古いデータを削除 (ベースライン期間より古いもの)
    final cutoff = timestamp.subtract(Duration(seconds: temporalBaselineSeconds));
    history.removeWhere((data) => data.timestamp.isBefore(cutoff));
  }

  /// ベースライン計算
  double? _calculateBaseline(String code) {
    final history = _history[code];
    if (history == null || history.length < 5) return null;

    // 移動平均でベースライン計算
    final sum = history.map((e) => e.intensity).reduce((a, b) => a + b);
    return sum / history.length;
  }

  /// 近隣点での検証
  bool _validateWithNeighbors(
    KyoshinMonitorImageParseObservationPoint targetPoint,
    double intensityDiff,
  ) {
    // 実装簡略化: 実際には近隣点の強度変化も考慮
    // ここでは基本的なしきい値チェックのみ
    return intensityDiff > intensityThreshold;
  }

  /// 空間的クラスタリング
  List<List<_DetectionResult>> _performSpatialClustering(
    List<_DetectionResult> results,
  ) {
    if (results.length < minimumClusterSize) return [];

    final clusters = <List<_DetectionResult>>[];
    final processed = <bool>[for (int i = 0; i < results.length; i++) false];

    for (int i = 0; i < results.length; i++) {
      if (processed[i]) continue;

      final cluster = <_DetectionResult>[results[i]];
      processed[i] = true;

      // 近隣点を検索してクラスターに追加
      for (int j = i + 1; j < results.length; j++) {
        if (processed[j]) continue;

        final distance = _calculateDistance(
          results[i].point.point.location.latitude,
          results[i].point.point.location.longitude,
          results[j].point.point.location.latitude,
          results[j].point.point.location.longitude,
        );

        if (distance <= spatialNeighborRadius) {
          cluster.add(results[j]);
          processed[j] = true;
        }
      }

      if (cluster.length >= minimumClusterSize) {
        clusters.add(cluster);
      }
    }

    return clusters;
  }

  /// 2点間の距離計算 (Haversine式)
  double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371.0; // km

    final dLat = _toRadians(lat2 - lat1);
    final dLon = _toRadians(lon2 - lon1);

    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(lat1)) * cos(_toRadians(lat2)) *
        sin(dLon / 2) * sin(dLon / 2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c;
  }

  double _toRadians(double degrees) => degrees * pi / 180;

  /// 検知イベントの作成
  List<ClientShakeDetectionEvent> _createDetectionEvents(
    List<List<_DetectionResult>> clusters,
    DateTime timestamp,
  ) {
    final events = <ClientShakeDetectionEvent>[];

    for (final cluster in clusters) {
      // クラスター内の最大強度を計算
      final maxIntensity = cluster
          .map((r) => r.intensityDiff)
          .reduce((a, b) => a > b ? a : b);

      // 地域名を決定 (簡略化)
      final regionNames = cluster
          .map((r) => r.point.point.region)
          .toSet()
          .toList();

      events.add(ClientShakeDetectionEvent(
        eventId: 'client_${timestamp.millisecondsSinceEpoch}',
        maxIntensity: _galToJmaIntensity(maxIntensity),
        detectionPoints: cluster.map((r) => r.point).toList(),
        regionNames: regionNames,
        detectedAt: timestamp,
        confidence: _calculateConfidence(cluster),
      ));
    }

    return events;
  }

  /// Gal値をJMA震度に変換
  JmaForecastIntensity _galToJmaIntensity(double gal) {
    if (gal < 1.0) return JmaForecastIntensity.zero;
    if (gal < 3.0) return JmaForecastIntensity.one;
    if (gal < 10.0) return JmaForecastIntensity.two;
    if (gal < 30.0) return JmaForecastIntensity.three;
    if (gal < 60.0) return JmaForecastIntensity.four;
    if (gal < 110.0) return JmaForecastIntensity.fiveLower;
    if (gal < 200.0) return JmaForecastIntensity.fiveUpper;
    if (gal < 350.0) return JmaForecastIntensity.sixLower;
    if (gal < 500.0) return JmaForecastIntensity.sixUpper;
    return JmaForecastIntensity.seven;
  }

  /// 検知信頼度の計算
  double _calculateConfidence(List<_DetectionResult> cluster) {
    // 点の数、強度の均一性、空間的分布などから信頼度を計算
    final pointCount = cluster.length;
    final intensityVariance = _calculateIntensityVariance(cluster);

    // 簡単な信頼度計算
    var confidence = (pointCount / 10.0).clamp(0.0, 1.0);
    
    // 強度のばらつきが少ないほど信頼度が高い
    confidence *= (1.0 - intensityVariance.clamp(0.0, 1.0));

    return confidence;
  }

  /// 強度のばらつき計算
  double _calculateIntensityVariance(List<_DetectionResult> cluster) {
    if (cluster.isEmpty) return 0.0;

    final mean = cluster.map((r) => r.intensityDiff).reduce((a, b) => a + b) / cluster.length;
    final variance = cluster
        .map((r) => pow(r.intensityDiff - mean, 2))
        .reduce((a, b) => a + b) / cluster.length;

    return sqrt(variance);
  }

  /// 履歴データをクリア
  void clearHistory() {
    _history.clear();
  }
}

/// 検知結果
class _DetectionResult {
  _DetectionResult({
    required this.point,
    required this.intensityDiff,
    required this.baseline,
    required this.timestamp,
  });

  final KyoshinMonitorImageParseObservationPoint point;
  final double intensityDiff;
  final double baseline;
  final DateTime timestamp;
}

/// 履歴データ
class _HistoricalIntensityData {
  _HistoricalIntensityData(this.intensity, this.timestamp);

  final double intensity;
  final DateTime timestamp;
}

/// クライアントサイド検知イベント
class ClientShakeDetectionEvent {
  ClientShakeDetectionEvent({
    required this.eventId,
    required this.maxIntensity,
    required this.detectionPoints,
    required this.regionNames,
    required this.detectedAt,
    required this.confidence,
  });

  final String eventId;
  final JmaForecastIntensity maxIntensity;
  final List<KyoshinMonitorImageParseObservationPoint> detectionPoints;
  final List<String> regionNames;
  final DateTime detectedAt;
  final double confidence; // 0.0 - 1.0
}