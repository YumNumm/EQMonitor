package net.yumnumm.eqmonitor.core.data.network.model.enum

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
enum class JmaForecastIntensity {
    @SerialName("0")
    ZERO,
    @SerialName("1")
    ONE,
    @SerialName("2")
    TWO,
    @SerialName("3")
    THREE,
    @SerialName("4")
    FOUR,
    @SerialName("5-")
    FIVE_LOWER,
    @SerialName("5+")
    FIVE_UPPER,
    @SerialName("6-")
    SIX_LOWER,
    @SerialName("6+")
    SIX_UPPER,
    @SerialName("7")
    SEVEN,
    @SerialName("不明")
    UNKNOWN;
}
