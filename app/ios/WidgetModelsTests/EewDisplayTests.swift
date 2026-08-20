//
//  EewDisplayTests.swift
//  WidgetModelsTests
//
//  取消報で誤情報（予想震度・主要動到達カウントダウン）を出さないことを保証する。
//  Lock Screen と Dynamic Island の両方がこの判定を参照しているため、
//  ここを固定しておけば片方だけ抑止し忘れる回帰を防げる。
//

import Foundation
import Testing

struct EewDisplayTests {
    private let arrival = Date(timeIntervalSince1970: 1_704_093_150)

    private func display(
        isCanceled: Bool = false,
        isWarning: Bool = true,
        isFinal: Bool = false,
        serialNo: Int? = 3,
        maxIntensity: IntensityValue? = .sixUpper,
        forecastIntensity: IntensityValue? = .fiveLower,
        arrivalDate: Date? = nil
    ) -> EewDisplay {
        EewDisplay(
            isCanceled: isCanceled,
            isWarning: isWarning,
            isFinal: isFinal,
            serialNo: serialNo,
            maxIntensity: maxIntensity,
            forecastIntensity: forecastIntensity,
            arrivalDate: arrivalDate ?? arrival
        )
    }

    // MARK: - 取消報の抑止

    @Test func canceledReportHidesIntensity() {
        #expect(display(isCanceled: true).intensity == nil)
    }

    @Test func canceledReportHidesEarthquakeDetails() {
        #expect(display(isCanceled: true).showsEarthquakeDetails == false)
        #expect(display().showsEarthquakeDetails)
    }

    /// 取消済みなのに秒読みが動き続けると誤情報になる
    @Test func canceledReportHidesArrivalCountdown() {
        #expect(display(isCanceled: true).countdownArrivalDate == nil)
        #expect(display().countdownArrivalDate == arrival)
    }

    /// backend は取消報で headline に「地震発生」を残す。取消時は出さない。
    @Test func canceledReportHidesHeadline() {
        #expect(display(isCanceled: true).headline(from: "地震発生") == nil)
        #expect(display().headline(from: "石川県で地震") == "石川県で地震")
    }

    @Test func canceledReportOverridesWarningInTypeLabel() {
        #expect(display(isCanceled: true, isWarning: true).typeLabel == "緊急地震速報(取消)")
    }

    // MARK: - 震度の優先順位

    @Test func prefersForecastIntensityForCurrentLocation() {
        let subject = display(maxIntensity: .sixUpper, forecastIntensity: .fiveLower)
        #expect(subject.intensity == .fiveLower)
        #expect(subject.intensityLabel == "予想震度")
    }

    @Test func fallsBackToNationwideMaxIntensity() {
        let subject = display(maxIntensity: .sixUpper, forecastIntensity: nil)
        #expect(subject.intensity == .sixUpper)
        #expect(subject.intensityLabel == "最大震度")
    }

    @Test func hasNoIntensityWhenBothAreMissing() {
        #expect(display(maxIntensity: nil, forecastIntensity: nil).intensity == nil)
    }

    // MARK: - 震度バッジ（不明の明示）

    /// 予想震度が発表されない報でバッジを消すと、震度の欄そのものが無いように
    /// 見えてしまう。値が無いときは「不明」として欄を残す。
    @Test func intensityBadgeFallsBackToUnknown() {
        let subject = display(maxIntensity: nil, forecastIntensity: nil)
        #expect(subject.intensityBadge == .unknown)
        #expect(subject.maxIntensityBadge == .unknown)
        #expect(subject.intensityLabel == "最大震度")
    }

    @Test func intensityBadgeCarriesValueWhenPublished() {
        let subject = display(maxIntensity: .sixUpper, forecastIntensity: .fiveLower)
        #expect(subject.intensityBadge == .value(.fiveLower))
        #expect(subject.maxIntensityBadge == .value(.sixUpper))
    }

    /// 現在地の予想震度だけが届いた報でも、Lock Screen の「最大震度」欄は
    /// 全国の予想最大震度で判断する（現在地の値を最大震度として出さない）。
    @Test func maxIntensityBadgeIgnoresCurrentLocationForecast() {
        let subject = display(maxIntensity: nil, forecastIntensity: .fiveLower)
        #expect(subject.maxIntensityBadge == .unknown)
        #expect(subject.intensityBadge == .value(.fiveLower))
    }

    /// 取消報では震度そのものが無効。「不明」ですらなく欄ごと出さない。
    @Test func canceledReportHidesIntensityBadgeEntirely() {
        let subject = display(isCanceled: true, maxIntensity: nil, forecastIntensity: nil)
        #expect(subject.intensityBadge == nil)
        #expect(subject.maxIntensityBadge == nil)
    }

    @Test func unknownBadgeDrawsUnknownText() {
        #expect(EewIntensityBadge.unknown.parts.main == "不明")
        #expect(EewIntensityBadge.unknown.parts.sub == nil)
        #expect(EewIntensityBadge.value(.fiveLower).parts.main == "5")
        #expect(EewIntensityBadge.value(.fiveLower).parts.sub == "弱")
    }

    // MARK: - 文言

    @Test func typeLabelDistinguishesWarningFromForecast() {
        #expect(display(isWarning: true).typeLabel == "緊急地震速報(警報)")
        #expect(display(isWarning: false).typeLabel == "緊急地震速報(予報)")
    }

    @Test func serialLabelMarksFinalReport() {
        #expect(display(isFinal: false, serialNo: 32).serialLabel == "第32報")
        #expect(display(isFinal: true, serialNo: 47).serialLabel == "最終 第47報")
    }

    /// 報番号が無い / 0 のときは「第0報」を出さない
    @Test func serialLabelIsAbsentWithoutSerialNumber() {
        #expect(display(serialNo: nil).serialLabel == nil)
        #expect(display(serialNo: 0).serialLabel == nil)
    }

    @Test func headerLabelJoinsTypeAndSerial() {
        #expect(display(isWarning: true, isFinal: true, serialNo: 47).headerLabel
                == "緊急地震速報(警報) 最終 第47報")
        #expect(display(isWarning: false, serialNo: nil).headerLabel == "緊急地震速報(予報)")
    }

    @Test func headlineIsAbsentWhenEmptyOrMissing() {
        #expect(display().headline(from: nil) == nil)
        #expect(display().headline(from: "") == nil)
    }

    /// 取消報ではヘッダーの見出し行を取消の主文に差し替える
    @Test func headerHeadlineReplacesStaleHeadlineOnCanceledReport() {
        #expect(display(isCanceled: true).headerHeadline(from: "地震発生")
                == EewDisplay.canceledTitle)
        #expect(display().headerHeadline(from: "石川県で地震") == "石川県で地震")
        #expect(display().headerHeadline(from: nil) == nil)
    }

    // MARK: - Dynamic Island のレイアウト選択

    /// 到達予想があるときは主要動到達カウントダウンを主役にする
    @Test func dynamicIslandEmphasizesCountdownWhenArrivalIsKnown() {
        #expect(display().dynamicIslandLayout == .countdown)
    }

    /// 到達予想が無いときは予想最大震度と震源要素の要約にする
    @Test func dynamicIslandFallsBackToSummaryWithoutArrival() {
        let withoutArrival = EewDisplay(
            isCanceled: false,
            isWarning: true,
            isFinal: false,
            serialNo: 3,
            maxIntensity: .sixUpper,
            forecastIntensity: nil,
            arrivalDate: nil
        )
        #expect(withoutArrival.dynamicIslandLayout == .summary)
    }

    /// 取消報では到達予想が残っていてもカウントダウンを主役にしない
    @Test func dynamicIslandUsesCanceledLayoutEvenWithStaleArrival() {
        #expect(display(isCanceled: true).dynamicIslandLayout == .canceled)
    }
}
