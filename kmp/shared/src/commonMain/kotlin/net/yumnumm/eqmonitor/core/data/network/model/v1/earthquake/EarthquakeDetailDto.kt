package net.yumnumm.eqmonitor.core.data.network.model.v1.earthquake

import net.yumnumm.eqmonitor.core.data.network.model.enum.JmaIntensity
import net.yumnumm.eqmonitor.core.data.network.model.enum.JmaLgIntensity
import net.yumnumm.eqmonitor.core.data.network.model.v1.eew.ForecastMaxInt
import net.yumnumm.eqmonitor.core.data.network.model.v1.eew.ForecastMaxLgInt

import kotlinx.serialization.Serializable
import kotlinx.serialization.SerialName

@Serializable
data class EarthquakeDetailDto(
    @SerialName("eventId")
    val eventId: Int,
    val status: String,
    val arrivalTime: String? = null, // DateTimeを文字列として扱う
    val depth: Int? = null,
    val epicenterCode: Int? = null,
    val epicenterDetailCode: Int? = null,
    val headline: String? = null,
    val intensityCities: List<ObservedRegionIntensity>? = null,
    val intensityPrefectures: List<ObservedRegionIntensity>? = null,
    val intensityRegions: List<ObservedRegionIntensity>? = null,
    val intensityStations: List<ObservedRegionIntensity>? = null,
    val latitude: Double? = null,
    val longitude: Double? = null,
    val lpgmIntensityPrefectures: List<ObservedRegionLpgmIntensity>? = null,
    val lpgmIntensityRegions: List<ObservedRegionLpgmIntensity>? = null,
    val lpgmIntenstiyStations: List<ObservedRegionLpgmIntensity>? = null,
    val magnitude: Double? = null,
    val magnitudeCondition: String? = null,
    val maxIntensity: JmaIntensity? = null,
    val maxIntensityRegionIds: List<Int>? = null,
    val maxLpgmIntensity: JmaLgIntensity? = null,
    val originTime: String? = null, // DateTimeを文字列として扱う
    val text: String? = null,
)
