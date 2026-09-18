//
//  UnifiedLiveActivityPreviews.swift
//  Widget
//
//  統合 Live Activity のデザイン確認用 Preview。
//
//  ActivityConfiguration を通す Preview（EQMonitorPreviewWidget）は実機に近い
//  代わりに反映が遅い。ここでは素の View を直接描いて、レイアウトの試行を速く回す。
//

import SwiftUI
import WidgetKit

#if DEBUG

/// Lock Screen は端末幅いっぱいに敷かれる。Preview でも同じ幅に固定して、
/// 折り返しや最小縮小率の挙動を実機と揃える。
@available(iOS 17.0, *)
private struct LockScreenPreviewFrame<Content: View>: View {
    let title: String
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption2.weight(.semibold))
                .foregroundStyle(.secondary)
            content
                .frame(width: 360)
                .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
        }
    }
}

// MARK: - 主表示ごとのレイアウト

@available(iOS 17.0, *)
#Preview("Lock Screen - 主表示 3 種") {
    let now = Date()
    return ScrollView {
        VStack(alignment: .leading, spacing: 20) {
            LockScreenPreviewFrame(title: "揺れ検知のみ（検知中）") {
                UnifiedLockScreenView(state: .shakeOnly(now: now))
            }
            LockScreenPreviewFrame(title: "揺れ検知のみ（検知終了・ピーク保持）") {
                UnifiedLockScreenView(state: .shakeOnlyEnded(now: now))
            }
            LockScreenPreviewFrame(title: "EEW（揺れ検知に結合・警報）") {
                UnifiedLockScreenView(state: .shakeWithEew(now: now))
            }
            LockScreenPreviewFrame(title: "EEW（予報・現在地は震度4未満）") {
                UnifiedLockScreenView(state: .eewOnlyForecast(now: now))
            }
            LockScreenPreviewFrame(title: "地震情報（震源・震度／EEW 帯あり）") {
                UnifiedLockScreenView(state: .earthquakeFull(now: now))
            }
        }
        .padding()
    }
}

@available(iOS 17.0, *)
#Preview("Lock Screen - 欠損・異常系") {
    let now = Date()
    return ScrollView {
        VStack(alignment: .leading, spacing: 20) {
            LockScreenPreviewFrame(title: "震度速報のみ（震源・規模なし）") {
                UnifiedLockScreenView(state: .earthquakeIntensityReportOnly(now: now))
            }
            LockScreenPreviewFrame(title: "M不明（未取得 null と区別する）") {
                UnifiedLockScreenView(state: .earthquakeMagnitudeUnknown(now: now))
            }
            LockScreenPreviewFrame(title: "M8以上（巨大地震）") {
                UnifiedLockScreenView(state: .earthquakeOverM8(now: now))
            }
            LockScreenPreviewFrame(title: "EEW 取消（終了させない）") {
                UnifiedLockScreenView(state: .eewCanceled(now: now))
            }
            LockScreenPreviewFrame(title: "地震情報 取消") {
                UnifiedLockScreenView(state: .earthquakeCanceled(now: now))
            }
            LockScreenPreviewFrame(title: "EEW なしの地震情報（防御的）") {
                UnifiedLockScreenView(state: .earthquakeWithoutEew(now: now))
            }
            LockScreenPreviewFrame(title: "ブロック欠損（異常系）") {
                UnifiedLockScreenView(state: .empty(now: now))
            }
        }
        .padding()
    }
}

// MARK: - 遷移

@available(iOS 17.0, *)
#Preview("Lock Screen - 揺れ検知→EEW→地震情報") {
    let now = Date()
    let states = UnifiedLiveActivityContentState.progressionSequence(now: now)
    return ScrollView {
        VStack(alignment: .leading, spacing: 20) {
            ForEach(Array(states.enumerated()), id: \.offset) { index, state in
                LockScreenPreviewFrame(title: "\(index + 1). \(UnifiedLiveActivityDisplay(state).typeLabel)") {
                    UnifiedLockScreenView(state: state)
                }
            }
        }
        .padding()
    }
}

// MARK: - 出所 Chip の配置比較

@available(iOS 17.0, *)
#Preview("震度バッジ - Chip 配置の比較") {
    ScrollView {
        VStack(alignment: .leading, spacing: 24) {
            ForEach(IntensityChipStyle.allCases, id: \.self) { style in
                VStack(alignment: .leading, spacing: 8) {
                    Text(String(describing: style))
                        .font(.caption.weight(.bold))
                        .foregroundStyle(.secondary)
                    HStack(spacing: 20) {
                        ForEach([IntensitySource.forecast, .observed], id: \.self) { source in
                            HStack(spacing: 12) {
                                UnifiedIntensityBadge(
                                    intensity: .fiveLower, size: 56,
                                    source: source, chipStyle: style
                                )
                                UnifiedIntensityBadge(
                                    intensity: .sixUpper, size: 56,
                                    source: source, chipStyle: style, isMaximum: true
                                )
                            }
                        }
                    }
                    .padding(style == .overhang ? 12 : 0)
                }
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("震度未発表のプレースホルダ")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.secondary)
                UnifiedIntensityPlaceholder(size: 56, label: "観測")
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("揺れレベル（Chip なし）")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.secondary)
                HStack(spacing: 12) {
                    ForEach(ShakeDetectionLevel.allCases, id: \.self) { level in
                        UnifiedShakeLevelBadge(level: level, size: 44)
                    }
                    UnifiedShakeLevelBadge(level: nil, size: 44)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    .background(Color.black)
}

/// Chip の配置を変えた Lock Screen を並べ、実際のレイアウトの中での
/// 見え方を比べる。バッジ単体では判断しづらいため。
@available(iOS 17.0, *)
#Preview("Lock Screen - Chip 配置の比較") {
    let now = Date()
    return ScrollView {
        VStack(alignment: .leading, spacing: 20) {
            ForEach(IntensityChipStyle.allCases, id: \.self) { style in
                LockScreenPreviewFrame(title: "地震情報 / \(String(describing: style))") {
                    UnifiedLockScreenView(state: .earthquakeFull(now: now), chipStyle: style)
                }
                LockScreenPreviewFrame(title: "EEW / \(String(describing: style))") {
                    UnifiedLockScreenView(state: .shakeWithEew(now: now), chipStyle: style)
                }
            }
        }
        .padding()
    }
}

#endif
