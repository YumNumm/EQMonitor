# Earthquake History Map Layer Parameter Update Fix

## Goal

Fix map layers on earthquake history detail page flickering/disappearing when debug parameters change. **No debounce** on debug modal saves.

## Root Cause

`parameter` is in the same `useEffect` deps as layer initialization. Each slider change triggers full remove → add. Four layer widgets each have independent `useMapOperationQueue`, causing parallel style mutations.

## Global Constraints

- Follow `HomeMapLabelLayer` pattern: init effect (unmount cleanup only) + update effect (no cleanup on param change)
- Single shared `MapOperationScheduler` from `_MapContent` for all detail map layers (one queue per map)
- Pass `enqueue` as required constructor param to layer widgets; layers must NOT call `useMapOperationQueue()` internally
- No debounce in debug modal or notifier
- Flutter rules: no private methods in widgets, use existing patterns
- Run tests with `mise exec --` for Flutter/Dart commands
- Fix `regionToCity` default: source `@Default(0)` must match generated code (run build_runner if needed)

## Task 1: Shared queue + map view wiring

**Files:**
- `app/lib/feature/earthquake_history/ui/components/earthquake_history_map_operation_scope.dart` (new, optional — or pass via constructor only)
- `app/lib/feature/earthquake_history/ui/components/earthquake_history_details_map_view.dart`

**Work:**
- In `_MapContent`, call `useMapOperationQueue()` once
- Pass `enqueue` to all layer children: Fill, Station, HypocenterError, Hypocenter
- Add `required MapOperationScheduler enqueue` to each layer widget signature (prepare for Task 2–4; layers may still use internal queue until Task 2–4 land — prefer completing signature in Task 1)

## Task 2: EarthquakeHistoryFillLayer init/update split

**Files:**
- `app/lib/feature/earthquake_history/ui/layer/earthquake_history_fill_layer.dart`

**Work:**
- Add `required MapOperationScheduler enqueue`
- Remove internal `useMapOperationQueue()`
- `useRef<List<String>>` for `addedLayerIds`
- Init `useEffect` deps: `[styleController, intensity, colorModel, mode, showingLpgmIntensity, fillLayerBuilder]` — NOT `parameter`
- Update `useEffect` deps: `[styleController, parameter, intensity, colorModel, mode, showingLpgmIntensity, fillLayerBuilder]` with `isInitialized` guard
- Update: enqueue remove all `addedLayerIds`, rebuild, add layers, refresh ref
- Fix hooks order: call all hooks before any early return

## Task 3: Station + Hypocenter + HypocenterError layers

**Files:**
- `earthquake_history_station_intensity_layer.dart`
- `earthquake_history_hypocenter_layer.dart`
- `earthquake_history_hypocenter_error_layer.dart`

**Work:**
- Same init/update split pattern as Task 2
- Station: track `iconLayerAdded` in ref for reliable cleanup on unmount only
- Init deps exclude `parameter`; update deps include `parameter`
- Use passed `enqueue`

## Task 4: Tests + regionToCity default

**Files:**
- Existing fill layer builder tests (ensure still pass)
- `earthquake_history_map_layer_parameter.dart` — verify `@Default(0)` for `regionToCity`
- Run `melos run generate` if freezed out of sync

**Work:**
- Add widget-level or unit test for update path if feasible (at minimum run existing tests)
- `mise exec -- melos run test:flutter` filtered to earthquake_history if possible

## Task 5: Knowledge doc (if warranted)

Only if new operational pattern is worth documenting.
