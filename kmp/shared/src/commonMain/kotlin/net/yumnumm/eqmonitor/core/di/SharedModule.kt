package net.yumnumm.eqmonitor.core.di

import io.ktor.client.HttpClient as KtorHttpClient
import io.ktor.client.plugins.contentnegotiation.ContentNegotiation
import io.ktor.serialization.kotlinx.json.json
import kotlinx.serialization.json.Json
import net.yumnumm.eqmonitor.core.data.network.EarthquakeApiService
import net.yumnumm.eqmonitor.feature.earthquake_history.data.repository.EarthquakeHistoryRepositoryImpl
import net.yumnumm.eqmonitor.feature.earthquake_history.domain.repository.EarthquakeHistoryRepository
import net.yumnumm.eqmonitor.feature.earthquake_history.domain.usecase.GetEarthquakeHistoryUseCase
import net.yumnumm.eqmonitor.feature.earthquake_history.domain.usecase.RefreshEarthquakeHistoryUseCase
import org.koin.dsl.module

val sharedModule = module {
    // JSON設定
    single {
        Json {
            ignoreUnknownKeys = true
            coerceInputValues = true
        }
    }

    // HTTP Client
    single {
        KtorHttpClient {
            install(ContentNegotiation) {
                json(get())
            }
        }
    }

    // API Service
    single { EarthquakeApiService(get()) }

    // Repository
    single<EarthquakeHistoryRepository> { EarthquakeHistoryRepositoryImpl(get()) }

    // Use Cases
    single { GetEarthquakeHistoryUseCase(get()) }
    single { RefreshEarthquakeHistoryUseCase(get()) }
}
