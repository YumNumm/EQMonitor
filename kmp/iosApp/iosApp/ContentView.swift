import SwiftUI
import Shared

struct ContentView: View {
    @StateObject private var diContainer = DIContainer()

    var body: some View {
        EarthquakeHistoryView(
            viewModel: diContainer.makeEarthquakeHistoryViewModel()
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
