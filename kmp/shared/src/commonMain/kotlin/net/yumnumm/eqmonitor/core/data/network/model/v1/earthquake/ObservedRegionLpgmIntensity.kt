package net.yumnumm.eqmonitor.core.data.network.model.v1.earthquake

import net.yumnumm.eqmonitor.core.data.network.model.enum.JmaIntensity
import net.yumnumm.eqmonitor.core.data.network.model.enum.JmaLgIntensity

import kotlinx.serialization.Serializable
import kotlinx.serialization.SerialName

@Serializable
data class ObservedRegionLpgmIntensity(
    val code: String,
    val name: String,
    @SerialName("maxInt")
    val intensity: JmaIntensity?,
    @SerialName("maxLgInt")
    val lpgmIntensity: JmaLgIntensity?
)
