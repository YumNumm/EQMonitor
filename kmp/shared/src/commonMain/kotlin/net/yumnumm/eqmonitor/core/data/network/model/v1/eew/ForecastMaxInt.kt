package net.yumnumm.eqmonitor.core.data.network.model.v1.eew

import net.yumnumm.eqmonitor.core.data.network.model.enum.JmaForecastIntensity
import net.yumnumm.eqmonitor.core.data.network.model.enum.JmaForecastIntensityOver

import kotlinx.serialization.Serializable

@Serializable
data class ForecastMaxInt(
    val from: JmaForecastIntensity,
    val to: JmaForecastIntensityOver,
)
