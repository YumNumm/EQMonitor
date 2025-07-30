// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'information_history_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

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
    r'e38d2303d991d0e3a43935793125bb949a945a90';

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

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
