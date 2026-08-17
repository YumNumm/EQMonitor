import 'package:flutter/widgets.dart';

class EewWarningOverlayBackDispatcherController {
  new({
    required BackButtonDispatcher parent,
    required Future<void> Function() onFullscreenBack,
  }) : _parent = parent,
       _dispatcher = parent.createChildBackButtonDispatcher() {
    _callback = () async {
      if (!_shouldIntercept || _isDisposed) {
        return false;
      }
      await onFullscreenBack();
      return true;
    };
  }

  final BackButtonDispatcher _parent;
  final ChildBackButtonDispatcher _dispatcher;
  late final ValueGetter<Future<bool>> _callback;
  var _isAttached = false;
  var _isDisposed = false;
  var _shouldIntercept = false;

  void attach() {
    if (_isAttached || _isDisposed) {
      return;
    }
    _dispatcher.addCallback(_callback);
    _isAttached = true;
    if (_shouldIntercept) {
      _dispatcher.takePriority();
    }
  }

  void update({required bool shouldIntercept}) {
    _shouldIntercept = shouldIntercept;
    if (!_isAttached || _isDisposed) {
      return;
    }
    if (shouldIntercept) {
      _dispatcher.takePriority();
    } else {
      _parent.forget(_dispatcher);
    }
  }

  void dispose() {
    if (_isDisposed) {
      return;
    }
    _isDisposed = true;
    if (_isAttached) {
      _dispatcher.removeCallback(_callback);
      _isAttached = false;
    }
  }
}
