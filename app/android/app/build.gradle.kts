import java.util.Base64
import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
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

tasks.register<Copy>("copySources") {
    from("src/${dartDefines["flavor"]}/res")
    into("src/main/res")
}

tasks.whenTaskAdded {
    dependsOn("copySources")
}

val keystorePropertiesFile = rootProject.file("key.properties")
val keystoreProperties = Properties()
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

android {
    namespace = "net.yumnumm.eqmonitor"
    buildToolsVersion = "36.1.0"
    compileSdk = 36
    ndkVersion = "28.2.13676358"

    compileOptions {
        // flutter_local_notificationsで利用
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    sourceSets {
        getByName("main").java.srcDirs("src/main/kotlin")
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
            multiDexEnabled = true
            resValue("string", "app_name", "EQMonitor")
        }
        getByName("debug") {
            versionNameSuffix = ".d"
            resValue("string", "app_name", "EQMonitor (Debug)")
        }
    }
    buildFeatures {
        viewBinding = true
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation("com.google.firebase:firebase-crashlytics:19.4.0")
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
    implementation("androidx.core:core-splashscreen:1.0.1")
}
