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
