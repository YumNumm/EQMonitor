import Foundation

/// A complete server snapshot selects exactly one source. Never reuse a previous block.
struct UnifiedLiveActivityDisplay {
    let state: UnifiedLiveActivityContentState

    var shake: UnifiedShakeDetection? {
        state.primary == .shakeDetection ? state.shakeDetection : nil
    }
    var eew: UnifiedEew? { state.primary == .eew ? state.eew : nil }
    var earthquake: UnifiedEarthquake? {
        state.primary == .earthquake ? state.earthquake : nil
    }
    var isCanceled: Bool { eew?.isCanceled == true || earthquake?.isCanceled == true }
    var isWarning: Bool { !isCanceled && eew?.isWarning == true }
    var isEnded: Bool { shake?.status == .ended }
    var isLowAccuracy: Bool {
        eew.map { $0.isPlum || $0.isLevel || $0.isOnePoint } ?? false
    }

    var title: String {
        if let eew {
            let kind = eew.isCanceled ? "取消" : eew.isWarning ? "警報" : "予報"
            let final = eew.isFinal ? " 最終" : ""
            return "緊急地震速報（\(kind)）\(final) 第\(eew.serialNo)報"
        }
        if earthquake != nil { return isCanceled ? "地震情報（取消）" : "地震情報" }
        return isEnded ? "揺れ検知（終了）" : "揺れ検知"
    }

    var headline: String {
        if isCanceled {
            return eew != nil ? "先ほどの緊急地震速報は取り消されました" : "先ほどの地震情報は取り消されました"
        }
        return shake?.headline ?? eew?.headline ?? earthquake?.headline ?? ""
    }

    var maximumIntensity: IntensityValue? {
        guard !isCanceled else { return nil }
        return eew?.maxIntensity ?? earthquake?.maxIntensity
    }
    var maximumIntensityLabel: String { eew != nil ? "最大予想震度" : "最大震度" }
    var localIntensity: IntensityValue? {
        guard !isCanceled else { return nil }
        return eew?.location?.forecastIntensity ?? earthquake?.location?.maxIntensity
    }
    var localIntensityLabel: String { eew != nil ? "現在地の予想震度" : "現在地の観測震度" }
    var localLpgmIntensity: LpgmIntensityValue? {
        isCanceled ? nil : eew?.location?.forecastLpgmIntensity
    }
    var shakeLevel: ShakeDetectionLevel? { shake?.level }
    var localShakeLevel: ShakeDetectionLevel? { shake?.location?.level }
    var regionName: String? {
        guard !isCanceled else { return nil }
        return shake?.location?.name ?? eew?.location?.regionName ?? earthquake?.location?.regionName
    }
    var isLocationWarning: Bool { !isCanceled && eew?.location?.isWarning == true }
    var arrivalDate: Date? {
        guard !isCanceled, let eew, !eew.isPlum, !eew.isLevel,
              eew.location?.isPlum != true else { return nil }
        return eew.location?.arrivalTime?.date
    }

    var hypocenterName: String? {
        guard !isCanceled else { return nil }
        return eew?.hypocenterName ?? earthquake?.hypocenterName
    }
    var sourceLabel: String { isLowAccuracy ? "検知観測点" : "震源地" }
    var magnitude: UnifiedLiveActivityMagnitude? {
        guard !isCanceled, !isLowAccuracy else { return nil }
        if let eew { return eew.magnitude.map(UnifiedLiveActivityMagnitude.normal) }
        return earthquake?.magnitude
    }
    var depth: Double? {
        guard !isCanceled, !isLowAccuracy else { return nil }
        return eew?.depth ?? earthquake?.depth
    }
    var eventDate: Date? {
        guard !isCanceled else { return nil }
        return shake?.detectedAt.date ?? eew?.time?.date ?? earthquake?.originTime?.date
    }
    var eventDateLabel: String {
        if shake != nil { return "揺れ検知" }
        if let eew { return eew.isOriginTime ? "地震発生" : "地震検知" }
        return "地震発生"
    }
    var methodLabel: String? {
        guard !isCanceled, let eew else { return nil }
        if eew.isPlum { return "PLUM法" }
        if eew.isLevel { return "レベル法" }
        if eew.isOnePoint { return "1点検知・低精度" }
        return nil
    }
    var eventId: String? { eew?.eventId ?? earthquake?.eventId }
}

extension UnifiedLiveActivityDisplay {
    var compactStatus: String {
        if isCanceled { return "取消" }
        if isEnded { return "終了" }
        if eew != nil { return isWarning ? "警報" : "予報" }
        return earthquake != nil ? "地震" : "揺れ"
    }

    var url: URL? {
        var components = URLComponents()
        components.scheme = "eqmonitor"
        components.host = ""
        if let eventId { return EarthquakeDetailURL.make(eventId: eventId) }
        components.path = "/"
        return components.url
    }
}
