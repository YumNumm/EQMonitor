import 'dart:async';

import 'package:clock/clock.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/provider/clock/app_clock.dart';
import 'package:eqmonitor/core/provider/clock/time_mode.dart';
import 'package:eqmonitor/core/provider/time_ticker.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/notifier/replay_notifier.dart';
import 'package:eqmonitor/feature/home/ui/component/eew/eew_card_text_style.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

class const EewCardArrivalCountdown({
  required final DateTime? arrivalTime,
  required final bool isArrived,
  required final DateTime Function()? clockOverride,
  required final Color color,
}) extends HookConsumerWidget {
  static const _refreshInterval = Duration(milliseconds: 50);
  static const _maxReplayStep = Duration(seconds: 1);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tick = ref.watch(timeTickerProvider()).value;
    final replayTime = switch (ref.watch(appClockProvider)) {
      ReplayTimeMode(:final currentTime) => currentTime,
      _ => null,
    };
    final replay = replayTime == null
        ? null
        : ref.watch(
            replayProvider.select(
              (state) => (
                isPlaying: state?.isPlaying ?? false,
                speed: state?.playbackSpeed ?? 1,
              ),
            ),
          );
    // 時刻の配信は通常が1秒おき、リプレイがフレームごと。その間は経過時間を足して0.1秒の桁を進める。
    // リプレイは倍速と一時停止に合わせ、次のフレームを追い越さないよう1秒までにとどめる。
    final base = replayTime ?? tick;
    final anchor = useMemoized(
      () => (time: base, elapsed: clock.stopwatch()..start()),
      [base],
    );
    final rate = replay == null ? 1.0 : (replay.isPlaying ? replay.speed : 0.0);
    final step = anchor.elapsed.elapsed * rate;
    final interpolated = anchor.time?.add(
      replay != null && step > _maxReplayStep ? _maxReplayStep : step,
    );
    final arrivalTime = this.arrivalTime;
    final now = clockOverride?.call() ?? interpolated;
    final remaining = isArrived || arrivalTime == null || now == null
        ? Duration.zero
        : arrivalTime.difference(now);
    final isCountingDown =
        remaining > Duration.zero && (clockOverride != null || rate > 0);
    final refreshCount = useState(0);
    useEffect(() {
      if (!isCountingDown) {
        return null;
      }
      final timer = Timer.periodic(_refreshInterval, (_) {
        refreshCount.value++;
      });
      return timer.cancel;
      // ignore_keys: refreshCount.value
    }, [isCountingDown]);

    if (!isArrived && (arrivalTime == null || now == null)) {
      return const SizedBox.shrink();
    }
    final tenths = remaining.isNegative
        ? 0
        : (remaining.inMilliseconds / 100).ceil();
    final minutes = tenths ~/ 600;
    final seconds = (tenths % 600) ~/ 10;
    final hasMinutes = minutes > 0;

    // 桁数が変わっても小数点と「秒」の位置が動かないよう、最長の桁で幅を確保して右寄せにする。
    return FittedBox(
      fit: .scaleDown,
      alignment: .centerLeft,
      child: Stack(
        alignment: .centerRight,
        children: [
          ExcludeSemantics(
            child: Visibility.maintain(
              visible: false,
              child: _EewCountdownText(
                whole: hasMinutes ? '1:11' : '11',
                fraction: '.1',
                showsUnit: !hasMinutes,
                color: color,
              ),
            ),
          ),
          _EewCountdownText(
            whole: hasMinutes
                ? '$minutes:${seconds.toString().padLeft(2, '0')}'
                : '$seconds',
            fraction: tenths == 0 ? null : '.${tenths % 10}',
            showsUnit: !hasMinutes,
            color: color,
          ),
        ],
      ),
    );
  }
}

/// Live Activity の `EQCountdown.ttf` と同じ比率で、小数と「秒」を小さく描く。
class const _EewCountdownText({
  required final String whole,
  required final String? fraction,
  required final bool showsUnit,
  required final Color color,
}) extends StatelessWidget {
  static const _size = 26.0;
  static const _fractionScale = 0.62;
  static const _unitScale = 0.56;
  static const _decimalPointTrim = _size * -0.083;

  @override
  Widget build(BuildContext context) {
    final fraction = this.fraction;
    final wholeStyle = EewCardCodeTextStyle(
      size: _size,
      weight: .w700,
      color: color,
    ).copyWith(height: 32 / _size);
    final fractionStyle = EewCardCodeTextStyle(
      size: _size * _fractionScale,
      weight: .w800,
      color: color,
    );

    return Text.rich(
      TextSpan(
        children: [
          if (fraction == null)
            TextSpan(text: whole)
          else ...[
            TextSpan(text: whole.substring(0, whole.length - 1)),
            // 等幅フォントの小数点は1文字分の幅を取るため、小数点の前後だけを詰める。
            TextSpan(
              text: whole.substring(whole.length - 1),
              style: wholeStyle.copyWith(letterSpacing: _decimalPointTrim),
            ),
            TextSpan(
              text: fraction.substring(0, 1),
              style: fractionStyle.copyWith(letterSpacing: _decimalPointTrim),
            ),
            TextSpan(text: fraction.substring(1), style: fractionStyle),
          ],
          if (showsUnit)
            const TextSpan(
              text: '秒',
              style: TextStyle(
                fontFamily: FontFamily.notoSansJP,
                fontSize: _size * _unitScale,
                height: 1,
                fontWeight: .w700,
              ),
            ),
        ],
      ),
      style: wholeStyle,
      maxLines: 1,
      softWrap: false,
    );
  }
}
