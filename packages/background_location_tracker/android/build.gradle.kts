group = "net.yumnumm.background_location_tracker"
version = "1.0"

plugins {
    id("com.android.library")
    id("kotlin-android")
}

android {
    namespace = "net.yumnumm.background_location_tracker"
    compileSdk = 35

    defaultConfig {
        minSdk = 21
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }
}

dependencies {
    implementation("com.google.android.gms:play-services-location:21.3.0")
}
