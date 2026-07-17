# MapLibre Android ProGuard Protection Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Keep every `org.maplibre.android` class and member in minified Android release builds so jnigen can resolve `Expression$Converter` at runtime.

**Architecture:** Add an app-owned ProGuard file to the release build type instead of changing the pinned MapLibre fork. Verify the built artifact itself with `apkanalyzer`, because a source-level rule assertion cannot prove that R8 retained the class.

**Tech Stack:** Flutter 3.44, Android Gradle Plugin, R8/ProGuard, MapLibre Native Android 13.0.2, jnigen, `apkanalyzer`, POSIX shell

## Global Constraints

- Run Flutter and Dart commands through `mise exec --`.
- Keep release minification and resource shrinking enabled.
- Keep all classes and members below `org.maplibre.android`.
- Do not change the pinned MapLibre fork commit or Dart map implementation.
- Record the Android release/jnigen operational finding in `docs/knowledge/`.

---

### Task 1: Artifact-level regression check

**Files:**
- Create: `tool/verify_maplibre_android_classes.sh`

**Interfaces:**
- Consumes: release APK path as the only positional argument and `apkanalyzer` from `PATH`.
- Produces: exit code 0 only when `org.maplibre.android.style.expressions.Expression$Converter` exists in the APK DEX.

- [ ] **Step 1: Add the artifact verifier before changing R8 configuration**

```sh
#!/bin/sh
set -eu

apk_path=${1:?Usage: verify_maplibre_android_classes.sh <apk-path>}
class_name='org.maplibre.android.style.expressions.Expression$Converter'

if ! command -v apkanalyzer >/dev/null 2>&1; then
  echo 'apkanalyzer is required' >&2
  exit 2
fi

if apkanalyzer dex packages --defined-only "$apk_path" | grep -Fq "$class_name"; then
  echo "Verified $class_name in $apk_path"
  exit 0
fi

echo "Missing $class_name in $apk_path" >&2
exit 1
```

- [ ] **Step 2: Resolve dependencies and create a baseline release APK**

Run from `app/`:

```bash
cp ../environment/.env.example ../environment/.env.prod
mise exec -- flutter pub get --enforce-lockfile
mise exec -- flutter build apk --release --no-pub --dart-define-from-file=../environment/.env.prod
```

Expected: `build/app/outputs/flutter-apk/app-release.apk` is created.

- [ ] **Step 3: Verify the regression check fails for the expected reason**

Run from the repository root:

```bash
tool/verify_maplibre_android_classes.sh app/build/app/outputs/flutter-apk/app-release.apk
```

Expected: exit 1 with `Missing org.maplibre.android.style.expressions.Expression$Converter`.

- [ ] **Step 4: Record the baseline APK size**

```bash
stat -f '%z' app/build/app/outputs/flutter-apk/app-release.apk
```

Expected: one integer byte count, retained for comparison in the PR body.

### Task 2: Release R8 protection

**Files:**
- Create: `app/android/app/proguard-rules.pro`
- Modify: `app/android/app/build.gradle.kts`

**Interfaces:**
- Consumes: Android release build type and R8 rule syntax.
- Produces: release builds that retain all MapLibre Android classes and members while keeping minification enabled.

- [ ] **Step 1: Add the app-owned MapLibre keep rule**

```proguard
# MapLibre classes are resolved by jnigen at runtime, so R8 cannot discover
# every usage from the Android bytecode call graph.
-keep class org.maplibre.android.** { *; }
```

- [ ] **Step 2: Load the rule from the release build type**

Add to `getByName("release")` in `app/android/app/build.gradle.kts`:

```kotlin
proguardFiles(
    getDefaultProguardFile("proguard-android-optimize.txt"),
    "proguard-rules.pro",
)
```

Keep `isMinifyEnabled = true` and `isShrinkResources = true` unchanged.

- [ ] **Step 3: Rebuild the release APK from clean Android outputs**

Run from `app/`:

```bash
rm -rf build/app/outputs/flutter-apk android/app/build/outputs
mise exec -- flutter build apk --release --no-pub --dart-define-from-file=../environment/.env.prod
```

Expected: exit 0 and a new `build/app/outputs/flutter-apk/app-release.apk`.

- [ ] **Step 4: Verify the artifact-level check passes**

```bash
tool/verify_maplibre_android_classes.sh app/build/app/outputs/flutter-apk/app-release.apk
```

Expected: exit 0 with `Verified org.maplibre.android.style.expressions.Expression$Converter`.

- [ ] **Step 5: Record and compare the protected APK size**

```bash
stat -f '%z' app/build/app/outputs/flutter-apk/app-release.apk
```

Expected: one integer byte count; calculate its byte and percentage difference from Task 1.

### Task 3: Knowledge record and repository checks

**Files:**
- Create: `docs/knowledge/20260716_maplibre_android_jnigen_proguard.md`

**Interfaces:**
- Consumes: confirmed root cause, keep rule, build command, and artifact check.
- Produces: a durable operational reference for future MapLibre/jnigen upgrades.

- [ ] **Step 1: Document the failure mode and exact verification commands**

The document must state:

```markdown
- Symptom: release-only `ClassNotFoundException` for a MapLibre class.
- Cause: jnigen string/JNI references are invisible to R8 reachability analysis.
- Rule: `-keep class org.maplibre.android.** { *; }`.
- Verification: build a release APK and run `tool/verify_maplibre_android_classes.sh` against it.
```

- [ ] **Step 2: Run formatting/static checks relevant to the changed files**

```bash
git --no-pager diff --check origin/develop...HEAD
mise exec -- flutter analyze app
```

Expected: both commands exit 0.

- [ ] **Step 3: Commit the focused implementation**

```bash
git add tool/verify_maplibre_android_classes.sh app/android/app/proguard-rules.pro app/android/app/build.gradle.kts docs/knowledge/20260716_maplibre_android_jnigen_proguard.md
git commit -m "fix: MapLibreのAndroidクラスをR8削除から保護"
```

- [ ] **Step 4: Re-run final evidence after the commit**

```bash
tool/verify_maplibre_android_classes.sh app/build/app/outputs/flutter-apk/app-release.apk
git --no-pager diff --check origin/develop...HEAD
git status --short --branch
```

Expected: verifier and diff check exit 0; worktree is clean and ahead of `origin/develop`.
