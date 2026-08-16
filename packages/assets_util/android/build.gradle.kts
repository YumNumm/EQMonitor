import com.android.build.api.dsl.LibraryExtension
import org.jetbrains.kotlin.gradle.dsl.JvmTarget

group = "net.yumnumm.assets_util"
version = "1.0"

plugins {
    id("com.android.library")
    id("kotlin-android")
}

extensions.configure<LibraryExtension>("android") {
    namespace = "net.yumnumm.assets_util"
    compileSdk = 36

    defaultConfig {
        minSdk = 29
        consumerProguardFiles("consumer-rules.pro")
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }
}

kotlin {
    compilerOptions {
        jvmTarget = JvmTarget.JVM_17
    }
}
