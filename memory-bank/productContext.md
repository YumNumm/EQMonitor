# Product Context

このファイルは、プロジェクトの高レベルな概要と作成される予定の製品について説明します。初期段階では、projectBrief.md（提供されている場合）と作業ディレクトリ内の他のすべてのプロジェクト関連情報に基づいています。このファイルはプロジェクトの進化に合わせて更新され、他のすべてのモードにプロジェクトの目標とコンテキストを知らせるために使用されるべきです。
2025-04-04 01:16:36 - 初期化時に作成されました。

## プロジェクト目標

EQMonitorは、日本全国の地震情報をリアルタイムで受信・表示するFlutterアプリケーションです。ユーザーに地震情報や緊急地震速報をいち早く届け、地震に関する情報を視覚的に分かりやすく提供することを目的としています。

## 主要機能

* **地震情報・緊急地震速報の通知**: 気象庁により発表された地震情報や、緊急地震速報を受信し、通知します。
* **過去の地震履歴の閲覧**: 過去に発表された地震情報を遡って確認できます。
* **緊急地震速報のリアルタイム表示**: 緊急地震速報が発表された際に、P波・S波の予想到達範囲、予想最大震度、震央地を表示します。
* **強震モニタの表示**: 防災科学技術研究所の提供するWebサービス 強震モニタ を表示します。

## 全体アーキテクチャ

* **アプリケーション**
  * 状態管理: Riverpod, Flutter Hooks
  * データ取得: Dio, retrofit, eqapi_client
  * JSONシリアライズ/デシリアライズ: freezed, json_serializable
  * マップ: flutter-maplibre

* **エッジサーバサイド(API)**
  * 実行環境: Cloudflare Workers
  * データベース: Cloudflare D1 + Supabase
  * キャッシュ: Cloudflare KV
  * WebSocket(Fallback): Cloudflare Durable Objects

* **バックエンド(通知配信, DB追加, データ加工, WebSocket, 揺れ検知)**
  * 実行環境: Oracle Cloud Infrastructure Compute Instance, Docker Compose
  * データベース(キャッシュ用): PostgreSQL
  * 言語: Node.js(TS), Bun(TS), Golang, C#
