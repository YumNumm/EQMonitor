package net.yumnumm.eqmonitor.core.data.network.model.v1.eew

import net.yumnumm.eqmonitor.core.data.network.model.enum.JmaForecastIntensity
import net.yumnumm.eqmonitor.core.data.network.model.enum.JmaForecastLgIntensity

import kotlinx.serialization.Serializable
import kotlinx.serialization.SerialName

@Serializable
data class EstimatedIntensityRegion(
    val code: String,
    val name: String,
    @SerialName("isPlum")
    val isPlum: Boolean,
    @SerialName("isWarning")
    val isWarning: Boolean,
    @SerialName("forecastMaxInt")
    val forecastMaxInt: ForecastMaxInt,
    @SerialName("forecastMaxLgInt")
    val forecastMaxLgInt: ForecastMaxLgInt?,
    val arrivalTime: String?, // DateTimeを文字列として扱う
)
