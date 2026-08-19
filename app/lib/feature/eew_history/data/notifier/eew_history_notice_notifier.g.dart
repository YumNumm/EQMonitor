// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eew_history_notice_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EewHistoryNoticeShown)
final eewHistoryNoticeShownProvider = EewHistoryNoticeShownProvider._();

final class EewHistoryNoticeShownProvider
    extends $AsyncNotifierProvider<EewHistoryNoticeShown, bool> {
  EewHistoryNoticeShownProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eewHistoryNoticeShownProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eewHistoryNoticeShownHash();

  @$internal
  @override
  EewHistoryNoticeShown create() => EewHistoryNoticeShown();
}

String _$eewHistoryNoticeShownHash() =>
    r'5858cc1aa136092ff722c4aa3958a0e83c580797';

abstract class _$EewHistoryNoticeShown extends $AsyncNotifier<bool> {
  FutureOr<bool> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<bool>, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<bool>, bool>,
              AsyncValue<bool>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
