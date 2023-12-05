//
//  DictionaryViewModel.swift
//  SampleApp
//
//  Created by Sean Machen on 12/1/23.
//

import Foundation

final class DictionaryViewModel: ObservableObject {
    private let wordNetworker: WordNetworking
    @Published var searchText = ""

    enum ViewState: Equatable {
        case initalState
        case loading
        case nothingFound
        case foundWord(DictionaryWord)
        case error
    }
    @Published private(set) var viewState: ViewState = .initalState

    enum ThesaurusWordState: Equatable {
        case loading
        case foundWord(ThesaurusWord)
        case error
    }
    @Published private(set) var thesaurusWordState: ThesaurusWordState? = nil

    init(wordNetworker: WordNetworking) {
        self.wordNetworker = wordNetworker
    }
}

// MARK: - Public Methods
extension DictionaryViewModel {
    func searchTapped() {
        getWordInfo()
    }
}

// MARK: - Private Methods
private extension DictionaryViewModel {
    func getWordInfo() {
        guard !searchText.isEmpty else {
            setViewState(to: .nothingFound)
            setThesaurusWordState(to: nil)
            return
        }

        setViewState(to: .loading)
        setThesaurusWordState(to: .loading)
        wordNetworker.fetchDictionaryWord(forSearchText: searchText) { [weak self] response in
            guard let self else { return }
            switch response {
            case .success(let wordResponce):
                setViewState(to: .foundWord(wordResponce.word))
            case .failure:
                setViewState(to: .error)
            }
        }

        wordNetworker.fetchThesaurusWord(forSearchText: searchText) { [weak self] response in
            guard let self else { return }
            switch response {
            case .success(let wordResponce):
                setThesaurusWordState(to: .foundWord(wordResponce.word))
            case .failure:
                setThesaurusWordState(to: .error)
            }
        }
    }

    func setViewState(to newValue: ViewState) {
        DispatchQueue.main.async { [weak self] in
            self?.viewState = newValue
        }
    }

    func setThesaurusWordState(to newValue: ThesaurusWordState?) {
        DispatchQueue.main.async { [weak self] in
            self?.thesaurusWordState = newValue
        }
    }
}
