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
        // 主表示を入れ替えても背景の View は保持する。
        VStack(spacing: 0) {
            if display.primary == .eew, let eew = display.eew {
                EewLockScreenView(state: eew.eewContentState)
                    .transition(.identity)
            } else {
                VStack(alignment: .leading, spacing: 2) {
                    UnifiedHeaderContainer(display: display, chipStyle: chipStyle)
                    content
                    if let eew = display.eewStrip {
                        UnifiedEewStrip(eew: eew)
                    }
                }
                .padding(12)
                .transition(.identity)
            }
        }
        .foregroundStyle(.white)
        .background(.black)
        .animation(nil, value: display.primary)
    }

    @ViewBuilder
    private var content: some View {
        switch display.primary {
        case .earthquake:
            if let earthquake = display.earthquake {
                EarthquakeBody(earthquake: earthquake, display: display, chipStyle: chipStyle)
            }
        case .shakeDetection:
            if let shake = display.shakeDetection {
                HStack(alignment: .bottom, spacing: 8) {
                    if let date = shake.detectedDate {
                        Text("検知  \(JSTDateFormat.timeWithSeconds(date))")
                            .font(AppFonts.code(size: 12, weight: .bold))
                            .monospacedDigit()
                            .lineLimit(1)
                    }
                    Spacer(minLength: 0)
                    if display.showsLocation {
                        UnifiedLocationPanel(display: display, badgeSize: 46)
                    }
                }
            }
        case .empty:
            Text("地震情報を受信しています")
                .font(AppFonts.flex(size: 12, weight: .medium))
                .foregroundStyle(.white.opacity(0.75))
        case .eew:
            EmptyView()
        }
    }
}

@available(iOS 16.1, *)
private struct EarthquakeBody: View {
    let earthquake: UnifiedEarthquake
    let display: UnifiedLiveActivityDisplay
    let chipStyle: IntensityChipStyle

    var body: some View {
        HStack(alignment: .bottom, spacing: 8) {
            VStack(alignment: .leading, spacing: 2) {
                if let date = earthquake.originDate {
                    Text("地震発生  \(JSTDateFormat.monthDay(date)) \(JSTDateFormat.timeWithSeconds(date))")
                        .font(AppFonts.code(size: 10, weight: .medium))
                        .foregroundStyle(.white.opacity(0.8))
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                }
                // 震源名はヘッダーの見出しに含まれるため重複させない。
                UnifiedMetricsRow(
                    magnitude: earthquake.magnitude?.displayValue,
                    depth: earthquake.depth,
                    emphasizeMagnitude: earthquake.magnitude?.isOverM8 == true
                )
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            if display.showsLocation {
                UnifiedLocationPanel(display: display, chipStyle: chipStyle, badgeSize: 36)
            }
        }
    }
}
