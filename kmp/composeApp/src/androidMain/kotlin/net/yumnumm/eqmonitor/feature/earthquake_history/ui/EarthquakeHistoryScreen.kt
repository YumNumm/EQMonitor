package net.yumnumm.eqmonitor.feature.earthquake_history.ui

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import kotlinx.datetime.LocalDateTime
import kotlinx.datetime.format
import kotlinx.datetime.format.char
import net.yumnumm.eqmonitor.core.data.network.model.enum.JmaIntensity
import net.yumnumm.eqmonitor.feature.earthquake_history.domain.model.Earthquake
import org.koin.androidx.compose.koinViewModel

/**
 * 地震履歴画面 (Android)
 */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun EarthquakeHistoryScreen(
    viewModel: EarthquakeHistoryViewModel = koinViewModel()
) {
    val uiState by viewModel.uiState.collectAsStateWithLifecycle()

    val pullRefreshState = rememberPullToRefreshState(
        isRefreshing = uiState.isRefreshing
    )

    if (pullRefreshState.isRefreshing) {
        LaunchedEffect(true) {
            viewModel.refreshEarthquakeHistory()
        }
    }

    Column(
        modifier = Modifier.fillMaxSize()
    ) {
        // タイトル
        TopAppBar(
            title = {
                Text(
                    text = "地震履歴",
                    style = MaterialTheme.typography.headlineSmall
                )
            }
        )

        Box(
            modifier = Modifier
                .fillMaxSize()
                .pullToRefresh(
                    state = pullRefreshState,
                    isRefreshing = uiState.isRefreshing,
                    onRefresh = { viewModel.refreshEarthquakeHistory() }
                )
        ) {
            when {
                uiState.isLoading -> {
                    LoadingIndicator()
                }
                uiState.hasError -> {
                    ErrorMessage(
                        message = uiState.errorMessage ?: "エラーが発生しました",
                        onRetry = { viewModel.loadEarthquakeHistory() }
                    )
                }
                uiState.earthquakes.isEmpty() -> {
                    EmptyState()
                }
                else -> {
                    EarthquakeList(earthquakes = uiState.earthquakes)
                }
            }

            PullToRefreshContainer(
                state = pullRefreshState,
                modifier = Modifier.align(Alignment.TopCenter)
            )
        }
    }
}

@Composable
private fun LoadingIndicator() {
    Box(
        modifier = Modifier.fillMaxSize(),
        contentAlignment = Alignment.Center
    ) {
        CircularProgressIndicator()
    }
}

@Composable
private fun ErrorMessage(
    message: String,
    onRetry: () -> Unit
) {
    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center
    ) {
        Text(
            text = message,
            style = MaterialTheme.typography.bodyLarge,
            color = MaterialTheme.colorScheme.error
        )
        Spacer(modifier = Modifier.height(16.dp))
        Button(onClick = onRetry) {
            Text("再試行")
        }
    }
}

@Composable
private fun EmptyState() {
    Box(
        modifier = Modifier.fillMaxSize(),
        contentAlignment = Alignment.Center
    ) {
        Text(
            text = "地震データがありません",
            style = MaterialTheme.typography.bodyLarge,
            color = MaterialTheme.colorScheme.onSurfaceVariant
        )
    }
}

@Composable
private fun EarthquakeList(earthquakes: List<Earthquake>) {
    LazyColumn(
        modifier = Modifier.fillMaxSize(),
        contentPadding = PaddingValues(16.dp),
        verticalArrangement = Arrangement.spacedBy(8.dp)
    ) {
        items(earthquakes) { earthquake ->
            EarthquakeItem(earthquake = earthquake)
        }
    }
}

@Composable
private fun EarthquakeItem(earthquake: Earthquake) {
    Card(
        modifier = Modifier.fillMaxWidth(),
        elevation = CardDefaults.cardElevation(defaultElevation = 2.dp)
    ) {
        Column(
            modifier = Modifier.padding(16.dp)
        ) {
            // 地震情報のヘッダー
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                Text(
                    text = earthquake.displayTitle,
                    style = MaterialTheme.typography.titleMedium,
                    fontWeight = FontWeight.Bold,
                    maxLines = 1,
                    overflow = TextOverflow.Ellipsis,
                    modifier = Modifier.weight(1f)
                )

                // 震度表示
                if (earthquake.maxIntensity != null) {
                    IntensityBadge(intensity = earthquake.maxIntensity)
                }
            }

            Spacer(modifier = Modifier.height(8.dp))

            // 発生時刻
            earthquake.originTime?.let { originTime ->
                Text(
                    text = "発生時刻: ${formatDateTime(originTime)}",
                    style = MaterialTheme.typography.bodyMedium,
                    color = MaterialTheme.colorScheme.onSurfaceVariant
                )
            }

            Spacer(modifier = Modifier.height(4.dp))

            // 震源地
            Text(
                text = "震源地: ${earthquake.displayLocation}",
                style = MaterialTheme.typography.bodyMedium,
                color = MaterialTheme.colorScheme.onSurfaceVariant
            )

            Spacer(modifier = Modifier.height(4.dp))

            // マグニチュードと深さ
            Row {
                Text(
                    text = earthquake.displayMagnitude,
                    style = MaterialTheme.typography.bodyMedium,
                    color = MaterialTheme.colorScheme.onSurfaceVariant
                )
                Spacer(modifier = Modifier.width(16.dp))
                Text(
                    text = "深さ ${earthquake.displayDepth}",
                    style = MaterialTheme.typography.bodyMedium,
                    color = MaterialTheme.colorScheme.onSurfaceVariant
                )
            }
        }
    }
}

@Composable
private fun IntensityBadge(intensity: JmaIntensity) {
    val (backgroundColor, textColor) = getIntensityColors(intensity)

    Box(
        modifier = Modifier
            .background(
                color = backgroundColor,
                shape = RoundedCornerShape(12.dp)
            )
            .padding(horizontal = 8.dp, vertical = 4.dp)
    ) {
        Text(
            text = getIntensityDisplayText(intensity),
            color = textColor,
            fontSize = 12.sp,
            fontWeight = FontWeight.Bold
        )
    }
}

@Composable
private fun getIntensityColors(intensity: JmaIntensity): Pair<Color, Color> {
    return when (intensity) {
        JmaIntensity.ONE -> Color(0xFFE3F2FD) to Color(0xFF1976D2)
        JmaIntensity.TWO -> Color(0xFFE8F5E8) to Color(0xFF388E3C)
        JmaIntensity.THREE -> Color(0xFFFFF3E0) to Color(0xFFF57C00)
        JmaIntensity.FOUR -> Color(0xFFFFE0B2) to Color(0xFFFF8F00)
        JmaIntensity.FIVE_LOWER -> Color(0xFFFFCCBC) to Color(0xFFE64A19)
        JmaIntensity.FIVE_UPPER -> Color(0xFFFFAB91) to Color(0xFFD84315)
        JmaIntensity.SIX_LOWER -> Color(0xFFFF8A80) to Color(0xFFD32F2F)
        JmaIntensity.SIX_UPPER -> Color(0xFFFF5252) to Color(0xFFB71C1C)
        JmaIntensity.SEVEN -> Color(0xFFE91E63) to Color.White
        JmaIntensity.FIVE_UPPER_NO_INPUT -> Color(0xFFBDBDBD) to Color(0xFF424242)
    }
}

private fun getIntensityDisplayText(intensity: JmaIntensity): String {
    return when (intensity) {
        JmaIntensity.ONE -> "1"
        JmaIntensity.TWO -> "2"
        JmaIntensity.THREE -> "3"
        JmaIntensity.FOUR -> "4"
        JmaIntensity.FIVE_LOWER -> "5弱"
        JmaIntensity.FIVE_UPPER -> "5強"
        JmaIntensity.SIX_LOWER -> "6弱"
        JmaIntensity.SIX_UPPER -> "6強"
        JmaIntensity.SEVEN -> "7"
        JmaIntensity.FIVE_UPPER_NO_INPUT -> "5弱以上"
    }
}

private fun formatDateTime(dateTime: LocalDateTime): String {
    val formatter = LocalDateTime.Format {
        year()
        char('/')
        monthNumber()
        char('/')
        dayOfMonth()
        char(' ')
        hour()
        char(':')
        minute()
    }
    return dateTime.format(formatter)
}
