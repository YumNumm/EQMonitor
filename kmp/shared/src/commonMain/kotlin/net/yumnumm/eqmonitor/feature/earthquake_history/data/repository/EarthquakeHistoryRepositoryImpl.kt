package net.yumnumm.eqmonitor.feature.earthquake_history.data.repository

import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.flow
import net.yumnumm.eqmonitor.core.data.network.EarthquakeApiService
import net.yumnumm.eqmonitor.core.data.network.model.enum.JmaIntensity
import net.yumnumm.eqmonitor.feature.earthquake_history.data.mapper.EarthquakeMapper.toDomain
import net.yumnumm.eqmonitor.feature.earthquake_history.domain.model.Earthquake
import net.yumnumm.eqmonitor.feature.earthquake_history.domain.repository.EarthquakeHistoryRepository

/**
 * 地震履歴リポジトリ実装
 */
class EarthquakeHistoryRepositoryImpl(
    private val apiService: EarthquakeApiService
) : EarthquakeHistoryRepository {

    override suspend fun getEarthquakeHistory(
        limit: Int,
        offset: Int,
        magnitudeLte: Double?,
        magnitudeGte: Double?,
        depthLte: Double?,
        depthGte: Double?,
        intensityLte: JmaIntensity?,
        intensityGte: JmaIntensity?,
    ): Flow<List<Earthquake>> = flow {
        try {
            val earthquakeDtos = apiService.getEarthquakes(
                limit = limit,
                offset = offset,
                magnitudeLte = magnitudeLte,
                magnitudeGte = magnitudeGte,
                depthLte = depthLte,
                depthGte = depthGte,
                intensityLte = intensityLte,
                intensityGte = intensityGte,
            )

            val earthquakes = earthquakeDtos.toDomain()
            emit(earthquakes)
        } catch (e: Exception) {
            println("Failed to fetch earthquake history: ${e.message}")
            emit(emptyList())
        }
    }

    override suspend fun refreshEarthquakeHistory() {
        // 今後のフェーズでローカルキャッシュを実装する際に使用
        // 現在はAPIから直接取得するだけなので何もしない
    }
}
