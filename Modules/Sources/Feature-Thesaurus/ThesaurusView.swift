import Root_Elements
import SwiftUI

public struct ThesaurusView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: ThesaurusViewModel

    public init(viewModel: ThesaurusViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        NavigationView {
            DataStateTemplate(
                dataState: viewModel.state.dataState,
                modelView: contentView,
                idleView: EmptyView.init
            )
            .navigationTitle(Text("Thesaurus"))
            .navigationBarItems(
                leading: Button(
                    action: { dismiss() },
                    label: {
                        Image(systemName: "xmark")
                            .imageScale(.large)
                    }
                )
            )
        }
        .navigationViewStyle(.stack)
        .onAppear(perform: viewModel.fetchThesaurus)
    }

    @ViewBuilder
    private func contentView(_ model: Thesaurus?) -> some View {
        if let model {
            List {
                Section(
                    header: Text("Synonyms"),
                    content: {
                        ForEach(model.syns, id: \.self) {
                            Text($0)
                        }
                    }
                )

                Section(
                    header: Text("Antonyms"),
                    content: {
                        ForEach(model.ants, id: \.self) {
                            Text($0)
                        }
                    }
                )
            }
            .listStyle(.grouped)
        }
    }
}
