package net.yumnumm.eqmonitor.core.di

import net.yumnumm.eqmonitor.feature.earthquake_history.domain.usecase.GetEarthquakeHistoryUseCase
import net.yumnumm.eqmonitor.feature.earthquake_history.domain.usecase.RefreshEarthquakeHistoryUseCase
import org.koin.core.component.KoinComponent
import org.koin.core.component.inject

/**
 * iOS用のDIヘルパークラス
 * KoinComponentを使用してSwiftから簡単に依存関係を取得できる
 */
class DIHelper : KoinComponent {

    private val getEarthquakeHistoryUseCase: GetEarthquakeHistoryUseCase by inject()
    private val refreshEarthquakeHistoryUseCase: RefreshEarthquakeHistoryUseCase by inject()

    fun getEarthquakeHistoryUseCase(): GetEarthquakeHistoryUseCase = getEarthquakeHistoryUseCase

    fun refreshEarthquakeHistoryUseCase(): RefreshEarthquakeHistoryUseCase = refreshEarthquakeHistoryUseCase
}
