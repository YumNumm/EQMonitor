import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_type.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/live_monitor/data/model/live_monitor_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_snapshot.dart';

Uri? liveMonitorEstimatedIntensityUri(String? fullUrl) {
  if (fullUrl == null) {
    return null;
  }
  final uri = Uri.tryParse(fullUrl);
  if (uri == null || !uri.isAbsolute || !uri.hasAuthority) {
    return null;
  }
  return uri;
}

bool liveMonitorEstimatedIntensityUrlMatchesIdentifier({
  required String fullUrl,
  required String identifier,
}) {
  final uri = liveMonitorEstimatedIntensityUri(fullUrl);
  return identifier.isNotEmpty &&
      uri != null &&
      uri.pathSegments.join('/') == identifier;
}

class LiveMonitorEventDetector {
  final Map<String, int> _eewSerials = {};
  final Map<String, int> _shakeSerials = {};
  final Set<(String, EarthquakeTelegramType, DateTime)> _telegrams = {};
  final Set<(String, String)> _estimatedIdentifiers = {};
  final Map<String, String?> _estimatedUrls = {};

  bool _hasEewBaseline = false;
  int? _lastShakeRevision;

  bool hasEarthquakeBaseline(String eventId) =>
      _estimatedUrls.containsKey(eventId);

  List<LiveMonitorDetectedEvent> detectEews(List<EewTelegramItem> eews) {
    if (!_hasEewBaseline) {
      _hasEewBaseline = true;
      for (final eew in eews) {
        final previous = _eewSerials[eew.eventId];
        if (previous == null || eew.serialNo > previous) {
          _eewSerials[eew.eventId] = eew.serialNo;
        }
      }
      return const [];
    }

    final events = <LiveMonitorDetectedEvent>[];
    for (final eew in eews) {
      final previous = _eewSerials[eew.eventId];
      if (previous == null) {
        _eewSerials[eew.eventId] = eew.serialNo;
        events.add(
          LiveMonitorDetectedEvent.eewStarted(
            eventId: eew.eventId,
            serialNo: eew.serialNo,
          ),
        );
      } else if (eew.serialNo > previous) {
        _eewSerials[eew.eventId] = eew.serialNo;
        events.add(
          LiveMonitorDetectedEvent.eewUpdated(
            eventId: eew.eventId,
            serialNo: eew.serialNo,
          ),
        );
      }
    }
    return events;
  }

  List<LiveMonitorDetectedEvent> detectShakeSnapshot(
    ShakeDetectionSnapshot snapshot,
  ) {
    final previousRevision = _lastShakeRevision;
    if (previousRevision == null) {
      _lastShakeRevision = snapshot.revision;
      for (final event in snapshot.events) {
        final previous = _shakeSerials[event.eventId];
        if (previous == null || event.serialNo > previous) {
          _shakeSerials[event.eventId] = event.serialNo;
        }
      }
      return const [];
    }
    if (snapshot.revision <= previousRevision) {
      return const [];
    }

    _lastShakeRevision = snapshot.revision;
    final events = <LiveMonitorDetectedEvent>[];
    for (final event in snapshot.events) {
      final previous = _shakeSerials[event.eventId];
      if (previous == null || event.serialNo > previous) {
        _shakeSerials[event.eventId] = event.serialNo;
        events.add(
          LiveMonitorDetectedEvent.shakeDetected(
            eventId: event.eventId,
            serialNo: event.serialNo,
          ),
        );
      }
    }
    return events;
  }

  void seedEarthquake(Earthquake earthquake) {
    for (final metadata in earthquake.telegramMetadata) {
      if (metadata.type
          case .vxse51 || .vxse52 || .vxse53 || .vxse61 || .vxse62) {
        _telegrams.add((
          earthquake.eventId,
          metadata.type,
          metadata.reportedAt,
        ));
      }
    }
    final estimatedIntensityTileUrl = earthquake.estimatedIntensityTileUrl;
    _estimatedUrls.putIfAbsent(
      earthquake.eventId,
      () => liveMonitorEstimatedIntensityUri(estimatedIntensityTileUrl) == null
          ? null
          : estimatedIntensityTileUrl,
    );
  }

  List<LiveMonitorEarthquakeUpsertEvent> detectEarthquake(
    Earthquake earthquake,
  ) {
    final metadata = [...earthquake.telegramMetadata]
      ..sort((left, right) => left.reportedAt.compareTo(right.reportedAt));
    final events = <LiveMonitorEarthquakeUpsertEvent>[];
    for (final item in metadata) {
      final kind = switch (item.type) {
        .vxse51 => LiveMonitorEarthquakeTriggerKind.vxse51,
        .vxse52 => LiveMonitorEarthquakeTriggerKind.vxse52,
        .vxse53 => LiveMonitorEarthquakeTriggerKind.vxse53,
        .vxse61 => LiveMonitorEarthquakeTriggerKind.vxse61,
        .vxse62 => LiveMonitorEarthquakeTriggerKind.vxse62,
        .vxse45Forecast || .vxse45Warning => null,
      };
      if (kind == null) {
        continue;
      }
      final isNew = _telegrams.add((
        earthquake.eventId,
        item.type,
        item.reportedAt,
      ));
      if (isNew == false) {
        continue;
      }
      events.add(
        LiveMonitorEarthquakeUpsertEvent(
          eventId: earthquake.eventId,
          trigger: LiveMonitorEarthquakeTrigger.telegram(
            kind: kind,
            reportedAt: item.reportedAt,
          ),
          earthquake: earthquake,
        ),
      );
    }

    final estimatedIntensityTileUrl = earthquake.estimatedIntensityTileUrl;
    final nextUrl =
        liveMonitorEstimatedIntensityUri(estimatedIntensityTileUrl) == null
        ? null
        : estimatedIntensityTileUrl;
    final previousUrl = _estimatedUrls[earthquake.eventId];
    _estimatedUrls[earthquake.eventId] = nextUrl;
    if (nextUrl != null && nextUrl != previousUrl) {
      events.add(
        LiveMonitorEarthquakeUpsertEvent(
          eventId: earthquake.eventId,
          trigger: const LiveMonitorEarthquakeTrigger.estimatedIntensity(
            generatedAt: null,
          ),
          earthquake: earthquake,
        ),
      );
    }
    return events;
  }

  bool acceptEstimatedIdentifier({
    required String eventId,
    required String identifier,
  }) => _estimatedIdentifiers.add((eventId, identifier));

  LiveMonitorEarthquakeUpsertEvent? detectEstimatedIntensity({
    required String eventId,
    required String identifier,
    required DateTime? generatedAt,
    required Earthquake earthquake,
  }) {
    final estimatedIntensityTileUrl = earthquake.estimatedIntensityTileUrl;
    final nextUrl =
        liveMonitorEstimatedIntensityUri(estimatedIntensityTileUrl) == null
        ? null
        : estimatedIntensityTileUrl;
    final previousUrl = _estimatedUrls[eventId];
    _estimatedUrls[eventId] = nextUrl;
    if (nextUrl == null || nextUrl == previousUrl) {
      return null;
    }
    return LiveMonitorEarthquakeUpsertEvent(
      eventId: eventId,
      trigger: LiveMonitorEarthquakeTrigger.estimatedIntensity(
        generatedAt: generatedAt,
      ),
      earthquake: earthquake,
    );
  }
}
