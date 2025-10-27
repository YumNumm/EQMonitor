//
//  Region.swift
//  Widget
//
//  Created by Widget Generator
//

import Foundation

struct Region: Codable, Hashable {
    let code: String
    let name: String
}

struct Epicenter: Codable, Hashable {
    let code: String
    let name: String
}

class RegionLoader {
    static func loadRegions() -> [Region] {
        guard let url = Bundle.main.url(forResource: "regions", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let regions = try? JSONDecoder().decode([Region].self, from: data) else {
            return []
        }
        return regions
    }
}

class EpicenterLoader {
    private static var epicentersCache: [String: String]?

    static func getName(forCode code: Int) -> String {
        if epicentersCache == nil {
            loadEpicenters()
        }

        let codeString = String(code)
        return epicentersCache?[codeString] ?? "震源地不明(\(code))"
    }

    private static func loadEpicenters() {
        guard let url = Bundle.main.url(forResource: "epicenters", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let epicenters = try? JSONDecoder().decode([Epicenter].self, from: data) else {
            epicentersCache = [:]
            return
        }

        var cache: [String: String] = [:]
        for epicenter in epicenters {
            cache[epicenter.code] = epicenter.name
        }
        epicentersCache = cache
    }
}
