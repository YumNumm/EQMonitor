// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'dio_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dioHash() => r'5d646c54d92a9b59f60f2253149c45b78b6a4e18';

/// See also [dio].
@ProviderFor(dio)
final dioProvider = Provider<Dio>.internal(
  dio,
  name: r'dioProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$dioHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DioRef = ProviderRef<Dio>;
String _$isDioProxyEnabledHash() => r'716d5c817b377684285a697bf988ce19f0645c81';

/// See also [IsDioProxyEnabled].
@ProviderFor(IsDioProxyEnabled)
final isDioProxyEnabledProvider =
    NotifierProvider<IsDioProxyEnabled, bool>.internal(
  IsDioProxyEnabled.new,
  name: r'isDioProxyEnabledProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isDioProxyEnabledHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$IsDioProxyEnabled = Notifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
