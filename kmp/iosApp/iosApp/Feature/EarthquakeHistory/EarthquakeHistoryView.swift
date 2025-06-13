import SwiftUI
import Shared

struct EarthquakeHistoryView: View {
    @StateObject private var viewModel: EarthquakeHistoryViewModel

    init(viewModel: EarthquakeHistoryViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.isLoading {
                    LoadingView()
                } else if viewModel.hasError {
                    ErrorView(
                        message: viewModel.errorMessage ?? "エラーが発生しました"
                    ) {
                        viewModel.loadEarthquakeHistory()
                    }
                } else if viewModel.earthquakes.isEmpty {
                    EmptyStateView()
                } else {
                    EarthquakeListView(earthquakes: viewModel.earthquakes)
                }
            }
            .navigationTitle("地震履歴")
            .navigationBarTitleDisplayMode(.large)
            .refreshable {
                await refreshData()
            }
        }
    }

    @MainActor
    private func refreshData() async {
        viewModel.refreshEarthquakeHistory()

        // Wait for refresh to complete
        while viewModel.isRefreshing {
            try? await Task.sleep(nanoseconds: 100_000_000) // 0.1 second
        }
    }
}

struct LoadingView: View {
    var body: some View {
        VStack {
            ProgressView()
                .scaleEffect(1.5)
            Text("読み込み中...")
                .padding(.top)
                .foregroundColor(.secondary)
        }
    }
}

struct ErrorView: View {
    let message: String
    let onRetry: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 50))
                .foregroundColor(.red)

            Text(message)
                .multilineTextAlignment(.center)
                .foregroundColor(.red)

            Button("再試行") {
                onRetry()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

struct EmptyStateView: View {
    var body: some View {
        VStack {
            Image(systemName: "list.bullet")
                .font(.system(size: 50))
                .foregroundColor(.secondary)

            Text("地震データがありません")
                .foregroundColor(.secondary)
                .padding(.top)
        }
    }
}

struct EarthquakeListView: View {
    let earthquakes: [Earthquake]

    var body: some View {
        List(earthquakes, id: \.eventId) { earthquake in
            EarthquakeRowView(earthquake: earthquake)
                .padding(.vertical, 4)
        }
        .listStyle(PlainListStyle())
    }
}

struct EarthquakeRowView: View {
    let earthquake: Earthquake

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Header with title and intensity
            HStack {
                Text(earthquake.displayTitle)
                    .font(.headline)
                    .fontWeight(.bold)
                    .lineLimit(1)

                Spacer()

                if let intensity = earthquake.maxIntensity {
                    IntensityBadge(intensity: intensity)
                }
            }

            // Origin time
            if let originTime = earthquake.originTime {
                Text("発生時刻: \(formatDateTime(originTime))")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            // Location
            Text("震源地: \(earthquake.displayLocation)")
                .font(.caption)
                .foregroundColor(.secondary)

            // Magnitude and depth
            HStack {
                Text(earthquake.displayMagnitude)
                    .font(.caption)
                    .foregroundColor(.secondary)

                Spacer()

                Text("深さ \(earthquake.displayDepth)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(Color(.systemBackground))
        .cornerRadius(8)
        .shadow(color: .gray.opacity(0.2), radius: 2, x: 0, y: 1)
    }
}

struct IntensityBadge: View {
    let intensity: JmaIntensity

    var body: some View {
        Text(getIntensityDisplayText(intensity))
            .font(.caption2)
            .fontWeight(.bold)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(getIntensityColor(intensity))
            .foregroundColor(getIntensityTextColor(intensity))
            .cornerRadius(12)
    }

    private func getIntensityDisplayText(_ intensity: JmaIntensity) -> String {
        switch intensity {
        case .one:
            return "1"
        case .two:
            return "2"
        case .three:
            return "3"
        case .four:
            return "4"
        case .fiveLower:
            return "5弱"
        case .fiveUpper:
            return "5強"
        case .sixLower:
            return "6弱"
        case .sixUpper:
            return "6強"
        case .seven:
            return "7"
        case .fiveUpperNoInput:
            return "5弱以上"
        default:
            return "不明"
        }
    }

    private func getIntensityColor(_ intensity: JmaIntensity) -> Color {
        switch intensity {
        case .one:
            return Color.blue.opacity(0.2)
        case .two:
            return Color.green.opacity(0.2)
        case .three:
            return Color.orange.opacity(0.2)
        case .four:
            return Color.orange.opacity(0.4)
        case .fiveLower:
            return Color.red.opacity(0.3)
        case .fiveUpper:
            return Color.red.opacity(0.5)
        case .sixLower:
            return Color.red.opacity(0.7)
        case .sixUpper:
            return Color.red.opacity(0.9)
        case .seven:
            return Color.purple
        case .fiveUpperNoInput:
            return Color.gray.opacity(0.3)
        default:
            return Color.gray.opacity(0.2)
        }
    }

    private func getIntensityTextColor(_ intensity: JmaIntensity) -> Color {
        switch intensity {
        case .seven:
            return Color.white
        default:
            return Color.primary
        }
    }
}

private func formatDateTime(_ dateTime: Kotlinx_datetimeLocalDateTime) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/M/d H:mm"

    // Convert Kotlin LocalDateTime to Swift Date
    let components = DateComponents(
        year: Int(dateTime.year),
        month: Int(dateTime.monthNumber),
        day: Int(dateTime.dayOfMonth),
        hour: Int(dateTime.hour),
        minute: Int(dateTime.minute),
        second: Int(dateTime.second)
    )

    if let date = Calendar.current.date(from: components) {
        return formatter.string(from: date)
    } else {
        return "不明"
    }
}

// Preview
struct EarthquakeHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        // This would need to be set up with proper DI in a real app
        // For now, this is just a placeholder
        Text("Preview not available - requires DI setup")
    }
}
