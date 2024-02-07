//
//  ViewModel.swift
//  SampleApp
//
//  Created by Ralston Goes on 2/7/24.
//

import Foundation
import Combine

class WordViewModel {
    enum State {
        case word(Word)
        case empty
        case invalid
        case networkError
    }
    
    private func updateState(_ newState: State) {
        stateSubject.send(newState)
    }
    
    private var stateSubject = PassthroughSubject<State, Never>()
    
    var statePublisher: AnyPublisher<State, Never> {
        return stateSubject.eraseToAnyPublisher()
    }
    
    /// Fetch word from API and trigger UI update accordingly
    /// - parameter query: word to search
    func fetchWord(query: String) {
        Task.init {
            do {
                let data = try await API.shared.fetchWord(query: query)
                guard let r = WordResponse.parseData(data) else {
                    self.updateState(.invalid)
                    return
                }

                self.updateState(.word(r.word))
            } catch let apiError as APIError {
                self.handleAPIError(apiError)
            } catch {
                print("NETWORK ERROR: \(error.localizedDescription)")
                self.updateState(.networkError)
            }
        }
    }

    private func handleAPIError(_ error: APIError) {
        switch error {
        case .noData:
            print("NETWORK ERROR: No data")
            updateState(.invalid)
        case .custom(let string):
            print("NETWORK ERROR: \(string)")
            updateState(.networkError)
        default:
            print("NETWORK ERROR: \(error.localizedDescription)")
            updateState(.networkError)
        }
    }
}
