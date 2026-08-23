import 'package:eqmonitor_map/eqmonitor_map.dart';
import 'package:flutter_test/flutter_test.dart';

MapOverlayVersionStamp _stamp({
  String sourceIdentity = 'event-a',
  String sourceIncarnation = 'incarnation-a',
  int dataSequence = 3,
  String dataDigest = 'data-a',
  int renderGeneration = 5,
  String renderDigest = 'render-a',
}) => createMapOverlayVersionStamp(
  sourceIdentity: createMapSourceIdentity(value: sourceIdentity),
  sourceIncarnation: createMapSourceIncarnation(value: sourceIncarnation),
  dataSequence: dataSequence,
  dataDigest: dataDigest,
  renderGeneration: renderGeneration,
  renderDigest: renderDigest,
);

void main() {
  test('normalizes every string and provides full value equality', () {
    final first = _stamp(
      sourceIdentity: ' event-a ',
      sourceIncarnation: ' incarnation-a ',
      dataDigest: ' data-a ',
      renderDigest: ' render-a ',
    );
    final second = _stamp();

    expect(first, second);
    expect(first.hashCode, second.hashCode);
  });

  test('rejects blank values and negative counters', () {
    expect(() => _stamp(sourceIdentity: ' '), throwsArgumentError);
    expect(() => _stamp(sourceIncarnation: '\n'), throwsArgumentError);
    expect(() => _stamp(dataDigest: '\t'), throwsArgumentError);
    expect(() => _stamp(renderDigest: ' '), throwsArgumentError);
    expect(() => _stamp(dataSequence: -1), throwsArgumentError);
    expect(() => _stamp(renderGeneration: -1), throwsArgumentError);
  });

  test('accepts only monotonic, digest-consistent same-source transitions', () {
    final current = _stamp();

    expect(
      canAdvanceMapOverlayVersionStamp(
        current: current,
        next: _stamp(dataSequence: 2),
      ),
      isFalse,
    );
    expect(
      canAdvanceMapOverlayVersionStamp(
        current: current,
        next: _stamp(dataDigest: 'data-b'),
      ),
      isFalse,
    );
    expect(
      canAdvanceMapOverlayVersionStamp(
        current: current,
        next: _stamp(renderGeneration: 4),
      ),
      isFalse,
    );
    expect(
      canAdvanceMapOverlayVersionStamp(
        current: current,
        next: _stamp(renderDigest: 'render-b'),
      ),
      isFalse,
    );
    expect(
      canAdvanceMapOverlayVersionStamp(current: current, next: _stamp()),
      isTrue,
    );
    expect(
      canAdvanceMapOverlayVersionStamp(
        current: current,
        next: _stamp(renderGeneration: 6, renderDigest: 'render-b'),
      ),
      isTrue,
    );
  });

  test('accepts a new identity or incarnation as full replacement', () {
    final current = _stamp(dataSequence: 100, renderGeneration: 100);

    expect(
      canAdvanceMapOverlayVersionStamp(
        current: current,
        next: _stamp(sourceIdentity: 'event-b'),
      ),
      isTrue,
    );
    expect(
      canAdvanceMapOverlayVersionStamp(
        current: current,
        next: _stamp(sourceIncarnation: 'incarnation-b'),
      ),
      isTrue,
    );
  });
}
