import com.android.build.api.dsl.LibraryExtension

group = "net.yumnumm.background_location_tracker"
version = "1.0"

plugins {
    id("com.android.library")
    id("kotlin-android")
}

extensions.configure<LibraryExtension> {
    namespace = "net.yumnumm.background_location_tracker"
    compileSdk = 35

    defaultConfig {
        minSdk = 21
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

dependencies {
    implementation("com.google.android.gms:play-services-location:21.0.1")
}
