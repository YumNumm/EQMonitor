//
//  UnifiedLockScreenView.swift
//  Widget
//
//  統合 Live Activity の Lock Screen 表示。
//
//  主役は `primary` が指す 1 ブロックだけ。副次表示は「主表示が地震情報のときの
//  EEW 1 行」に限り、揺れ検知は副次表示しない。
//

import SwiftUI
import WidgetKit

@available(iOS 16.1, *)
struct UnifiedLockScreenView: View {
    let state: UnifiedLiveActivityContentState
    var chipStyle: IntensityChipStyle = .corner

    private var display: UnifiedLiveActivityDisplay {
        UnifiedLiveActivityDisplay(state)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            UnifiedHeaderContainer(display: display, chipStyle: chipStyle)

            content

            if let eew = display.eewStrip {
                UnifiedEewStrip(eew: eew)
            }
        }
        .padding(12)
        .foregroundStyle(.white)
        .background(.black)
    }

    @ViewBuilder
    private var content: some View {
        switch display.primary {
        case .eew:
            if let eew = display.eew {
                EewBody(eew: eew, display: display, chipStyle: chipStyle)
            }
        case .earthquake:
            if let earthquake = display.earthquake {
                EarthquakeBody(
                    earthquake: earthquake, display: display, chipStyle: chipStyle
                )
            }
        case .shakeDetection:
            if let shake = display.shakeDetection {
                ShakeDetectionBody(shake: shake, display: display)
            }
        case .empty:
            Text("地震情報を受信しています")
                .font(AppFonts.flex(size: 12, weight: .medium))
                .foregroundStyle(.white.opacity(0.75))
        }
    }
}

// MARK: - EEW 本文

@available(iOS 16.1, *)
private struct EewBody: View {
    let eew: UnifiedEew
    let display: UnifiedLiveActivityDisplay
    let chipStyle: IntensityChipStyle

    var body: some View {
        if !eew.display.isCanceled {
            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .bottom, spacing: 8) {
                    VStack(alignment: .leading, spacing: 8) {
                        if let date = eew.timeDate {
                            Text("\(eew.timeLabel)  \(JSTDateFormat.monthDay(date)) \(JSTDateFormat.timeWithSeconds(date))")
                                .font(AppFonts.code(size: 10, weight: .medium))
                                .foregroundStyle(.white.opacity(0.8))
                                .lineLimit(1)
                                .minimumScaleFactor(0.8)
                        }
                        UnifiedMetricsRow(
                            magnitudeText: eew.magnitude.map { "M" + String(format: "%.1f", $0) },
                            depth: eew.depth,
                            lowAccuracyLabel: lowAccuracyLabel
                        )
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    if display.showsLocation {
                        UnifiedLocationPanel(display: display, chipStyle: chipStyle)
                    }
                }

                if eew.display.showsDeepHypocenterIntensityNotice {
                    Text(EewDisplay.deepHypocenterIntensityNotice)
                        .font(AppFonts.flex(size: 11, weight: .medium))
                        .foregroundStyle(.white.opacity(0.75))
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
    }

    /// 仮定震源要素による検知では震源要素を数値で見せない
    private var lowAccuracyLabel: String? {
        guard eew.display.isLowAccuracyDetection else { return nil }
        if eew.isPlum == true { return "PLUM法" }
        if eew.isLevel == true { return "レベル法" }
        return "低精度"
    }
}

// MARK: - 地震情報 本文

@available(iOS 16.1, *)
private struct EarthquakeBody: View {
    let earthquake: UnifiedEarthquake
    let display: UnifiedLiveActivityDisplay
    let chipStyle: IntensityChipStyle

    var body: some View {
        if earthquake.isCanceled != true {
            HStack(alignment: .bottom, spacing: 8) {
                VStack(alignment: .leading, spacing: 8) {
                    if let date = earthquake.originDate {
                        Text("地震発生  \(JSTDateFormat.monthDay(date)) \(JSTDateFormat.timeWithSeconds(date))")
                            .font(AppFonts.code(size: 10, weight: .medium))
                            .foregroundStyle(.white.opacity(0.8))
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)
                    }

                    // 震度速報の段階では震源が未確定。行ごと出さず、欠測を推測しない
                    if let hypocenterName = earthquake.hypocenterName, !hypocenterName.isEmpty {
                        Text(hypocenterName)
                            .font(AppFonts.flex(size: 14, weight: .bold))
                            .foregroundStyle(.white)
                            .lineLimit(1)
                            .minimumScaleFactor(0.7)
                    }

                    if earthquake.magnitude?.displayText != nil || earthquake.depth != nil {
                        UnifiedMetricsRow(
                            magnitudeText: earthquake.magnitude?.displayText,
                            depth: earthquake.depth,
                            emphasizeMagnitude: earthquake.magnitude?.isOverM8 == true
                        )
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                if display.showsLocation {
                    UnifiedLocationPanel(display: display, chipStyle: chipStyle)
                }
            }
        }
    }
}

// MARK: - 揺れ検知 本文

@available(iOS 16.1, *)
private struct ShakeDetectionBody: View {
    let shake: UnifiedShakeDetection
    let display: UnifiedLiveActivityDisplay

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .bottom, spacing: 8) {
                VStack(alignment: .leading, spacing: 4) {
                    if let date = shake.detectedDate {
                        timeRow(label: "検知", date: date)
                    }
                    if let date = shake.updatedDate, date != shake.detectedDate {
                        timeRow(label: "更新", date: date)
                    }
                    if let level = shake.shakeLevel {
                        Text(level.displayString)
                            .font(AppFonts.flex(size: 14, weight: .bold))
                            .foregroundStyle(.white)
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                if display.showsLocation {
                    UnifiedLocationPanel(display: display, badgeSize: 46)
                }
            }

            // 検知が終わってもピークは下げない。表示中の値が「これまでの最大」で
            // あることを明示し、今まさに揺れていると誤解させない
            if shake.isEnded {
                Text("揺れの検知は終了しました。これまでの最大の揺れを表示しています")
                    .font(AppFonts.flex(size: 11, weight: .medium))
                    .foregroundStyle(.white.opacity(0.75))
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }

    private func timeRow(label: String, date: Date) -> some View {
        HStack(spacing: 6) {
            Text(label)
                .font(AppFonts.flex(size: 9, weight: .bold))
                .foregroundStyle(.white.opacity(0.7))
            Text(JSTDateFormat.timeWithSeconds(date))
                .font(AppFonts.code(size: 12, weight: .bold))
                .foregroundStyle(.white.opacity(0.9))
                .monospacedDigit()
        }
    }
}
