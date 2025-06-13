package net.yumnumm.eqmonitor.di

import net.yumnumm.eqmonitor.feature.earthquake_history.ui.EarthquakeHistoryViewModel
import org.koin.androidx.viewmodel.dsl.viewModel
import org.koin.dsl.module

val androidModule = module {
    viewModel { EarthquakeHistoryViewModel(get(), get()) }
}
