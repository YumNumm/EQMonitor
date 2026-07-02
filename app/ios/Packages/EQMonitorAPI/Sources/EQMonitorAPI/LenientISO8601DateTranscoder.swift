import Foundation
import OpenAPIRuntime

/// backend が返す複数の日時表現を吸収する寛容な DateTranscoder。
///
/// backend の日時は経路によって表現が揺れる:
/// - PostgreSQL timestamptz のテキスト表現 `2026-06-26 18:59:00+00`
///   （スペース区切り・`T` 無し・オフセットが 2 桁のみ）
/// - ISO8601 fractional あり/なし `2023-11-14T22:08:20.000Z` / `...Z`
///
/// swift-openapi-runtime デフォルトの `.iso8601`（非 fractional 固定・`T` 必須・
/// オフセット `HH:mm` 必須）ではこれらの大半がデコードに失敗するため、
/// Client 生成時に本 transcoder を Configuration へ渡して吸収する。
///
/// `ISO8601DateFormatter` は Sendable でないため、Sendable な `Date.ISO8601FormatStyle`
/// を用いる（DateTranscoder は Sendable 準拠を要求する）。
public struct LenientISO8601DateTranscoder: DateTranscoder {
    private let withFractionalSeconds = Date.ISO8601FormatStyle(includingFractionalSeconds: true)
    private let withoutFractionalSeconds = Date.ISO8601FormatStyle(includingFractionalSeconds: false)

    public init() {}

    public func encode(_ date: Date) throws -> String {
        withFractionalSeconds.format(date)
    }

    public func decode(_ dateString: String) throws -> Date {
        let normalized = Self.normalize(dateString)
        if let date = try? withFractionalSeconds.parse(normalized) {
            return date
        }
        if let date = try? withoutFractionalSeconds.parse(normalized) {
            return date
        }
        throw DecodingError.dataCorrupted(
            .init(codingPath: [], debugDescription: "Expected ISO8601 date string, got \(dateString)")
        )
    }

    /// PostgreSQL timestamptz テキスト表現を ISO8601 パーサが受理できる形へ寄せる。
    /// - 日付と時刻の区切りスペースを `T` に置換
    /// - 末尾のオフセットが 2 桁のみ（`+00` / `-09`）なら `:00` を補って `HH:mm` にする
    private static func normalize(_ raw: String) -> String {
        var s = raw
        if let space = s.firstIndex(of: " ") {
            s.replaceSubrange(space...space, with: "T")
        }
        if let offset = shortOffsetRange(in: s) {
            s.insert(contentsOf: ":00", at: offset.upperBound)
        }
        return s
    }

    /// 末尾が `+HH` / `-HH`（分を伴わない 2 桁オフセット）ならその範囲を返す。
    private static func shortOffsetRange(in s: String) -> Range<String.Index>? {
        guard s.count >= 3 else { return nil }
        let offsetStart = s.index(s.endIndex, offsetBy: -3)
        let sign = s[offsetStart]
        guard sign == "+" || sign == "-" else { return nil }
        let digits = s[s.index(after: offsetStart)...]
        guard digits.count == 2, digits.allSatisfy(\.isNumber) else { return nil }
        return offsetStart..<s.endIndex
    }
}
