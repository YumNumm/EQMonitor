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
    var isWarning: Bool? = nil
    var isPlum: Bool? = nil

    var forecastIntensityValue: IntensityValue? {
        guard let forecastIntensity = forecastIntensity else { return nil }
        return IntensityValue(rawValue: forecastIntensity)
    }

    var arrivalDate: Date? {
        LiveActivityDate.parse(arrivalTime)
    }
}
