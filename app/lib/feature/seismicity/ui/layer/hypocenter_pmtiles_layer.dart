import 'dart:async';

import 'package:eqmonitor/core/hook/use_map_operation_queue.dart';
import 'package:eqmonitor/core/util/map/remove_map_style_resources.dart';
import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_archive.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_color_mode.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:maplibre/maplibre.dart';

class HypocenterPmTilesLayer extends HookWidget {
  const new({
    required this.archives,
    required this.colorMode,
    super.key,
  });

  final List<HypocenterArchive> archives;
  final SeismicityColorMode colorMode;

  @override
  Widget build(BuildContext context) {
    final styleController = MapController.maybeOf(context)?.style;
    final enqueue = useMapOperationQueue();
    final token = useRef<Object?>(null);
    final tick = useState(0);
    final archiveKey = archives
        .map(
          (archive) => '${archive.id}:${archive.url}:${archive.queryRevision}',
        )
        .join('|');

    useEffect(() {
      if (colorMode != SeismicityColorMode.elapsedTime) {
        return null;
      }
      final timer = Timer.periodic(const Duration(minutes: 10), (_) {
        tick.value++;
      });
      return timer.cancel;
    }, [colorMode]);

    useEffect(() {
      if (styleController == null) {
        return null;
      }
      final currentToken = Object();
      token.value = currentToken;
      const builder = HypocenterPmTilesStyleBuilder();
      final ids = archives.map(builder.idsFor).toList();
      unawaited(
        enqueue(() async {
          for (final archive in archives) {
            if (token.value != currentToken) {
              return;
            }
            final source = builder.sourceFor(archive: archive);
            final layers = builder.layersFor(
              archive: archive,
              colorMode: colorMode,
              now: DateTime.now().toUtc(),
            );
            await styleController.addSource(source);
            await styleController.addLayer(layers.cluster);
            await styleController.addLayer(layers.hypocenter);
          }
        }),
      );
      return () {
        if (token.value == currentToken) {
          token.value = null;
        }
        unawaited(
          enqueue(
            () => MapStyleResourceRemover.remove(
              styleController: styleController,
              layerIds: [
                for (final value in ids) ...[
                  value.clusterLayerId,
                  value.hypocenterLayerId,
                ],
              ],
              sourceIds: ids.map((value) => value.sourceId).toList(),
            ),
          ),
        );
      };
    }, [styleController, archiveKey, colorMode, tick.value]);

    return const SizedBox.shrink();
  }
}

class HypocenterPmTilesStyleBuilder {
  const new();

  HypocenterPmTilesStyleIds idsFor(HypocenterArchive archive) {
    final suffix = '${archive.id.partition.name}-${archive.id.jstLabel}'
        .replaceAll(RegExp('[^a-zA-Z0-9_-]'), '-');
    return HypocenterPmTilesStyleIds(
      sourceId: 'hypocenter-$suffix',
      clusterLayerId: 'hypocenter-cluster-$suffix',
      hypocenterLayerId: 'hypocenter-point-$suffix',
    );
  }

  VectorSource sourceFor({required HypocenterArchive archive}) {
    final url = archive.url.startsWith('pmtiles://')
        ? archive.url
        : 'pmtiles://${archive.url}';
    return VectorSource(id: idsFor(archive).sourceId, url: url, volatile: true);
  }

  HypocenterPmTilesLayers layersFor({
    required HypocenterArchive archive,
    required SeismicityColorMode colorMode,
    required DateTime now,
  }) {
    final ids = idsFor(archive);
    final magnitude = [
      'coalesce',
      ['get', 'magnitude'],
      -1,
    ];
    final maxMagnitude = [
      'coalesce',
      ['get', 'max_magnitude'],
      -1,
    ];
    final pointColor = switch (colorMode) {
      SeismicityColorMode.magnitude => magnitudeColor(magnitude),
      SeismicityColorMode.elapsedTime => elapsedColor(
        property: 'origin_time_unix_ms',
        now: now,
      ),
    };
    final clusterColor = switch (colorMode) {
      SeismicityColorMode.magnitude => magnitudeColor(maxMagnitude),
      SeismicityColorMode.elapsedTime => elapsedColor(
        property: 'latest_origin_time_unix_ms',
        now: now,
      ),
    };
    return HypocenterPmTilesLayers(
      cluster: CircleStyleLayer(
        id: ids.clusterLayerId,
        sourceId: ids.sourceId,
        sourceLayerId: 'clusters',
        maxZoom: 7,
        paint: {
          'circle-color': clusterColor,
          'circle-radius': [
            'interpolate',
            ['linear'],
            ['get', 'count'],
            1,
            4,
            1000,
            18,
          ],
          'circle-opacity': 0.7,
        },
      ),
      hypocenter: CircleStyleLayer(
        id: ids.hypocenterLayerId,
        sourceId: ids.sourceId,
        sourceLayerId: 'hypocenters',
        minZoom: 7,
        maxZoom: 15,
        paint: {
          'circle-color': pointColor,
          'circle-radius': [
            'interpolate',
            ['linear'],
            magnitude,
            -1,
            2,
            2,
            3,
            7,
            14,
          ],
          'circle-opacity': 0.75,
          'circle-stroke-width': 0.5,
          'circle-stroke-color': '#00000080',
        },
      ),
    );
  }

  List<Object> magnitudeColor(List<Object> value) => [
    'interpolate',
    ['linear'],
    value,
    -1,
    '#9e9e9e',
    2,
    '#90a4ae',
    4,
    '#ffca28',
    6,
    '#e53935',
  ];

  List<Object> elapsedColor({
    required String property,
    required DateTime now,
  }) => [
    'interpolate',
    ['linear'],
    [
      '/',
      [
        '-',
        now.millisecondsSinceEpoch,
        ['get', property],
      ],
      3600000,
    ],
    0,
    '#e53935',
    720,
    '#9e9e9e',
  ];
}

class HypocenterPmTilesStyleIds {
  const new({
    required this.sourceId,
    required this.clusterLayerId,
    required this.hypocenterLayerId,
  });

  final String sourceId;
  final String clusterLayerId;
  final String hypocenterLayerId;
}

class HypocenterPmTilesLayers {
  const new({
    required this.cluster,
    required this.hypocenter,
  });

  final CircleStyleLayer cluster;
  final CircleStyleLayer hypocenter;
}
