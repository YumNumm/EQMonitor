import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_depth.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_magnitude.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_sort_by.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/coordinate.dart';
import 'package:eqmonitor/feature/earthquake_history/data/repository/earthquake_history_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;

sealed class EarthquakeRealtimeListDecision {
  const EarthquakeRealtimeListDecision();
}

final class EarthquakeRealtimeListUpsert
    extends EarthquakeRealtimeListDecision {
  const EarthquakeRealtimeListUpsert(this.item);

  final EarthquakePartial item;
}

final class EarthquakeRealtimeListRemove
    extends EarthquakeRealtimeListDecision {
  const EarthquakeRealtimeListRemove();
}

final class EarthquakeRealtimeListPreserve
    extends EarthquakeRealtimeListDecision {
  const EarthquakeRealtimeListPreserve();
}

final class EarthquakeRealtimeListReconciler {
  const EarthquakeRealtimeListReconciler({
    required this.parameter,
    required this.repository,
  });

  final EarthquakeHistoryParameter parameter;
  final EarthquakeHistoryRepository repository;

  EarthquakeRealtimeListDecision decide({
    required api.Earthquake record,
    required EarthquakePartial? previous,
  }) {
    final full = repository.toEarthquakeFromRealtimeRecord(record);
    final partial = _toPartial(full: full, record: record);
    if (!_matchesBase(full)) {
      return const EarthquakeRealtimeListRemove();
    }

    return switch (parameter) {
      EarthquakeHistoryParameterAll() => _upsertWhenOrderIsKnown(
        item: partial,
        previous: previous,
        matches: _matchesAll(full),
      ),
      EarthquakeHistoryParameterRegion(:final regionCode) =>
        _upsertForIntensityCode(
          record: record,
          partial: partial,
          previous: previous,
          code: regionCode,
          station: false,
        ),
      EarthquakeHistoryParameterStation(:final stationCode) =>
        _upsertForIntensityCode(
          record: record,
          partial: partial,
          previous: previous,
          code: stationCode,
          station: true,
        ),
      // Full Earthquake intensity_tree only carries region and station codes.
      // Prefecture/city search membership therefore cannot be inferred without
      // changing the backend contract. Preserve known membership and update its
      // shared earthquake fields; do not invent membership for an absent item.
      EarthquakeHistoryParameterPrefecture() => switch (previous) {
        EarthquakePartialPrefecture(:final prefectureIntensity) =>
          EarthquakeRealtimeListUpsert(
            EarthquakePartial.prefecture(
              prefectureIntensity: prefectureIntensity,
              earthquake: partial,
            ),
          ),
        _ => const EarthquakeRealtimeListPreserve(),
      },
      EarthquakeHistoryParameterCity() => switch (previous) {
        EarthquakePartialCity(:final cityIntensity) =>
          EarthquakeRealtimeListUpsert(
            EarthquakePartial.city(
              cityIntensity: cityIntensity,
              earthquake: partial,
            ),
          ),
        _ => const EarthquakeRealtimeListPreserve(),
      },
    };
  }

  EarthquakeRealtimeListDecision _upsertForIntensityCode({
    required api.Earthquake record,
    required EarthquakePartialNormal partial,
    required EarthquakePartial? previous,
    required String code,
    required bool station,
  }) {
    final matchedIntensity = record.intensity?.intensityTree
        .where(
          (tree) => station
              ? (tree.stations ?? const <String>[]).contains(code)
              : tree.regions.contains(code),
        )
        .map((tree) => tree.intensity.toJmaIntensity)
        .firstOrNull;
    if (matchedIntensity == null || !_matchesIntensity(matchedIntensity)) {
      return const EarthquakeRealtimeListRemove();
    }
    final item = station
        ? EarthquakePartial.station(
            stationIntensity: matchedIntensity,
            earthquake: partial,
          )
        : EarthquakePartial.region(
            regionIntensity: matchedIntensity,
            earthquake: partial,
          );
    return _upsertWhenOrderIsKnown(
      item: item,
      previous: previous,
      matches: true,
    );
  }

  EarthquakeRealtimeListDecision _upsertWhenOrderIsKnown({
    required EarthquakePartial item,
    required EarthquakePartial? previous,
    required bool matches,
  }) {
    if (!matches) {
      return const EarthquakeRealtimeListRemove();
    }
    if (previous == null && parameter.sortBy != EarthquakeSortBy.eventId) {
      return const EarthquakeRealtimeListPreserve();
    }
    return EarthquakeRealtimeListUpsert(item);
  }

  bool _matchesBase(Earthquake earthquake) {
    final statuses = parameter.statuses ?? const [TelegramStatus.normal];
    if (!statuses.contains(earthquake.status)) {
      return false;
    }
    final hypocenter = earthquake.hypocenter;
    final magnitude = switch (hypocenter?.magnitude) {
      EarthquakeMagnitudeValue(:final value) => value,
      _ => null,
    };
    final depth = switch (hypocenter?.depth) {
      EarthquakeDepthShallow() => 0,
      EarthquakeDepthValue(:final value) => value,
      EarthquakeDepthOver700km() => 700,
      _ => null,
    };
    final epicenterCode = int.tryParse(hypocenter?.code ?? '');
    final epicenterCodes = parameter.epicenterCodes;
    return _inRange(
          magnitude,
          parameter.magnitudeGte,
          parameter.magnitudeLte,
        ) &&
        _inRange(depth, parameter.depthGte, parameter.depthLte) &&
        _inDateRange(
          earthquake.originTime,
          parameter.originTimeGte?.toDateTime(),
          parameter.originTimeLte?.toDateTime(),
        ) &&
        (epicenterCodes == null ||
            (epicenterCode != null &&
                epicenterCodes.contains(epicenterCode))) &&
        (parameter.earthquakeType == null ||
            earthquake.earthquakeType == parameter.earthquakeType) &&
        _inOrderRange(
          earthquake.intensity?.maxLpgmIntensity?.orderIndex,
          parameter.maxLpgmIntensityGte?.orderIndex,
          parameter.maxLpgmIntensityLte?.orderIndex,
        );
  }

  bool _matchesAll(Earthquake earthquake) {
    final p = parameter as EarthquakeHistoryParameterAll;
    final intensity = earthquake.intensity;
    final hypocenter = earthquake.hypocenter;
    final coordinates = switch (hypocenter?.coordinates) {
      CoordinateLatLng(:final latitude, :final longitude) => (
        latitude: latitude,
        longitude: longitude,
      ),
      _ => null,
    };
    final telegramTypes = p.telegramTypes;
    return _matchesIntensity(intensity?.maxIntensity) &&
        (p.datasource == null ||
            earthquake.dataSources.contains(p.datasource)) &&
        (telegramTypes == null ||
            telegramTypes.every(earthquake.telegramTypes.contains)) &&
        _inRange(coordinates?.latitude, p.latitudeGte, p.latitudeLte) &&
        _inRange(coordinates?.longitude, p.longitudeGte, p.longitudeLte);
  }

  bool _matchesIntensity(JmaIntensity? intensity) => _inOrderRange(
    intensity?.orderIndex,
    parameter.intensityGte?.orderIndex,
    parameter.intensityLte?.orderIndex,
  );

  bool _inDateRange(DateTime? value, DateTime? gte, DateTime? lte) =>
      _inRange(value, gte, lte);

  bool _inOrderRange(int? value, int? gte, int? lte) =>
      _inRange(value, gte, lte);

  bool _inRange<T extends Comparable<T>>(T? value, T? gte, T? lte) {
    if (gte == null && lte == null) {
      return true;
    }
    if (value == null) {
      return false;
    }
    return (gte == null || value.compareTo(gte) >= 0) &&
        (lte == null || value.compareTo(lte) <= 0);
  }

  EarthquakePartialNormal _toPartial({
    required Earthquake full,
    required api.Earthquake record,
  }) {
    final intensity = full.intensity;
    return EarthquakePartialNormal(
      eventId: full.eventId,
      status: full.status,
      originTime: full.originTime,
      originTimePrecision: full.originTimePrecision,
      arrivalTime: full.arrivalTime,
      dataSources: full.dataSources,
      hypocenter: full.hypocenter,
      intensity: intensity == null
          ? null
          : EarthquakeIntensityPartial(
              maxIntensity: intensity.maxIntensity,
              maxLpgmIntensity: intensity.maxLpgmIntensity,
            ),
      earthquakeType: record.earthquakeType.toEarthquakeType,
      telegramTypes: full.telegramTypes,
      estimatedIntensityTileUrl: full.estimatedIntensityTileUrl,
    );
  }
}
