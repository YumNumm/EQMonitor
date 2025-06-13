package net.yumnumm.eqmonitor.core.data.network.model.v1.earthquake

import net.yumnumm.eqmonitor.core.data.network.model.enum.JmaIntensity

import kotlinx.serialization.Serializable
import kotlinx.serialization.SerialName

@Serializable
data class ObservedRegionIntensity(
    val code: String,
    val name: String,
    @SerialName("maxInt")
    val intensity: JmaIntensity?
)
