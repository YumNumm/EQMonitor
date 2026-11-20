// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'visible_release_highlight_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// ホームに表示する新機能の案内。表示するものが無ければ null。
///
/// 案内する機能をこの端末で使えない間は表示せず、既読にもしない。

@ProviderFor(visibleReleaseHighlight)
final visibleReleaseHighlightProvider = VisibleReleaseHighlightProvider._();

/// ホームに表示する新機能の案内。表示するものが無ければ null。
///
/// 案内する機能をこの端末で使えない間は表示せず、既読にもしない。

final class VisibleReleaseHighlightProvider
    extends
        $FunctionalProvider<
          VisibleReleaseHighlight?,
          VisibleReleaseHighlight?,
          VisibleReleaseHighlight?
        >
    with $Provider<VisibleReleaseHighlight?> {
  /// ホームに表示する新機能の案内。表示するものが無ければ null。
  ///
  /// 案内する機能をこの端末で使えない間は表示せず、既読にもしない。
  VisibleReleaseHighlightProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'visibleReleaseHighlightProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$visibleReleaseHighlightHash();

  @$internal
  @override
  $ProviderElement<VisibleReleaseHighlight?> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  VisibleReleaseHighlight? create(Ref ref) {
    return visibleReleaseHighlight(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VisibleReleaseHighlight? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VisibleReleaseHighlight?>(value),
    );
  }
}

String _$visibleReleaseHighlightHash() =>
    r'98700592e2597b5388b4601b05571bff233eb4d3';
