package net.yumnumm.eqmonitor.core.data.network.model.v1.eew

import net.yumnumm.eqmonitor.core.data.network.model.enum.JmaForecastLgIntensity
import net.yumnumm.eqmonitor.core.data.network.model.enum.JmaForecastLgIntensityOver

import kotlinx.serialization.Serializable

@Serializable
data class ForecastMaxLgInt(
    val from: JmaForecastLgIntensity,
    val to: JmaForecastLgIntensityOver,
)
