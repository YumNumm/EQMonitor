typedef SeismicityWorkerTerminalCounters = ({
  int errorCount,
  int exitCount,
});

enum SeismicityWorkerTerminalTransition { error, exit }

abstract interface class SeismicityWorkerTerminalProbe {
  SeismicityWorkerTerminalCounters get counters;

  void recordTransition({
    required SeismicityWorkerTerminalTransition transition,
  });
}
