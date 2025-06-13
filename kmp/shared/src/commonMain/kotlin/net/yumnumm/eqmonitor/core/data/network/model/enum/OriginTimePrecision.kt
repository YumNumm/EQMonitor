package net.yumnumm.eqmonitor.core.data.network.model.enum

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
enum class OriginTimePrecision {
    @SerialName("month")
    MONTH,
    @SerialName("day")
    DAY,
    @SerialName("hour")
    HOUR,
    @SerialName("minute")
    MINUTE,
    @SerialName("second")
    SECOND,
    @SerialName("millisecond")
    MILLISECOND;
}
