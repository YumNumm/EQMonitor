import SwiftUI

/// 低精度時にM・深さを出さない既存方針を、ロック画面とExpandedで共有する。
@available(iOS 16.1, *)
struct EewSourceMetricsView: View {
    let state: EewContentState
    var vertical: Bool = false
    var size: CGFloat = 77.23 / 3

    var body: some View {
        if state.display.isLowAccuracyDetection {
            Text(state.isPlum == true ? "PLUM法" : state.isLevel == true ? "レベル法" : "低精度")
                .font(.system(size: 12, weight: .bold))
                .fixedSize()
                .padding(.horizontal, 7)
                .padding(.vertical, 3)
                .overlay(ContainerRelativeShape().strokeBorder(.white.opacity(0.5)))
                .padding(4)
        } else {
            let layout = vertical
                // Figmaはcap heightでトリム済み。Google Sans Codeの行ボックスには
                // 約10ptの上下余白があるため、10ptをさらに足すと行間が二重になる。
                ? AnyLayout(VStackLayout(alignment: .center, spacing: 0))
                : AnyLayout(HStackLayout(alignment: .firstTextBaseline, spacing: 8 / 3))
            layout {
                if let magnitude = state.magnitude {
                    EewMetricView(
                        label: "M", value: String(format: "%.1f", magnitude),
                        size: size, trackingRatio: -0.22, spacing: 0
                    )
                }
                if let depth = state.depth {
                    EewMetricView(
                        label: "深さ", value: String(Int(depth)), unit: "km",
                        size: size, trackingRatio: -0.03, spacing: size * 0.074
                    )
                }
            }
        }
    }
}

@available(iOS 16.1, *)
private struct EewMetricView: View {
    let label: String
    let value: String
    var unit: String = ""
    let size: CGFloat
    let trackingRatio: CGFloat
    let spacing: CGFloat

    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: spacing) {
            Text(label)
                .font(AppFonts.code(size: size * 0.44, weight: .medium))
                .foregroundStyle(.white.opacity(0.8))
            Text(value)
                .font(AppFonts.code(size: size, weight: .bold))
                .tracking(size * trackingRatio)
            if !unit.isEmpty {
                Text(unit)
                    .font(AppFonts.code(size: size * 0.44, weight: .medium))
                    .foregroundStyle(.white.opacity(0.8))
            }
        }
        .foregroundStyle(.white)
        .lineLimit(1)
        .minimumScaleFactor(0.7)
    }
}
