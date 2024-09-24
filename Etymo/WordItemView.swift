import SwiftUI

struct WordItemView: View {
    let word: Word
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(word.text)
                .font(.title)
            
            VStack(alignment: .leading, spacing: 8) {
                ForEach(Array(word.definitions.enumerated()), id: \.offset) { index, definition in
                    Text("\(index + 1). \(definition)")
                        .font(.subheadline)
                }
            }
        }
        .padding()
        .background(.primary.opacity(0.1), in: .rect(cornerRadius: 8))
    }
}

#Preview {
    WordItemView(
        word: .init(
            text: "serendipity",
            definitions: [
                "the faculty or phenomenon of finding valuable or agreeable things not sought for; also : an instance of this"
            ]
        )
    )
    .frame(maxWidth: .infinity)
    .padding()
}
