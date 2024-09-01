//
//  LiveActivityExtensionLiveActivity.swift
//  LiveActivityExtension
//
//  Created by 尾上 遼太朗 on 2024/09/02.
//

import ActivityKit
import SwiftUI
import WidgetKit

struct LiveActivityAttributes: ActivityAttributes {
  public struct ContentState: Codable, Hashable {
    var intensity: String
    var colorARGB: String  // ARGB値を保存するためのUInt32型
    var hypoName: String
    var magnitude: Double
    var depth: Double
    var arrivalTime: String
    var estimatedMaxIntensity: String
  }

  var eventId: String
}

@available(iOS 16.2, *)
struct LiveActivityLiveActivity: Widget {
  var body: some WidgetConfiguration {
    ActivityConfiguration(for: LiveActivityAttributes.self) { context in
      VStack(spacing: 8) {
        HStack {
          Text("緊急地震速報")
            .font(.headline)
            .foregroundColor(.white)
          Spacer()
          Text("強い揺れに警戒")
            .font(.caption)
            .foregroundColor(.white)
            .padding(.horizontal, 8)
            .background(Color.red)
            .cornerRadius(4)
        }

        HStack {
          VStack(alignment: .leading) {
            Text("現在地予想震度")
              .font(.caption)
            Text("\(context.state.intensity)程度")
              .font(.largeTitle)
              .fontWeight(.bold)
          }
          Spacer()
          VStack(alignment: .trailing) {
            Text("到達予想時刻")
              .font(.caption)
            Text(context.state.arrivalTime)
              .font(.title2)
              .fontWeight(.bold)
          }
        }

        Text("震源地: \(context.state.hypoName)")
          .font(.caption)
          .lineLimit(1)

        HStack {
          Text("予想最大震度: \(context.state.estimatedMaxIntensity)")
          Spacer()
          Text("M\(String(format: "%.1f", context.state.magnitude))")
        }
        .font(.caption)
      }
      .padding()
      //.background(context.state.color)
    } dynamicIsland: { context in
      DynamicIsland {
        DynamicIslandExpandedRegion(.leading) {
          Text("震度\(context.state.intensity)")
            .font(.headline)
        }
        DynamicIslandExpandedRegion(.trailing) {
          Text(context.state.arrivalTime)
            .font(.headline)
        }
        DynamicIslandExpandedRegion(.bottom) {
          Text(context.state.hypoName)
            .font(.caption)
            .lineLimit(1)
        }
      } compactLeading: {
        Text("震度\(context.state.intensity)")
      } compactTrailing: {
        Text(context.state.arrivalTime)
      } minimal: {
        Text("\(context.state.intensity)")
      }
      .keylineTint(Color.red)
    }
  }
}

extension LiveActivityAttributes {
  fileprivate static var preview: LiveActivityAttributes {
    LiveActivityAttributes(eventId: "")
  }
}

//#Preview("Notification", as: .content, using: LiveActivityAttributes.preview) {
//   LiveActivityLiveActivity()
//} contentStates: {
//    LiveActivityAttributes.ContentState.smiley
//    LiveActivityAttributes.ContentState.starEyes
//}
