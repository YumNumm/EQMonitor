import Foundation

class DIContainer: ObservableObject {

    init() {
        // 一時的にKoinを使わないアプローチ
    }

    @MainActor
    func makeEarthquakeHistoryViewModel() -> EarthquakeHistoryViewModel {
        // 一時的に直接UseCaseを作成 (Sharedモジュールの問題が解決されるまで)
        // TODO: Sharedモジュールが正しく参照できるようになったらKoinを使う
        fatalError("Shared module not accessible - please fix iOS project configuration first")
    }
}
