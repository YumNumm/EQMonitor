//
//  EQMonitorPreviewWidgetBundle.swift
//  EQMonitorPreviewWidget
//

import SwiftUI
import WidgetKit

@main
struct EQMonitorPreviewWidgetBundle: WidgetBundle {
    var body: some Widget {
        EarthquakeWidget()
        if #available(iOS 16.1, *) {
            EewLiveActivityWidget()
            ShakeDetectionLiveActivityWidget()
        }
    }
}
