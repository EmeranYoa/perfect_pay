/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/1.png
  AssetGenImage get a1 => const AssetGenImage('assets/images/1.png');

  /// File path: assets/images/12.png
  AssetGenImage get a12 => const AssetGenImage('assets/images/12.png');

  /// File path: assets/images/13.png
  AssetGenImage get a13 => const AssetGenImage('assets/images/13.png');

  /// File path: assets/images/2.png
  AssetGenImage get a2 => const AssetGenImage('assets/images/2.png');

  /// File path: assets/images/3.png
  AssetGenImage get a3 => const AssetGenImage('assets/images/3.png');

  /// File path: assets/images/4.png
  AssetGenImage get a4 => const AssetGenImage('assets/images/4.png');

  /// File path: assets/images/5.png
  AssetGenImage get a5 => const AssetGenImage('assets/images/5.png');

  /// File path: assets/images/bg.png
  AssetGenImage get bg => const AssetGenImage('assets/images/bg.png');

  /// File path: assets/images/fi-rr-sign-out.png
  AssetGenImage get fiRrSignOut =>
      const AssetGenImage('assets/images/fi-rr-sign-out.png');

  /// File path: assets/images/fi-rr-time-past 1.png
  AssetGenImage get fiRrTimePast1 =>
      const AssetGenImage('assets/images/fi-rr-time-past 1.png');

  /// File path: assets/images/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/images/logo.png');

  /// File path: assets/images/qr-code-2 1.png
  AssetGenImage get qrCode21 =>
      const AssetGenImage('assets/images/qr-code-2 1.png');

  /// File path: assets/images/scan.png
  AssetGenImage get scan => const AssetGenImage('assets/images/scan.png');

  /// File path: assets/images/splashscreen.png
  AssetGenImage get splashscreen =>
      const AssetGenImage('assets/images/splashscreen.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        a1,
        a12,
        a13,
        a2,
        a3,
        a4,
        a5,
        bg,
        fiRrSignOut,
        fiRrTimePast1,
        logo,
        qrCode21,
        scan,
        splashscreen
      ];
}

class Assets {
  Assets._();

  static const String aEnv = '.env.development';
  static const String pEnv = '.env.production';
  static const $AssetsImagesGen images = $AssetsImagesGen();

  /// List of all assets
  static List<String> get values => [aEnv, pEnv];
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

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
