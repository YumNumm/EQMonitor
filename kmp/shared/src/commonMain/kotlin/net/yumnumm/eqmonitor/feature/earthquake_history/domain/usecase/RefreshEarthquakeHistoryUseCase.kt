package net.yumnumm.eqmonitor.feature.earthquake_history.domain.usecase

import net.yumnumm.eqmonitor.feature.earthquake_history.domain.repository.EarthquakeHistoryRepository

/**
 * 地震履歴更新UseCase
 */
class RefreshEarthquakeHistoryUseCase(
    private val repository: EarthquakeHistoryRepository
) {
    /**
     * 地震履歴を更新する
     */
    suspend operator fun invoke() {
        repository.refreshEarthquakeHistory()
    }
}
