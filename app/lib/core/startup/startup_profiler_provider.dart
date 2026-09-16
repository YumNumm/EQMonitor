import 'package:eqmonitor/core/startup/startup_profiler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'startup_profiler_provider.g.dart';

/// `_main()` で生成した [StartupProfiler] を注入する。
/// override されない場合は空のインスタンスを返す (テスト等)。
@Riverpod(keepAlive: true)
StartupProfiler startupProfiler(Ref ref) => StartupProfiler();
