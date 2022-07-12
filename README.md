# EQMonitor

## 現在、状態管理ライブラリを移行しています。

**どんな人でも地震発生時に即座に地震情報を入手でき、適切な行動をする支援をするアプリケーションになる**  
ことを目標に開発しています。

[![Github All Releases](https://img.shields.io/github/downloads/EQMonitor/EQMonitor/total.svg)]()   ![GitHub release (latest by date including pre-releases)](https://img.shields.io/github/v/release/EQMonitor/EQMonitor?color=blue&include_prereleases&label=Release)
![GitHub release (latest by date and asset including pre-releases)](https://img.shields.io/github/downloads-pre/EQMonitor/EQMonitor/latest/app-release.apk)
[![Codemagic build status](https://api.codemagic.io/apps/621bb2a4bc3d3d2156cab924/621bb2a4bc3d3d2156cab923/status_badge.svg)](https://codemagic.io/apps/621bb2a4bc3d3d2156cab924/621bb2a4bc3d3d2156cab923/latest_build)

> **Warning**
> [利用規約](https://github.com/EQMonitor/EQMonitor/blob/main/docs/policy.md)を必ずご確認の上ご利用ください。

## 機能
- [x] リアルタイム震度の表示
- [x] 緊急地震速報・地震情報の通知
- [x] 通知の自動ツイート機能
- [x] 地震履歴の表示
- [x] PGA(リアルタイム加速度)の表示
- [ ] P,S波到達予想円の表示
- [ ] 震源地からの距離の表示
- [ ] 緊急地震速報の表示(通知ではない)
- [ ] 震度の色分け
- [ ] 震源地の表示
- [ ] アクセシビリティ向上  

## 目標
- **定性目標**  
**どんな人でも地震発生時に即座に地震情報を入手でき、適切な行動をする支援をするアプリケーションになる**

- **定量目標**  
**アプリストア公開から半年後までに計5000DL**  
PlayStoreへの公開は2023年1月1日午前0時を目標にしています。


## **Warning**
GitHub上にあるコードのみではビルドできません。
以下がGitHub上にないコードです
```
android/app/google-services.json #Firebase Key
lib/private/keys.dart #Twitter API Keyを格納
```


## Build Status

[![DigitalOcean Referral Badge](https://web-platforms.sfo2.cdn.digitaloceanspaces.com/WWW/Badge%201.svg)](https://www.digitalocean.com/?refcode=642cebc69a3e&utm_campaign=Referral_Invite&utm_medium=Referral_Program&utm_source=badge)
