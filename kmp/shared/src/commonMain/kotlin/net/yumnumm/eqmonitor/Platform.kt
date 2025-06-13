package net.yumnumm.eqmonitor

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform
