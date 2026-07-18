package net.yumnumm.assets_util;

import android.content.Context;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.os.Build;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;

/**
 * Copies a platform asset into app-private storage and returns its absolute path.
 *
 * <p>Reuses an existing copy when the marker matches the current app versionCode. Writes via a
 * temporary file then renames atomically to avoid partial files.
 *
 * <p>Note: assets may be compressed in the APK, so {@link android.content.res.AssetManager#openFd}
 * is not used.
 */
public final class AssetsUtil {
  private AssetsUtil() {}

  public static String resolveLocalPath(Context context, String fileName) throws IOException {
    final File outDir = new File(context.getFilesDir(), "map");
    if (!outDir.exists() && !outDir.mkdirs()) {
      throw new IllegalStateException("Failed to create directory: " + outDir.getAbsolutePath());
    }

    final long versionCode = currentVersionCode(context);
    final File outFile = new File(outDir, fileName);
    final File markerFile = new File(outDir, fileName + ".version");
    if (outFile.exists()
        && markerFile.exists()
        && readUtf8(markerFile).trim().equals(Long.toString(versionCode))) {
      return outFile.getAbsolutePath();
    }

    final File tmpFile = new File(outDir, fileName + ".tmp");
    if (tmpFile.exists() && !tmpFile.delete()) {
      throw new IllegalStateException("Failed to delete partial file: " + tmpFile.getAbsolutePath());
    }

    try (InputStream input = context.getAssets().open(fileName);
        FileOutputStream output = new FileOutputStream(tmpFile)) {
      final byte[] buffer = new byte[64 * 1024];
      int read;
      while ((read = input.read(buffer)) != -1) {
        output.write(buffer, 0, read);
      }
      output.getFD().sync();
    }

    if (outFile.exists() && !outFile.delete()) {
      //noinspection ResultOfMethodCallIgnored
      tmpFile.delete();
      throw new IllegalStateException("Failed to replace existing file: " + outFile.getAbsolutePath());
    }

    if (!tmpFile.renameTo(outFile)) {
      try (FileInputStream input = new FileInputStream(tmpFile);
          FileOutputStream output = new FileOutputStream(outFile)) {
        final byte[] buffer = new byte[64 * 1024];
        int read;
        while ((read = input.read(buffer)) != -1) {
          output.write(buffer, 0, read);
        }
        output.getFD().sync();
      }
      //noinspection ResultOfMethodCallIgnored
      tmpFile.delete();
    }

    writeUtf8(markerFile, Long.toString(versionCode));
    return outFile.getAbsolutePath();
  }

  private static long currentVersionCode(Context context) {
    try {
      final PackageInfo packageInfo;
      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
        packageInfo =
            context
                .getPackageManager()
                .getPackageInfo(context.getPackageName(), PackageManager.PackageInfoFlags.of(0));
      } else {
        packageInfo = context.getPackageManager().getPackageInfo(context.getPackageName(), 0);
      }
      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
        return packageInfo.getLongVersionCode();
      }
      //noinspection deprecation
      return packageInfo.versionCode;
    } catch (PackageManager.NameNotFoundException e) {
      throw new IllegalStateException("Failed to read versionCode", e);
    }
  }

  private static String readUtf8(File file) throws IOException {
    try (FileInputStream input = new FileInputStream(file)) {
      return new String(input.readAllBytes(), StandardCharsets.UTF_8);
    }
  }

  private static void writeUtf8(File file, String value) throws IOException {
    try (FileOutputStream output = new FileOutputStream(file)) {
      output.write(value.getBytes(StandardCharsets.UTF_8));
      output.getFD().sync();
    }
  }
}
