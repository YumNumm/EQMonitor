// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eew_warning_overlay_candidate_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(eewWarningOverlayCandidates)
final eewWarningOverlayCandidatesProvider =
    EewWarningOverlayCandidatesProvider._();

final class EewWarningOverlayCandidatesProvider
    extends
        $FunctionalProvider<
          List<EewWarningOverlayCandidate>,
          List<EewWarningOverlayCandidate>,
          List<EewWarningOverlayCandidate>
        >
    with $Provider<List<EewWarningOverlayCandidate>> {
  EewWarningOverlayCandidatesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eewWarningOverlayCandidatesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eewWarningOverlayCandidatesHash();

  @$internal
  @override
  $ProviderElement<List<EewWarningOverlayCandidate>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<EewWarningOverlayCandidate> create(Ref ref) {
    return eewWarningOverlayCandidates(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<EewWarningOverlayCandidate> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<EewWarningOverlayCandidate>>(
        value,
      ),
    );
  }
}

String _$eewWarningOverlayCandidatesHash() =>
    r'7fde071e4259f7977018f0ece36009d998b4039b';
