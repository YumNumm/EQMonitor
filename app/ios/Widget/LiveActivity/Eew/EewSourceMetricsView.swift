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
            SourceMetricsView(
                magnitude: state.magnitude.map { String(format: "%.1f", $0) },
                depth: state.depth, vertical: vertical, size: size
            )
        }
    }
}

@available(iOS 16.1, *)
struct SourceMetricsView: View {
    var magnitude: String?
    var depth: Double?
    var vertical = false
    var size: CGFloat = 77.23 / 3

    var body: some View {
        let labelFont = AppFonts.flex(size: max(8, size * 0.44), weight: .medium)
        let valueFont = AppFonts.code(size: size, weight: .bold)
        let magnitudeText = magnitude.map {
            Text("\(Text("M").font(labelFont))\(Text($0).font(valueFont))")
        }
        let depthText = depth.map {
            Text("\(Text("深さ ").font(labelFont))\(Text(String(Int($0))).font(valueFont))\(Text("km").font(labelFont))")
        }
        Group {
            if vertical {
                VStack(spacing: 0) {
                    magnitudeText
                    depthText
                }
            } else if let magnitudeText, let depthText {
                // 一つの Text として縮小し、Mだけが省略されたり深さに重ならないようにする。
                Text("\(magnitudeText)  \(depthText)")
            } else {
                magnitudeText
                depthText
            }
        }
        .foregroundStyle(.white)
        .lineLimit(1)
        .minimumScaleFactor(0.7)
    }
}
