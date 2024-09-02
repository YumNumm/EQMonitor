//
//  LiveActivityLiveActivity.swift
//  LiveActivity
//
//  Created by guoxingxu on 2024/1/30.
//

import ActivityKit
import SwiftUI
import WidgetKit

struct EarthquakeEarlyWarningAttributes: ActivityAttributes, Identifiable {
    public typealias LiveDeliveryData = ContentState

    public struct ContentState: Codable, Hashable {
        var serial_no: Int
        var origin_time: Date?
        var hypo_name: String
        var depth: Double?
        var magnitude: Double?
        var forecast_max_intensity: JmaIntensity?
        var arrival_time: Date?
        var forecast_intensity: JmaIntensity?

        enum JmaIntensity: String, Codable {
            case zero = "0"
            case one = "1"
            case two = "2"
            case three = "3"
            case four = "4"
            case fiveMinus = "5-"
            case fivePlus = "5+"
            case sixMinus = "6-"
            case sixPlus = "6+"
            case seven = "7"
        }

        init(from decoder: any Decoder) throws {
            do {
                // decode ISO8601 Date
                let container:
                KeyedDecodingContainer<EarthquakeEarlyWarningAttributes.ContentState.CodingKeys> =
                try decoder.container(
                    keyedBy: EarthquakeEarlyWarningAttributes.ContentState.CodingKeys.self
                )
                self.serial_no = try container.decode(Int.self, forKey: .serial_no)
                self.hypo_name = try container.decode(String.self, forKey: .hypo_name)
                self.depth = try container.decode(Double?.self, forKey: .depth)
                self.magnitude = try container.decode(Double?.self, forKey: .magnitude)
                self.forecast_max_intensity = try container.decode(
                    JmaIntensity?.self, forKey: .forecast_max_intensity)
                self.forecast_intensity = try container.decode(
                    JmaIntensity?.self, forKey: .forecast_intensity)

                let origin_time_str = try container.decode(String.self, forKey: .origin_time)
                let arrival_time_str = try container.decode(String?.self, forKey: .arrival_time)

                let fmt = ISO8601DateFormatter()
                self.origin_time = fmt.date(from: origin_time_str)
                if let arrival_time_str = arrival_time_str {
                    self.arrival_time = fmt.date(from: arrival_time_str)
                }
            } catch {
                print("Error decoding EarthquakeEarlyWarningAttributes: \(error)")
                throw error
            }
        }

        init(
            serial_no: Int,
            origin_time: Date,
            hypo_name: String,
            depth: Double?,
            magnitude: Double?,
            forecast_max_intensity: JmaIntensity?,
            arrival_time: Date?,
            forecast_intensity: JmaIntensity?
        ) {
            self.serial_no = serial_no
            self.origin_time = origin_time
            self.hypo_name = hypo_name
            self.depth = depth
            self.magnitude = magnitude
            self.forecast_max_intensity = forecast_max_intensity
            self.arrival_time = arrival_time
            self.forecast_intensity = forecast_intensity
        }
    }

    var id = UUID()
}

let sharedDefault = UserDefaults(suiteName: "group.net.yumnumm.eqmonitor")

@available(iOS 16.2, *)
struct LiveActivityLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: EarthquakeEarlyWarningAttributes.self) { context in
            VStack{
                HStack {
                    Text("緊急地震速報 警報")
                        .font(.headline)
                        .padding(8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
                .background(
                    LinearGradient(
                        stops: [
                            Gradient.Stop(color: Color(red: 0.23, green: 0.38, blue: 0.9), location: 0.00),
                            Gradient.Stop(color: Color(red: 0.05, green: 0.26, blue: 0.66), location: 1.00),
                        ],
                        startPoint: UnitPoint(x: 0.5, y: 0),
                        endPoint: UnitPoint(x: 0.5, y: 1)
                    )
                )

                HStack {
                    // 現在地の予想震度
                    VStack {
                        Text("現在地の予想震度")
                        HStack {
                            Text("震度")
                            Text("5")
                            Text("弱")
                        }
                    }
                    Spacer()
                    // 主要動 到達まで
                    VStack {
                        Text("主要動 到達まで")
                        if let arrivalTime = context.state.arrival_time {
                            CountdownTimerView(targetDate: arrivalTime)
                        } else {
                            Text("不明")
                        }
                    }
                }
            }
            .activityBackgroundTint(Color.black.opacity(0.5))
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    VStack(alignment: .leading) {
                        Text("震度\(context.state.forecast_intensity?.rawValue ?? "不明")")
                            .font(.headline)
                            .foregroundColor(.white) // 追加
                        Text(context.state.hypo_name)
                            .font(.caption)
                            .foregroundColor(.gray) // 追加
                    }
                }
                DynamicIslandExpandedRegion(.trailing) {
                    if let arrivalTime = context.state.arrival_time {
                        CountdownTimerView(targetDate: arrivalTime)
                            .frame(width: 50)
                    } else {
                        Text("到達時刻不明")
                            .font(.caption)
                            .foregroundColor(.red) // 追加
                    }
                }
                DynamicIslandExpandedRegion(.bottom) {
                    HStack {
                        Text("M\(context.state.magnitude.map { String(format: "%.1f", $0) } ?? "不明")")
                        Spacer()
                        Text("深さ\(context.state.depth.map { String(format: "%.0f", $0) } ?? "不明")km")
                    }
                    .font(.caption)
                    .foregroundColor(.gray) // 追加
                }
            } compactLeading: {
                Text("震度\(context.state.forecast_intensity?.rawValue ?? "不明")")
                    .foregroundColor(.white) // 追加
            } compactTrailing: {
                if let arrivalTime = context.state.arrival_time {
                    Text(arrivalTime, style: .timer)
                        .foregroundColor(.white) // 追加
                } else {
                    Text("不明")
                        .foregroundColor(.red) // 追加
                }
            } minimal: {
                Text(context.state.forecast_intensity?.rawValue ?? "不明")
                    .foregroundColor(.white) // 追加
            }
        }
    }

    private func backgroundForIntensity(
        _ intensity: EarthquakeEarlyWarningAttributes.ContentState.JmaIntensity?
    ) -> some View {
        let color = intensity?.color ?? .gray
        return LinearGradient(
            gradient: Gradient(colors: [color, color.opacity(0.7)]), startPoint: .topLeading,
            endPoint: .bottomTrailing)
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        return formatter.string(from: date)
    }
}

struct CountdownTimerView: View {
    let targetDate: Date

    var body: some View {
        // Text(timerInterval: Date.now...targetDate, countsDown: true, showsHours: false)
        Text(targetDate, style: .timer)
        // .monospacedDigit()
        // .font(.system(size: 24, weight: .bold, design: .rounded))
            .foregroundColor(.white)
    }
}


@available(iOS 16.2, *)
extension EarthquakeEarlyWarningAttributes {
    fileprivate static var preview: EarthquakeEarlyWarningAttributes {
        EarthquakeEarlyWarningAttributes(eventId: "")
    }
}

extension DateFormatter {
    /// ミリ秒付きのiso8601フォーマット e.g. 2019-08-22T09:30:15.000+0900
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}

extension EarthquakeEarlyWarningAttributes.ContentState.JmaIntensity {
    var color: Color {
        switch self {
        case .zero:
            return .blue
        case .one:
            return .green
        case .two:
            return .yellow
        case .three:
            return .orange
        case .four:
            return .red
        case .fiveMinus, .fivePlus:
            return .purple
        case .sixMinus, .sixPlus:
            return .brown
        case .seven:
            return .black
        }
    }
}
