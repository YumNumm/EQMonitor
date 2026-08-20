// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'app_clock.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// アプリ全体の現在時刻を提供する統一クロック。
///
/// 状態として現在の [TimeMode] を保持し、`now` でモードに応じた「現在時刻」を返す。
/// - ベース時刻は NTP 補正済み時刻（`Ntp.now`）を優先し、未同期時は `clock` にフォールバックする。
/// - 強震モニタ・EEW・揺れ検知はこのクロックを参照することで、通常/タイムシフト/リプレイの
///   いずれのモードでも整合した時刻基準で動作する。

@ProviderFor(AppClock)
final appClockProvider = AppClockProvider._();

/// アプリ全体の現在時刻を提供する統一クロック。
///
/// 状態として現在の [TimeMode] を保持し、`now` でモードに応じた「現在時刻」を返す。
/// - ベース時刻は NTP 補正済み時刻（`Ntp.now`）を優先し、未同期時は `clock` にフォールバックする。
/// - 強震モニタ・EEW・揺れ検知はこのクロックを参照することで、通常/タイムシフト/リプレイの
///   いずれのモードでも整合した時刻基準で動作する。
final class AppClockProvider extends $NotifierProvider<AppClock, TimeMode> {
  /// アプリ全体の現在時刻を提供する統一クロック。
  ///
  /// 状態として現在の [TimeMode] を保持し、`now` でモードに応じた「現在時刻」を返す。
  /// - ベース時刻は NTP 補正済み時刻（`Ntp.now`）を優先し、未同期時は `clock` にフォールバックする。
  /// - 強震モニタ・EEW・揺れ検知はこのクロックを参照することで、通常/タイムシフト/リプレイの
  ///   いずれのモードでも整合した時刻基準で動作する。
  AppClockProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appClockProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appClockHash();

  @$internal
  @override
  AppClock create() => AppClock();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TimeMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TimeMode>(value),
    );
  }
}

String _$appClockHash() => r'0c305e2c661203d27ef746a2244606ea480b986c';

/// アプリ全体の現在時刻を提供する統一クロック。
///
/// 状態として現在の [TimeMode] を保持し、`now` でモードに応じた「現在時刻」を返す。
/// - ベース時刻は NTP 補正済み時刻（`Ntp.now`）を優先し、未同期時は `clock` にフォールバックする。
/// - 強震モニタ・EEW・揺れ検知はこのクロックを参照することで、通常/タイムシフト/リプレイの
///   いずれのモードでも整合した時刻基準で動作する。

abstract class _$AppClock extends $Notifier<TimeMode> {
  TimeMode build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<TimeMode, TimeMode>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<TimeMode, TimeMode>,
              TimeMode,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// リプレイ再生中かどうか。
///
/// 値が bool のため、再生位置更新（[AppClock.updateReplayTime] による
/// 毎フレームの [TimeMode] 再生成）では通知されず、リプレイの開始/終了という
/// モード遷移時のみ購読側へ通知される。

@ProviderFor(isReplayMode)
final isReplayModeProvider = IsReplayModeProvider._();

/// リプレイ再生中かどうか。
///
/// 値が bool のため、再生位置更新（[AppClock.updateReplayTime] による
/// 毎フレームの [TimeMode] 再生成）では通知されず、リプレイの開始/終了という
/// モード遷移時のみ購読側へ通知される。

final class IsReplayModeProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// リプレイ再生中かどうか。
  ///
  /// 値が bool のため、再生位置更新（[AppClock.updateReplayTime] による
  /// 毎フレームの [TimeMode] 再生成）では通知されず、リプレイの開始/終了という
  /// モード遷移時のみ購読側へ通知される。
  IsReplayModeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isReplayModeProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isReplayModeHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isReplayMode(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isReplayModeHash() => r'ffd3de0c6622ab10c56b7687418b48812d8f2285';

/// 通常再生中かどうか。
///
/// 値が bool のため、リプレイ再生位置の更新では通知されず、通常/非通常の
/// モード遷移時のみ購読側へ通知される。

@ProviderFor(isRealtimeMode)
final isRealtimeModeProvider = IsRealtimeModeProvider._();

/// 通常再生中かどうか。
///
/// 値が bool のため、リプレイ再生位置の更新では通知されず、通常/非通常の
/// モード遷移時のみ購読側へ通知される。

final class IsRealtimeModeProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// 通常再生中かどうか。
  ///
  /// 値が bool のため、リプレイ再生位置の更新では通知されず、通常/非通常の
  /// モード遷移時のみ購読側へ通知される。
  IsRealtimeModeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isRealtimeModeProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isRealtimeModeHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isRealtimeMode(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isRealtimeModeHash() => r'cb00a8e424e61eafb3914004ce1c025eaac052e1';
