package net.yumnumm.eqmonitor

import android.app.Application
import net.yumnumm.eqmonitor.core.di.sharedModule
import net.yumnumm.eqmonitor.di.androidModule
import org.koin.android.ext.koin.androidContext
import org.koin.core.context.startKoin

class EQMonitorApplication : Application() {
    override fun onCreate() {
        super.onCreate()

        startKoin {
            androidContext(this@EQMonitorApplication)
            modules(
                sharedModule,
                androidModule
            )
        }
    }
}
