import Foundation

enum WidgetLayoutKind {
    case small
    case medium
    case large
}

// 実際に並べる件数は View が実寸で決める。ここは候補の上限と取得件数だけを持つ。
enum WidgetLayoutPolicy {
    static let fetchLimit = 7

    static func maxItemCount(layout: WidgetLayoutKind) -> Int {
        switch layout {
        case .small, .medium:
            return 3
        case .large:
            return fetchLimit
        }
    }
}
