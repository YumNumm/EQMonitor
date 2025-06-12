package net.yumnumm.eqmonitor

import kotlin.random.Random

class Greeting {
    private val platform = getPlatform()

    fun greet(): List<String> = buildList {
        add(if (Random.nextBoolean()) "Hi!" else "こんにちは")
        add("from ${platform.name}!")
    }
}