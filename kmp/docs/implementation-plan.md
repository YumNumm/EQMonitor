# EQMonitor KMP版 実装方針・開発計画

## プロジェクト概要

### 背景
- **現状**: EQMonitor Flutter版が既にGoogle Play・App Storeでリリース済み、多数のユーザーが利用中
- **移行理由**: より深いプラットフォーム統合とネイティブな体験を提供したい
- **開発体制**: 個人開発、じっくりと品質重視で進める
- **移行戦略**: KMP版を完全開発後、Flutter版を全面置き換え
- **品質方針**: 一部機能のデグレード許容、UI/UX向上を重視

### アプリケーション機能概要
- 地震情報・緊急地震速報の通知
- 過去の地震履歴の閲覧
- 緊急地震速報のリアルタイム表示（P波・S波予想到達範囲等）
- 強震モニタの表示

## 技術スタック

### Core Technologies
| カテゴリ | 技術 | 理由 |
|---------|------|------|
| **Framework** | Kotlin Multiplatform | ネイティブ統合、コード共有 |
| **UI** | Compose Multiplatform | モダンなUI、宣言的UI |
| **Design System** | Material 3 | 一貫性のあるデザイン |
| **Architecture** | Clean Architecture + MVVM | 保守性、テスタビリティ |
| **Networking** | Ktor Client | KMP標準、軽量 |
| **Local Database** | SQLDelight | タイプセーフ、KMP対応 |
| **Serialization** | Kotlinx Serialization | KMP標準 |
| **Settings** | Multiplatform Settings | 設定管理 |
| **DI** | Koin | 軽量、KMP対応良好 |
| **ViewModel** | Compose ViewModel | Compose統合 |
| **Navigation** | Navigation Compose | Compose統合 |
| **Date/Time** | Kotlinx DateTime | KMP標準 |
| **Map** | MapLibre Native | 高性能、カスタマイズ性、オープンソース |

### 追加Dependencies（Phase別で導入）
```kotlin
// Phase 1: 基盤
implementation("io.ktor:ktor-client-core")
implementation("app.cash.sqldelight:runtime")
implementation("org.jetbrains.kotlinx:kotlinx-serialization-json")
implementation("io.insert-koin:koin-core")
implementation("com.russhwolf:multiplatform-settings")

// Phase 2: 地震履歴
implementation("io.ktor:ktor-client-logging")
implementation("io.ktor:ktor-client-content-negotiation")
implementation("io.ktor:ktor-serialization-kotlinx-json")

// Phase 3: 通知
implementation("io.ktor:ktor-client-websockets")
// Android: WorkManager
// iOS: Background Tasks

// Phase 4: 地図・可視化
implementation("io.github.xxfast:kstore")
// Map libraries (検討中)
```

## アーキテクチャ設計

### レイヤー構成
```
┌─────────────────────────────────────┐
│           Presentation Layer        │
│  ┌─────────────┐  ┌─────────────┐   │
│  │   Compose   │  │  ViewModel  │   │
│  │     UI      │  │             │   │
│  └─────────────┘  └─────────────┘   │
└─────────────────────────────────────┘
┌─────────────────────────────────────┐
│            Domain Layer             │
│  ┌─────────────┐  ┌─────────────┐   │
│  │  Use Cases  │  │ Repository  │   │
│  │             │  │ Interfaces  │   │
│  └─────────────┘  └─────────────┘   │
└─────────────────────────────────────┘
┌─────────────────────────────────────┐
│             Data Layer              │
│  ┌─────────────┐  ┌─────────────┐   │
│  │ Repository  │  │    Data     │   │
│  │Implementations│  │  Sources    │   │
│  └─────────────┘  └─────────────┘   │
└─────────────────────────────────────┘
```

### モジュール構成（Feature-based Architecture）
```
shared/
├── src/commonMain/kotlin/
│   ├── core/                    # 共通コア機能
│   │   ├── data/               # 共通データ基盤
│   │   │   ├── network/        # API Client、WebSocket
│   │   │   ├── local/          # Database、Preferences
│   │   │   └── repository/     # 共通Repository
│   │   ├── domain/             # 共通ドメイン
│   │   │   ├── model/          # 共通ドメインモデル
│   │   │   └── util/           # ユーティリティ
│   │   ├── ui/                 # 共通UIコンポーネント
│   │   │   ├── component/      # 再利用可能コンポーネント
│   │   │   ├── theme/          # テーマ、スタイル
│   │   │   └── util/           # UI関連ユーティリティ
│   │   ├── map/                # 地図機能（共通）
│   │   │   ├── data/          # 地図データ処理
│   │   │   ├── domain/        # 地図関連ドメイン
│   │   │   └── ui/            # 地図コンポーネント
│   │   │       ├── BaseMapView.kt           # 基本地図コンポーネント
│   │   │       ├── EarthquakeMapView.kt     # 地震情報付き地図
│   │   │       ├── IntensityMapView.kt      # 震度分布地図
│   │   │       └── RealtimeMapView.kt       # リアルタイム更新地図
│   │   └── di/                 # DI設定
│   ├── feature/
│   │   ├── earthquake_history/ # 地震履歴機能
│   │   │   ├── data/          # Repository実装、DataSource
│   │   │   ├── domain/        # UseCase、Repository Interface
│   │   │   └── ui/            # UI、ViewModel
│   │   │       ├── list/      # 履歴一覧画面
│   │   │       └── detail/    # 地震詳細画面（core/mapを使用）
│   │   ├── eew/               # 緊急地震速報機能
│   │   │   ├── data/          # EEW WebSocket、処理
│   │   │   ├── domain/        # EEW計算ロジック
│   │   │   └── ui/            # リアルタイム表示（core/mapを使用）
│   │   ├── kyoshin_monitor/   # 強震モニタ機能
│   │   │   ├── data/          # 強震データ取得
│   │   │   ├── domain/        # データ処理
│   │   │   └── ui/            # 強震モニタ表示（core/mapを使用）
│   │   └── notification/      # 通知機能
│   │       ├── data/          # 通知データ管理
│   │       ├── domain/        # 通知ロジック
│   │       └── ui/            # 通知設定画面
│   └── app/                   # アプリケーション層
│       ├── navigation/        # アプリ全体のナビゲーション
│       ├── MainActivity.kt    # メインアクティビティ
│       └── EQMonitorApp.kt    # アプリケーションエントリポイント
```

## 段階的開発計画

### Phase 1: 基盤構築 (2-3ヶ月)

#### 目標
プロジェクトの基盤となるアーキテクチャとツールチェーンの構築

#### 成果物
- [ ] 依存関係の設定・更新
- [ ] Clean Architectureの骨組み実装
- [ ] DI (Koin) 設定
- [ ] 基本的なナビゲーション構造
- [ ] CI/CD pipeline設定（GitHub Actions）
- [ ] 基本的なテスト環境構築

#### 技術タスク
1. **Gradle設定更新**
   - 必要なKMPライブラリ追加
   - Version Catalogの整理

2. **アーキテクチャ基盤**
   - Clean Architectureディレクトリ構造作成
   - BaseViewModel, BaseRepository作成
   - DI Module設定

3. **UI基盤**
   - Material 3テーマ設定
   - 基本コンポーネント作成
   - ナビゲーショングラフ設計

### Phase 2: 地震履歴機能 (2-3ヶ月)

#### 目標
過去の地震情報を取得・表示・管理する機能の実装

#### 成果物
- [ ] 地震履歴API連携
- [ ] ローカルデータベース実装
- [ ] 地震履歴一覧画面
- [ ] 地震詳細画面
- [ ] 検索・フィルタ機能

#### 技術タスク
1. **データレイヤー**
   ```kotlin
   // API Client
   interface EarthquakeApiService {
       suspend fun getEarthquakeHistory(
           startDate: String,
           endDate: String,
           minMagnitude: Double? = null
       ): List<EarthquakeDto>

       suspend fun getEarthquakeDetail(id: String): EarthquakeDetailDto
   }

   // Local Database
   CREATE TABLE earthquake (
       id TEXT PRIMARY KEY,
       occurrence_time TEXT NOT NULL,
       magnitude REAL,
       depth INTEGER,
       location TEXT NOT NULL,
       max_intensity INTEGER,
       created_at TEXT NOT NULL
   );
   ```

2. **ドメインレイヤー**
   ```kotlin
   data class Earthquake(
       val id: String,
       val occurrenceTime: LocalDateTime,
       val magnitude: Double?,
       val depth: Int?,
       val location: String,
       val maxIntensity: Int?
   )

   interface EarthquakeRepository {
       suspend fun getEarthquakeHistory(
           dateRange: DateRange,
           filters: EarthquakeFilters
       ): Flow<List<Earthquake>>
   }
   ```

3. **UIレイヤー**
   - 地震履歴一覧（LazyColumn + Pull to Refresh）
   - 地震詳細情報表示
   - 検索・フィルタUI

### Phase 3: 通知機能 (2-3ヶ月)

#### 目標
地震情報のプッシュ通知機能を実装

#### 成果物
- [ ] WebSocket接続によるリアルタイム通信
- [ ] プラットフォーム固有通知実装
- [ ] 通知設定画面
- [ ] バックグラウンド処理実装

#### 技術タスク
1. **WebSocket通信**
   ```kotlin
   class RealtimeEarthquakeService {
       suspend fun startListening(): Flow<EarthquakeUpdate>
       suspend fun stopListening()
   }
   ```

2. **プラットフォーム固有実装**
   - **Android**: WorkManager, NotificationManager
   - **iOS**: Background Tasks, UNUserNotificationCenter

3. **通知管理**
   - 通知優先度設定
   - 震度別通知設定
   - Do Not Disturb連携

### Phase 4: 地図・可視化機能 (3-4ヶ月)

#### 目標
地震情報の地図表示と緊急地震速報の可視化

#### 成果物
- [ ] 地震震源地マップ表示
- [ ] 震度分布表示
- [ ] 緊急地震速報リアルタイム表示
- [ ] P波・S波予測円表示
- [ ] 強震モニタ統合

### 技術考慮事項
#### MapLibre Native実装
```kotlin
// shared/src/commonMain/kotlin/core/map/
expect class MapView

expect class MapController {
    fun setCenter(latitude: Double, longitude: Double, zoom: Double)
    fun addEarthquakeMarkers(earthquakes: List<EarthquakeMarker>)
    fun addIntensityLayer(intensityData: IntensityData)
    fun addRealtimeLayer(realtimeData: RealtimeData)
}

// shared/src/androidMain/kotlin/core/map/
actual class MapView : AndroidMapView()
actual class MapController(
    private val mapLibreMap: MapLibreMap
) {
    // Android MapLibre Native実装
}

// shared/src/iosMain/kotlin/core/map/
actual class MapView : UIViewRepresentable
actual class MapController(
    private val mapView: MLNMapView
) {
    // iOS MapLibre Native実装
}
```

#### パフォーマンス最適化
- 高頻度更新処理の最適化（60fps維持）
- メモリリーク対策（地図タイル管理）
- バッテリー消費対策（描画頻度調整）

### Phase 5: 最適化・完成 (1-2ヶ月)

#### 目標
パフォーマンス最適化とリリース準備

#### 成果物
- [ ] パフォーマンス最適化
- [ ] テストカバレッジ向上
- [ ] ドキュメント整備
- [ ] リリース準備

## データ管理戦略

### キャッシュ戦略
- **Recent Data (24h)**: メモリ + SQLiteキャッシュ
- **Historical Data**: SQLiteオンリー
- **Settings**: Multiplatform Settings

### オフライン対応
- 直近7日間の地震データはローカル保存
- ネットワーク切断時の適切なUI表示
- 復帰時の差分同期

## パフォーマンス要件

### 重要指標
1. **アプリ起動時間**: < 2秒（コールドスタート）
2. **通知応答時間**: < 5秒（WebSocket → 通知表示）
3. **地図描画**: < 1秒（初期表示）
4. **バッテリー消費**: 1日あたり < 5%

### 最適化戦略
- Compose最適化（安定性重視、remember適切使用）
- Database Index最適化
- 画像リソース最適化
- バックグラウンド処理最小化

## テスト戦略

### テスト分類
- **Unit Tests**: Domain層、Data層
- **Integration Tests**: Repository, UseCase
- **UI Tests**: Critical User Flows
- **Platform Tests**: 通知、バックグラウンド処理

### テストツール
- **Unit**: Kotlin Test
- **UI**: Compose Test
- **Mock**: MockK or Mockito

## リリース戦略

### リリース段階
1. **Internal Testing** (Phase 5)
2. **Beta Release** (限定ユーザー)
3. **Soft Launch** (段階的地域展開)
4. **Full Release** (Flutter版置き換え)

### 移行計画
- Flutter版のユーザーデータ移行検討
- 段階的機能告知
- フィードバック収集・対応

## リスク管理

### 技術リスク
- **KMP成熟度**: 一部ライブラリが不安定な可能性
- **地図ライブラリ**: Compose Multiplatform対応ライブラリが限定的
- **プラットフォーム固有機能**: iOS/Androidの差異による実装複雑化

### 軽減策
- 早期POC実装による技術検証
- 代替ライブラリの事前調査
- Platform-specific実装の分離設計

## 次のステップ

1. **Phase 1の詳細タスク分解**
2. **依存関係の詳細選定・バージョン決定**
3. **モックデザインの作成**
4. **開発環境セットアップ**

---

*最終更新: 2025年6月13日*
*作成者: EQMonitor KMP開発チーム*
