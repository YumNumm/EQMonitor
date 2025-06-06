// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_side_shake_detection_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$clientSideShakeDetectorHash() =>
    r'b4f8d5c7e9a1d2f0a8c6b3e7d1f4e8a2c5b9d6f2e5a8b1c4d7e0f3a6b9c2d5e8f1a4b7c0';

/// See also [clientSideShakeDetector].
@ProviderFor(clientSideShakeDetector)
final clientSideShakeDetectorProvider =
    Provider<ClientSideShakeDetector>.internal(
  clientSideShakeDetector,
  name: r'clientSideShakeDetectorProvider',
  debugGetCreateSourceHash: _$clientSideShakeDetectorHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ClientSideShakeDetectorRef = ProviderRef<ClientSideShakeDetector>;
String _$clientSideShakeDetectionHash() =>
    r'a3e5f8c2b6d9e1f4a7b0c3d6e9f2a5b8c1d4e7f0a3b6c9d2e5f8a1b4c7d0e3f6a9b2c5d8e1f4';

/// See also [ClientSideShakeDetection].
@ProviderFor(ClientSideShakeDetection)
final clientSideShakeDetectionProvider = AsyncNotifierProvider<
    ClientSideShakeDetection, List<ClientShakeDetectionEvent>>.internal(
  ClientSideShakeDetection.new,
  name: r'clientSideShakeDetectionProvider',
  debugGetCreateSourceHash: _$clientSideShakeDetectionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ClientSideShakeDetection
    = AsyncNotifier<List<ClientShakeDetectionEvent>>;
String _$integratedShakeDetectionHash() =>
    r'c5e8f1a4b7c0d3e6f9a2b5c8d1e4f7a0b3c6d9e2f5a8b1c4d7e0f3a6b9c2d5e8f1a4b7c0d3e6';

/// クライアントサイド検知とサーバーサイド検知の統合
///
/// See also [IntegratedShakeDetection].
@ProviderFor(IntegratedShakeDetection)
final integratedShakeDetectionProvider = AsyncNotifierProvider<
    IntegratedShakeDetection, List<IntegratedShakeDetectionEvent>>.internal(
  IntegratedShakeDetection.new,
  name: r'integratedShakeDetectionProvider',
  debugGetCreateSourceHash: _$integratedShakeDetectionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$IntegratedShakeDetection
    = AsyncNotifier<List<IntegratedShakeDetectionEvent>>;