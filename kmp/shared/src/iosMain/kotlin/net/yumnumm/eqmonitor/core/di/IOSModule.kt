package net.yumnumm.eqmonitor.core.di

import net.yumnumm.eqmonitor.feature.earthquake_history.domain.usecase.IOSGetEarthquakeHistoryUseCase
import org.koin.dsl.module

val iosModule = module {
    // iOS専用UseCase
    single { IOSGetEarthquakeHistoryUseCase(get()) }
}
