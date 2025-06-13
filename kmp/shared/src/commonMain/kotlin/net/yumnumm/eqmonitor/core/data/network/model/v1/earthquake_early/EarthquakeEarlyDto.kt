package net.yumnumm.eqmonitor.core.data.network.model.v1.earthquake_early

import net.yumnumm.eqmonitor.core.data.network.model.enum.JmaForecastIntensity
import net.yumnumm.eqmonitor.core.data.network.model.enum.OriginTimePrecision

import kotlinx.serialization.Serializable
import kotlinx.serialization.SerialName

@Serializable
data class EarthquakeEarlyDto(
    val id: String,
    val depth: Int? = null,
    val latitude: Double? = null,
    val longitude: Double? = null,
    val magnitude: Double? = null,
    val maxIntensity: JmaForecastIntensity? = null,
    val maxIntensityIsEarly: Boolean,
    val name: String,
    val originTime: String, // DateTimeを文字列として扱う
    val originTimePrecision: OriginTimePrecision,
)
