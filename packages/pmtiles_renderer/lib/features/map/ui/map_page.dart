import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:vector_map_tiles/vector_map_tiles.dart';
import 'package:vector_map_tiles_pmtiles/vector_map_tiles_pmtiles.dart';
import 'package:vector_tile_renderer/vector_tile_renderer.dart' as vtr;

/// TODO: use your own tile source https://docs.protomaps.com/pmtiles/cloud-storage
/// This can be a hosted file or local file in your file system,
/// However, flutter assets are not supported.
const String tileSource = 'https://v2.map.eqmonitor.app/all.pmtiles';

class VectorMapTilesPmTilesPage extends StatelessWidget {
  VectorMapTilesPmTilesPage({super.key});

  /// The theme specifies the look of the rendered map.
  ///
  /// Note: Styles from Mapbox, OpenMapTiles and others and not compatible
  /// with Protomaps styles.
  final vtr.Theme mapTheme = vtr.ThemeReader(
    logger: kDebugMode ? const vtr.Logger.console() : null,
  ).read({
    "version": 8,
    "name": "EQMonitor Light",
    "sources": {
      "world": {
        "type": "vector",
        "url": "pmtiles://https://v2.map.eqmonitor.app/world.pmtiles",
      },
      "japan": {
        "type": "vector",
        "url": "pmtiles://https://v2.map.eqmonitor.app/japan.pmtiles",
      },
      "overview": {
        "type": "vector",
        "url": "pmtiles://https://v2.map.eqmonitor.app/overview.pmtiles",
      },
    },
    "layers": [
      {
        "id": "background",
        "type": "background",
        "paint": {"background-color": "#ffffff"},
      },
      {
        "id": "countries",
        "type": "line",
        "source": "world",
        "source-layer": "countries",
        "paint": {"line-color": "#cccccc", "line-width": 1},
      },
      {
        "id": "areaForecastLocalE",
        "type": "line",
        "source": "japan",
        "source-layer": "areaForecastLocalE",
        "paint": {"line-color": "#666666", "line-width": 1},
      },
      {
        "id": "areaForecastLocalEew",
        "type": "line",
        "source": "japan",
        "source-layer": "areaForecastLocalEew",
        "paint": {"line-color": "#ff9900", "line-width": 1},
      },
      {
        "id": "areaInformationCityQuake",
        "type": "line",
        "source": "japan",
        "source-layer": "areaInformationCityQuake",
        "paint": {"line-color": "#ff0033", "line-width": 1},
      },
      {
        "id": "areaTsunami",
        "type": "line",
        "source": "japan",
        "source-layer": "areaTsunami",
        "paint": {
          "line-color": "#3366cc",
          "line-width": [
            "interpolate",
            ["linear"],
            ["zoom"],
            3,
            0.5,
            5.5,
            1,
          ],
        },
      },
    ],
  });

  final _futureTileProvider = PmTilesVectorTileProvider.fromSource(tileSource);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('vector_map_tiles_pmtiles')),
      body: FutureBuilder<PmTilesVectorTileProvider>(
        future: _futureTileProvider,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final tileProvider = snapshot.data!;
            return FlutterMap(
              options: const MapOptions(
                initialCenter: LatLng(43.787942, 11.237517), // firenze
                maxZoom: 18,
                minZoom: 0,
              ),
              children: [
                VectorTileLayer(
                  theme: mapTheme,
                  tileProviders: TileProviders({
                    'japan': tileProvider,
                    'world': tileProvider,
                    'overview': tileProvider,
                  }),
                  
                ),
              ],
            );
          }
          if (snapshot.hasError) {
            debugPrint(snapshot.error.toString());
            debugPrintStack(stackTrace: snapshot.stackTrace);
            return Center(child: Text(snapshot.error.toString()));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
