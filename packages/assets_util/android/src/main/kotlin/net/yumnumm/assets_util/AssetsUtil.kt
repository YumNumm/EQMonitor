package net.yumnumm.assets_util

import android.content.Context
import android.content.pm.PackageManager
import android.os.Build
import java.io.File
import java.io.FileInputStream
import java.io.FileOutputStream

object AssetsUtil {
  @JvmStatic
  fun resolveLocalPath(
    context: Context,
    fileName: String,
  ): String {
    val outDir = File(context.filesDir, "map")
    if (!outDir.exists() && !outDir.mkdirs()) {
      throw IllegalStateException("Failed to create directory: ${outDir.absolutePath}")
    }

    val versionCode = currentVersionCode(context)
    val outFile = File(outDir, fileName)
    val markerFile = File(outDir, "$fileName.version")
    if (
      outFile.exists() &&
      markerFile.exists() &&
      markerFile.readText().trim() == versionCode.toString()
    ) {
      return outFile.absolutePath
    }

    val tmpFile = File(outDir, "$fileName.tmp")
    if (tmpFile.exists() && !tmpFile.delete()) {
      throw IllegalStateException("Failed to delete partial file: ${tmpFile.absolutePath}")
    }

    context.assets.open(fileName).use { input ->
      FileOutputStream(tmpFile).use { output ->
        input.copyTo(output)
        output.fd.sync()
      }
    }

    if (outFile.exists() && !outFile.delete()) {
      tmpFile.delete()
      throw IllegalStateException("Failed to replace existing file: ${outFile.absolutePath}")
    }

    if (!tmpFile.renameTo(outFile)) {
      FileInputStream(tmpFile).use { input ->
        FileOutputStream(outFile).use { output ->
          input.copyTo(output)
          output.fd.sync()
        }
      }
      tmpFile.delete()
    }

    markerFile.writeText(versionCode.toString())
    return outFile.absolutePath
  }

  private fun currentVersionCode(context: Context): Long {
    val packageInfo =
      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
        context.packageManager.getPackageInfo(
          context.packageName,
          PackageManager.PackageInfoFlags.of(0),
        )
      } else {
        @Suppress("DEPRECATION")
        context.packageManager.getPackageInfo(context.packageName, 0)
      }
    return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
      packageInfo.longVersionCode
    } else {
      @Suppress("DEPRECATION")
      packageInfo.versionCode.toLong()
    }
  }
}
