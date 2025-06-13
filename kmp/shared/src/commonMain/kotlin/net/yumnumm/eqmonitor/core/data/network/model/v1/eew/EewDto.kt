package net.yumnumm.eqmonitor.core.data.network.model.v1.eew

import net.yumnumm.eqmonitor.core.data.network.model.enum.JmaForecastIntensity
import net.yumnumm.eqmonitor.core.data.network.model.enum.JmaForecastLgIntensity

import kotlinx.serialization.Serializable
import kotlinx.serialization.SerialName

@Serializable
data class EewDto(
    val id: Int,
    val eventId: Int,
    val type: String,
    val schemaType: String,
    val status: String,
    val infoType: String,
    val reportTime: String, // DateTimeを文字列として扱う
    val isCanceled: Boolean,
    val isLastInfo: Boolean,
    val isPlum: Boolean? = null,
    val accuracy: EewAccuracy? = null,
    val serialNo: Int? = null,
    val headline: String? = null,
    val isWarning: Boolean? = null,
    val originTime: String? = null, // DateTimeを文字列として扱う
    val arrivalTime: String? = null, // DateTimeを文字列として扱う
    val hypoName: String? = null,
    val depth: Int? = null,
    val latitude: Double? = null,
    val longitude: Double? = null,
    val magnitude: Double? = null,
    val forecastMaxIntensity: JmaForecastIntensity? = null,
    val forecastMaxIntensityIsOver: Boolean? = null,
    val forecastMaxLpgmIntensity: JmaForecastLgIntensity? = null,
    val forecastMaxLpgmIntensityIsOver: Boolean? = null,
    val regions: List<EstimatedIntensityRegion>? = null,
)
