package net.yumnumm.eqmonitor.core.data.network.model.v1.shake_detection

import net.yumnumm.eqmonitor.core.data.network.model.enum.JmaForecastIntensity

import kotlinx.serialization.Serializable
import kotlinx.serialization.SerialName

@Serializable
data class ShakeDetectionEventDto(
    val id: Int? = -1,
    val eventId: String,
    val serialNo: Int,
    val createdAt: String, // DateTimeを文字列として扱う
    val insertedAt: String, // DateTimeを文字列として扱う
    val maxIntensity: JmaForecastIntensity,
    val regions: List<ShakeDetectionRegion>,
    val topLeft: ShakeDetectionLatLng,
    val bottomRight: ShakeDetectionLatLng,
    val pointCount: Int,
)
