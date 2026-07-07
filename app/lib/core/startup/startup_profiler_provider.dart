import 'package:eqmonitor/core/startup/startup_profiler.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// `_main()` で生成した [StartupProfiler] を注入する。
/// override されない場合は空のインスタンスを返す (テスト等)。
final startupProfilerProvider = Provider<StartupProfiler>(
  (ref) => StartupProfiler(),
);
