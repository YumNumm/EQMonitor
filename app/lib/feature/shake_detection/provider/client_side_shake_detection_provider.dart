import 'package:eqmonitor/core/provider/time_ticker.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_notifier.dart';
import 'package:eqmonitor/feature/shake_detection/data/client_side_shake_detector.dart';
import 'package:eqmonitor/feature/shake_detection/model/shake_detection_kmoni_merged_event.dart';
import 'package:eqmonitor/feature/shake_detection/provider/shake_detection_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'client_side_shake_detection_provider.g.dart';

@Riverpod(keepAlive: true)
ClientSideShakeDetector clientSideShakeDetector(
  ClientSideShakeDetectorRef ref,
) => ClientSideShakeDetector();

@Riverpod(keepAlive: true)
class ClientSideShakeDetection extends _$ClientSideShakeDetection {
  @override
  Future<List<ClientShakeDetectionEvent>> build() async {
    final detector = ref.watch(clientSideShakeDetectorProvider);
    final events = <ClientShakeDetectionEvent>[];

    // Kyoshin Monitorのリアルタイムデータを監視
    ref.listen(kyoshinMonitorNotifierProvider, (previous, next) {
      if (next case AsyncData(value: final state)) {
        if (state.analyzedPoints case final points?) {
          final timestamp = state.lastUpdatedAt ?? DateTime.now();
          final detectedEvents = detector.detectShaking(points, timestamp);
          
          if (detectedEvents.isNotEmpty) {
            _addEvents(detectedEvents);
          }
        }
      }
    });

    // 時間経過による古いイベントの削除
    ref.listen(timeTickerProvider(), (_, __) {
      if (state case AsyncData(value: final currentEvents)) {
        final now = DateTime.now();
        final validEvents = currentEvents
            .where((event) => 
                now.difference(event.detectedAt) < const Duration(seconds: 30))
            .toList();
        
        if (validEvents.length != currentEvents.length) {
          state = AsyncData(validEvents);
        }
      }
    });

    return events;
  }

  /// 新しいイベントを追加
  void _addEvents(List<ClientShakeDetectionEvent> newEvents) {
    final currentEvents = state.value ?? [];
    final updatedEvents = [...currentEvents, ...newEvents];
    
    // 重複削除（eventIdベース）
    final eventMap = <String, ClientShakeDetectionEvent>{};
    for (final event in updatedEvents) {
      eventMap[event.eventId] = event;
    }
    
    state = AsyncData(eventMap.values.toList());
  }

  /// 履歴をクリア
  void clearHistory() {
    ref.read(clientSideShakeDetectorProvider).clearHistory();
    state = const AsyncData([]);
  }
}

/// クライアントサイド検知とサーバーサイド検知の統合
@Riverpod(keepAlive: true)
class IntegratedShakeDetection extends _$IntegratedShakeDetection {
  @override
  Future<List<IntegratedShakeDetectionEvent>> build() async {
    final clientEvents = ref.watch(clientSideShakeDetectionProvider).value ?? [];
    final serverEvents = ref.watch(shakeDetectionKmoniPointsMergedProvider).value ?? [];

    // クライアントサイドとサーバーサイドのイベントを統合
    final integratedEvents = <IntegratedShakeDetectionEvent>[];

    // サーバーサイドイベントを追加（優先）
    for (final serverEvent in serverEvents) {
      integratedEvents.add(IntegratedShakeDetectionEvent(
        eventId: serverEvent.event.eventId,
        source: ShakeDetectionSource.server,
        serverEvent: serverEvent,
        clientEvent: null,
        confidence: 1.0, // サーバーサイドは常に高信頼度
        detectedAt: serverEvent.event.createdAt,
      ));
    }

    // クライアントサイドのみのイベントを追加
    for (final clientEvent in clientEvents) {
      // サーバーサイドと重複していないもののみ
      final isOverlapping = serverEvents.any((serverEvent) =>
          _isEventsOverlapping(clientEvent, serverEvent));

      if (!isOverlapping && clientEvent.confidence > 0.5) {
        integratedEvents.add(IntegratedShakeDetectionEvent(
          eventId: clientEvent.eventId,
          source: ShakeDetectionSource.client,
          serverEvent: null,
          clientEvent: clientEvent,
          confidence: clientEvent.confidence,
          detectedAt: clientEvent.detectedAt,
        ));
      }
    }

    return integratedEvents;
  }

  /// イベントの重複判定
  bool _isEventsOverlapping(
    ClientShakeDetectionEvent clientEvent,
    ShakeDetectionKmoniMergedEvent serverEvent,
  ) {
    // 時間的重複チェック（±30秒以内）
    final timeDiff = clientEvent.detectedAt.difference(serverEvent.event.createdAt).abs();
    if (timeDiff > const Duration(seconds: 30)) return false;

    // 空間的重複チェック（観測点の重複）
    final clientPointCodes = clientEvent.detectionPoints
        .map((p) => p.point.code)
        .toSet();
    
    final serverPointCodes = <String>{};
    for (final region in serverEvent.regions) {
      for (final point in region.points) {
        serverPointCodes.add(point.code);
      }
    }

    // 50%以上の観測点が重複していれば同じイベントとみなす
    final overlap = clientPointCodes.intersection(serverPointCodes);
    final overlapRatio = overlap.length / clientPointCodes.length;
    
    return overlapRatio >= 0.5;
  }
}

/// 統合検知イベント
class IntegratedShakeDetectionEvent {
  IntegratedShakeDetectionEvent({
    required this.eventId,
    required this.source,
    required this.serverEvent,
    required this.clientEvent,
    required this.confidence,
    required this.detectedAt,
  });

  final String eventId;
  final ShakeDetectionSource source;
  final ShakeDetectionKmoniMergedEvent? serverEvent;
  final ClientShakeDetectionEvent? clientEvent;
  final double confidence;
  final DateTime detectedAt;
}

/// 検知ソース
enum ShakeDetectionSource {
  server,
  client,
}