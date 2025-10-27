// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'information_history_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(InformationHistoryViewModel)
const informationHistoryViewModelProvider =
    InformationHistoryViewModelProvider._();

final class InformationHistoryViewModelProvider
    extends
        $NotifierProvider<
          InformationHistoryViewModel,
          AsyncValue<List<InformationV3>>?
        > {
  const InformationHistoryViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'informationHistoryViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$informationHistoryViewModelHash();

  @$internal
  @override
  InformationHistoryViewModel create() => InformationHistoryViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<List<InformationV3>>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<List<InformationV3>>?>(
        value,
      ),
    );
  }
}

String _$informationHistoryViewModelHash() =>
    r'e36e4b1e0d2833f78e25284fd68c34f48f1f4f92';

abstract class _$InformationHistoryViewModel
    extends $Notifier<AsyncValue<List<InformationV3>>?> {
  AsyncValue<List<InformationV3>>? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<InformationV3>>?,
              AsyncValue<List<InformationV3>>?
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<InformationV3>>?,
                AsyncValue<List<InformationV3>>?
              >,
              AsyncValue<List<InformationV3>>?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
