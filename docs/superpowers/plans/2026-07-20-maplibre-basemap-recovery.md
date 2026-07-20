# MapLibre Basemap Recovery Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Restore every shared MapLibre basemap by bundling the former production `all.pmtiles` archive and loading it through a supported local file URI.

**Architecture:** Keep the existing platform asset filename and packaging configuration, but replace its bytes with the previously used HTTPS archive. Resolve that packaged asset through `AssetsUtil`, validate the resulting file, and pass MapLibre Native the encoded `pmtiles://file:///...` URI.

**Tech Stack:** Flutter/Dart, Riverpod, MapLibre Native, PMTiles v3, Android assets/JNI, iOS Bundle Resources/FFI

## Global Constraints

- Do not add new tests, per user request.
- Do not add a runtime HTTPS fallback.
- Keep `earthquake_tsunami_all.pmtiles` as the platform asset filename.
- Run Flutter and Dart commands through `mise exec --`.
- Preserve explicit errors for missing or empty local files.

---

### Task 1: Replace the incompatible bundled PMTiles archive

**Files:**
- Modify: `app/assets/platform/earthquake_tsunami_all.pmtiles`

**Interfaces:**
- Consumes: `https://v2.map.eqmonitor.app/all.pmtiles`
- Produces: a PMTiles v3 archive whose vector layer IDs include `countries`, `areaForecastLocalE`, `areaForecastLocalEew`, and `areaInformationCityQuake`

- [ ] **Step 1: Download to a temporary file without overwriting the tracked asset**

Run:

```bash
download_path=$(mktemp /tmp/eqmonitor-all-pmtiles.XXXXXX)
curl --fail --location --output "$download_path" https://v2.map.eqmonitor.app/all.pmtiles
```

Expected: `curl` exits 0 and the temporary file is non-empty.

- [ ] **Step 2: Validate the downloaded PMTiles header and metadata**

Run:

```bash
xxd -l 8 "$download_path"
metadata_offset=$(od -An -tu8 -j24 -N8 "$download_path" | tr -d ' ')
metadata_length=$(od -An -tu8 -j32 -N8 "$download_path" | tr -d ' ')
dd if="$download_path" bs=1 skip="$metadata_offset" count="$metadata_length" status=none \
  | gzip -dc \
  | jq -r '.vector_layers[].id'
```

Expected: the file begins with `PMTiles` plus version byte `03`, and metadata contains `countries`, `areaForecastLocalE`, `areaForecastLocalEew`, and `areaInformationCityQuake`.

- [ ] **Step 3: Replace the tracked platform asset**

Run:

```bash
mv "$download_path" app/assets/platform/earthquake_tsunami_all.pmtiles
```

Expected: `git status --short` reports the PMTiles asset as modified.

### Task 2: Restore the supported local-file source URI

**Files:**
- Modify: `app/lib/feature/map/data/repository/base_map_pmtiles_repository.dart:21-40`

**Interfaces:**
- Consumes: `AssetsUtil.resolveLocalPath({required String fileName})`
- Produces: `Future<String> resolveSourceUri()` returning `pmtiles://file:///...`

- [ ] **Step 1: Remove the unsupported early return**

Delete:

```dart
return 'pmtiles://asset://earthquake_tsunami_all.pmtiles';
```

This makes the existing absolute-path resolution and file validation reachable.

- [ ] **Step 2: Correct URI construction**

Replace the final return with:

```dart
return 'pmtiles://${Uri.file(absolutePath)}';
```

Expected: an absolute path such as `/data/user/0/.../map.pmtiles` becomes `pmtiles://file:///data/user/0/.../map.pmtiles` with no duplicated `file://` segment.

### Task 3: Align canonical documentation with the implementation

**Files:**
- Modify: `docs/map_spec_v3.md`
- Modify: `docs/knowledge/20260717_maplibre_platform_pmtiles_assets.md`
- Verify: `docs/knowledge/20260718_maplibre_pmtiles_file_uri.md`

**Interfaces:**
- Consumes: the supported URI contract from Task 2
- Produces: documentation that consistently requires absolute local file paths

- [ ] **Step 1: Update the map specification**

Document that iOS and Android bundle the former `all.pmtiles` content and resolve it as `pmtiles://file://<absolute-path>` through `AssetsUtil`.

- [ ] **Step 2: Correct the obsolete platform-asset knowledge entry**

Remove the claim that Android can read `pmtiles://asset://` directly. Record that Android copies the packaged asset to `filesDir/map/`, while iOS resolves its bundle path, and both pass an absolute `file://` URI to MapLibre.

- [ ] **Step 3: Check documentation consistency**

Run:

```bash
rg -n "pmtiles://asset://|pmtiles://file://|Uri.file" docs app/lib/feature/map packages/assets_util
```

Expected: `pmtiles://asset://` only appears in historical problem explanations, never as a supported implementation.

### Task 4: Verify, commit, push, and open the PR

**Files:**
- Verify all files modified by Tasks 1-3

**Interfaces:**
- Consumes: completed implementation and documentation
- Produces: a pushed branch and draft PR targeting `develop`

- [ ] **Step 1: Run focused Dart analysis**

Run from `app/`:

```bash
mise exec -- dart analyze \
  lib/feature/map/data/provider/map_style_util.dart \
  lib/feature/map/data/repository/base_map_pmtiles_repository.dart
```

Expected: no issues in the two target files.

- [ ] **Step 2: Revalidate the final asset and packaging references**

Confirm the tracked PMTiles header and exact required layer IDs, then run:

```bash
rg -n "earthquake_tsunami_all.pmtiles|assets/platform" \
  app/android/app/build.gradle.kts \
  app/ios/Runner.xcodeproj/project.pbxproj \
  app/lib/feature/map \
  packages/assets_util
```

Expected: both mobile targets package the same asset and the repository resolves it.

- [ ] **Step 3: Inspect and validate the complete diff**

Run:

```bash
git --no-pager diff --stat
git --no-pager diff -- app/lib docs
git --no-pager diff --check
```

Expected: only the approved basemap recovery files changed and `diff --check` exits 0.

- [ ] **Step 4: Commit the implementation**

Stage only the approved files and commit:

```bash
git add \
  app/assets/platform/earthquake_tsunami_all.pmtiles \
  app/lib/feature/map/data/repository/base_map_pmtiles_repository.dart \
  docs/map_spec_v3.md \
  docs/knowledge/20260717_maplibre_platform_pmtiles_assets.md \
  docs/knowledge/20260718_maplibre_pmtiles_file_uri.md \
  docs/superpowers/plans/2026-07-20-maplibre-basemap-recovery.md
git commit -m "fix: MapLibreベースマップを復旧"
```

- [ ] **Step 5: Push and create a draft PR**

Push `agent/fix-maplibre-basemap`, then create a draft PR targeting `develop`. The PR body must summarize the incompatible archive, unsupported Android asset URI, corrected local file URI, and completed verification.
