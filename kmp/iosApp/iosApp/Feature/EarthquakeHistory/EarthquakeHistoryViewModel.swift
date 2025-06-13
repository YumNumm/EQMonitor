import Foundation
import Shared
import Combine

@MainActor
class EarthquakeHistoryViewModel: ObservableObject {
    @Published var earthquakes: [Earthquake] = []
    @Published var isLoading: Bool = false
    @Published var isRefreshing: Bool = false
    @Published var errorMessage: String? = nil
    @Published var hasError: Bool = false

    private let getEarthquakeHistoryUseCase: GetEarthquakeHistoryUseCase
    private let refreshEarthquakeHistoryUseCase: RefreshEarthquakeHistoryUseCase
    private var cancellables = Set<AnyCancellable>()

    init(
        getEarthquakeHistoryUseCase: GetEarthquakeHistoryUseCase,
        refreshEarthquakeHistoryUseCase: RefreshEarthquakeHistoryUseCase
    ) {
        self.getEarthquakeHistoryUseCase = getEarthquakeHistoryUseCase
        self.refreshEarthquakeHistoryUseCase = refreshEarthquakeHistoryUseCase

        loadEarthquakeHistory()
    }

    func loadEarthquakeHistory() {
        isLoading = true
        hasError = false
        errorMessage = nil

        let iosUseCase = IOSGetEarthquakeHistoryUseCase(getEarthquakeHistoryUseCase: getEarthquakeHistoryUseCase)

        iosUseCase.invokeDefault(
            onResult: { [weak self] earthquakeList in
                Task { @MainActor in
                    self?.earthquakes = earthquakeList
                    self?.isLoading = false
                    self?.hasError = false
                    self?.errorMessage = nil
                }
            },
            onError: { [weak self] error in
                Task { @MainActor in
                    self?.isLoading = false
                    self?.hasError = true
                    self?.errorMessage = error.message ?? "Unknown error"
                }
            }
        )
    }

    func refreshEarthquakeHistory() {
        isRefreshing = true

        Task {
            do {
                try await refreshEarthquakeHistoryUseCase.invoke()

                let iosUseCase = IOSGetEarthquakeHistoryUseCase(getEarthquakeHistoryUseCase: getEarthquakeHistoryUseCase)

                iosUseCase.invokeDefault(
                    onResult: { [weak self] earthquakeList in
                        Task { @MainActor in
                            self?.earthquakes = earthquakeList
                            self?.isRefreshing = false
                            self?.hasError = false
                            self?.errorMessage = nil
                        }
                    },
                    onError: { [weak self] error in
                        Task { @MainActor in
                            self?.isRefreshing = false
                            self?.hasError = true
                            self?.errorMessage = error.message ?? "Unknown error"
                        }
                    }
                )
            } catch {
                await MainActor.run {
                    self.isRefreshing = false
                    self.hasError = true
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func clearError() {
        hasError = false
        errorMessage = nil
    }
}
