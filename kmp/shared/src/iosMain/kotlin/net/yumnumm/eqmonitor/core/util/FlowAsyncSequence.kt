package net.yumnumm.eqmonitor.core.util

import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.FlowCollector

class FlowAsyncSequence<T>(private val flow: Flow<T>) {
    suspend fun collect(collector: FlowCollector<T>) {
        flow.collect(collector)
    }
}

fun <T> Flow<T>.asAsyncSequence(): FlowAsyncSequence<T> = FlowAsyncSequence(this)
