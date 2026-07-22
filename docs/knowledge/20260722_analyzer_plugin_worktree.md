# Analyzer plugin path in Git worktrees

## Symptom

Running `mise exec -- dart analyze` can stop before source diagnostics with an
analyzer-plugin setup error for `app/tools/eqmonitor_custom_lints`.

## Cause

`app/analysis_options.yaml` references the custom-lint plugin through that
project-relative path. The path is absent in this worktree, so the analyzer
cannot resolve the plugin package.

## Recovery

Restore the expected plugin directory or update the analyzer configuration to
the valid checked-out plugin path, then rerun the intended `dart analyze`
command. Do not treat this setup failure as a source-level analysis result.
