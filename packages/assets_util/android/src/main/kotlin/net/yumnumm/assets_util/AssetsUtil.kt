package net.yumnumm.assets_util

import android.content.Context
import android.content.pm.PackageManager
import android.os.Build
import com.google.android.play.core.assetpacks.AssetPackManagerFactory
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
   * Resolves the absolute path to the Play Asset Delivery install-time
   * pack [packName]'s root directory.
   *
   * Prefers [AssetPackManagerFactory]'s `AssetPackManager.getPackLocation`,
   * which returns the on-device location of a delivered asset pack. Per
   * Play Core's own documentation
   * (https://developer.android.com/reference/com/google/android/play/core/assetpacks/AssetPackLocation),
   * `AssetPackLocation.assetsPath()`/`path()` return `null` when the pack's
   * storage method is `APK_ASSETS` — i.e. Play fused the install-time
   * pack's contents into the base APK instead of shipping it as a separate
   * split (documented to happen for some device/Play Store combinations
   * even with install-time delivery). "To access assets from packs
   * installed as APKs, use Asset Manager" (same reference page) — but
   * `resolvePackRoot`'s contract (mirrored from the iOS/macOS
   * implementations) must return a real filesystem *directory* path, and
   * `AssetManager` has no such notion for APK-embedded assets. So in the
   * fused case we extract the pack's files out of `context.assets` into
   * `filesDir/<packName>/` once (atomic tmp-then-rename, same pattern as
   * [resolveLocalPath]'s single-file copy, gated by the same
   * `versionCode` marker so it isn't repeated every launch), and return
   * that directory's absolute path.
   *
   * Returns `null` if the pack isn't available through either path yet;
   * callers turn that into `AssetPackNotReadyException`.
   */
  @JvmStatic
  fun resolvePackRoot(
    context: Context,
    packName: String,
  ): String? {
    val assetPackManager = AssetPackManagerFactory.getInstance(context)
    val location = assetPackManager.getPackLocation(packName)
    val assetsPath = location?.assetsPath() ?: location?.path()
    if (assetsPath != null) {
      val dir = File(assetsPath)
      if (dir.exists() && dir.isDirectory) {
        return dir.absolutePath
      }
    }

    // Fallback: pack fused into the base APK (APK_ASSETS). `packName` is
    // where AGP places a fused install-time pack's assets inside the base
    // APK's own `assets/` tree (mirrors the module's
    // `src/main/assets/` root, i.e. `assets/manifest.json` etc. under
    // `assets/<packName>/` is *not* how AGP fuses — assets are merged
    // directly at the base APK's assets root). Probe both layouts for the
    // pack's mandated `manifest.json` before extracting.
    val candidateAssetRoots = listOf(packName, "")
    val assetRoot =
      candidateAssetRoots.firstOrNull { root ->
        val probePath = if (root.isEmpty()) "manifest.json" else "$root/manifest.json"
        try {
          context.assets.open(probePath).close()
          true
        } catch (_: java.io.FileNotFoundException) {
          false
        }
      } ?: return null

    return extractFusedAssetPackToFilesDir(context, packName, assetRoot)
  }

  /**
   * Copies a fused (APK_ASSETS) install-time asset pack out of
   * `context.assets` into `filesDir/<packName>/`, mirroring the relative
   * directory structure, and returns the destination directory's absolute
   * path. Uses the same `versionCode`-marker caching as [resolveLocalPath]
   * so repeat launches don't re-copy tens of megabytes of pack contents.
   */
  private fun extractFusedAssetPackToFilesDir(
    context: Context,
    packName: String,
    assetRoot: String,
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

    copyAssetDirectoryRecursively(context, assetRoot, outDir)
    markerFile.writeText(versionCode.toString())
    return outDir.absolutePath
  }

  /**
   * Recursively copies every file under `context.assets`'s [assetPath]
   * directory (or the assets root, if [assetPath] is empty) into
   * [destDir]. `AssetManager.list(path)` returns a non-empty array for
   * directories and an empty array for files, which is the only way to
   * distinguish the two via this API.
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
        context.assets.open(childAssetPath).use { input ->
          FileOutputStream(destFile).use { output ->
            input.copyTo(output)
            output.fd.sync()
          }
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
