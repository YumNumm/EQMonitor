group = "net.yumnumm.assets_util"
version = "1.0"

plugins {
    id("com.android.library")
    id("kotlin-android")
}

android {
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

    kotlinOptions {
        jvmTarget = "17"
    }

    sourceSets {
        getByName("main").java.srcDirs("src/main/kotlin")
    }
}

dependencies {
    // Play Asset Delivery: AssetPackManager / AssetPackLocation for
    // resolving the eqmonitor_assets install-time pack's on-device
    // location (resolvePackRoot). Version 2.3.0 confirmed as the latest
    // available via https://dl.google.com/android/maven2/com/google/android/play/group-index.xml.
    implementation("com.google.android.play:asset-delivery-ktx:2.3.0")
}
