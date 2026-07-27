plugins {
    id("com.android.asset-pack")
}

assetPack {
    packName.set("eqmonitor_assets")
    dynamicDelivery {
        deliveryType.set("install-time")
    }
}
