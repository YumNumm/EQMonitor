package net.yumnumm.eqmonitor.feature.earthquake_history.ui

import net.yumnumm.eqmonitor.feature.earthquake_history.domain.model.Earthquake

/**
 * 地震履歴画面のUIState
 */
data class EarthquakeHistoryUiState(
    val earthquakes: List<Earthquake> = emptyList(),
    val isLoading: Boolean = false,
    val isRefreshing: Boolean = false,
    val errorMessage: String? = null,
    val hasError: Boolean = false,
) {
    companion object {
        fun initial() = EarthquakeHistoryUiState(
            isLoading = true
        )
    }
}
