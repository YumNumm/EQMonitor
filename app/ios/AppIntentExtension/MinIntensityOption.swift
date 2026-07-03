//
//  MinIntensityOption.swift
//  AppIntentExtension
//
//  Intent の「最小震度」パラメータ。rawValue は API の JmaIntensity 生値。
//  震度0と未入電（!5-/!6-）はフィルタ条件として意味を持たないため含めない。
//

import AppIntents
import EQMonitorAPI

enum MinIntensityOption: String, AppEnum {
    case int1 = "1"
    case int2 = "2"
    case int3 = "3"
    case int4 = "4"
    case int5Lower = "5-"
    case int5Upper = "5+"
    case int6Lower = "6-"
    case int6Upper = "6+"
    case int7 = "7"

    static let typeDisplayRepresentation: TypeDisplayRepresentation = "最小震度"

    static let caseDisplayRepresentations: [MinIntensityOption: DisplayRepresentation] = [
        .int1: "震度1以上",
        .int2: "震度2以上",
        .int3: "震度3以上",
        .int4: "震度4以上",
        .int5Lower: "震度5弱以上",
        .int5Upper: "震度5強以上",
        .int6Lower: "震度6弱以上",
        .int6Upper: "震度6強以上",
        .int7: "震度7",
    ]

    var apiValue: Components.Schemas.JmaIntensity {
        // rawValue は JmaIntensity の enum 値と同一のため必ず成功する
        Components.Schemas.JmaIntensity(rawValue: rawValue)!
    }
}
