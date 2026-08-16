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

  /**
   * Extracts the immutable Asset Pack bundled under `assets/[packName]` to a
   * filesystem directory. Map readers require regular file paths and cannot
   * read directly from Android's AssetManager.
   */
  @JvmStatic
  fun resolvePackRoot(
    context: Context,
    packName: String,
  ): String? {
    if (!Regex("^[A-Za-z0-9_-]+$").matches(packName)) {
      return null
    }
    val manifestPath = "$packName/manifest.json"
    try {
      context.assets.open(manifestPath).close()
    } catch (_: java.io.FileNotFoundException) {
      return null
    }
    return extractBundledAssetPackToFilesDir(context, packName)
  }

  /**
   * Copies the immutable app-bundled pack from AssetManager into
   * `filesDir/<packName>/`. Map readers need regular filesystem paths.
   */
  private fun extractBundledAssetPackToFilesDir(
    context: Context,
    packName: String,
  ): String? {
    val outDir = File(context.filesDir, packName)
    val versionCode = currentVersionCode(context)
    val markerFile = File(outDir, ".version")
    if (
      outDir.exists() &&
      markerFile.exists() &&
      markerFile.readText().trim() == versionCode.toString()
    ) {
      return outDir.absolutePath
    }

    if (!outDir.exists() && !outDir.mkdirs()) {
      throw IllegalStateException("Failed to create directory: ${outDir.absolutePath}")
    }

    copyAssetDirectoryRecursively(context, packName, outDir)
    markerFile.writeText(versionCode.toString())
    return outDir.absolutePath
  }

  /**
   * Recursively copies every file under `context.assets`'s [assetPath]
   * directory (or the assets root, if [assetPath] is empty) into
   * [destDir]. `AssetManager.list(path)` returns a non-empty array for
   * directories and an empty array for files, which is the only way to
   * distinguish the two via this API.
   *
   * Each file is written via a `.tmp` sibling + atomic rename (same
   * pattern as [resolveLocalPath]'s single-file copy), so a
   * process-death mid-copy can never leave a truncated file at the final
   * path — only an orphaned `.tmp` that a retried extraction overwrites.
   */
  private fun copyAssetDirectoryRecursively(
    context: Context,
    assetPath: String,
    destDir: File,
  ) {
    val entries = context.assets.list(assetPath) ?: return
    for (entry in entries) {
      val childAssetPath = if (assetPath.isEmpty()) entry else "$assetPath/$entry"
      val childEntries = context.assets.list(childAssetPath)
      if (!childEntries.isNullOrEmpty()) {
        val childDestDir = File(destDir, entry)
        if (!childDestDir.exists() && !childDestDir.mkdirs()) {
          throw IllegalStateException("Failed to create directory: ${childDestDir.absolutePath}")
        }
        copyAssetDirectoryRecursively(context, childAssetPath, childDestDir)
      } else {
        val destFile = File(destDir, entry)
        val tmpFile = File(destDir, "$entry.tmp")
        if (tmpFile.exists() && !tmpFile.delete()) {
          throw IllegalStateException("Failed to delete partial file: ${tmpFile.absolutePath}")
        }
        context.assets.open(childAssetPath).use { input ->
          FileOutputStream(tmpFile).use { output ->
            input.copyTo(output)
            output.fd.sync()
          }
        }
        if (destFile.exists() && !destFile.delete()) {
          tmpFile.delete()
          throw IllegalStateException("Failed to replace existing file: ${destFile.absolutePath}")
        }
        if (!tmpFile.renameTo(destFile)) {
          FileInputStream(tmpFile).use { input ->
            FileOutputStream(destFile).use { output ->
              input.copyTo(output)
              output.fd.sync()
            }
          }
          tmpFile.delete()
        }
      }
    }
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
