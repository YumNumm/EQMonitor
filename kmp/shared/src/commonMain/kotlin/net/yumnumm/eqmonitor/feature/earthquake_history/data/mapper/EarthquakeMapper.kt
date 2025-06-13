package net.yumnumm.eqmonitor.feature.earthquake_history.data.mapper

import kotlinx.datetime.LocalDateTime
import kotlinx.datetime.toLocalDateTime
import net.yumnumm.eqmonitor.core.data.network.model.v1.earthquake.EarthquakeDto
import net.yumnumm.eqmonitor.feature.earthquake_history.domain.model.Earthquake

/**
 * EarthquakeDtoからEarthquakeドメインモデルへのマッパー
 */
object EarthquakeMapper {

    fun EarthquakeDto.toDomain(): Earthquake {
        return Earthquake(
            eventId = eventId,
            status = status,
            arrivalTime = arrivalTime?.parseToLocalDateTime(),
            depth = depth,
            epicenterCode = epicenterCode,
            epicenterDetailCode = epicenterDetailCode,
            headline = headline,
            latitude = latitude,
            longitude = longitude,
            magnitude = magnitude,
            magnitudeCondition = magnitudeCondition,
            maxIntensity = maxIntensity,
            maxIntensityRegionIds = maxIntensityRegionIds,
            maxLpgmIntensity = maxLpgmIntensity,
            originTime = originTime?.parseToLocalDateTime(),
            text = text,
        )
    }

    fun List<EarthquakeDto>.toDomain(): List<Earthquake> {
        return map { it.toDomain() }
    }

    /**
     * ISO8601形式の日時文字列をLocalDateTimeに変換
     * 例: "2024-12-01T15:30:00Z" -> LocalDateTime
     */
    private fun String.parseToLocalDateTime(): LocalDateTime? {
        return try {
            // ISO形式の文字列を解析
            when {
                // UTC時刻（Z付き）の場合
                endsWith("Z") -> substring(0, length - 1).toLocalDateTime()
                // タイムゾーン情報なしの場合
                matches(Regex("\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}")) -> toLocalDateTime()
                // その他の形式への対応が必要な場合はここで追加
                else -> null
            }
        } catch (e: Exception) {
            println("Failed to parse datetime: $this, error: ${e.message}")
            null
        }
    }
}
