//
//  EQMonitorLiveActivityWidget.swift
//  Widget
//

import ActivityKit
import SwiftUI
import WidgetKit

// MARK: - EEW Live Activity Widget

@available(iOS 16.1, *)
struct EewLiveActivityWidget: Widget {
    var body: some WidgetConfiguration {
        let configuration = ActivityConfiguration(for: EewLiveActivityAttributes.self) { context in
            EewActivityContentView(state: context.state)
                .environment(\.fixedArrivalCountdown, context.state.fixedRemainingSeconds)
                .liveActivityFixedTypeSize()
                .activityBackgroundTint(EewAlertStyle.surfaceColor(for: context.state.display))
                .activitySystemActionForegroundColor(.white)
        } dynamicIsland: { context in
            eewDynamicIsland(state: context.state)
        }
        // Apple Watch の Smart Stack と CarPlay 向けの .small は iOS 18 以降
        if #available(iOS 18.0, *) {
            return configuration.supplementalActivityFamilies([.small])
        } else {
            return configuration
        }
    }
}

@available(iOS 16.1, *)
private struct EewActivityContentView: View {
    let state: EewContentState

    var body: some View {
        if #available(iOS 18.0, *) {
            EewActivityFamilyContentView(state: state)
        } else {
            EewLockScreenView(state: state)
        }
    }
}

@available(iOS 18.0, *)
private struct EewActivityFamilyContentView: View {
    @Environment(\.activityFamily) private var activityFamily
    let state: EewContentState

    var body: some View {
        switch activityFamily {
        case .small:
            EewSmallActivityView(state: state)
        default:
            EewLockScreenView(state: state)
        }
    }
}

@available(iOS 16.1, *)
private func eewDynamicIsland(state: EewContentState) -> DynamicIsland {
    DynamicIsland {
        // カメラ脇と下部で高さの割り当てが異なるため本文はbottomに置く。
        DynamicIslandExpandedRegion(.leading) {
            EewExpandedLeadingView(state: state)
                .liveActivityFixedTypeSize()
                .dynamicIsland(verticalPlacement: .belowIfTooWide)
        }
        DynamicIslandExpandedRegion(.trailing) {
            EewExpandedTrailingView(state: state)
                .liveActivityFixedTypeSize()
                .dynamicIsland(verticalPlacement: .belowIfTooWide)
        }
        DynamicIslandExpandedRegion(.bottom) {
            ViewThatFits(in: .vertical) {
                EewExpandedBottomView(state: state)
                    .fixedSize(horizontal: false, vertical: true)
                EewExpandedBottomView(state: state, compact: true)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.horizontal, EewExpandedMetrics.horizontalInset)
            .padding(.bottom, 8)
            .liveActivityFixedTypeSize()
        }
    } compactLeading: {
        DynamicIslandWidthReader { isLimited in
            EewCompactLeadingView(state: state, limited: isLimited)
        }
        .liveActivityFixedTypeSize()
    } compactTrailing: {
        DynamicIslandWidthReader { isLimited in
            EewCompactTrailingView(state: state, limited: isLimited)
        }
        .liveActivityFixedTypeSize()
    } minimal: {
        EewMinimalView(state: state)
            .liveActivityFixedTypeSize()
    }
    .keylineTint(eewKeylineTint(for: state))
}

/// Expanded の leading / trailing / bottom で左右の端を揃えるための余白。
enum EewExpandedMetrics {
    static let horizontalInset: CGFloat = 8
}

@available(iOS 16.1, *)
private func eewKeylineTint(for state: EewContentState) -> Color {
    if state.display.isCanceled {
        return .gray
    }
    return state.display.isWarning ? .red : .orange
}

// MARK: - EEW Dynamic Island Views

@available(iOS 16.1, *)
struct EewCompactLeadingView: View {
    let state: EewContentState
    /// 幅が狭いDynamic Island。直径28ptの円に収める。
    var limited = false

    var body: some View {
        if state.display.isCanceled {
            EewCanceledSymbol(size: 20)
        } else if let intensity = state.display.localIntensity {
            // 角丸の四角は対角が長いため、狭い幅では円に収まる大きさへ下げる
            EewLocalIntensityView(intensity: intensity, size: limited ? 21 : 26)
                // Islandの丸い端でバッジの左の角が欠けるため、内側へ寄せる
                .padding(.leading, limited ? 0 : 4)
        } else {
            // 太字のMAXは字送り幅ぎりぎりまで描画され、領域の左端で欠けるため余白を取る。
            EewMaximumIntensityView(intensity: state.display.maxIntensity, size: limited ? 18 : 20)
                .padding(.horizontal, limited ? 2 : 4)
        }
    }
}

@available(iOS 16.1, *)
struct EewCompactTrailingView: View {
    let state: EewContentState
    /// 幅が狭いDynamic Island。直径28ptの円に収める。
    var limited = false

    var body: some View {
        HStack(spacing: 2) {
            if let remaining = ArrivalCountdown.remaining(until: state.display.countdownArrivalDate) {
                // 到達までが10分を超えることはないため、狭い幅では分1桁ぶんの幅だけ確保する
                ArrivalCountdownText(
                    remaining: remaining,
                    size: limited ? 11 : 14,
                    color: .white,
                    placeholder: limited ? "0:00" : "00:00",
                    showsTenths: !limited
                )
            } else if state.display.showsImminentArrival, !limited {
                EewImminentArrivalText(size: 10, twoLines: true)
            } else {
                EewStatusPill(
                    isWarning: state.display.isWarning,
                    isCanceled: state.display.isCanceled,
                    compact: true,
                    limited: limited
                )
            }
        }
    }
}

/// 幅が狭いDynamic Island（横向き、複数のLive Activityが並ぶ端末など）かどうかを渡す。
/// `isDynamicIslandLimitedInWidth` はiOS 27以降のため、それ未満では常に `false`。
@available(iOS 16.1, *)
struct DynamicIslandWidthReader<Content: View>: View {
    @ViewBuilder let content: (_ isLimited: Bool) -> Content

    var body: some View {
        if #available(iOS 27.0, *) {
            DynamicIslandLimitedWidthReader(content: content)
        } else {
            content(false)
        }
    }
}

@available(iOS 27.0, *)
private struct DynamicIslandLimitedWidthReader<Content: View>: View {
    @Environment(\.isDynamicIslandLimitedInWidth) private var isLimited
    let content: (Bool) -> Content

    var body: some View {
        content(isLimited)
    }
}

@available(iOS 16.1, *)
struct EewMinimalView: View {
    let state: EewContentState

    var body: some View {
        HStack(spacing: 1) {
            if state.display.isCanceled {
                EewCanceledSymbol(size: 18)
            } else if let intensity = state.display.localIntensity {
                EewLocalIntensityView(intensity: intensity, size: 24)
            } else {
                EewMaximumIntensityView(intensity: state.display.maxIntensity, size: 19)
                    .padding(.horizontal, 2)
            }
        }
    }
}

@available(iOS 16.1, *)
struct EewExpandedLeadingView: View {
    let state: EewContentState

    var body: some View {
        EewMaximumIntensityView(intensity: state.display.maxIntensity, size: 38, inlineMaximumLabel: true)
            .padding(.horizontal, EewExpandedMetrics.horizontalInset)
            .opacity(state.display.isCanceled ? 0 : 1)
            .accessibilityHidden(state.display.isCanceled)
    }
}

@available(iOS 16.1, *)
struct EewExpandedTrailingView: View {
    let state: EewContentState

    var body: some View {
        if state.display.isCanceled {
            if let serialLabel = state.display.serialLabel {
                Text(serialLabel)
                    .font(.system(size: 11, weight: .bold))
                    .foregroundStyle(.white.opacity(0.75))
                    .fixedSize()
                    .padding(.horizontal, EewExpandedMetrics.horizontalInset)
            }
        } else {
            EewSourceMetricsView(state: state, vertical: true, size: 21)
                .foregroundStyle(.white)
                .padding(.horizontal, EewExpandedMetrics.horizontalInset)
        }
    }
}

@available(iOS 16.1, *)
struct EewExpandedBottomView: View {
    let state: EewContentState
    var compact = false

    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            Text((state.isLocalTest ? "【テスト】" : "") + state.display.typeLabel)
                .font(.system(size: 11, weight: .medium))
                .foregroundStyle(.white.opacity(0.8))
                .fixedSize(horizontal: true, vertical: true)
            if let headline = state.display.headerHeadline(from: state.headline) {
                Text(headline)
                    .font(AppFonts.flex(size: 16, weight: .heavy))
                    .lineLimit(compact ? 1 : 2)
            } else {
                EewHypocenterSummaryView(state: state, size: 16)
            }

            if state.display.showsEventTime, let date = state.timeDate {
                // 日時は Lock Screen と同じ等幅フォントにする
                Text("\(state.timeLabel)  \(JSTDateFormat.monthDay(date)) \(JSTDateFormat.timeWithSeconds(date))")
                    .font(AppFonts.code(size: 11, weight: .medium))
                    .foregroundStyle(.white.opacity(0.8))
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }

            if state.display.usesLocalIntensity || state.display.locationNotice != nil {
                EewExpandedLocationView(state: state, intensitySize: compact ? 44 : 56)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .foregroundStyle(.white)
    }
}

@available(iOS 16.1, *)
private struct EewExpandedLocationView: View {
    let state: EewContentState
    let intensitySize: CGFloat

    var body: some View {
        HStack(alignment: .bottom, spacing: 8) {
            if let notice = state.display.locationNotice {
                EewLocationNoticeView(
                    notice: notice,
                    intensity: state.display.localIntensity,
                    blinkAnchor: state.display.countdownArrivalDate
                )
            } else {
                VStack(alignment: .leading, spacing: 2) {
                    Text("現在地")
                        .font(AppFonts.flex(size: 10, weight: .medium))
                        .foregroundStyle(.white.opacity(0.75))
                    if let regionName = state.location?.displayRegionName, !regionName.isEmpty {
                        Text(regionName)
                            .font(AppFonts.flex(size: 12, weight: .bold))
                            .lineLimit(2)
                            .minimumScaleFactor(0.8)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            if let arrivalDate = state.display.countdownArrivalDate {
                EewArrivalView(arrivalDate: arrivalDate)
                    .fixedSize()
            } else if state.display.showsImminentArrival {
                EewImminentArrivalText(size: 13)
            }
            if let intensity = state.display.localIntensity {
                EewLocalIntensityView(intensity: intensity, size: intensitySize)
                    .fixedSize()
            }
        }
    }
}

/// 震源地（PLUM法・レベル法では検知観測点）を 1 行で示す。
/// 細い領域で Text を分割すると折り返し・切り取りが起きるため 1 つにまとめる。
@available(iOS 16.1, *)
struct EewHypocenterSummaryView: View {
    let state: EewContentState
    let size: CGFloat

    var body: some View {
        if let text = text {
            Text(text)
                .font(AppFonts.flex(size: size, weight: .bold))
                .foregroundStyle(.white)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
        }
    }

    private var text: String? {
        guard let hypocenterName = state.hypocenterName, !hypocenterName.isEmpty else {
            return nil
        }
        // 仮定震源要素を使う検知では震源地ではなく検知観測点。混同させない
        if state.isPlum == true || state.isLevel == true {
            return "検知観測点 \(hypocenterName)"
        }
        return hypocenterName
    }
}


// MARK: - Common Views

/// Dynamic Island の寸法。
///
/// 展開時の leading / trailing は TrueDepth カメラ脇の細い L 字領域で、
/// 領域側に独自の余白を足すと内容がその分だけ切り取られる。ここで一括管理し、
/// 各 View では `padding` を足さない。
enum DynamicIslandMetrics {
    /// 展開時のバッジ寸法。leading 領域の幅に収まる大きさに抑える。
    static let expandedBadgeSize: CGFloat = 32
}


@available(iOS 16.1, *)
struct EewStatusPill: View {
    let isWarning: Bool
    let isCanceled: Bool
    var compact: Bool = false
    /// 幅が狭いDynamic Island向けに左右の余白を詰める
    var limited: Bool = false

    var body: some View {
        Text(label)
            .font(AppFonts.flex(size: compact ? 10 : 11, weight: .bold))
            .foregroundStyle(.white)
            .padding(.horizontal, limited ? 3 : (compact ? 6 : 8))
            .padding(.vertical, compact ? 2 : 3)
            .background(Capsule().fill(backgroundColor))
    }

    private var label: String {
        if isCanceled {
            return "取消"
        }
        return isWarning ? "警報" : "予報"
    }

    private var backgroundColor: Color {
        if isCanceled {
            return Color.gray
        }
        return isWarning ? Color.red : Color.orange
    }
}

/// 取消報を一目で伝えるシンボル。震度バッジの代わりに置く。
@available(iOS 16.1, *)
struct EewCanceledSymbol: View {
    let size: CGFloat

    var body: some View {
        Image(systemName: "slash.circle.fill")
            .font(.system(size: size, weight: .semibold))
            // 地色は外観に依らず黒。外観で変わる色だとライトモードで暗く沈む
            .foregroundStyle(Color(rgb: 0xC4CCD7))
    }
}
