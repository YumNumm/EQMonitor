#!/bin/sh
# PreToolUse(Bash) guard: refuse `gh` PR/Issue creation that does not explicitly
# target a YumNumm repository.
#
# Why a script and not an inline regex: the first version matched the literal
# token sequence `gh pr create`, which missed `gh pr --repo X create` (gh accepts
# flags before the subcommand), the `new` aliases, and compound commands where
# one allowed `--repo` satisfied the check for a second, disallowed invocation.
#
# So: split the command line on separators and check each invocation on its own.
# Over-splitting is safe here (every fragment is checked); under-splitting is
# what lets a disallowed invocation through. Ambiguous input denies.

cmd=$(jq -r '.tool_input.command')

# The trailing newline matters: without it `read` fails on the final fragment
# and a single-command line is never checked at all.
printf '%s\n' "$cmd" | tr ';|&\n' '\n\n\n\n' | while IFS= read -r seg; do
  # The fragment must *begin* with gh: that is what an invocation looks like.
  # Matching gh anywhere instead flags prose that merely mentions these
  # commands — a --body containing a markdown table of examples, say — which
  # then splits on its own pipes into fragments that look like invocations.
  printf '%s' "$seg" | grep -Eq '^[[:space:]]*gh([[:space:]]|$)' || continue
  printf '%s' "$seg" | grep -Eq '(^|[[:space:]])(pr|issue)([[:space:]]|$)' || continue
  printf '%s' "$seg" | grep -Eq '(^|[[:space:]])(create|new)([[:space:]]|$)' || continue
  # `--repo YumNumm/x`, `--repo=YumNumm/x` and `-R YumNumm/x` all count.
  printf '%s' "$seg" | grep -Eq '(--repo|-R)[[:space:]=]+YumNumm/' && continue

  printf '%s' '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"PR/Issue の作成先は YumNumm org のみです。この Bash 呼び出しの中に、--repo YumNumm/<repo> を明示していない gh の作成コマンドがあります。各コマンドごとに明示してください。third_party/flutter_scene のような fork 配下では gh が upstream(bdero/flutter_scene 等)を既定にするため、省略すると upstream へ送られます。"}}'
  break
done

exit 0
