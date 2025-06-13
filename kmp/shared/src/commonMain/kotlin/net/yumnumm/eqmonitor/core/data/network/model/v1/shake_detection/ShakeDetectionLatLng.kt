package net.yumnumm.eqmonitor.core.data.network.model.v1.shake_detection

import kotlinx.serialization.Serializable

@Serializable
data class ShakeDetectionLatLng(
    val latitude: Double,
    val longitude: Double,
)
