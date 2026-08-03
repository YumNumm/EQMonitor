# EEW Card / Live Activity Alignment Implementation Plan

> **For agentic workers:** Implement task-by-task. Steps use checkbox syntax.

**Goal:** Align `eew_card` and iOS Live Activity EEW display for final report, arrival, assumed hypocenter, cancel, and depth.

**Architecture:** Shared semantics via getters on `EewTelegramItem`; Live Activity UI fixes in Swift Widget; debug samples for each case.

**Tech Stack:** Flutter/Dart, SwiftUI WidgetKit Live Activities

**Spec:** `docs/superpowers/specs/2026-08-01-eew-card-live-activity-alignment-design.md`

## Tasks

- [ ] Task 1: Add `isLevelMethod` / `isOnePointDetection` getters on `EewTelegramItem`
- [ ] Task 2: Update `eew_card.dart` (cancel, assumed hypocenter, depth, null M/depth hide, arrived label)
- [ ] Task 3: Update Live Activity Swift (final label, arrived, Expanded Bottom, depth, PLUM timeLabel)
- [ ] Task 4: Expand debug EEW card samples + accuracy controls
- [ ] Task 5: Knowledge doc
