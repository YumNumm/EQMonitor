import SwiftUI

@available(iOS 16.1, *)
struct UnifiedLiveActivityView: View {
    let display: UnifiedLiveActivityDisplay

    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            UnifiedLiveActivityHeader(display: display)
            if !display.isCanceled {
                ViewThatFits(in: .horizontal) {
                    HStack(alignment: .top, spacing: 6) {
                        UnifiedSourceDetails(display: display)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        UnifiedLocationDetails(display: display)
                    }
                    VStack(alignment: .leading, spacing: 8) {
                        UnifiedSourceDetails(display: display)
                        UnifiedLocationDetails(display: display)
                    }
                }
            }
        }
        .padding(10)
        .foregroundStyle(.white)
        .background(.black)
    }
}

@available(iOS 16.1, *)
struct UnifiedLiveActivityHeader: View {
    let display: UnifiedLiveActivityDisplay

    var body: some View {
        HStack(spacing: 8) {
            VStack(alignment: .leading, spacing: 2) {
                Text(display.title)
                    .font(AppFonts.flex(size: 11, weight: .semibold))
                    .foregroundStyle(.white.opacity(0.85))
                Text(display.headline)
                    .font(AppFonts.flex(size: 16, weight: .heavy))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .fixedSize(horizontal: false, vertical: true)
            if !display.isCanceled {
                UnifiedMaximumBadge(display: display, size: 36.5)
            }
        }
        .padding(.horizontal, 7)
        .padding(.vertical, 7)
        .background(display.headerColor, in: RoundedRectangle(cornerRadius: 10))
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(display.headerBorderColor, lineWidth: 1)
        }
    }
}

@available(iOS 16.1, *)
struct UnifiedSourceDetails: View {
    let display: UnifiedLiveActivityDisplay

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            if let date = display.eventDate {
                Text("\(display.eventDateLabel) \(JSTDateFormat.monthDay(date)) \(JSTDateFormat.timeWithSeconds(date))")
                    .font(AppFonts.code(size: 11, weight: .medium))
                    .foregroundStyle(.white.opacity(0.8))
            }
            if let shakeLevel = display.shakeLevel {
                Text(shakeLevel.displayString)
                    .font(AppFonts.flex(size: 14, weight: .bold))
            }
            UnifiedSourceMetrics(display: display)
                .padding(.top, 8)
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}

@available(iOS 16.1, *)
struct UnifiedSourceMetrics: View {
    let display: UnifiedLiveActivityDisplay
    var vertical = false
    var size: CGFloat = 26

    var body: some View {
        if let method = display.methodLabel {
            Text(method)
                .font(AppFonts.flex(size: 11, weight: .bold))
        } else {
            let layout = vertical
                ? AnyLayout(VStackLayout(alignment: .trailing, spacing: 0))
                : AnyLayout(HStackLayout(alignment: .firstTextBaseline, spacing: 3))
            layout {
                if let magnitude = display.magnitude {
                    let value = switch magnitude {
                    case let .normal(number): number.formatted(.number.precision(.fractionLength(1)))
                    case .unknown: "不明"
                    case .overM8: "8超"
                    }
                    UnifiedMetric(label: "M", value: value, size: size)
                }
                if let depth = display.depth {
                    UnifiedMetric(
                        label: "深さ",
                        value: depth.formatted(.number.precision(.fractionLength(0...1))),
                        unit: "km", size: size
                    )
                }
            }
        }
    }
}

@available(iOS 16.1, *)
private struct UnifiedMetric: View {
    let label: String
    let value: String
    var unit = ""
    let size: CGFloat

    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 0) {
            Text(label).font(AppFonts.flex(size: size * 0.44, weight: .medium))
            Text(value).font(AppFonts.code(size: size, weight: .bold)).monospacedDigit()
            if !unit.isEmpty {
                Text(unit).font(AppFonts.code(size: size * 0.44, weight: .medium))
            }
        }
        .foregroundStyle(.white)
    }
}
