import 'dart:developer';
import 'dart:math' as math;

import 'package:dmdata_telegram_json/dmdata_telegram_json.dart';
import 'package:eqmonitor/provider/init/talker.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:latlong2/latlong.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../../../model/setting/jma_intensity_color_model.dart';
import '../../../../provider/init/map_area_forecast_local_e.dart';
import '../../../../provider/init/map_area_information_city_quake.dart';
import '../../../../provider/init/parameter_earthquake.dart';
import '../../../../provider/setting/intensity_color_provider.dart';
import '../../../../provider/theme_providers.dart';
import '../../../../schema/local/prefecture/map_polygon.dart';
import '../../../../schema/remote/dmdata/eq-information/earthquake-information/intensity/station.dart';
import '../../../../schema/remote/dmdata/parameter-earthquake/parameter-earthquake.dart';
import '../../../../utils/map/map_global_offset.dart';
import '../../../theme/jma_intensity.dart';
import '../../../view/widget/intensity_widget.dart';
import '../earthquake_history.viewmodel.dart';
import '../kmoni_map/map/base_map.dart';

class EarthquakeHistoryDetailPage extends ConsumerStatefulWidget {
  const EarthquakeHistoryDetailPage({
    super.key,
    required this.item,
  });
  final EarthquakeHistoryItem item;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EarthquakeHistoryDetailPageState();
}

class _EarthquakeHistoryDetailPageState
    extends ConsumerState<EarthquakeHistoryDetailPage> {
  _EarthquakeHistoryDetailPageState();

  late EarthquakeHistoryItem item;
  final TransformationController transformationController =
      TransformationController();

  final mapKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    // Widgetの表示領域を取得
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final size = mapKey.currentContext!.size!;
      // 画面中央の座標
      final center = Offset(size.width / 2, size.height / 2);
      // 震央地の座標
      if (widget.item.component?.hypocenter.coordinate.latitude?.value ==
          null) {
        return;
      }
      // CustomPainter内で使うOffset
      final hypoLocalOffset = MapGlobalOffset.latLonToGlobalPoint(
        LatLng(
          widget.item.component!.hypocenter.coordinate.latitude!.value,
          widget.item.component!.hypocenter.coordinate.longitude!.value,
        ),
      ).toLocalOffset(const Size(476, 927.4));
      // 実際のWidgetの座標から見たときの震央地の座標に変換
      final zoom = math.max(size.width / 476, size.height / 927.4);
      final hypoOffset = Offset(
        hypoLocalOffset.dx * zoom,
        hypoLocalOffset.dy * zoom,
      );
      // 画面中央に震央地を表示するための移動量
      final translate = center - hypoOffset;

      transformationController.value = (Matrix4.identity()
        ..translate(center.dx, center.dy)
        ..scale(4.0, 4)
        ..translate(-center.dx, -center.dy)
        ..translate(translate.dx, translate.dy));
    });
  }

  @override
  Widget build(BuildContext context) {
    item = widget.item;

    final colors = ref.watch(jmaIntensityColorProvider);
    final maxInt = JmaIntensity.values.firstWhere(
      (e) => e.name == (item.intensity?.maxInt.name),
      orElse: () => JmaIntensity.Unknown,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('地震情報'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8),
            child: Card(
              elevation: 0,
              color: maxInt.fromUser(colors).withOpacity(0.2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: maxInt.fromUser(colors),
                  width: 2,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(),
                  // 発生時刻
                  if (item.component != null)
                    Text(
                      '${DateFormat('yyyy/MM/dd HH:mm').format(item.component!.originTime.toLocal())}頃',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              const Text('最大震度'),
                              Row(
                                textBaseline: TextBaseline.alphabetic,
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    maxInt.name
                                        .replaceAll(RegExp(r'[^0-9]'), ''),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 55,
                                    ),
                                  ),
                                  Text(
                                    maxInt.name
                                        .replaceAll(RegExp(r'[0-9]'), '')
                                        .replaceAll('+', '強')
                                        .replaceAll('-', '弱')
                                        .replaceAll('?', '不明'),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const VerticalDivider(),
                      Flexible(
                        flex: 2,
                        child: Column(
                          children: [
                            // 震央地
                            FittedBox(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    '震央地',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    item.component?.hypocenter.name ?? '調査中',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (item.component != null)
                              FittedBox(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    // Magunitude
                                    if (item.component!.magnitude.condition ==
                                        null) ...[
                                      const Text(
                                        'M',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        (item.component?.magnitude.condition !=
                                                null)
                                            ? item.component!.magnitude
                                                .condition!.description
                                            : (item.component!.magnitude
                                                        .value ??
                                                    '不明')
                                                .toString(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 45,
                                        ),
                                      ),
                                    ],
                                    const VerticalDivider(),
                                    // Depth
                                    if (item.component?.hypocenter.depth
                                            .condition ==
                                        null) ...[
                                      const Text(
                                        '深さ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        (item.component?.hypocenter.depth
                                                    .condition !=
                                                null)
                                            ? item.component!.hypocenter.depth
                                                .condition!.description
                                            : (item.component!.hypocenter.depth
                                                        .value ??
                                                    '不明')
                                                .toString(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 45,
                                        ),
                                      ),
                                      const Text(
                                        'km',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      )
                                    ] else ...[
                                      const Text(
                                        '深さ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        item.component!.hypocenter.depth
                                            .condition!.description,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 45,
                                        ),
                                      )
                                    ],
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      (StringBuffer()
                            ..writeAll(
                              <String>[
                                for (final comment in item.comments) ...[
                                  if (comment.forecast?.text != null)
                                    comment.forecast!.text,
                                  if (comment.free != null) '\n${comment.free!}'
                                ]
                              ],
                            ))
                          .toString(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: ref.watch(themeProvider.notifier).isDarkMode
                    ? const Color.fromARGB(255, 22, 28, 45)
                    : const Color.fromARGB(255, 207, 219, 255),
              ),
              child: Stack(
                children: [
                  InteractiveViewer(
                    key: mapKey,
                    transformationController: transformationController,
                    maxScale: 20,
                    child: RepaintBoundary(
                      child: Stack(
                        children: [
                          // マップベース
                          const BaseMapWidget(),
                          // Region毎の震度
                          MapRegionIntensityWidget(
                            regions: item.intensity?.regions ?? [],
                            stations: item.intensity?.stations ??
                                <EarthquakeInformationStation>[],
                            cities: item.intensity?.cities ??
                                <EarthquakeInformationCity>[],
                          ),

                          // 震央位置
                          if (item.component != null)
                            MaphypocenterMapWidget(
                              component: item.component!.hypocenter,
                            ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          // int1 ~ maxInt
                          for (final i in JmaIntensity.values)
                            if ([
                              JmaIntensity.Int0,
                              JmaIntensity.over,
                              JmaIntensity.Unknown,
                              JmaIntensity.Error,
                            ].contains(i))
                              const SizedBox.shrink()
                            else if (i.intValue <= maxInt.intValue)
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IntensityWidget(
                                    intensity: i,
                                    size: 25,
                                    opacity: 1,
                                  ),
                                  const SizedBox(width: 5),
                                ],
                              ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MapRegionIntensityWidget extends ConsumerWidget {
  const MapRegionIntensityWidget({
    super.key,
    required this.regions,
    required this.stations,
    required this.cities,
  });
  final List<EarthquakeInformationRegion> regions;
  final List<EarthquakeInformationStation> stations;
  final List<EarthquakeInformationCity> cities;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapSource = ref.watch(mapAreaForecastLocalEProvider);
    final parameterEarthquake = ref.watch(parameterEarthquakeProvider);
    final mapAreaInformationCityQuake =
        ref.watch(mapAreaInformationCityQuakeProvider);

    return CustomPaint(
      isComplex: true,
      painter: MapRegionIntensityV2Painter(
        mapPolygons: mapSource,
        regions: regions,
        cities: cities,
        stations: stations,
        colors: ref.watch(jmaIntensityColorProvider),
        parameterEarthquake: parameterEarthquake,
        mapAreaInformationCityQuakePolygons: mapAreaInformationCityQuake,
        isDarkMode: ref.watch(themeProvider.notifier).isDarkMode,
        talker: ref.watch(talkerProvider),
      ),
      size: Size.infinite,
    );
  }
}

class MapRegionIntensityV2Painter extends CustomPainter {
  MapRegionIntensityV2Painter({
    required this.mapPolygons,
    required this.regions,
    required this.stations,
    required this.cities,
    required this.colors,
    required this.parameterEarthquake,
    required this.mapAreaInformationCityQuakePolygons,
    required this.isDarkMode,
    required this.talker,
  });
  final List<MapPolygon> mapPolygons;
  final List<EarthquakeInformationRegion> regions;
  final List<EarthquakeInformationStation> stations;
  final List<EarthquakeInformationCity> cities;
  final JmaIntensityColorModel colors;
  final ParameterEarthquake parameterEarthquake;
  final List<MapAreaInformationCityQuakePolygon>
      mapAreaInformationCityQuakePolygons;
  final bool isDarkMode;
  final Talker talker;

  @override
  void paint(Canvas canvas, Size size) {
    final stopWatch = Stopwatch()..start();

    // Cityの描画
    for (final city in cities) {
      // city.codeが一致するMapPolygonを探す
      try {
        final mapCityPolygons = mapAreaInformationCityQuakePolygons.where(
          (element) => element.code == city.code,
        );
        for (final mapPolygon in mapCityPolygons) {
          canvas
            ..drawPath(
              mapPolygon.path,
              Paint()
                ..color = JmaIntensity.values
                    .firstWhere(
                      (e) => e.name == city.maxInt?.name,
                      orElse: () => JmaIntensity.Error,
                    )
                    .fromUser(colors)
                ..isAntiAlias = true
                ..strokeCap = StrokeCap.square,
            )
            ..drawPath(
              mapPolygon.path,
              Paint()
                ..color = isDarkMode
                    ? const Color.fromARGB(70, 50, 50, 50)
                    : const Color.fromARGB(70, 150, 150, 150)
                ..isAntiAlias = true
                ..style = PaintingStyle.stroke,
            );
        }
      } on Exception catch (e, st) {
        talker.error(
          'MapRegionIntensityV2Painter ${city.code}',
          e,
          st,
        );
      }
    }
    // Regionの描画
    for (final region in regions) {
      // region.codeが一致するMapPolygonを探す
      final mapRegionPolygons = mapPolygons.where(
        (element) => element.code == region.code,
      );
      for (final mapPolygon in mapRegionPolygons) {
        if (cities.isEmpty) {
          canvas.drawPath(
            mapPolygon.path,
            Paint()
              ..color = JmaIntensity.values
                  .firstWhere(
                    (e) => e.name == region.maxInt?.name,
                    orElse: () => JmaIntensity.Error,
                  )
                  .fromUser(colors)
              ..isAntiAlias = true
              ..strokeCap = StrokeCap.square,
          );
        }
        canvas.drawPath(
          mapPolygon.path,
          Paint()
            ..color = isDarkMode
                ? const Color.fromARGB(150, 50, 50, 50)
                : const Color.fromARGB(150, 150, 150, 150)
            ..isAntiAlias = true
            ..style = PaintingStyle.stroke,
        );
      }
    }
    // TODO(YumNumm): 観測点の描画実装
    /*for (final station in stations) {
      final param =
          parameterEarthquake.items.firstWhere((e) => e.code == station.code);
      final offset = MapGlobalOffset.latLonToGlobalPoint(
        LatLng(param.latitude, param.longitude),
      ).toLocalOffset(const Size(476, 927.4));
      canvas.drawCircle(
        offset,
        1,
        Paint()
          ..color = JmaIntensity.values
              .firstWhere((e) => e.name == station.intensity)
              .color
              .withBlue(100)
          ..isAntiAlias = true
          ..style = PaintingStyle.fill,
      );
    }
    */

    talker.debug(
      'MapRegionIntensityPainter took ${stopWatch.elapsed.inMicroseconds / 1000}ms',
    );
  }

  @override
  bool shouldRepaint(MapRegionIntensityV2Painter oldDelegate) {
    return oldDelegate.mapPolygons != mapPolygons ||
        oldDelegate.regions != regions ||
        oldDelegate.colors != colors ||
        oldDelegate.parameterEarthquake != parameterEarthquake ||
        oldDelegate.stations != stations ||
        oldDelegate.cities != cities ||
        oldDelegate.mapAreaInformationCityQuakePolygons !=
            mapAreaInformationCityQuakePolygons ||
        oldDelegate.isDarkMode != isDarkMode;
  }
}

class MaphypocenterMapWidget extends StatelessWidget {
  const MaphypocenterMapWidget({
    super.key,
    required this.component,
  });
  final EarthquakeComponentHypocenter? component;

  @override
  Widget build(BuildContext context) {
    if (component == null) {
      return const SizedBox.shrink();
    }
    return CustomPaint(
      painter: MaphypocenterV2Painter(
        component: component!,
      ),
      size: Size.infinite,
    );
  }
}

class MaphypocenterV2Painter extends CustomPainter {
  MaphypocenterV2Painter({
    required this.component,
  });

  final EarthquakeComponentHypocenter component;

  @override
  void paint(Canvas canvas, Size size) {
    {
      final offset = MapGlobalOffset.latLonToGlobalPoint(
        LatLng(
          component.coordinate.latitude!.value,
          component.coordinate.longitude!.value,
        ),
      ).toLocalOffset(const Size(476, 927.4));
      // ×印を描く
      {
        canvas
          ..drawLine(
            Offset(offset.dx - 4, offset.dy - 4),
            Offset(offset.dx + 4, offset.dy + 4),
            Paint()
              ..color = const Color.fromARGB(255, 0, 0, 0)
              ..isAntiAlias = true
              ..strokeCap = StrokeCap.square
              ..style = PaintingStyle.stroke
              ..strokeWidth = 2,
          )
          ..drawLine(
            Offset(offset.dx + 4, offset.dy - 4),
            Offset(offset.dx - 4, offset.dy + 4),
            Paint()
              ..color = const Color.fromARGB(255, 0, 0, 0)
              ..isAntiAlias = true
              ..strokeCap = StrokeCap.square
              ..style = PaintingStyle.stroke
              ..strokeWidth = 2,
          )
          ..drawLine(
            Offset(offset.dx - 4, offset.dy - 4),
            Offset(offset.dx + 4, offset.dy + 4),
            Paint()
              ..color = const Color.fromARGB(255, 255, 255, 255)
              ..isAntiAlias = true
              ..strokeCap = StrokeCap.square
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1.5,
          )
          ..drawLine(
            Offset(offset.dx + 4, offset.dy - 4),
            Offset(offset.dx - 4, offset.dy + 4),
            Paint()
              ..color = const Color.fromARGB(255, 255, 255, 255)
              ..isAntiAlias = true
              ..strokeCap = StrokeCap.square
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1.5,
          )
          ..drawLine(
            Offset(offset.dx - 4, offset.dy - 4),
            Offset(offset.dx + 4, offset.dy + 4),
            Paint()
              ..color = const Color.fromARGB(255, 255, 0, 0)
              ..isAntiAlias = true
              ..strokeCap = StrokeCap.square
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1.3,
          )
          ..drawLine(
            Offset(offset.dx + 4, offset.dy - 4),
            Offset(offset.dx - 4, offset.dy + 4),
            Paint()
              ..color = const Color.fromARGB(255, 255, 0, 0)
              ..isAntiAlias = true
              ..strokeCap = StrokeCap.square
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1.3,
          );
      }
    }
  }

  @override
  bool shouldRepaint(covariant MaphypocenterV2Painter oldDelegate) =>
      oldDelegate.component != component;
}

class MapStationIntensityWidget extends ConsumerWidget {
  const MapStationIntensityWidget({
    super.key,
    required this.stations,
  });
  final List<Station> stations;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final allParameterEarthquakeItem = ref.watch(parameterEarthquakeProvider);

    final widgets = <Widget>[];

    // 各観測点の処理
    //for (final station in stations) {
    //  try {
    //    // 緯度経度を取得
    //    //final param = allParameterEarthquakeItem.items
    //    //    .firstWhere((e) => e.code == station.code);
    //    // final offset = MapGlobalOffset.latLonToGlobalPoint(
    //    //   LatLng(param.latitude, param.longitude),
    //    // ).toLocalOffset(const Size(476, 927.4));
    //    // widgets.add(
    //    //   DecoratedBox(
    //    //     decoration: BoxDecoration(
    //    //       border: Border.all(
    //    //         color: Colors.red,
    //    //       ),
    //    //     ),
    //    //     child: Positioned(
    //    //       left: offset.dx,
    //    //       top: offset.dy,
    //    //       child: IntensityWidget(
    //    //         intensity: JmaIntensity.values
    //    //             .firstWhere((e) => e.name == station.intensity),
    //    //         size: 2,
    //    //         opacity: 1,
    //    //       ),
    //    //     ),
    //    //   ),
    //    // );
    //  } on Exception catch (_) {}
    //}

    return Stack(
      children: widgets,
    );
  }
}
