/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

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

  /// File path: assets/fonts/JetBrainsMono-Bold.ttf
  String get jetBrainsMonoBold => 'assets/fonts/JetBrainsMono-Bold.ttf';

  /// File path: assets/fonts/JetBrainsMono-ExtraBold.ttf
  String get jetBrainsMonoExtraBold =>
      'assets/fonts/JetBrainsMono-ExtraBold.ttf';

  /// File path: assets/fonts/JetBrainsMono-Medium.ttf
  String get jetBrainsMonoMedium => 'assets/fonts/JetBrainsMono-Medium.ttf';

  /// File path: assets/fonts/NotoSansJP-Black.ttf
  String get notoSansJPBlack => 'assets/fonts/NotoSansJP-Black.ttf';

  /// File path: assets/fonts/NotoSansJP-Bold.ttf
  String get notoSansJPBold => 'assets/fonts/NotoSansJP-Bold.ttf';

  /// File path: assets/fonts/NotoSansJP-Medium.ttf
  String get notoSansJPMedium => 'assets/fonts/NotoSansJP-Medium.ttf';

  /// File path: assets/fonts/NotoSansJP-Regular.ttf
  String get notoSansJPRegular => 'assets/fonts/NotoSansJP-Regular.ttf';

  /// List of all assets
  List<String> get values => [
        jetBrainsMonoBold,
        jetBrainsMonoExtraBold,
        jetBrainsMonoMedium,
        notoSansJPBlack,
        notoSansJPBold,
        notoSansJPMedium,
        notoSansJPRegular
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/icon.png
  AssetGenImage get icon => const AssetGenImage('assets/images/icon.png');

  /// File path: assets/images/icon_foreground.png
  AssetGenImage get iconForeground =>
      const AssetGenImage('assets/images/icon_foreground.png');

  $AssetsImagesThemeGen get theme => const $AssetsImagesThemeGen();

  /// List of all assets
  List<AssetGenImage> get values => [icon, iconForeground];
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
  Assets._();

  static const String kyoshinShindoColorMap =
      'assets/KyoshinShindoColorMap.json';
  static const $AssetsDocsGen docs = $AssetsDocsGen();
  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const AssetGenImage header = AssetGenImage('assets/header.png');
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const String jmaCodeTable = 'assets/jma_code_table.pb';
  static const String jmaMap = 'assets/jma_map.pb';
  static const String kyoshinObservationPoint =
      'assets/kyoshin_observation_point.pb';
  static const String tjma2001 = 'assets/tjma2001.csv';

  /// List of all assets
  static List<dynamic> get values => [
        kyoshinShindoColorMap,
        header,
        jmaCodeTable,
        jmaMap,
        kyoshinObservationPoint,
        tjma2001
      ];
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

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
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
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

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
