package net.yumnumm.eqmonitor

import androidx.compose.material3.MaterialTheme
import androidx.compose.runtime.Composable
import androidx.compose.ui.tooling.preview.Preview
import net.yumnumm.eqmonitor.feature.earthquake_history.ui.EarthquakeHistoryScreen

@Composable
@Preview
fun App() {
    MaterialTheme {
        EarthquakeHistoryScreen()
    }
}
