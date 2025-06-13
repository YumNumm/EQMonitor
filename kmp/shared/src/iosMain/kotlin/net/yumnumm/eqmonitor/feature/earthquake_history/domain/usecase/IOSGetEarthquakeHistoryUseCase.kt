package net.yumnumm.eqmonitor.feature.earthquake_history.domain.usecase

import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.launch
import net.yumnumm.eqmonitor.core.data.network.model.enum.JmaIntensity
import net.yumnumm.eqmonitor.feature.earthquake_history.domain.model.Earthquake

/**
 * iOS用の地震履歴取得UseCase
 */
class IOSGetEarthquakeHistoryUseCase(
    private val getEarthquakeHistoryUseCase: GetEarthquakeHistoryUseCase
) {
    /**
     * 地震履歴を取得してコールバックで返す
     */
    fun invoke(
        onResult: (List<Earthquake>) -> Unit,
        onError: (Throwable) -> Unit,
        limit: Int = 20,
        offset: Int = 0,
        magnitudeLte: Double? = null,
        magnitudeGte: Double? = null,
        depthLte: Double? = null,
        depthGte: Double? = null,
        intensityLte: JmaIntensity? = null,
        intensityGte: JmaIntensity? = null,
    ) {
        CoroutineScope(Dispatchers.Main).launch {
            try {
                getEarthquakeHistoryUseCase.invoke(
                    limit = limit,
                    offset = offset,
                    magnitudeLte = magnitudeLte,
                    magnitudeGte = magnitudeGte,
                    depthLte = depthLte,
                    depthGte = depthGte,
                    intensityLte = intensityLte,
                    intensityGte = intensityGte,
                ).collect { earthquakes ->
                    onResult(earthquakes)
                }
            } catch (e: Exception) {
                onError(e)
            }
        }
    }

    /**
     * デフォルトパラメータでの簡単な呼び出し
     */
    fun invokeDefault(
        onResult: (List<Earthquake>) -> Unit,
        onError: (Throwable) -> Unit
    ) {
        invoke(
            onResult = onResult,
            onError = onError,
            limit = 20,
            offset = 0,
            magnitudeLte = null,
            magnitudeGte = null,
            depthLte = null,
            depthGte = null,
            intensityLte = null,
            intensityGte = null
        )
    }
}
