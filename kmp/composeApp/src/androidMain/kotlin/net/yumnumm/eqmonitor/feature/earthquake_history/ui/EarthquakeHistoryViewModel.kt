package net.yumnumm.eqmonitor.feature.earthquake_history.ui

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.catch
import kotlinx.coroutines.launch
import net.yumnumm.eqmonitor.feature.earthquake_history.domain.usecase.GetEarthquakeHistoryUseCase
import net.yumnumm.eqmonitor.feature.earthquake_history.domain.usecase.RefreshEarthquakeHistoryUseCase

/**
 * 地震履歴画面のViewModel (Android)
 */
class EarthquakeHistoryViewModel(
    private val getEarthquakeHistoryUseCase: GetEarthquakeHistoryUseCase,
    private val refreshEarthquakeHistoryUseCase: RefreshEarthquakeHistoryUseCase,
) : ViewModel() {

    private val _uiState = MutableStateFlow(EarthquakeHistoryUiState.initial())
    val uiState: StateFlow<EarthquakeHistoryUiState> = _uiState.asStateFlow()

    init {
        loadEarthquakeHistory()
    }

    /**
     * 地震履歴を読み込む
     */
    fun loadEarthquakeHistory() {
        viewModelScope.launch {
            _uiState.value = _uiState.value.copy(
                isLoading = true,
                hasError = false,
                errorMessage = null
            )

            getEarthquakeHistoryUseCase()
                .catch { exception ->
                    _uiState.value = _uiState.value.copy(
                        isLoading = false,
                        hasError = true,
                        errorMessage = exception.message ?: "地震データの取得に失敗しました"
                    )
                }
                .collect { earthquakes ->
                    _uiState.value = _uiState.value.copy(
                        earthquakes = earthquakes,
                        isLoading = false,
                        hasError = false,
                        errorMessage = null
                    )
                }
        }
    }

    /**
     * Pull-to-refreshで地震履歴を更新
     */
    fun refreshEarthquakeHistory() {
        viewModelScope.launch {
            _uiState.value = _uiState.value.copy(isRefreshing = true)

            try {
                refreshEarthquakeHistoryUseCase()

                getEarthquakeHistoryUseCase()
                    .catch { exception ->
                        _uiState.value = _uiState.value.copy(
                            isRefreshing = false,
                            hasError = true,
                            errorMessage = exception.message ?: "地震データの更新に失敗しました"
                        )
                    }
                    .collect { earthquakes ->
                        _uiState.value = _uiState.value.copy(
                            earthquakes = earthquakes,
                            isRefreshing = false,
                            hasError = false,
                            errorMessage = null
                        )
                    }
            } catch (exception: Exception) {
                _uiState.value = _uiState.value.copy(
                    isRefreshing = false,
                    hasError = true,
                    errorMessage = exception.message ?: "地震データの更新に失敗しました"
                )
            }
        }
    }

    /**
     * エラーメッセージをクリア
     */
    fun clearError() {
        _uiState.value = _uiState.value.copy(
            hasError = false,
            errorMessage = null
        )
    }
}
