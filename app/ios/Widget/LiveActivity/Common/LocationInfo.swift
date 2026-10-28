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
    var isWarning: Bool? = nil
    var isPlum: Bool? = nil

    var displayRegionName: String {
        LiveActivityLocationName.format(regionName)
    }

    var forecastIntensityValue: IntensityValue? {
        guard let forecastIntensity = forecastIntensity else { return nil }
        return IntensityValue(rawValue: forecastIntensity)
    }

    var arrivalDate: Date? {
        LiveActivityDate.parse(arrivalTime)
    }
}

enum LiveActivityLocationName {
    static func format(_ name: String) -> String {
        zip("０１２３４５６７８９", "0123456789").reduce(name) { result, digits in
            result.replacingOccurrences(of: String(digits.0), with: String(digits.1))
        }
    }
}
