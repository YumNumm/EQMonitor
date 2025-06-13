package net.yumnumm.eqmonitor.core.data.network.model.v1.common

import net.yumnumm.eqmonitor.core.data.network.model.enum.JmaIntensity
import net.yumnumm.eqmonitor.core.data.network.model.enum.JmaLgIntensity
import net.yumnumm.eqmonitor.core.data.network.model.v1.earthquake.EarthquakeDto

import kotlinx.serialization.Serializable
import kotlinx.serialization.SerialName

@Serializable
data class RegionItemDto(
    val id: Int,
    val eventId: Int,
    val areaCode: String,
    val maxIntensity: JmaIntensity,
    val maxLpgmIntensity: JmaLgIntensity?,
    val earthquake: EarthquakeDto,
)
