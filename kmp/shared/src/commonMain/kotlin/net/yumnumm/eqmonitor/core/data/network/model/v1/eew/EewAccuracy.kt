package net.yumnumm.eqmonitor.core.data.network.model.v1.eew

import kotlinx.serialization.Serializable
import kotlinx.serialization.SerialName

@Serializable
data class EewAccuracy(
    val epicenters: List<Int>,
    val depth: Int,
    @SerialName("magnitudeCalculation")
    val magnitudeCalculation: Int,
    @SerialName("numberOfMagnitudeCalculation")
    val numberOfMagnitudeCalculation: Int,
)
