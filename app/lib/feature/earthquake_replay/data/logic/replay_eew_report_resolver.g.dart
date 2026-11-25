// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'replay_eew_report_resolver.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(replayEewReportResolver)
final replayEewReportResolverProvider = ReplayEewReportResolverProvider._();

final class ReplayEewReportResolverProvider
    extends
        $FunctionalProvider<
          ReplayEewReportResolver,
          ReplayEewReportResolver,
          ReplayEewReportResolver
        >
    with $Provider<ReplayEewReportResolver> {
  ReplayEewReportResolverProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'replayEewReportResolverProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$replayEewReportResolverHash();

  @$internal
  @override
  $ProviderElement<ReplayEewReportResolver> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ReplayEewReportResolver create(Ref ref) {
    return replayEewReportResolver(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReplayEewReportResolver value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReplayEewReportResolver>(value),
    );
  }
}

String _$replayEewReportResolverHash() =>
    r'182ee908eb50277143f67f94da2d2d165072d79d';
