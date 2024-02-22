import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/provider/jma_parameter/jma_parameter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ParameterLoaderWidget extends HookConsumerWidget {
  const ParameterLoaderWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(
      () {
        WidgetsBinding.instance.endOfFrame.then(
          (_) {},
        );
        return null;
      },
      [],
    );
    final state = ref.watch(jmaParameterProvider);
    return switch (state) {
      AsyncError() => Text(state.toString()),
      AsyncData() || AsyncError() => const AnimatedSwitcher(
          duration: Duration(milliseconds: 150),
          child: SizedBox.shrink(
            key: ValueKey('non'),
          ),
        ),
      _ => const AnimatedSwitcher(
          duration: Duration(milliseconds: 150),
          child: BorderedContainer(
            key: ValueKey('loading'),
            elevation: 1,
            child: Row(
              children: [
                Text('観測点の情報を取得中...'),
                SizedBox(width: 8),
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator.adaptive(),
                ),
              ],
            ),
          ),
        ),
    };
  }
}
