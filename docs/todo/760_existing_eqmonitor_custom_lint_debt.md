# eqmonitor の既存 custom lint debt を解消する

## 背景

Flutter master toolchain移行時のroot full scanで、24 packages中23 packagesは成功したが、
`eqmonitor`だけが1,381 diagnosticsで失敗した。主な内訳は既存custom pluginの
`avoid_null_assertion`、top-level function、declaration ordering、UI API import制約で、
Task 1の変更ファイルに限定されないapp全体のdebtである。

同じsource treeをrepositoryのstable Flutter baselineで解析しても同じ1,381件が
再現したため、固定Flutter masterへの移行が原因ではない。

## 再現コマンド

```bash
mise exec -- dart pub get --enforce-lockfile
mise exec -- dart run melos run analyze
```

2026-08-02の固定master実測:

- 23 packages: success
- `eqmonitor`: 1,381 issues

## CI への影響

この debt により `PR Flutter Check / flutter-analyze` が blocking で落ち続けている。
2026-08-03 以降、`flutter-analyze` が実行されたすべての run が failure。

2026-08-07 時点の内訳（`app` 配下、warning 1,414件 / error 0件）:

- `app/lib/`: 648件
- `app/test/`: 765件

`app/test/` 側が過半を占めるが、todo の方針どおり一括 ignore や
非blocking化ではなく rule別・directory別に解消すること。

## 実施内容

- rule別・directory別に件数を固定し、小さい単位で既存違反を解消する
- generated codeとhand-written codeの適用範囲を明文化する
- 既存`Report analyze` actionのblocking contractを弱めずに進める
- 新規`eqmonitor_map`はdebtを継承せず、専用CIでstrict analyzeをblockingにする

root full scanを一時的にnonblocking化する変更や、app全体への一括ignoreは行わない。
