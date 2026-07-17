// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsDebugGen {
  const $AssetsDebugGen();

  /// File path: assets/debug/.gitkeep
  String get aGitkeep => 'assets/debug/.gitkeep';

  /// List of all assets
  List<String> get values => [aGitkeep];
}

class $AssetsDocsGen {
  const $AssetsDocsGen();

  /// File path: assets/docs/about_this_app.md
  String get aboutThisApp => 'assets/docs/about_this_app.md';

  /// File path: assets/docs/privacy_policy.md
  String get privacyPolicy => 'assets/docs/privacy_policy.md';

  /// File path: assets/docs/term_of_service.md
  String get termOfService => 'assets/docs/term_of_service.md';

  /// List of all assets
  List<String> get values => [aboutThisApp, privacyPolicy, termOfService];
}

class $AssetsFontsGen {
  const $AssetsFontsGen();
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/icon.png
  AssetGenImage get icon => const AssetGenImage('assets/images/icon.png');

  /// File path: assets/images/icon_foreground.png
  AssetGenImage get iconForeground =>
      const AssetGenImage('assets/images/icon_foreground.png');

  /// Directory path: assets/images/map
  $AssetsImagesMapGen get map => const $AssetsImagesMapGen();

  /// Directory path: assets/images/theme
  $AssetsImagesThemeGen get theme => const $AssetsImagesThemeGen();

  /// List of all assets
  List<AssetGenImage> get values => [icon, iconForeground];
}

class $AssetsParameterGen {
  const $AssetsParameterGen();

  /// File path: assets/parameter/earthquake.bin
  String get earthquake => 'assets/parameter/earthquake.bin';

  /// File path: assets/parameter/tsunami.bin
  String get tsunami => 'assets/parameter/tsunami.bin';

  /// List of all assets
  List<String> get values => [earthquake, tsunami];
}

class $AssetsParametersGen {
  const $AssetsParametersGen();

  /// File path: assets/parameters/earthquake_stations.json
  String get earthquakeStations => 'assets/parameters/earthquake_stations.json';

  /// File path: assets/parameters/jma_code_table.json
  String get jmaCodeTable => 'assets/parameters/jma_code_table.json';

  /// File path: assets/parameters/kyoshin_observation_points.json
  String get kyoshinObservationPoints =>
      'assets/parameters/kyoshin_observation_points.json';

  /// File path: assets/parameters/manifest.json
  String get manifest => 'assets/parameters/manifest.json';

  /// File path: assets/parameters/shindo_db_stations.json
  String get shindoDbStations => 'assets/parameters/shindo_db_stations.json';

  /// File path: assets/parameters/tsunami_stations.json
  String get tsunamiStations => 'assets/parameters/tsunami_stations.json';

  /// List of all assets
  List<String> get values => [
    earthquakeStations,
    jmaCodeTable,
    kyoshinObservationPoints,
    manifest,
    shindoDbStations,
    tsunamiStations,
  ];
}

class $AssetsImagesMapGen {
  const $AssetsImagesMapGen();

  /// File path: assets/images/map/low_precise_hypocenter.png
  AssetGenImage get lowPreciseHypocenter =>
      const AssetGenImage('assets/images/map/low_precise_hypocenter.png');

  /// File path: assets/images/map/normal_hypocenter.png
  AssetGenImage get normalHypocenter =>
      const AssetGenImage('assets/images/map/normal_hypocenter.png');

  /// List of all assets
  List<AssetGenImage> get values => [lowPreciseHypocenter, normalHypocenter];
}

class $AssetsImagesThemeGen {
  const $AssetsImagesThemeGen();

  /// File path: assets/images/theme/dark.png
  AssetGenImage get dark => const AssetGenImage('assets/images/theme/dark.png');

  /// File path: assets/images/theme/light.png
  AssetGenImage get light =>
      const AssetGenImage('assets/images/theme/light.png');

  /// List of all assets
  List<AssetGenImage> get values => [dark, light];
}

class Assets {
  const Assets._();

  static const String kyoshinShindoColorMap =
      'assets/KyoshinShindoColorMap.json';
  static const $AssetsDebugGen debug = $AssetsDebugGen();
  static const $AssetsDocsGen docs = $AssetsDocsGen();
  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const AssetGenImage header = AssetGenImage('assets/header.png');
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const String jmaCodeTable = 'assets/jma_code_table.pb';
  static const String jmaMap = 'assets/jma_map.pb';
  static const String kyoshinMonitorScale = 'assets/kyoshin_monitor_scale.json';
  static const String kyoshinObservationPoint =
      'assets/kyoshin_observation_point.pb';
  static const $AssetsParameterGen parameter = $AssetsParameterGen();
  static const $AssetsParametersGen parameters = $AssetsParametersGen();
  static const String tjma2001 = 'assets/tjma2001.csv';

  /// List of all assets
  static List<dynamic> get values => [
    kyoshinShindoColorMap,
    header,
    jmaCodeTable,
    jmaMap,
    kyoshinMonitorScale,
    kyoshinObservationPoint,
    tjma2001,
  ];
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
