package net.yumnumm.eqmonitor.core.data.network.model.enum

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
enum class JmaLgIntensity {
    @SerialName("0")
    ZERO,
    @SerialName("1")
    ONE,
    @SerialName("2")
    TWO,
    @SerialName("3")
    THREE,
    @SerialName("4")
    FOUR;
}
