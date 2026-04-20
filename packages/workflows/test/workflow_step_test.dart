import 'package:test/test.dart';
import 'package:workflows/workflows.dart';

void main() {
  group('WorkflowStep', () {
    late InMemoryWorkflowPersistence persistence;
    late WorkflowStep step;

    setUp(() {
      persistence = InMemoryWorkflowPersistence();
      step = WorkflowStep(instanceId: 'test-instance', persistence: persistence);
    });

    test('executes callback on first call', () async {
      var called = 0;
      final result = await step('stepA', () {
        called++;
        return 'hello';
      });
      expect(result, 'hello');
      expect(called, 1);
    });

    test('does not re-execute callback on subsequent calls with same name',
        () async {
      var called = 0;
      await step('stepA', () {
        called++;
        return 'first';
      });
      final result = await step('stepA', () {
        called++;
        return 'second';
      });
      expect(result, 'first');
      expect(called, 1);
    });

    test('independent steps run independently', () async {
      var calledA = 0;
      var calledB = 0;
      await step('stepA', () => ++calledA);
      await step('stepB', () => ++calledB);
      expect(calledA, 1);
      expect(calledB, 1);
    });

    test('persists null result and distinguishes from not-yet-run', () async {
      var called = 0;
      await step<String?>('nullStep', () {
        called++;
        return null;
      });
      final result = await step<String?>('nullStep', () {
        called++;
        return 'should not run';
      });
      expect(result, isNull);
      expect(called, 1);
    });

    test('new instance runs steps independently', () async {
      await step('stepA', () => 'first-instance');

      final step2 = WorkflowStep(
        instanceId: 'other-instance',
        persistence: persistence,
      );
      var called = 0;
      final result = await step2('stepA', () {
        called++;
        return 'second-instance';
      });
      expect(result, 'second-instance');
      expect(called, 1);
    });
  });

  group('WorkflowRunner', () {
    test('resumes from last completed step on restart', () async {
      final persistence = InMemoryWorkflowPersistence();
      final runner = WorkflowRunner(persistence: persistence);

      final executedSteps = <String>[];

      Future<void> runWorkflow() => runner.run(
            instanceId: 'instance-1',
            workflow: (step) async {
              await step('step1', () async {
                executedSteps.add('step1');
                return 'done1';
              });
              await step('step2', () async {
                executedSteps.add('step2');
                return 'done2';
              });
              await step('step3', () async {
                executedSteps.add('step3');
                return 'done3';
              });
            },
          );

      // First run completes normally
      await runWorkflow();
      expect(executedSteps, ['step1', 'step2', 'step3']);

      // Second run with same instance — all steps are already done
      executedSteps.clear();
      await runWorkflow();
      expect(executedSteps, isEmpty);
    });

    group('for loop over step array', () {
      const items = ['alpha', 'beta', 'gamma', 'delta'];

      test('各要素のステップが一度だけ実行され結果が返る', () async {
        final persistence = InMemoryWorkflowPersistence();
        final runner = WorkflowRunner(persistence: persistence);
        final executed = <String>[];

        final results = await runner.run(
          instanceId: 'loop-inst',
          workflow: (step) async {
            final out = <String>[];
            for (final item in items) {
              final r = await step('process-$item', () {
                executed.add(item);
                return item.toUpperCase();
              });
              out.add(r);
            }
            return out;
          },
        );

        expect(results, ['ALPHA', 'BETA', 'GAMMA', 'DELTA']);
        expect(executed, items);
      });

      test('2回目の実行でコールバックが一切呼ばれない (全要素キャッシュ済み)', () async {
        final persistence = InMemoryWorkflowPersistence();
        final runner = WorkflowRunner(persistence: persistence);
        var callCount = 0;

        Future<List<String>> runLoop() => runner.run(
              instanceId: 'loop-inst',
              workflow: (step) async {
                final out = <String>[];
                for (final item in items) {
                  final r = await step('process-$item', () {
                    callCount++;
                    return item.toUpperCase();
                  });
                  out.add(r);
                }
                return out;
              },
            );

        final first = await runLoop();
        expect(callCount, items.length);

        final second = await runLoop();
        expect(callCount, items.length, reason: '2回目でコールバックが追加実行されてはいけない');
        expect(second, first, reason: 'キャッシュから同じ結果が返るはず');
      });

      test('中間のステップが失敗した場合、再実行でそのステップから再開される', () async {
        final persistence = InMemoryWorkflowPersistence();
        final runner = WorkflowRunner(persistence: persistence);
        const failItem = 'gamma';
        var shouldFail = true;
        final executed = <String>[];

        Future<void> runLoop() => runner.run(
              instanceId: 'loop-inst',
              workflow: (step) async {
                for (final item in items) {
                  await step('process-$item', () {
                    if (item == failItem && shouldFail) {
                      throw Exception('fail at $item');
                    }
                    executed.add(item);
                    return item.toUpperCase();
                  });
                }
              },
            );

        // 1回目: alpha, beta は完了し gamma で失敗
        await expectLater(runLoop(), throwsA(isA<Exception>()));
        expect(executed, ['alpha', 'beta']);

        // 2回目: alpha, beta はスキップされ gamma から再開
        shouldFail = false;
        await runLoop();
        expect(
          executed,
          ['alpha', 'beta', 'gamma', 'delta'],
          reason: 'gamma と delta だけ2回目で実行されるはず',
        );
      });

      test('ステップ名にインデックスを使った場合も正常動作する', () async {
        final persistence = InMemoryWorkflowPersistence();
        final runner = WorkflowRunner(persistence: persistence);
        var callCount = 0;

        Future<List<int>> runLoop() => runner.run(
              instanceId: 'idx-loop',
              workflow: (step) async {
                final out = <int>[];
                for (var i = 0; i < items.length; i++) {
                  final r = await step('step-$i', () {
                    callCount++;
                    return i * 10;
                  });
                  out.add(r);
                }
                return out;
              },
            );

        expect(await runLoop(), [0, 10, 20, 30]);
        expect(callCount, items.length);

        // 2回目はキャッシュを使う
        await runLoop();
        expect(callCount, items.length);
      });
    });

    test('clear removes persisted state so steps run again', () async {
      final persistence = InMemoryWorkflowPersistence();
      final runner = WorkflowRunner(persistence: persistence);

      var count = 0;
      await runner.run(
        instanceId: 'inst',
        workflow: (step) async {
          await step('s', () => ++count);
        },
      );
      expect(count, 1);

      await runner.clear('inst');

      await runner.run(
        instanceId: 'inst',
        workflow: (step) async {
          await step('s', () => ++count);
        },
      );
      expect(count, 2);
    });
  });
}
