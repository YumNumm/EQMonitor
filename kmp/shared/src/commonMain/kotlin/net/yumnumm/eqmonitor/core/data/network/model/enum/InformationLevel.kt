package net.yumnumm.eqmonitor.core.data.network.model.enum

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
enum class InformationLevel {
    @SerialName("info")
    INFO,
    @SerialName("warning")
    WARNING,
    @SerialName("critical")
    CRITICAL;
}
