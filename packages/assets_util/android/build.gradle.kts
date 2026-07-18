group = "net.yumnumm.assets_util"
version = "1.0"

plugins {
    id("com.android.library")
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
}
