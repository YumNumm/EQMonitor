import 'package:eqmonitor_map/src/flutter_scene/flutter_scene_spike_controller.dart';
import 'package:flutter/foundation.dart';

typedef FlutterSceneSpikeControllerFactory =
    FlutterSceneSpikeController Function(
      SceneSpikeRunLog runLog,
    );

class FlutterSceneSpikeRemountOwner extends ChangeNotifier {
  factory FlutterSceneSpikeRemountOwner.create() =>
      FlutterSceneSpikeRemountOwner.withDependencies(
        controllerFactory: (runLog) => FlutterSceneSpikeController.create(
          runLog: runLog,
        ),
      );

  FlutterSceneSpikeRemountOwner.withDependencies({
    required FlutterSceneSpikeControllerFactory controllerFactory,
  }) : _controllerFactory = controllerFactory,
       _runLog = SceneSpikeRunLog(startedAtUtc: DateTime.now().toUtc()) {
    _controller = _controllerFactory(_runLog);
  }

  final FlutterSceneSpikeControllerFactory _controllerFactory;
  final SceneSpikeRunLog _runLog;
  late FlutterSceneSpikeController _controller;
  var _awaitingReplacementMount = false;
  var _isDisposed = false;

  FlutterSceneSpikeController get controller => _controller;

  void requestRemount() {
    if (_isDisposed || _awaitingReplacementMount) {
      return;
    }
    final previous = _controller;
    previous.dispose();
    if (previous.lifecycle.phase != .disposed) {
      throw StateError('Previous Scene controller did not dispose.');
    }
    _awaitingReplacementMount = true;
    _controller = _controllerFactory(_runLog);
    notifyListeners();
  }

  void confirmMounted({required FlutterSceneSpikeController controller}) {
    if (_isDisposed ||
        !_awaitingReplacementMount ||
        !identical(controller, _controller) ||
        controller.lifecycle.phase != .active) {
      return;
    }
    _awaitingReplacementMount = false;
    controller.recordConfirmedDisposeAndRemount();
    notifyListeners();
  }

  @override
  void dispose() {
    if (_isDisposed) {
      return;
    }
    _isDisposed = true;
    _controller.dispose();
    super.dispose();
  }
}
