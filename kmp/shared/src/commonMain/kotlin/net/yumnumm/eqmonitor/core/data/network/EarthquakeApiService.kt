package net.yumnumm.eqmonitor.core.data.network

import io.ktor.client.HttpClient as KtorHttpClient
import io.ktor.client.call.body
import io.ktor.client.request.get
import io.ktor.client.request.parameter
import net.yumnumm.eqmonitor.core.data.network.model.v1.earthquake.EarthquakeDetailDto
import net.yumnumm.eqmonitor.core.data.network.model.v1.earthquake.EarthquakeDto
import net.yumnumm.eqmonitor.core.data.network.model.v1.earthquake_early.EarthquakeEarlyDto
import net.yumnumm.eqmonitor.core.data.network.model.v1.eew.EewDto
import net.yumnumm.eqmonitor.core.data.network.model.v1.information.InformationDto
import net.yumnumm.eqmonitor.core.data.network.model.enum.JmaIntensity
import net.yumnumm.eqmonitor.core.data.network.model.v1.common.RegionItemDto
import net.yumnumm.eqmonitor.core.data.network.model.v1.shake_detection.ShakeDetectionEventDto

class EarthquakeApiService(private val httpClient: KtorHttpClient) {
    suspend fun getEarthquakes(
        limit: Int = 10,
        offset: Int = 0,
        magnitudeLte: Double? = null,
        magnitudeGte: Double? = null,
        depthLte: Double? = null,
        depthGte: Double? = null,
        intensityLte: JmaIntensity? = null,
        intensityGte: JmaIntensity? = null,
    ): List<EarthquakeDto> {
        return httpClient.get("/v1/earthquake/list") {
            parameter("limit", limit)
            parameter("offset", offset)
            magnitudeLte?.let { parameter("magnitudeLte", it) }
            magnitudeGte?.let { parameter("magnitudeGte", it) }
            depthLte?.let { parameter("depthLte", it) }
            depthGte?.let { parameter("depthGte", it) }
            intensityLte?.let { parameter("intensityLte", it.name) }
            intensityGte?.let { parameter("intensityGte", it.name) }
        }.body()
    }

    suspend fun getEarthquakeDetail(eventId: String): EarthquakeDetailDto {
        return httpClient.get("/v1/earthquake/detail/$eventId").body()
    }

    suspend fun getEarthquakeRegions(
        regionCode: String,
        limit: Int = 10,
        offset: Int = 0,
        intensityLte: JmaIntensity? = null,
        intensityGte: JmaIntensity? = null,
    ): List<RegionItemDto> {
        return httpClient.get("/v1/earthquake/region") {
            parameter("regionCode", regionCode)
            parameter("limit", limit)
            parameter("offset", offset)
            intensityLte?.let { parameter("intensityLte", it.name) }
            intensityGte?.let { parameter("intensityGte", it.name) }
        }.body()
    }

    suspend fun getInformations(
        limit: Int = 10,
        offset: Int = 0,
    ): List<InformationDto> {
        return httpClient.get("/v1/information") {
            parameter("limit", limit)
            parameter("offset", offset)
        }.body()
    }

    suspend fun getEew(
        limit: Int = 10,
        offset: Int = 0,
    ): List<EewDto> {
        return httpClient.get("/v1/eew") {
            parameter("limit", limit)
            parameter("offset", offset)
        }.body()
    }

    suspend fun getEewLatest(): List<EewDto> {
        return httpClient.get("/v1/eew/latest").body()
    }

    suspend fun getEewByEventId(eventId: String): List<EewDto> {
        return httpClient.get("/v1/eew/search") {
            parameter("eventId", eventId)
        }.body()
    }

    suspend fun getEarthquakeEarlies(
        limit: Int = 10,
        offset: Int = 0,
        magnitudeLte: Double? = null,
        magnitudeGte: Double? = null,
        depthLte: Double? = null,
        depthGte: Double? = null,
        intensityLte: JmaIntensity? = null,
        intensityGte: JmaIntensity? = null,
        originTimeLte: String? = null, // DateTimeを文字列として扱う
        originTimeGte: String? = null, // DateTimeを文字列として扱う
        sort: String = "origin_time", // EarthquakeEarlySortTypeを文字列として扱う
        ascending: Boolean = false,
    ): List<EarthquakeEarlyDto> {
        return httpClient.get("/v1/earthquake-early/list") {
            parameter("limit", limit)
            parameter("offset", offset)
            magnitudeLte?.let { parameter("magnitudeLte", it) }
            magnitudeGte?.let { parameter("magnitudeGte", it) }
            depthLte?.let { parameter("depthLte", it) }
            depthGte?.let { parameter("depthGte", it) }
            intensityLte?.let { parameter("intensityLte", it.name) }
            intensityGte?.let { parameter("intensityGte", it.name) }
            originTimeLte?.let { parameter("originTimeLte", it) }
            originTimeGte?.let { parameter("originTimeGte", it) }
            parameter("sort", sort)
            parameter("ascending", ascending)
        }.body()
    }

    suspend fun getLatestShakeDetectionEvents(): List<ShakeDetectionEventDto> {
        return httpClient.get("/v1/shake-detection/latest").body()
    }
}
