// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'saved_replay_files_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SavedReplayFiles)
final savedReplayFilesProvider = SavedReplayFilesProvider._();

final class SavedReplayFilesProvider
    extends $AsyncNotifierProvider<SavedReplayFiles, List<SavedReplayFile>> {
  SavedReplayFilesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'savedReplayFilesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$savedReplayFilesHash();

  @$internal
  @override
  SavedReplayFiles create() => SavedReplayFiles();
}

String _$savedReplayFilesHash() => r'6da16168e7b9be6892cb2fd30204fa409cdf49c2';

abstract class _$SavedReplayFiles
    extends $AsyncNotifier<List<SavedReplayFile>> {
  FutureOr<List<SavedReplayFile>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<SavedReplayFile>>, List<SavedReplayFile>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<SavedReplayFile>>,
                List<SavedReplayFile>
              >,
              AsyncValue<List<SavedReplayFile>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
