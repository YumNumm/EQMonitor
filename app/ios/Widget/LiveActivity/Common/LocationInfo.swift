//
//  LocationInfo.swift
//  Widget
//

import Foundation

struct LocationInfo: Codable, Hashable {
    let regionName: String
    let forecastIntensity: String?
    let forecastLpgmIntensity: String?
    let arrivalTime: String?
    let intensity: Double?

    var forecastIntensityValue: IntensityValue? {
        guard let forecastIntensity = forecastIntensity else { return nil }
        return IntensityValue(rawValue: forecastIntensity)
    }

    var arrivalDate: Date? {
        guard let arrivalTime = arrivalTime else { return nil }
        return ISO8601DateFormatter().date(from: arrivalTime)
    }
}
