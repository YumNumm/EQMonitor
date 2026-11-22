package net.yumnumm.eqmonitor

import android.app.Activity
import android.net.Uri
import android.provider.OpenableColumns
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.util.concurrent.ExecutorService
import java.util.concurrent.Executors

class ReplayFileMethodChannel(
    private val activity: Activity,
    messenger: BinaryMessenger,
) : MethodChannel.MethodCallHandler {
    private val channel = MethodChannel(messenger, CHANNEL_NAME)
    private val executor: ExecutorService = Executors.newSingleThreadExecutor()

    init {
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "readContentUri" -> readContentUri(call.argument<String>("uri"), result)
            else -> result.notImplemented()
        }
    }

    fun dispose() {
        channel.setMethodCallHandler(null)
        executor.shutdown()
    }

    private fun readContentUri(uriString: String?, result: MethodChannel.Result) {
        val uri = uriString?.let(Uri::parse)
        if (uri == null || uri.scheme != "content") {
            result.error("invalid_argument", "content uri is required", null)
            return
        }
        // 受け取った Intent の一時的な読み取り権限は Activity に付与されるため、Activity の resolver で読む。
        executor.execute {
            try {
                val resolver = activity.contentResolver
                val bytes = resolver.openInputStream(uri)?.use { it.readBytes() }
                val name = resolver.query(uri, arrayOf(OpenableColumns.DISPLAY_NAME), null, null, null)
                    ?.use { cursor -> if (cursor.moveToFirst()) cursor.getString(0) else null }
                activity.runOnUiThread {
                    if (bytes == null) {
                        result.error("unavailable", "content uri could not be opened", null)
                    } else {
                        result.success(mapOf("bytes" to bytes, "name" to name))
                    }
                }
            } catch (error: Exception) {
                activity.runOnUiThread {
                    result.error("read_failed", error.message, null)
                }
            }
        }
    }

    private companion object {
        const val CHANNEL_NAME = "net.yumnumm.eqmonitor/replay_file"
    }
}
