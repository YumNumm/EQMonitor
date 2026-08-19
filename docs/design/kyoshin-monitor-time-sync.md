# 強震モニタ / 長周期地震動モニタ 時刻同期の再設計

## 背景

長周期地震動モニタ（lmoni）の表示時刻がずれる、という報告を起点に、強震モニタ系の
時刻同期経路全体を調査した。結果として **lmoni 固有の問題ではなく、時刻同期の実装
精度そのものに複数の欠陥がある**ことが判明した。

調査は以下の実測に基づく（2026-08-19 実施）。

- 公式フロントエンド `https://www.lmoni.bosai.go.jp/monitor/` の JS バンドル
  (`static/prism_longterm/js/prism_longperiod.js`) の読解
- KyoshinEewViewer for ingen (以下 KEVi) のソース読解
  - `src/KyoshinEewViewer/Services/TimerService.cs`
  - `src/KyoshinEewViewer/Series/KyoshinMonitor/Services/KyoshinMonitorWatchService.cs`
  - `src/KyoshinEewViewer.Core/Models/KyoshinEewViewerConfiguration.cs`
- 各エンドポイントへの HTTP 実測（100ms 刻みポーリングによる公開遅延の定量化）

---

## 現状の問題点

### 問題1: NTP が一度も同期していない

`app/lib/core/provider/ntp/ntp_provider.dart`

```dart
@override
Future<NtpState> build() async {
  final config = await ref.watch(ntpConfigProvider.future);
  final interval = config.interval;                    // 既定 30分

  final timer = Timer.periodic(interval, (_) async {
    await sync();
  });
  ref.onDispose(timer.cancel);

  return const NtpState();                              // ← 初回 sync を呼んでいない
}
```

`build()` は周期タイマーを張るだけで初回 `sync()` を呼ばない。リポジトリ全体を検索しても
`Ntp.sync()` の呼び出し元は存在しない。

結果として **アプリ起動後 30 分間は `NtpState.offset` が `null`**、
`AppClock.now()` は `clock.now()`（端末時計）にフォールバックし続ける。

これは強震モニタだけでなく、**P/S 波到達予想円・揺れ検知を含む `AppClock` 利用箇所すべて**に
影響する。

### 問題2: 端末時計誤差の二重適用

遅延の測定は端末時計基準:

```dart
// kyoshin_monitor_timer_notifier.dart:110-117
Future<Result<Duration, Exception>> _syncDelaySimple() async =>
    Result.capture(() async {
      final latestJson = await ref
          .read(kyoshinMonitorWebApiDataSourceProvider)
          .getLatestDataTime();
      final deviceTime = DateTime.now();               // ← 端末時計
      return deviceTime.difference(latestJson.latestTime);
    });
```

適用は NTP 補正済み時刻に対して:

```dart
// kyoshin_monitor_timer_stream.dart:230
streamController.add(clock.now().subtract(delay));     // ← AppClock = NTP補正済み
```

端末時計が +30 秒進んでいる場合:

| 変数 | 値 |
|---|---|
| `deviceNow` | `trueNow + 30s` |
| `ntpOffset` | `-30s` |
| `clock.now()` | `trueNow` |
| `delayFromDevice` | `(trueNow + 30s) - (trueNow - 1s)` = `31s` |
| `targetTime` | `trueNow - 31s` |
| **正しい値** | **`trueNow - 1s`** |

端末時計の誤差が二重に効き、**30 秒古い画像を取得する**。

現状は問題1により `ntpOffset` が常に `null` なので偶然打ち消されている。
**問題1を修正した瞬間にこのバグが顕在化する**ため、両者は同時に直す必要がある。

### 問題3: 遅延測定に RTT 補正・外れ値除去がない

`_syncDelaySimple` は

- `deviceTime` を**往復完了後**に取得しているため、**RTT がまるごと遅延に加算される**
- **単一サンプル**しか取らないため、一度の悪い RTT が次の再同期（既定 10 分後）まで残り続ける
- `latest_time` は 1 秒粒度なので、最大 1 秒の量子化誤差が乗る

公式フロントは後述のとおり RTT/2 補正と 5 件のトリム平均を実装しており、この点で
現状実装は明確に劣っている。

### 問題4: タイムゾーンが「偶然の相殺」で成立している

`packages/kyoshin_monitor_api/lib/src/util/json_converters.dart`

```dart
DateTime dateTimeFromString(String value) =>
    DateTime.parse(value.replaceAll('/', '-'));
```

`latest.json` の `"2026/08/19 00:17:30"` は JST だが、タイムゾーン指定がないため
`DateTime.parse` は**端末ローカル時刻**として解釈する。

一方 URL 生成側も端末ローカル:

```dart
// kyoshin_monitor_web_api_data_source.dart
static DateFormat get dateTimeFormat => DateFormat('yyyyMMddHHmmss');
// → .format(dateTime) は DateTime のローカルフィールドを読む
```

非 JST 端末では「parse 時の誤差」と「format 時の誤差」が打ち消し合い、結果的に正しい
JST 文字列になる。

**この相殺は `targetTime` を `latest_time` から導出している限りしか成立しない。**
NTP の絶対時刻から `targetTime` を作ると相殺が消え、非 JST 端末が全滅する。
したがって **JST 固定化は本設計の前提作業**であり、時刻ソースの変更と不可分。

（なお公式フロントも同じ構造で、`latest_time` は `+09:00` を付けて正しく絶対時刻化する
一方、URL 生成は date-fns のローカル系ゲッタ `getFullYear`/`getHours` を使っている。）

### 問題5: lmoni の公開遅延の速さを活かせていない

後述の実測どおり lmoni は kmoni より **0.66 秒早く**画像を公開している。
にもかかわらず現状は kmoni の `latest_time` 基準（+ RTT + 1 秒量子化）で取得しているため、
**理論上 0.66 秒以上ムダに古い画像を表示している**。

---

## 実測結果

### 公開遅延（対象秒 T の画像が最初に 200 を返す時刻 − T、100ms 刻みポーリング、8 サンプル）

| 対象 | min | max | mean |
|---|---|---|---|
| lmoni `abrspmx_s` | 0.56 s | 0.58 s | **0.57 s** |
| kmoni `jma_s` | 1.21 s | 1.24 s | **1.23 s** |

ブレは ±0.02 秒と極めて安定。**lmoni は kmoni より約 0.66 秒早い。**

長周期系列間（`abrspmx`, `abrsp1s`, `abrsp2s`, `abrsp5s`, `abrsp7s`）の差は無し
（すべて 0.6〜0.7 s）。同一バッチで一斉生成されていると見られる。

実用上の含意:

- lmoni `abrspmx_s`: `now-0s` は「秒に入って 0.57s 以降」でしか通らない。`now-1s` なら常に安全。
- kmoni `jma_s`: `now-1s` は「秒に入って 0.23s 以降」でないと 404。`now-2s` が安全。

### 未公開時刻に対するレスポンス

```
status=404  content-type=text/html  size=146
```

**両サーバとも本物の 404 を返す**ため、404 をフィードバックとして使うオフセット自動調整は
実装可能。

### latest.json エンドポイント

| URL | 結果 |
|---|---|
| `http://www.kmoni.bosai.go.jp/webservice/server/pros/latest.json` | 200 |
| `https://smi.lmoniexp.bosai.go.jp/webservice/server/pros/latest.json` | 200 |
| `https://www.lmoni.bosai.go.jp/monitor/webservice/server/pros/latest.json` | **500** |
| `https://www.lmoni.bosai.go.jp/img_svr/webservice/server/pros/latest.json` | **200** |

**lmoni にも latest.json は存在する。パスが `/monitor/` 配下ではなく `/img_svr/` 配下。**

さらに `/img_svr/` は **lmoni ホスト上の kmoni へのリバースプロキシ**である。根拠:

- 返る JSON の `security.realm` (`/webservice/server/pros/latest/`) と
  `hash` (`4660cc50…`) が kmoni 側と完全一致
- `https://www.lmoni.bosai.go.jp/img_svr/data/map_img/RealTimeImg/jma_s/…/….jma_s.gif` と
  kmoni の同名画像が 6174 B で完全一致

つまり **lmoni 専用のサーバ時刻は存在せず、公式フロント自身も kmoni の `latest_time` を
使っている**。現状アプリが kmoni の latest.json で lmoni 画像を取得しているのは、方式として
公式と同じであり誤りではなかった。

`latest_time` の画像可用性（15 サンプル）:

| endpoint | `request_time − latest_time` | `latest_time` の画像が 200 |
|---|---|---|
| lmoni `/img_svr/…/latest.json` | 1〜2 s | 15/15 |
| kmoni `/webservice/…/latest.json` | 1〜2 s | 14/15（1 件はタイムアウト、404 ではない） |

lmoni の実測遅延 0.57 s に対し `latest_time` は約 1 s 遅れなので、常に安全側。

---

## 参照実装

### 公式フロント lmoni (`Ut.f[36]` TimeCorrector)

```js
// 同期
o = getTime(serverTime) - (sendMs + recvMs) / 2      // shift: RTT の中点で評価
this.pushRoundTripTime(recvMs - sendMs)
this.pushShiftTime(o)

// 予測
predictServerTime(t) = addMilliseconds(subMilliseconds(t, rtt / 2), shift)
```

- RTT / shift を **直近 5 件保持、最小・最大を捨てたトリム平均**
  （`orderBy().skip(1).takeExceptLast(1).average()`、3 件以上で有効）
- 再同期間隔 **最初の 5 回は 1 秒、以降 60 秒**
  （`Enumerable.repeat(1, 5).concat(Enumerable.repeat(60)).share()`）
- ハートビート **1000 ms**（`hb.start(1e3)`）
- **固定オフセットは無し**（バンドル内に `Asia/Tokyo` / `32400` / `540` は 0 件）
- **404 は透明 1x1 GIF に差し替えるだけ。リトライもオフセット調整も無し**

### KEVi

NTP (`TimerService.cs`):

- 既定サーバ **`time.google.com`**、timeout 1000 ms、**最大 10 回リトライ**
- 片道遅延補正
  `serverSendTime + ((recv − send) − (srvSend − srvRecv)) / 2`
- HTTP フォールバック（`https://svs.ingen084.net/time/` + RTT/2）
- 無効時は `DateTime.UtcNow.AddHours(9)`（端末時計を JST として使用）
- 再同期 **初回 5 分後、以降 10 分間隔**
- **秒境界同期タイマー**（`SecondBasedTimer`、精度 100 ms）。ティック間は
  `LastElapsedTime + (DateTime.Now - LastElapsedLocalTime)` で補間

オフセット自動調整 (`KyoshinMonitorWatchService.cs`, `TimerConfig`):

- 既定 `Timer.Offset = 1100` ms、`AutoOffsetIncrement = true`
- 非 200（404）→ `Offset = Math.Min(5000, Offset + 100)` してそのティックは捨てる
- 成功 && `time.Second == 0` && `Offset > 1100` → `Offset -= 100`（毎分 1 回だけ短縮を試す）
- 整数秒部を URL 時刻に、端数（`offset % 1s`）は発火位相の遅延に使う
  （例: `Offset=1100ms` → URL 時刻 = `t - 1s`、発火は秒境界 + 100ms）
- kmoni / lmoni はモードで URL だけ切り替え、**オフセットは共通**で 404 により自動再収束
- `latest.json` は一切使わない

---

## 設計

### 全体像: 3 段階でオフセット精度を上げる

| 段階 | 時刻ソース | オフセット | 発動条件 |
|---|---|---|---|
| **Stage 1** | 端末時計 | `latest.json` 実測（RTT/2 補正 + トリム平均） | 起動直後 |
| **Stage 2** | NTP 補正時刻 | NTP offset を考慮して再計算 | NTP 同期成功後 |
| **Stage 3** | NTP 補正時刻 | 投機的先読みで前方に詰める（KEVi 方式） | Stage 2 到達後、継続的 |

Stage 1 は公式フロントと同じ方式で「すぐ動く」ことを保証し、Stage 2 で端末時計依存を
排除し、Stage 3 で lmoni の 0.57 s / kmoni の 1.23 s という実際の公開遅延まで詰める。

### `AppClock` の役割は変更しない

`AppClock` は名前どおり **「NTP 補正済みの正確な現在時刻（＋再生モード）」** を提供する
責務のままとする。強震モニタの公開遅延は `AppClock` の**外側**で引く（現状どおり）。

```dart
// 現状の役割分担（維持する）
AppClock.now()                          // NTP補正済みの正確な現在時刻
clock.now().subtract(kmoniDelay)        // 強震モニタ画像の対象時刻（timer_stream 内でのみ）
```

### Stage 1: latest.json による遅延測定の精度改善

`KyoshinMonitorTimerNotifier._syncDelaySimple` を以下に置き換える。

```
sendMs   = 送信直前の端末時計
serverMs = latest_time（JST として絶対時刻化）
recvMs   = 受信直後の端末時計

rtt   = recvMs - sendMs
shift = serverMs - (sendMs + recvMs) / 2
```

- `rtt` / `shift` を **直近 5 件保持し、最小・最大を除いたトリム平均**（3 件以上で有効）
- 再同期間隔は **最初の 5 回を 1 秒、以降は設定値**（公式フロント準拠）。
  現状の「初回成功まで 5 秒間隔でリトライ」も維持
- **叩く latest.json は画像と同じホストのものにする**
  - `KyoshinMonitorSource.kmoni` → 現行の `api.endpoint`（kmoni / lmoniexp）
  - `KyoshinMonitorSource.lmoni` → `https://www.lmoni.bosai.go.jp/img_svr/webservice/server/pros/latest.json`

  中身は同一だが、画像と同一ホスト・同一経路で測ることで RTT 推定が実態に近くなる。

### Stage 2: NTP offset を考慮したオフセット再計算

問題2（二重適用）の解消。`targetTime` の導出を一箇所に集約する。

```
ntpOffset       = Ntp.offset   （端末時計 → 真の時刻）
deviceToServer  = shift        （端末時計 → サーバ latest_time、Stage 1 で測定）

# NTP 未取得時（Stage 1）
targetTime = deviceNow + shift - rtt/2

# NTP 取得後（Stage 2）
publishDelay = -(shift - ntpOffset)        # サーバの公開遅延そのもの（端末時計依存が消える）
targetTime   = (deviceNow + ntpOffset) - publishDelay
             = AppClock.now() - publishDelay
```

要点は **`AppClock.now()` から引くのは「サーバの公開遅延」だけ**であり、端末時計の誤差を
含む生の `deviceTime - latestTime` を引かないこと。`publishDelay` は端末時計の誤差が
`shift` と `ntpOffset` で相殺されるため、端末時計が狂っていても正しい値になる。

実測ではこの `publishDelay` は lmoni ≈ 0.57〜1.0 s、kmoni ≈ 1.23〜2.0 s になる見込み。

### Stage 3: 投機的先読みによるオフセットの前方詰め（KEVi 方式）

Stage 2 のオフセットは `latest_time` の 1 秒量子化ぶん保守的なので、KEVi と同じ 404
フィードバックで詰める。

```
404（画像未公開） → offset = min(maxOffset, offset + 100ms)、そのティックは破棄
成功 && targetTime.second == 0 && offset > minOffset → offset -= 100ms
```

- `minOffset` / `maxOffset` は設定値（KEVi は 1100ms / 5000ms）。
  lmoni は実測 0.57 s なので `minOffset` は 600ms 程度まで下げられる余地がある
- 404 が返ったティックはエラー状態にせず、直前の表示を維持する（後述）

### オフセットの保持粒度と永続化

**画像の生成パイプライン別（`kmoni` / `lpgm`）に分けて永続化する。**

ここは「ホスト別」ではないことが重要。`latest.json` はどちらのホストから取っても
強震モニタのパイプラインの時刻を返す（長周期地震動モニタの `/img_svr/` は
強震モニタへのリバースプロキシ）ため、そこから求まる `publishDelay` は常に
強震モニタ基準になる。0.66 秒の差を吸収しているのは 404 フィードバックの
学習分だけなので、学習値はパイプラインで分けなければならない。

そして UI は長周期地震動モニタを選んでいるときに LPGM 系列だけでなく
**震度などの非 LPGM 系列も選べる**。非 LPGM 系列は `/img_svr/` 経由で
強震モニタのパイプラインから配信されるため、ホストで分けると

| 設定 | 実際のパイプライン | ホスト別のキー |
|---|---|---|
| lmoni + `abrsp2s` | LPGM (0.57s) | `lmoni` |
| lmoni + `shindo` | 強震モニタ (1.23s) | `lmoni`（衝突） |

のように 0.66 秒違う 2 つのパイプラインが 1 つの学習値を取り合ってしまう。
症状は「LPGM → 震度に切り替えた直後に数秒間 404 で空白コマ」「震度 → LPGM に
戻すと毎分 100ms しか詰まらないため約 6 分間ムダに古い画像を表示」。

したがって

- 学習キー: `KyoshinMonitorDelayProfile { kmoni, lpgm }`
  （`realtimeDataType.isLpgm` で決まる = `KyoshinMonitorSettingsModelX.delayProfile`）
- `latest.json` の取得先ホスト: `KyoshinMonitorSettingsModelX.effectiveMonitorSource`
  （LPGM 系列なら `monitorSource` に関わらず lmoni）
- 画像取得の分岐も `effectiveMonitorSource` に一本化し、
  「取得ホスト」と「学習キー」が構造的にずれないようにする
- 長周期系列間（`abrspmx` / `abrsp1s`〜`abrsp7s`）には有意差が無かったため
  （実測いずれも 0.6〜0.7s）、系列別に分ける必要はない
- SharedPreferences に保存し、次回起動時は Stage 3 到達済みの値から始める

`KyoshinMonitorSettingsApiModel` への追加案:

```dart
/// 遅延調整の方式
@Default(KyoshinMonitorDelayAdjustType.imageFetch404Ntp)
KyoshinMonitorDelayAdjustType delayAdjustType,

/// データソース別の調整済みオフセット
@Default({}) Map<KyoshinMonitorSource, Duration> offsets,

/// 404 によるオフセット自動調整を行うか
@Default(true) bool autoOffsetIncrement,

/// オフセットの下限 / 上限
@Default(Duration(milliseconds: 600)) Duration minOffset,
@Default(Duration(milliseconds: 5000)) Duration maxOffset,
```

既にスタブとして存在する
`app/lib/feature/kyoshin_monitor/data/service/kyoshin_monitor_delay_adjust_service.dart`
の `KyoshinMonitorDelayAdjustType` をそのまま活用する（`imageFetch404Ntp` が本設計に対応）。

### 秒境界同期タイマー

KEVi の `SecondBasedTimer` 相当を導入する。現状の `periodicTimer(1s)` は
`Timer.periodic` を張った瞬間の位相に固定されるため、発火タイミングが起動タイミング依存で
ランダムに残り、100 ms 刻みのオフセット調整が実質 1 秒粒度に丸められてしまう。

- NTP 補正済み JST の**秒境界**に同期して発火（精度 100 ms 程度）
- オフセットの整数秒部を URL 時刻に、端数を発火位相の遅延に使う（KEVi 準拠）
- ティック間の現在時刻は「最終ティック時刻 + 単調経過時間」で補間する

### JST 固定化（前提作業・不可分）

Stage 2 以降は `targetTime` を絶対時刻から導出するため、問題4 の偶然の相殺が消える。
以下を**同時に**修正する。

1. `KyoshinMonitorWebApiDataSource` / `LpgmKyoshinMonitorWebApiDataSource` の
   `dateFormat` / `dateTimeFormat` を、**JST に変換してから** format する
   （`dateTime.toUtc().add(const Duration(hours: 9))`）
2. `dateTimeFromString` を JST 前提のパースに直す
   （`+09:00` を付与してから `DateTime.parse`）

片方だけ直すと非 JST 端末が壊れるため、必ずセットで行う。
既に `debug_live_activity_content_builder.dart:341` に `_iso8601Jst` という同種の実装が
あるので、共通ユーティリティに切り出して両方から使う。

### 404 時のふるまい

現状 `KyoshinMonitorNotifier._fetchAndAnalyzeImage` は `AsyncValue.guard` で包んでいるため、
404 が `AsyncError` になり画面がエラー表示に落ちる。

- `DioException` の `statusCode == 404` を捕捉し、**エラー状態にせず直前の表示を維持**する
- 同時に delay adjust service に通知してオフセットを +100 ms する
- 成功時は `onFetchSucceeded(targetTime)` を通知（毎分の短縮判定用）

公式フロントが「404 なら透明 GIF に差し替えて次の秒へ」という挙動なのと同じ方向性。

### NTP 同期の堅牢化

1. **`Ntp.build()` で初回同期を実行する**（問題1）。失敗しても `offset = null` のまま
   継続し、指数バックオフで再試行する
2. **リトライ**: KEVi は最大 10 回。1 回の失敗で 10 分待つ現状より大幅に改善する
3. **複数サーバへのフォールバック**: `ntp.nict.jp` を主、失敗時に `time.google.com` などへ。
   モバイル網では UDP:123 が閉じられている場合があるため実効性が高い
4. **再同期間隔**を 30 分 → 10 分（KEVi 準拠）

`ntp` パッケージ (2.0.0) の `NTP.getNtpOffset` は KEVi と同等の標準 NTP offset 計算
（RTT 補正込み）を実装済みなので、自前 SNTP クライアントは不要。

```dart
// ntp-2.0.0/lib/ntp/ntp.dart:90-93
final double localClockOffset =
    ((ntpMessage._receiveTimestamp - ntpMessage._originateTimestamp) +
            (ntpMessage._transmitTimestamp - destinationTimestamp)) / 2;
```

ただしリトライ・サーバフォールバック・トリム平均は持たないため、呼び出し側で実装する。

---

## P/S 波到達予想円

### 現状は既に正しく配線されている

```dart
// app/lib/feature/home/ui/component/map/layer/eew_ps_wave_layer.dart:233,296-297
final now = ref.read(appClockProvider.notifier).now();
...
final elapsed = now.difference(originTime).inMilliseconds / 1000;
final travelTime = travelTimeMap.getTravelTime(depth, elapsed);
```

リアルタイムの P/S 波円は **既に `AppClock` を参照している**。つまり強震モニタの公開遅延は
引かれておらず、「正確な現在時刻」基準で描かれる設計になっている。

**したがって追加の配線は不要。** 現在ずれているのは問題1（初回 NTP 同期が無いため
`AppClock` が端末時計にフォールバックしている）が原因であり、**問題1 を直すだけで
P/S 波円も同時に直る。**

対象外のレイヤ:

| ファイル | 時刻基準 | 対応 |
|---|---|---|
| `eew_static_ps_wave_layer.dart` | 電文発表時刻（静的） | 変更不要 |
| `eew_simulation_ps_wave_layer.dart` | シミュレーション再生位置 | 変更不要 |

### 追加する設定

「強震モニタの遅延に合わせるか」を選択できるようにする（加算的なオプション）。

| 設定 | 時刻基準 | 見え方 |
|---|---|---|
| **正確な現在時刻**（既定） | `AppClock.now()` | 円は実時間どおり。画像より 0.6〜1.2 秒進んで見える |
| 強震モニタに合わせる | 強震モニタの `targetTime` | 円と観測点画像が完全に同期。円は公開遅延ぶん過去にずれる |

既定は「正確な現在時刻」とする。P/S 波円は本来「今どこまで波が来ているか」を示すものであり、
画像との見た目の一致より実時間の正確さを優先すべきため。

---

## 実装順序

1. **NTP 初回同期 + リトライ + サーバフォールバック**（問題1）
   - これ単体で強震モニタ・P/S 波円・揺れ検知すべてに効く独立したバグ修正
   - 問題2 を同時に直さないと端末時計が狂った端末で悪化するため、2 とセットで出す
2. **JST 固定化**（問題4）— 3 の前提
3. **`targetTime` 導出の集約と Stage 2 化**（問題2、問題3）
4. **`KyoshinMonitorDelayAdjustService` 実装 + データソース別オフセット永続化**（Stage 3）
5. **秒境界同期タイマー**
6. **404 のフィードバック配線**
7. **P/S 波円の設定追加**
8. **デバッグ画面の拡充** — `debug_kyoshin_monitor.dart` に
   現在オフセット / NTP offset / 最終同期時刻 / RTT / 404 カウントを表示

## テスト方針

- delay adjust service の純ロジック（+100 / −100、上限・下限クランプ、`second == 0` 条件）
- トリム平均（5 件保持、最小・最大除去、3 件未満のときのふるまい）
- `publishDelay` の算出が端末時計の誤差に依存しないこと（問題2 の回帰テスト）
- JST フォーマッタ: テスト時のタイムゾーンを UTC にしても URL 文字列が JST になること
- 既存の `isImageDelayed` テスト（`app/test/feature/kyoshin_monitor/kyoshin_monitor_delay_test.dart`）は
  しきい値の意味が変わるため見直す

## 実装結果と設計からの変更点

実装時に判明したこと・設計を上回った点を記録する。

### lmoni にも `latest.json` があった

設計時点では「lmoni に `latest.json` は存在しない」としていたが、公式フロントエンドの
JS を読んだところ `/img_svr/webservice/server/pros/latest.json` に存在した
(`/monitor/` 配下は 500)。`/img_svr/` は lmoni ホスト上の強震モニタへの
リバースプロキシで、内容は強震モニタのものと同一。

そのため「lmoni では遅延を測れない」という前提は誤りで、**画像と同じホストの
`latest.json` を叩く**方式にした (`LpgmKyoshinMonitorWebApiClient.getLatestDataTime`)。
内容は同じでも、画像と同一ホスト・同一経路で測ることで往復時間の推定が実態に近くなる。

### 学習キーはホストではなくパイプライン

当初はデータソース（ホスト）別に補正量を持つ設計だったが、長周期地震動モニタを
選んだままデータ種別を LPGM ⇄ 非 LPGM で切り替えると、公開遅延が 0.66 秒違う
2 つのパイプラインが 1 つの学習値を共有してしまう（上記「オフセットの保持粒度と
永続化」参照）。`KyoshinMonitorDelayProfile` を導入してパイプラインで分けた。

### 補正量は「絶対値」ではなく「実測値からの差分」で保持する

設計では Stage 3 のオフセットを絶対値として持つ想定だったが、それだと
`latest.json` の再同期が端末時計のドリフトやサーバ側の遅延変動を追従できなくなる。

実装では `effectiveOffset = clamp(publishDelay + adjustment, min, max)` とし、
404 フィードバックは `adjustment` (差分) のみを動かす。これにより

- `publishDelay` はサーバ/端末時計の変化を追い続ける
- `adjustment` は学習した「詰めぶん」として維持される

の両立ができる。

### `publishDelay` は保存せず、参照時に毎回導出する

`KyoshinMonitorTimerState` には `shift` (端末時計から見たずれ) と `roundTripTime` を
保存し、`publishDelay` は参照時に現在の NTP オフセットから導出する
(`KyoshinMonitorTimerStateX.publishDelay`)。

同期時点と参照時点で NTP の有無が変わっても、必ず「引く対象の時計」と補正の有無が
揃うようにするため。問題2 の再発防止として重要。

### 各種既定値

| 項目 | 変更前 | 変更後 | 根拠 |
|---|---|---|---|
| NTP タイムアウト | 10 s | 3 s | 全サーバ試行の最悪時間を 18 秒に抑える |
| NTP 1サーバあたり試行回数 | (リトライなし) | 2 | |
| NTP フォールバック先 | なし | `time.google.com`, `time.cloudflare.com` | モバイル網で UDP:123 が閉じられる場合がある。`time.google.com` は KEVi の既定 |
| NTP 再同期間隔 | 30 min | 10 min | KEVi 準拠 |
| `latest.json` 再同期間隔 | 10 min (実際は毎秒。後述) | 60 s | lmoni 公式フロント準拠 |
| 公開遅延の下限 | — | 600 ms | lmoni の実測公開遅延 0.57 s |
| 公開遅延の上限 | — | 5000 ms | KEVi 準拠 |
| 調整ステップ | — | 100 ms | KEVi 準拠 |
| 補正量の絶対値上限 | — | 5 s | クランプ状態で補正量が積み上がって戻れなくなるのを防ぐ |

### `imageFetchInterval` の意味が変わった

変更前の `KyoshinMonitorTimerNotifier` は、再同期タイマーに
`delayAdjustInterval` ではなく **`imageFetchInterval` (既定 1 秒) を渡していた**ため、
`latest.json` を実質毎秒取得していた (`isResyncing` ガードはあった)。
`delayAdjustInterval` は事実上使われていなかった。

実装後は

- `latest.json` の再同期 → `delayAdjustInterval` (60 秒)
- `imageFetchInterval` → KEVi の `FetchFrequency` 相当。秒境界タイマーは常に毎秒
  発火し、`targetTime` の Unix 秒がこの値の倍数でないティックを捨てる

とした。既定値 1 秒での挙動は変わらないが、`latest.json` へのリクエストは約 60 分の 1 になる。

### `imageFetch404DeviceTime` と `imageFetch404Ntp` は同じ挙動になる

`KyoshinMonitorDelayAdjustType` は既存の enum をそのまま使ったが、この 2 つは実装上
区別していない。`publishDelay` の導出が NTP オフセットの有無を自動的に吸収し、
どちらでも `AppClock` と整合するため、分ける意味がない。
`latestJson` / `latestJsonMultiple` を選んだ場合のみ 404 調整を行わず実測値をそのまま使う。

### JST ユーティリティの置き場所

設計では `debug_live_activity_content_builder.dart` の `_iso8601Jst` と共通化する
としていたが、あちらは Live Activity 向けの ISO8601 文字列生成で用途が異なり、
パッケージも別 (`app` と `kyoshin_monitor_api`) のため共通化は見送った。
`kyoshin_monitor_api` 側に `JstDateTimeX.toJst()` / `Jst.offset` を置いている。

### 検証状況

- `dart analyze app packages/kyoshin_monitor_api` — 今回の変更による新規の警告・エラーはなし
- `packages/kyoshin_monitor_api` の `test/src/util/` — 31 件パス
  (JST 整形・`latest_time` の JST 解釈・往復変換)
- `app/test/feature/kyoshin_monitor/` — 28 件パス
  (トリム平均・RTT/2 補正・二重適用の回帰・404 調整の増減とクランプ)
- `app/test/core/provider/clock/` — パス

**未検証**: `flutter test` の全体実行は、本変更と無関係な既存のコンパイルエラー
(`app/lib/feature/devices/data/model/registered_device.dart:25` が
`DeviceType.desktop` を網羅していない) により 43 ファイルが読み込めず完走しない。
`DeviceType` に `desktop` が追加された際に `registered_device.dart` の switch が
更新されていないもので、`develop` 時点から存在する。別途対応が必要。

## 長周期地震動モニタ固有系列の動作確認

`monitorSource = lmoni` + LPGM 系列（例: `abrsp2s` = 階級データ周期2秒台）での
経路を実測込みで確認した。

| 段階 | 結果 |
|---|---|
| `latest.json` | lmoni の `/img_svr/webservice/server/pros/latest.json` → 200 |
| 画像 | `/monitor/data/data/map_img/RealTimeImg/abrsp2s_s/{date}/{dateTime}.abrsp2s_s.gif` → 200 |
| レイヤー | `isLpgm` により地上 (`_s`) 固定（`effectiveRealtimeLayer`） |
| スケール画像 | `ScaleImg2/nied_abrsp2s_s_w_scale.gif` → 200 |
| 観測点の色 | geoJson の `color` は画像の生 RGB なので階級色がそのまま出る |
| スケールカード | LPGM は連続スケールなしとしてラベル表示に切替済み |
| 学習キー | `KyoshinMonitorDelayProfile.lpgm` |

`abrspmx` / `abrsp1s` / `abrsp2s` / `abrsp5s` はいずれも画像 200 を確認。

### 本設計の対象外だが既存の課題

`kyoshin_monitor_image_parser` が出力する geoJson の `intensity` プロパティは
`scale * 10 - 3`（震度換算）で、**データ種別に関わらず常にこの式**が使われる。
`homeKyoshinMonitorObservationGeoJson` の「最低リアルタイム震度」フィルタは
この値で判定しているため、長周期地震動階級・最大加速度・最大速度・最大変位を
選んでいるときのしきい値の意味は震度ではない。表示色は生 RGB なので正しい。
時刻同期とは独立した課題なので本 PR では扱わない。

## 未確認事項

- 地震発生時・高負荷時に公開遅延が伸びるかは未測定（平常時のみ計測）。
  `maxOffset` の妥当な値はこの挙動に依存する
- 計測は 1 拠点 1 経路からのサンプルであり、他地域・他回線での遅延分布は不明
- lmoni の `latest_time` が 1 s / 2 s で揺れる原因（生成バッチ側か `request_time` 側か）は不明
