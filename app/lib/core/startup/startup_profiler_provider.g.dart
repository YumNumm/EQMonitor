// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'startup_profiler_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// `_main()` で生成した [StartupProfiler] を注入する。
/// override されない場合は空のインスタンスを返す (テスト等)。

@ProviderFor(startupProfiler)
final startupProfilerProvider = StartupProfilerProvider._();

/// `_main()` で生成した [StartupProfiler] を注入する。
/// override されない場合は空のインスタンスを返す (テスト等)。

final class StartupProfilerProvider
    extends
        $FunctionalProvider<StartupProfiler, StartupProfiler, StartupProfiler>
    with $Provider<StartupProfiler> {
  /// `_main()` で生成した [StartupProfiler] を注入する。
  /// override されない場合は空のインスタンスを返す (テスト等)。
  StartupProfilerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'startupProfilerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$startupProfilerHash();

  @$internal
  @override
  $ProviderElement<StartupProfiler> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  StartupProfiler create(Ref ref) {
    return startupProfiler(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StartupProfiler value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StartupProfiler>(value),
    );
  }
}

String _$startupProfilerHash() => r'271024ab8ba0b2717652f39920cad7a29a7ad0d8';
