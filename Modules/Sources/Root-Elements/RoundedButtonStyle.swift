import SwiftUI

public struct RoundedButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled: Bool

    public init() {}

    public func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
            .background(isEnabled ? .blue: .gray)
            .foregroundColor(.white)
            .cornerRadius(8)
    }
}
