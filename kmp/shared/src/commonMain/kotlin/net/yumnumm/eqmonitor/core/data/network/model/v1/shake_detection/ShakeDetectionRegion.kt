package net.yumnumm.eqmonitor.core.data.network.model.v1.shake_detection

import net.yumnumm.eqmonitor.core.data.network.model.enum.JmaForecastIntensity

import kotlinx.serialization.Serializable
import kotlinx.serialization.SerialName

@Serializable
data class ShakeDetectionRegion(
    val name: String,
    @SerialName("maxIntensity")
    val maxIntensity: JmaForecastIntensity,
    val points: List<ShakeDetectionPoint>,
)
