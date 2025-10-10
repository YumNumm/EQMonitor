//
//  WidgetBundle.swift
//  Widget
//
//  Created by 尾上 遼太朗 on 2025/10/09.
//

import WidgetKit
import SwiftUI

@main
struct EQMonitorWidgetBundle: WidgetBundle {
    var body: some Widget {
        EarthquakeWidget()
        WidgetControl()
    }
}
