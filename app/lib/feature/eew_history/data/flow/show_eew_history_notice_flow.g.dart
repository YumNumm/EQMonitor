// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'show_eew_history_notice_flow.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(eewHistoryNoticeFlow)
final eewHistoryNoticeFlowProvider = EewHistoryNoticeFlowProvider._();

final class EewHistoryNoticeFlowProvider
    extends
        $FunctionalProvider<
          EewHistoryNoticeFlow,
          EewHistoryNoticeFlow,
          EewHistoryNoticeFlow
        >
    with $Provider<EewHistoryNoticeFlow> {
  EewHistoryNoticeFlowProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eewHistoryNoticeFlowProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eewHistoryNoticeFlowHash();

  @$internal
  @override
  $ProviderElement<EewHistoryNoticeFlow> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  EewHistoryNoticeFlow create(Ref ref) {
    return eewHistoryNoticeFlow(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EewHistoryNoticeFlow value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EewHistoryNoticeFlow>(value),
    );
  }
}

String _$eewHistoryNoticeFlowHash() =>
    r'd85578be54820c166213a8d897b11d33cbbfec7d';
