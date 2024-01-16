//
//  SearchViewModel.swift
//  SampleApp
//
//  Created by Nathan Lambson on 1/15/24.
//

import Foundation

@Observable class SearchViewModel {
    var searchString: String = ""
    var dictionaryResponseState: DictionaryRequestState = .start
    var thesaurusResponseState: ThesaurusRequestState = .start
    var giphyResponseState: GiphyRequestState = .start
    
    enum DictionaryRequestState: Equatable {
        case start
        case loading
        case empty
        case error(APIError)
        case definitions([Word])
    }
    
    enum ThesaurusRequestState: Equatable {
        case start
        case loading
        case empty
        case error(APIError)
        case synonyms([String])
    }
    
    enum GiphyRequestState: Equatable {
        case start
        case loading
        case empty
        case error(APIError)
        case media(String?)
    }
    
    func searchGiphy(with words: [String]) async {
        self.giphyResponseState = .loading
        
        let giphyResponse = await API.shared.fetchMedia(for: words)
        
        switch giphyResponse {
        case .success(let media):
            DispatchQueue.main.async {
                //This is yuck, because the Giphy SDK was supposed to work with just a GPHMedia object, I couldn't get it working, and it was supposed to have a helper method that extracted the gif URL which failed every time. That was code straight from their documentation. So basically I dug into the JSON object and pulled it out myself; yuck.
                if let jsonRepresentation = media.jsonRepresentation,
                   let images = jsonRepresentation["images"] as? [String: Any],
                   let original = images["original"] as? [String: Any],
                   let gifUrl = original["url"] as? String {
                    self.giphyResponseState = GiphyRequestState.media(gifUrl)
                }
            }
        case .failure(let error):
            DispatchQueue.main.async {
                self.giphyResponseState = .error(error)
            }
        }
    }
    
    func searchTapped() async {
        DispatchQueue.main.async {
            self.dictionaryResponseState = .loading
            self.thesaurusResponseState = .loading
        }
        
        let dictionaryResponse = await API.shared.fetch(word: searchString)
        let thesaurusResponse = await API.shared.fetchSynonyms(for: searchString)
        
        switch dictionaryResponse {
        case .success(let data):
            do {
                guard let response = try WordResponse.word(from: data) else {
                    DispatchQueue.main.async {
                        self.dictionaryResponseState = .error(.noData)
                    }
                    return
                }
                let words = response.map { $0.word }
                DispatchQueue.main.async {
                    self.dictionaryResponseState = .definitions(words)
                }
            } catch {
                DispatchQueue.main.async {
                    self.dictionaryResponseState = .error(.custom(error.localizedDescription))
                }
            }
            
        case .failure(let error):
            DispatchQueue.main.async {
                self.dictionaryResponseState = .error(error)
            }
        }
        
        switch thesaurusResponse {
        case .success(let data):
            do {
                guard let response = try SynonymResponse.synonyms(from: data) else {
                    DispatchQueue.main.async {
                        self.thesaurusResponseState = .error(.noData)
                    }
                    return
                }
                
                if let firstSetOfSynonyms = response.first?.meta?.syns?.first {
                    DispatchQueue.main.async {
                        self.thesaurusResponseState = .synonyms(firstSetOfSynonyms)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.thesaurusResponseState = .empty
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.thesaurusResponseState = .error(.custom(error.localizedDescription))
                }
            }
            
        case .failure(let error):
            DispatchQueue.main.async {
                self.thesaurusResponseState = .error(error)
            }
        }
    }
}
