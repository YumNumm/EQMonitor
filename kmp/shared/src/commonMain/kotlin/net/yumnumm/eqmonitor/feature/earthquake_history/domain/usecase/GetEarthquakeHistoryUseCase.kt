package net.yumnumm.eqmonitor.feature.earthquake_history.domain.usecase

import kotlinx.coroutines.flow.Flow
import net.yumnumm.eqmonitor.core.data.network.model.enum.JmaIntensity
import net.yumnumm.eqmonitor.feature.earthquake_history.domain.model.Earthquake
import net.yumnumm.eqmonitor.feature.earthquake_history.domain.repository.EarthquakeHistoryRepository

/**
 * 地震履歴取得UseCase
 */
class GetEarthquakeHistoryUseCase(
    private val repository: EarthquakeHistoryRepository
) {
    /**
     * 地震履歴を取得する
     */
    suspend operator fun invoke(
        limit: Int = 20,
        offset: Int = 0,
        magnitudeLte: Double? = null,
        magnitudeGte: Double? = null,
        depthLte: Double? = null,
        depthGte: Double? = null,
        intensityLte: JmaIntensity? = null,
        intensityGte: JmaIntensity? = null,
    ): Flow<List<Earthquake>> {
        return repository.getEarthquakeHistory(
            limit = limit,
            offset = offset,
            magnitudeLte = magnitudeLte,
            magnitudeGte = magnitudeGte,
            depthLte = depthLte,
            depthGte = depthGte,
            intensityLte = intensityLte,
            intensityGte = intensityGte,
        )
    }
}
