import SwiftUI

extension UnifiedLiveActivityDisplay {
    var localIntensityBackground: Color? {
        localIntensity == .three ? Color(rgb: 0x59FF30) : localIntensity?.backgroundColor
    }

    var headerColor: Color {
        if isCanceled || isEnded { return Color(white: 0.25) }
        if isWarning { return Color(rgb: 0xB31918) }
        if let shakeLevel { return shakeLevel.headerBackgroundColor }
        return eew != nil ? Color(red: 0.8, green: 0.4, blue: 0.05) : Color(white: 0.25)
    }

    var headerBorderColor: Color {
        if isWarning { return Color(rgb: 0xFF5151) }
        return headerColor.opacity(0.8)
    }
}

@available(iOS 16.1, *)
struct UnifiedMaximumBadge: View {
    let display: UnifiedLiveActivityDisplay
    let size: CGFloat

    var body: some View {
        if display.isCanceled {
            Image(systemName: "slash.circle.fill")
                .font(.system(size: size * 0.65, weight: .semibold))
                .accessibilityLabel("取消")
        } else if let level = display.shakeLevel {
            VStack(spacing: 1) {
                Text("揺れ").font(AppFonts.flex(size: 9, weight: .medium))
                LiveActivityShakeBadge(level: level, size: size)
            }
            .accessibilityElement(children: .ignore)
            .accessibilityLabel("検知した揺れ \(level.displayString)")
        } else {
            LiveActivityMaximumIntensityView(
                intensity: display.maximumIntensity, size: size,
                accessibilityTitle: display.maximumIntensityLabel
            )
        }
    }
}

@available(iOS 16.1, *)
struct UnifiedLocationDetails: View {
    let display: UnifiedLiveActivityDisplay
    var intensitySize: CGFloat = 56

    var body: some View {
        if let regionName = display.regionName {
            HStack(alignment: .bottom, spacing: 6) {
                VStack(alignment: .leading, spacing: 3) {
                    Text(display.isLocationWarning ? "現在地に警報" : "現在地")
                        .font(AppFonts.flex(size: 9, weight: .medium))
                        .foregroundStyle(.white.opacity(0.8))
                    Text(regionName)
                        .font(AppFonts.flex(size: 10, weight: .heavy))
                        .fixedSize(horizontal: false, vertical: true)
                    if let arrivalDate = display.arrivalDate {
                        LiveActivityArrivalView(arrivalDate: arrivalDate)
                    }
                    if let lpgm = display.localLpgmIntensity {
                        Text("予想長周期階級 \(lpgm.rawValue)")
                            .font(AppFonts.flex(size: 9, weight: .medium))
                    }
                }
                if let intensity = display.localIntensity {
                    LiveActivityLocalIntensityView(
                        intensity: intensity, size: intensitySize,
                        accessibilityTitle: display.localIntensityLabel,
                        backgroundColor: display.localIntensityBackground
                    )
                } else if let level = display.localShakeLevel {
                    LiveActivityShakeBadge(level: level, size: intensitySize)
                        .accessibilityLabel("現在地の揺れ \(level.displayString)")
                }
            }
            .padding(.leading, 7)
            .overlay(alignment: .leading) {
                Rectangle().fill(.white.opacity(0.35)).frame(width: 0.5)
            }
        }
    }
}
