# iOS Widget アーキテクチャ図

## システムアーキテクチャ

```mermaid
graph TB
    subgraph "iOS Widget"
        WE[Widget Extension]
        TP[Timeline Provider]
        WV[Widget Views]
        AI[App Intents]
    end

    subgraph "Data Layer"
        API[API Client]
        DM[Data Models]
        TC[Type Converter]
    end

    subgraph "UI Layer"
        HV[Header View]
        RV[Row Views]
        EV[Error/Empty Views]
        AC[Adaptive Colors]
    end

    subgraph "EQMonitor API v2"
        EQ[/v2/earthquake]
        REG[/v2/earthquake/intensity/region]
        PREF[/v2/earthquake/intensity/prefecture]
    end

    WE --> TP
    TP --> API
    TP --> WV
    WV --> HV
    WV --> RV
    WV --> EV
    WV --> AC
    AI --> TP

    API --> DM
    DM --> TC
    TC --> WV

    API --> EQ
    API --> REG
    API --> PREF

    style WE fill:#e1f5ff
    style TP fill:#b3e5fc
    style API fill:#ffecb3
    style DM fill:#fff9c4
    style WV fill:#c8e6c9
```

## データフロー図

```mermaid
sequenceDiagram
    participant Widget as Widget UI
    participant Provider as Timeline Provider
    participant API as API Client
    participant Server as EQMonitor API v2

    Widget->>Provider: タイムライン要求
    Provider->>Provider: 設定を確認（全国/地域別）

    alt 全国の地震
        Provider->>API: fetchEarthquakeList()
        API->>Server: GET /v2/earthquake?limit=10
    else 地域別検索
        Provider->>API: searchByRegion(code)
        API->>Server: GET /v2/earthquake/intensity/region?code=xxx
    end

    Server-->>API: JSON Response
    API->>API: JSONデコード<br/>Union型処理
    API-->>Provider: EarthquakeListResponse

    Provider->>Provider: DisplayItem変換<br/>表示用データ整形
    Provider-->>Widget: Timeline Entry
    Widget->>Widget: レンダリング
```

## データ変換フロー

```mermaid
graph LR
    subgraph "API Response"
        A1[EarthquakePartial]
        A2[Hypocenter]
        A3[Coordinate Union]
        A4[Depth Union]
        A5[Magnitude Union]
    end

    subgraph "Display Model"
        D1[EarthquakeDisplayItem]
        D2[magnitude: String]
        D3[depth: String]
        D4[latitude/longitude: Double?]
    end

    A1 --> D1
    A2 --> D1
    A3 --> D4
    A4 --> D3
    A5 --> D2

    style A1 fill:#ffe0b2
    style D1 fill:#c5e1a5
```

## Union型の処理フロー

```mermaid
graph TD
    subgraph "Coordinate Union"
        C1{type?}
        C1 -->|LAT_LNG| C2[latitude, longitude]
        C1 -->|UNKNOWN| C3[condition]
        C2 --> C4[地図表示可能]
        C3 --> C5[地図表示不可]
    end

    subgraph "Depth Union"
        D1{type?}
        D1 -->|SHALLOW| D2[ごく浅い]
        D1 -->|NORMAL| D3[XXkm]
        D1 -->|OVER_700| D4[700km以上]
        D1 -->|UNKNOWN| D5[不明]
    end

    subgraph "Magnitude Union"
        M1{type?}
        M1 -->|NORMAL| M2[M6.4]
        M1 -->|UNKNOWN| M3[M不明]
        M1 -->|OVER_M8| M4[M8以上]
    end

    style C2 fill:#a5d6a7
    style C3 fill:#ffccbc
    style D2 fill:#a5d6a7
    style D3 fill:#a5d6a7
    style D4 fill:#a5d6a7
    style D5 fill:#ffccbc
    style M2 fill:#a5d6a7
    style M3 fill:#ffccbc
    style M4 fill:#a5d6a7
```

## エラーハンドリングフロー

```mermaid
graph TD
    A[API リクエスト] --> B{レスポンス}
    B -->|200-299| C[JSONデコード]
    B -->|400-499| D[クライアントエラー]
    B -->|500-599| E[サーバーエラー]
    B -->|タイムアウト| F[ネットワークエラー]

    C --> G{デコード成功?}
    G -->|成功| H[データ表示]
    G -->|失敗| I[デコードエラー]

    D --> J[エラーUI表示]
    E --> J
    F --> J
    I --> J

    J --> K[5分後に再試行]
    H --> L[15分後に更新]

    style H fill:#c8e6c9
    style J fill:#ffccbc
    style K fill:#fff9c4
    style L fill:#c8e6c9
```

## Widget更新サイクル

```mermaid
graph LR
    A[Widget表示] --> B[15分待機]
    B --> C[自動更新]
    C --> D{成功?}
    D -->|成功| A
    D -->|失敗| E[エラー表示]
    E --> F[5分待機]
    F --> G[再試行]
    G --> D

    H[ユーザーが再読み込み] --> C
    I[App起動] --> C

    style A fill:#e1f5ff
    style C fill:#b3e5fc
    style E fill:#ffccbc
    style G fill:#fff9c4
```

## UI コンポーネント階層

```mermaid
graph TD
    A[EarthquakeWidget] --> B{WidgetFamily}
    B -->|systemSmall| C[SmallWidgetView]
    B -->|systemMedium| D[MediumWidgetView]
    B -->|systemLarge| E[LargeWidgetView]

    C --> F[CompactHeader]
    C --> G[CompactRows]

    D --> H[StandardHeader]
    D --> I[StandardRows]

    E --> H
    E --> J[ExtendedRows]

    H --> K[Title]
    H --> L[UpdateTime]
    H --> M[RefreshButton]

    I --> N[EarthquakeRow]
    J --> N

    N --> O[IntensityBadge]
    N --> P[HypocenterName]
    N --> Q[MagnitudeLabel]
    N --> R[DepthLabel]
    N --> S[TimeLabel]

    style A fill:#e1f5ff
    style C fill:#c5cae9
    style D fill:#b2dfdb
    style E fill:#c8e6c9
    style N fill:#fff9c4
```

## 震度表示の色マッピング

```mermaid
graph LR
    subgraph "震度値"
        I0[震度0]
        I1[震度1]
        I2[震度2]
        I3[震度3]
        I4[震度4]
        I5L[震度5弱]
        I5U[震度5強]
        I6L[震度6弱]
        I6U[震度6強]
        I7[震度7]
    end

    subgraph "表示色"
        C0[グレー]
        C1[薄い青]
        C2[水色]
        C3[明るい黄]
        C4[黄色]
        C5L[オレンジ]
        C5U[オレンジ]
        C6L[赤]
        C6U[赤]
        C7[紫]
    end

    I0 --> C0
    I1 --> C1
    I2 --> C2
    I3 --> C3
    I4 --> C4
    I5L --> C5L
    I5U --> C5U
    I6L --> C6L
    I6U --> C6U
    I7 --> C7

    style C0 fill:#808080
    style C1 fill:#ccccff
    style C2 fill:#00ccff
    style C3 fill:#ffff00
    style C4 fill:#ffcc00
    style C5L fill:#ff6600
    style C5U fill:#ff6600
    style C6L fill:#ff0000
    style C6U fill:#ff0000
    style C7 fill:#b300b3
```

## 実装フェーズ

```mermaid
gantt
    title iOS Widget 改善実装スケジュール
    dateFormat  YYYY-MM-DD
    section Phase 1: API統合
    データモデル作成       :done, p1-1, 2026-01-06, 2d
    APIクライアント実装    :active, p1-2, 2026-01-08, 3d
    変換レイヤー実装       :p1-3, after p1-2, 2d
    基本表示確認          :p1-4, after p1-3, 1d

    section Phase 2: UI改善
    ヘッダー改善          :p2-1, after p1-4, 1d
    行表示改善            :p2-2, after p2-1, 2d
    エラー・空状態改善     :p2-3, after p2-2, 1d
    ダークモード対応      :p2-4, after p2-3, 1d

    section Phase 3: 最適化
    アクセシビリティ      :p3-1, after p2-4, 2d
    Dynamic Type対応      :p3-2, after p3-1, 1d
    パフォーマンス最適化   :p3-3, after p3-2, 1d
    テストケース拡充      :p3-4, after p3-3, 2d
```

## デプロイメントフロー

```mermaid
graph TD
    A[開発開始] --> B[データモデル実装]
    B --> C[APIクライアント実装]
    C --> D[Preview確認]
    D --> E{動作確認}
    E -->|OK| F[UI改善]
    E -->|NG| B

    F --> G[アクセシビリティ対応]
    G --> H[全体テスト]
    H --> I{品質チェック}
    I -->|OK| J[本番デプロイ]
    I -->|NG| F

    J --> K[モニタリング]
    K --> L{問題検出?}
    L -->|あり| M[修正]
    L -->|なし| N[完了]
    M --> H

    style A fill:#e1f5ff
    style J fill:#c8e6c9
    style N fill:#a5d6a7
    style M fill:#ffccbc
```

## アクセシビリティ対応フロー

```mermaid
graph TD
    A[UI要素] --> B{タップ可能?}
    B -->|はい| C[44x44pt以上?]
    B -->|いいえ| D[VoiceOverラベル]

    C -->|はい| E[アクセシビリティヒント]
    C -->|いいえ| F[サイズ拡大]
    F --> E

    D --> G{重要な情報?}
    G -->|はい| H[要素を統合]
    G -->|いいえ| I[適切なラベル]

    E --> J[Dynamic Type対応]
    H --> J
    I --> J

    J --> K[コントラスト確認]
    K --> L{WCAG AA準拠?}
    L -->|はい| M[完了]
    L -->|いいえ| N[色を調整]
    N --> K

    style M fill:#c8e6c9
    style F fill:#fff9c4
    style N fill:#fff9c4
```

---

これらの図により、システムの全体像と実装の流れが視覚的に理解できます。
