import java.util.Base64
import java.util.Properties
import java.io.FileInputStream
import org.gradle.api.file.DirectoryProperty
import org.gradle.api.tasks.OutputDirectory
import org.gradle.api.tasks.Sync

plugins {
    id("com.android.application")
    id("dev.flutter.flutter-gradle-plugin")
}

abstract class StageBundledAssetPackTask : Sync() {
    @get:OutputDirectory
    abstract val outputDirectory: DirectoryProperty

    init {
        into(outputDirectory)
    }
}

val dartDefines = mutableMapOf<String, String>()
if (project.hasProperty("dart-defines")) {
  val defines = project.property("dart-defines") as String
  defines.split(",").forEach { entry ->
    val decoded = String(Base64.getDecoder().decode(entry))
    val pair = decoded.split("=")
    if (pair.size == 2) {
      dartDefines[pair[0]] = pair[1]
    }
  }
}

val keystorePropertiesFile = rootProject.file("key.properties")
val keystoreProperties = Properties()
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

val stageBundledAssetPack = tasks.register<StageBundledAssetPackTask>(
    "stageBundledAssetPack",
) {
    from("../../assets/platform") {
        into("platform")
    }
    outputDirectory.set(layout.buildDirectory.dir("generated/bundledAssetPack"))
}

android {
    namespace = "net.yumnumm.eqmonitor"
    buildToolsVersion = "36.1.0"
    compileSdk = 36
    ndkVersion = "29.0.14206865"

    // AGP 9 では既定で無効。app_name を dart-define から差し替えるために必要
    buildFeatures {
        resValues = true
    }
    compileOptions {
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    sourceSets {
        getByName("main") {
            java.srcDirs("src/main/kotlin")
        }
    }
    defaultConfig {
        applicationId = "net.yumnumm.eqmonitor"
        dartDefines["appIdSuffix"]?.let {
            applicationIdSuffix = it
        }
        minSdk = 29
        targetSdk = 36
        multiDexEnabled = true
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        resValue("string", "app_name", dartDefines["appName"] ?: "EQMonitor")
    }

    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties["keyAlias"] as String?
            keyPassword = keystoreProperties["keyPassword"] as String?
            storeFile = (keystoreProperties["storeFile"] as String?)?.let { file(it) }
            storePassword = keystoreProperties["storePassword"] as String?
        }
    }

    buildTypes {
        getByName("release") {
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro",
            )
            multiDexEnabled = true
            resValue("string", "app_name", "EQMonitor")
        }
        getByName("debug") {
            versionNameSuffix = ".d"
            resValue("string", "app_name", "EQMonitor (Debug)")
        }
    }
}

androidComponents {
    onVariants(selector().all()) { variant ->
        variant.sources.assets?.addGeneratedSourceDirectory(
            stageBundledAssetPack,
            StageBundledAssetPackTask::outputDirectory,
        )
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation("com.google.firebase:firebase-crashlytics:19.4.0")
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.5")
    implementation("androidx.core:core-splashscreen:1.0.1")
    implementation("com.google.android.material:material:1.12.0")
}
