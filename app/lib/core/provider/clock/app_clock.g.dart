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

String _$appClockHash() => r'fb6978de4293d91a9df3d7afee1a64f5e3dd385d';

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
  void runBuild() {
    final ref = this.ref as $Ref<TimeMode, TimeMode>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<TimeMode, TimeMode>,
              TimeMode,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
