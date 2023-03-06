import SwiftUI

public struct RoundedTextFieldStyle: TextFieldStyle {
    public init() {}

    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
            .foregroundColor(.primary)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(8)
    }
}
