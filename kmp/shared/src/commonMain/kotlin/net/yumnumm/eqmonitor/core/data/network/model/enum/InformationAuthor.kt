package net.yumnumm.eqmonitor.core.data.network.model.enum

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
enum class InformationAuthor {
    @SerialName("jma")
    JMA,
    @SerialName("developer")
    DEVELOPER,
    @SerialName("unknown")
    UNKNOWN;
}
