import 'package:eqmonitor/feature/map/ui/map_operation_queue_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// `MapOperationQueueScope`(StatefulWidget)の
/// キュー生成・保持の振る舞いを、HookWidget化前に固定するテスト。
void main() {
  testWidgets('Scope配下からqueueを取得できる', (tester) async {
    late MapOperationQueue? queue;
    await tester.pumpWidget(
      MaterialApp(
        home: MapOperationQueueScope(
          child: Builder(
            builder: (context) {
              queue = MapOperationQueueScope.maybeOf(context);
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );

    expect(queue, isNotNull);
  });

  testWidgets('Scopeが存在しない場合maybeOfはnullを返しofは例外を投げる', (tester) async {
    late MapOperationQueue? queue;
    late Object? thrown;
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            queue = MapOperationQueueScope.maybeOf(context);
            try {
              MapOperationQueueScope.of(context);
              thrown = null;
            } on Object catch (e) {
              thrown = e;
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );

    expect(queue, isNull);
    expect(thrown, isNotNull);
  });

  testWidgets('親の再buildでもScopeの子が再構築されなければ同一queueを維持する', (tester) async {
    final queues = <MapOperationQueue?>[];
    var counter = 0;
    late StateSetter setState;

    await tester.pumpWidget(
      MaterialApp(
        home: StatefulBuilder(
          builder: (context, setter) {
            setState = setter;
            return MapOperationQueueScope(
              child: Builder(
                builder: (context) {
                  // counterの変化を child tree に反映させ再buildを誘発しつつ、
                  // MapOperationQueueScope自体のElementはunmountされない。
                  queues.add(MapOperationQueueScope.maybeOf(context));
                  return Text('$counter');
                },
              ),
            );
          },
        ),
      ),
    );

    setState(() => counter++);
    await tester.pump();

    expect(queues, hasLength(2));
    expect(queues[0], same(queues[1]));
  });

  testWidgets('enqueueした操作は登録順に直列実行される', (tester) async {
    final order = <int>[];
    final queue = MapOperationQueue();

    await tester.runAsync(() async {
      final first = queue.enqueue(() async {
        await Future<void>.delayed(const Duration(milliseconds: 20));
        order.add(1);
      });
      final second = queue.enqueue(() async {
        order.add(2);
      });
      final third = queue.enqueue(() async {
        order.add(3);
      });
      await Future.wait([first, second, third]);
    });

    expect(order, [1, 2, 3]);
  });
}
