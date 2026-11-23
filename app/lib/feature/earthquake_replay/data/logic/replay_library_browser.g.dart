// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'replay_library_browser.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(replayLibraryBrowser)
final replayLibraryBrowserProvider = ReplayLibraryBrowserProvider._();

final class ReplayLibraryBrowserProvider
    extends
        $FunctionalProvider<
          ReplayLibraryBrowser,
          ReplayLibraryBrowser,
          ReplayLibraryBrowser
        >
    with $Provider<ReplayLibraryBrowser> {
  ReplayLibraryBrowserProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'replayLibraryBrowserProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$replayLibraryBrowserHash();

  @$internal
  @override
  $ProviderElement<ReplayLibraryBrowser> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ReplayLibraryBrowser create(Ref ref) {
    return replayLibraryBrowser(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReplayLibraryBrowser value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReplayLibraryBrowser>(value),
    );
  }
}

String _$replayLibraryBrowserHash() =>
    r'414acef45303cc3ad86815fa1591df7e3744e62c';
