# Task 3 Implementer Report

## Result

- Implementation commit: `e1a6c46da`
- Implemented the PMTiles v3 127-byte header decoder with strict magic,
  version, MVT type, zoom, root-window, section-bound, and overlap checks.
- Implemented canonical unsigned varints, delta tile IDs, run lengths,
  lengths, and offset-plus-one/sentinel directory decoding.
- Implemented root and leaf traversal with a maximum of three directory
  levels, parent-range/order validation, exact section reads, and run/zoom
  interval intersection.
- Implemented `none` and `gzip` decoding. Unknown, brotli, zstd, and other
  compression values fail with the typed unsupported-compression exception.
- Added Freezed public header and directory-entry values and the public archive
  contract. The archive owns and closes its random-access reader.
- Added handcrafted root-only, leaf, nested-leaf, gzip, run, malformed-varint,
  malformed-gzip, section-bound, descriptor, ordering, and close fixtures.

The implementation follows the official
[PMTiles v3 specification](https://github.com/protomaps/PMTiles/blob/master/spec/v3/spec.md).
It does not import `package:pmtiles` or its internal sources.

## Verification

Run from `packages/seismicity_pmtiles`:

```text
mise exec -- dart run build_runner build --delete-conflicting-outputs
```

Result: succeeded. `build_runner` reported that
`--delete-conflicting-outputs` is now ignored and warned that the installed SDK
language version is newer than the analyzer language version; generation still
completed successfully.

```text
mise exec -- dart format lib test
```

Result: succeeded; all source and test files formatted.

```text
mise exec -- dart analyze --fatal-infos
```

Result: `No issues found!`

```text
mise exec -- dart test test
```

Result: `42` tests passed, including all Task 1-2 regression tests and `20`
Task 3 parser/archive tests.

```text
git --no-pager diff --cached --check
```

Result before commit: no whitespace errors.

## Deviations and concerns

- Added `SeismicityPmTilesException.tileNotFound` so a missing tile has an
  explicit typed failure instead of returning empty bytes or misclassifying it
  as archive corruption.
- MVT is validated as the PMTiles v3 MVT tile-type value `1`, as required by
  this seismicity archive contract.
- Metadata JSON and MVT feature decoding remain outside Task 3. Network source
  support also remains outside this task.
- No production blocker remains. The code-generation warnings above are
  toolchain-version warnings and did not affect generated output, analysis, or
  tests.
