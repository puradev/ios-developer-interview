import Feature_Thesaurus
import Root_Elements
import SwiftUI

public struct WordDefinitionView: View {
    @ObservedObject var viewModel: WordDefinitionViewModel

    public init(viewModel: WordDefinitionViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        NavigationView {
            VStack(spacing: .zero) {
                HStack(spacing: 4) {
                    TextField(
                        "Some word",
                        text: .init(
                            get: viewModel.getQuery,
                            set: viewModel.setQuery
                        )
                    )
                    .textFieldStyle(RoundedTextFieldStyle())

                    Button(
                        action: viewModel.fetchWord,
                        label: { Text("Search") }
                    )
                    .disabled(viewModel.state.isSearchDisabled)
                    .buttonStyle(RoundedButtonStyle())
                }
                .padding(.all, 12)

                Spacer()

                DataStateTemplate(
                    dataState: viewModel.state.dataState,
                    modelView: contentView,
                    idleView: EmptyView.init
                )

                Spacer()
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationTitle(Text("Word Definitions"))
        }
        .navigationViewStyle(.stack)
        .sheet(
            isPresented: .init(
                get: viewModel.isThesaurusPresented,
                set: viewModel.presentThesaurus
            ),
            content: {
                ThesaurusView(
                    viewModel: .init(
                        initialState: .init(
                            query: viewModel.state.query
                        )
                    )
                )
            }
        )
    }

    @ViewBuilder
    private func contentView(_ model: Word?) -> some View {
        if let model {
            List {
                Section(
                    header: Text("Word"),
                    content: { Text(model.text) }
                )

                Section(
                    header: Text("Definitions"),
                    content: {
                        ForEach(model.definitions, id: \.self) {
                            Text($0)
                        }
                    }
                )

                Section(
                    header: Text("More"),
                    content: {
                        Button(
                            action: { viewModel.presentThesaurus(true) },
                            label: { Text("Check Thesaurus") }
                        )
                    }
                )
            }
            .listStyle(.grouped)
        } else {
            Text("Empty result")
        }
    }
}
