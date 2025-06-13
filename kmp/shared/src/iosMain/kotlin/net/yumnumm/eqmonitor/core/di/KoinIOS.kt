package net.yumnumm.eqmonitor.core.di

import org.koin.core.context.startKoin
import org.koin.dsl.KoinAppDeclaration

fun doInitKoinIOS(appDeclaration: KoinAppDeclaration = {}) = startKoin {
    appDeclaration()
    modules(sharedModule, iosModule)
}
