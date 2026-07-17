import Foundation

enum WidgetLayoutKind {
    case small
    case medium
    case large
    case extraLarge
}

enum WidgetLayoutPolicy {
    static func maxItemCount(layout: WidgetLayoutKind, availableHeight: Double) -> Int {
        let metrics = switch layout {
        case .small:
            (reservedHeight: 33.5, rowHeight: 42.0, limit: 2)
        case .medium:
            (reservedHeight: 54.0, rowHeight: 52.0, limit: 3)
        case .large:
            (reservedHeight: 54.0, rowHeight: 52.0, limit: 5)
        case .extraLarge:
            (reservedHeight: 54.0, rowHeight: 52.0, limit: 8)
        }
        let spacing = 6.0
        let usableHeight = max(0, availableHeight - metrics.reservedHeight)
        let fittingCount = Int((usableHeight + spacing) / (metrics.rowHeight + spacing))
        return min(metrics.limit, max(1, fittingCount))
    }
}
