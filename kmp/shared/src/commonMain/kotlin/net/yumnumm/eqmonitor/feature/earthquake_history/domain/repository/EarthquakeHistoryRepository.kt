package net.yumnumm.eqmonitor.feature.earthquake_history.domain.repository

import kotlinx.coroutines.flow.Flow
import net.yumnumm.eqmonitor.core.data.network.model.enum.JmaIntensity
import net.yumnumm.eqmonitor.feature.earthquake_history.domain.model.Earthquake

interface EarthquakeHistoryRepository {
    suspend fun getEarthquakeHistory(
        limit: Int = 20,
        offset: Int = 0,
        magnitudeLte: Double? = null,
        magnitudeGte: Double? = null,
        depthLte: Double? = null,
        depthGte: Double? = null,
        intensityLte: JmaIntensity? = null,
        intensityGte: JmaIntensity? = null,
    ): Flow<List<Earthquake>>

    suspend fun refreshEarthquakeHistory()
}
