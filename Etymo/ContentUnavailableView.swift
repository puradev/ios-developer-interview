import SwiftUI

struct ContentUnavailableView: View {
    var image: Image
    var title: LocalizedStringKey
    var description: LocalizedStringKey
    
    var body: some View {
        VStack(spacing: 8) {
            image
                .font(.largeTitle.weight(.bold))
                .imageScale(.large)
                .foregroundStyle(.tint)
                .accessibilityHidden(true)

            VStack(spacing: 4) {
                Text(title)
                    .font(.headline)
                Text(description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .multilineTextAlignment(.center)
            .accessibilityElement(children: .combine)
        }
    }
}

#Preview {
    ContentUnavailableView(
        image: Image(.wifiSlash),
        title: "Not Connected",
        description: "Unable to lookup words while offline.\nCheck your Internet connection."
    )
    .tint(.red)
}
