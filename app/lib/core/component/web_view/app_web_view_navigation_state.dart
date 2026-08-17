import 'package:eqmonitor/core/component/web_view/app_web_view_body.dart';

class AppWebViewNavigationState {
  const AppWebViewNavigationState.initial()
    : generation = 0,
      activeMainFrameUrl = null,
      status = AppWebViewLoadStatus.loading;

  const AppWebViewNavigationState({
    required this.generation,
    required this.activeMainFrameUrl,
    required this.status,
  });

  final int generation;
  final String? activeMainFrameUrl;
  final AppWebViewLoadStatus status;

  AppWebViewNavigationState retry() => AppWebViewNavigationState(
    generation: generation + 1,
    activeMainFrameUrl: null,
    status: AppWebViewLoadStatus.loading,
  );

  AppWebViewNavigationState loadStarted({
    required int generation,
    required Uri? url,
  }) {
    if (generation != this.generation) {
      return this;
    }
    return AppWebViewNavigationState(
      generation: generation,
      activeMainFrameUrl: url?.toString(),
      status: AppWebViewLoadStatus.loading,
    );
  }

  AppWebViewNavigationState loadStopped({
    required int generation,
    required Uri? url,
  }) {
    final matchesActiveNavigation =
        generation == this.generation &&
        url != null &&
        url.toString() == activeMainFrameUrl;
    if (!matchesActiveNavigation || status == AppWebViewLoadStatus.error) {
      return this;
    }
    return AppWebViewNavigationState(
      generation: generation,
      activeMainFrameUrl: activeMainFrameUrl,
      status: AppWebViewLoadStatus.loaded,
    );
  }

  AppWebViewNavigationState networkError({
    required int generation,
    required Uri url,
    required bool? isForMainFrame,
    required bool isCancellation,
  }) {
    final matchesActiveNavigation =
        generation == this.generation && url.toString() == activeMainFrameUrl;
    if (!matchesActiveNavigation || isForMainFrame != true || isCancellation) {
      return this;
    }
    return AppWebViewNavigationState(
      generation: generation,
      activeMainFrameUrl: activeMainFrameUrl,
      status: AppWebViewLoadStatus.error,
    );
  }

  AppWebViewNavigationState httpError({
    required int generation,
    required Uri url,
    required bool? isForMainFrame,
    required int? statusCode,
  }) {
    final matchesActiveNavigation =
        generation == this.generation && url.toString() == activeMainFrameUrl;
    if (!matchesActiveNavigation ||
        isForMainFrame != true ||
        statusCode == null ||
        statusCode < 400) {
      return this;
    }
    return AppWebViewNavigationState(
      generation: generation,
      activeMainFrameUrl: activeMainFrameUrl,
      status: AppWebViewLoadStatus.error,
    );
  }
}
