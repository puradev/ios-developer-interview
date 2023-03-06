import SwiftUI

public struct DataStateTemplate<Model: Equatable, Content: View, IdleView: View>: View {
    private let dataState: DataState<Model>
    private let modelView: (Model) -> Content
    private let idleView: () -> IdleView

    public init(
        dataState: DataState<Model>,
        @ViewBuilder modelView: @escaping (Model) -> Content,
        @ViewBuilder idleView: @escaping () -> IdleView
    ) {
        self.dataState = dataState
        self.modelView = modelView
        self.idleView = idleView
    }

    public var body: some View {
        switch dataState {
        case let .loaded(model):
            modelView(model)

        case .loading:
            ProgressView()
                .progressViewStyle(.circular)

        case let .error(description):
            VStack(spacing: 12) {
                Text("Error")
                    .font(.title)
                    .bold()

                Text(description)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
            }

        case .idle:
            idleView()
        }
    }
}
