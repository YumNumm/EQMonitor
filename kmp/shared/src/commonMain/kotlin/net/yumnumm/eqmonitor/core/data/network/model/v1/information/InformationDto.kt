package net.yumnumm.eqmonitor.core.data.network.model.v1.information

import net.yumnumm.eqmonitor.core.data.network.model.enum.InformationAuthor
import net.yumnumm.eqmonitor.core.data.network.model.enum.InformationLevel

import kotlinx.serialization.Serializable
import kotlinx.serialization.SerialName
import kotlinx.serialization.json.JsonElement

@Serializable
data class InformationDto(
    val id: Int,
    val author: InformationAuthor,
    val body: JsonElement, // Map<String, dynamic> の代わりに JsonElement を使用
    @SerialName("created_at")
    val createdAt: String, // DateTimeを文字列として扱う
    val level: InformationLevel,
    val title: String,
    val type: String,
)
