import ComposableArchitecture
import SwiftUI

@main
struct TheWordApp: App {
    var body: some Scene {
        WindowGroup {
            AppFeatureRootView(
                store: Store(
                    initialState: AppFeature.State(),
                    reducer: {
                        #if DEBUG
                        AppFeature()
                            ._printChanges()
                        #else
                        AppFeature()
                        #endif
                    }
                )
            )
        }
    }
}
