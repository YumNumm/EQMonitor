package net.yumnumm.eqmonitor.feature.earthquake_history.domain.model

import kotlinx.datetime.LocalDateTime
import net.yumnumm.eqmonitor.core.data.network.model.enum.JmaIntensity
import net.yumnumm.eqmonitor.core.data.network.model.enum.JmaLgIntensity

data class Earthquake(
    val eventId: Int,
    val status: String,
    val arrivalTime: LocalDateTime? = null,
    val depth: Int? = null,
    val epicenterCode: Int? = null,
    val epicenterDetailCode: Int? = null,
    val headline: String? = null,
    val latitude: Double? = null,
    val longitude: Double? = null,
    val magnitude: Double? = null,
    val magnitudeCondition: String? = null,
    val maxIntensity: JmaIntensity? = null,
    val maxIntensityRegionIds: List<Int>? = null,
    val maxLpgmIntensity: JmaLgIntensity? = null,
    val originTime: LocalDateTime? = null,
    val text: String? = null,
) {
    val displayTitle: String
        get() = headline ?: text ?: "地震情報"

    val displayLocation: String
        get() = when {
            latitude != null && longitude != null -> "北緯${latitude}° 東経${longitude}°"
            text?.contains("震源地") == true -> text.substringAfter("震源地").substringBefore("震源の深さ").trim()
            else -> "震源地不明"
        }

    val displayMagnitude: String
        get() = when {
            magnitude != null -> "M${magnitude}"
            magnitudeCondition != null -> magnitudeCondition
            else -> "M不明"
        }

    val displayDepth: String
        get() = when {
            depth != null -> "${depth}km"
            else -> "深さ不明"
        }

    val displayMaxIntensity: String
        get() = when (maxIntensity) {
            JmaIntensity.ONE -> "震度1"
            JmaIntensity.TWO -> "震度2"
            JmaIntensity.THREE -> "震度3"
            JmaIntensity.FOUR -> "震度4"
            JmaIntensity.FIVE_LOWER -> "震度5弱"
            JmaIntensity.FIVE_UPPER -> "震度5強"
            JmaIntensity.SIX_LOWER -> "震度6弱"
            JmaIntensity.SIX_UPPER -> "震度6強"
            JmaIntensity.SEVEN -> "震度7"
            JmaIntensity.FIVE_UPPER_NO_INPUT -> "震度5弱以上未入電"
            null -> "震度不明"
        }
}
