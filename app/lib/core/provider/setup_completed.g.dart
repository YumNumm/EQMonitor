// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setup_completed.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$setupCompletedHash() => r'setup_completed_hash';

/// 初期設定が完了しているかどうかを判定するProvider
/// userIdが存在する場合は初期設定完了とみなす
///
/// Copied from [SetupCompleted].
@ProviderFor(SetupCompleted)
final setupCompletedProvider =
    AsyncNotifierProvider<SetupCompleted, bool>.internal(
  SetupCompleted.new,
  name: r'setupCompletedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$setupCompletedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SetupCompleted = AsyncNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
