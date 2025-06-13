package net.yumnumm.eqmonitor.core.data.network.model.v1.shake_detection

import net.yumnumm.eqmonitor.core.data.network.model.enum.JmaForecastIntensity

import kotlinx.serialization.Serializable

@Serializable
data class ShakeDetectionPoint(
    val intensity: JmaForecastIntensity,
    val code: String,
)
