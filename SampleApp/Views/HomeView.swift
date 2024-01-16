//
//  HomeView.swift
//  SampleApp
//
//  Created by Nathan Lambson on 1/15/24.
//

import SwiftUI
import Combine
import GiphyUISDK

struct HomeView: View {
    @State private var vm = SearchViewModel()
    @FocusState private var isTextFieldFocused: Bool
    @State private var offset: CGFloat = 40
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // Search bar
            searchBar
                .modifier(KeyboardResponsiveModifier(offset: $offset))
            
            Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture {
                        isTextFieldFocused = true
                    }
        }
        .onReceive(Publishers.keyboardHeight) { keyboardHeight in
            withAnimation(.easeOut(duration: 0.16)) {
                DispatchQueue.main.async {
                    let openPadding = 10.0
                    let minimumPaddingFromBottom = 40.0
                    
                    if keyboardHeight > 0 {
                        self.offset = keyboardHeight + openPadding
                    } else {
                        self.offset = minimumPaddingFromBottom
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .background(
            Group {
                if isTextFieldFocused {
                    Image("background")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .edgesIgnoringSafeArea(.all)
                } else if case .media(let gphMediaURL) = vm.giphyResponseState {
                    if let gifURL = URL(string: gphMediaURL ?? "") {
                        
                        AnimatedGifView(url: Binding(get: { gifURL }, set: { _ in }))
                            .frame(maxWidth: .infinity, alignment: .top)
                            .edgesIgnoringSafeArea(.top)
                            .offset(y: -100)
                         
                    } else {
                        Image("background")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .edgesIgnoringSafeArea(.all)
                    }
                } else {
                    Image("background")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .edgesIgnoringSafeArea(.all)
                }
            }
        )
        .onChange(of: vm.thesaurusResponseState) { oldValue, newValue in
            if case .synonyms(let syns) = newValue, !syns.isEmpty {
                Task {
                    await vm.searchGiphy(with: syns)
                }
            }
        }
    }
    
    private func performSearch() {
        isTextFieldFocused = false // Dismiss the keyboard
        UIApplication.shared.endEditing() // Redundant with focused modifier, but kept for clarity
        Task {
            await vm.searchTapped()
        }
    }
    
    private func searchResults(definitions: [Word]) -> some View {
        VStack {
            ForEach(definitions) { word in
                VStack(alignment: .leading) {
                    HStack(alignment: .firstTextBaseline) {
                        Text(word.text)
                            .font(.title)
                        Text(word.functionalLabel)
                            .font(.callout)
                    }
                    Text(word.definitions.joined(separator: ","))
                }
                .foregroundColor(.black)
                .padding()
                .background(VisualEffectBlur(effect: UIBlurEffect(style: .extraLight)))
                .cornerRadius(20)
                .padding(.horizontal)
                
            }
        }
        .padding(.bottom, 10)
    }
    
    private var searchBar: some View {
        // Search TextField
        VStack {
            if !isTextFieldFocused {
                if case .definitions(let definitions) = vm.dictionaryResponseState {
                    searchResults(definitions: definitions)
                }
            }
            
            HStack {
                TextField("Search...", text: $vm.searchString)
                    .focused($isTextFieldFocused)
                    .onChange(of: isTextFieldFocused) { wasFocused, isFocused in
                        if isFocused && !wasFocused { // if the text field is now focused
                            vm.searchString = "" // clear the text field
                        }
                    }
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 40))
                    .background(Color(.systemGray6))
                    .cornerRadius(20)
                    .submitLabel(.search)
                    .onSubmit {
                        performSearch()
                    }
                    .overlay(
                        HStack {
                            Spacer()
                            if vm.dictionaryResponseState == .loading {
                                ProgressView()
                                    .padding(.trailing, 15)
                            } else {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 15)

                            }
                        }
                    )
            }
            .padding(.horizontal)
        }
    }
}

struct VisualEffectBlur: UIViewRepresentable {
    var effect: UIVisualEffect?
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: effect)
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = effect
    }
}

#Preview {
    HomeView()
}

//MARK: Extensions and View Modifiers for responsive keyboard handling
struct KeyboardResponsiveModifier: ViewModifier {
    @Binding var offset: CGFloat
    
    func body(content: Content) -> some View {
        content
            .padding(.bottom, offset)
            .animation(.easeOut(duration: 0.16), value: offset)
    }
}

// Create a Combine publisher to listen to keyboard notifications
extension Publishers {
    static var keyboardHeight: AnyPublisher<CGFloat, Never> {
        let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
            .map { $0.keyboardHeight }
        
        let willHide = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }
        
        return MergeMany(willShow, willHide)
            .eraseToAnyPublisher()
    }
}

extension Notification {
    var keyboardHeight: CGFloat {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
