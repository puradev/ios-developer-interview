//
//  ApiImage.swift
//  SampleApp
//
//  Created by MacBook on 26/01/23.
//

import Foundation


class ApiImage : NSObject{
   
    static let shared = ApiImage()
    let session = URLSession.shared
    static let baseUrl = "https://g.tenor.com/v1/search?q="
    
    
    
    func getImage(word: String, _ completion: @escaping (Result<Data, APIError>) -> Void) {
        
        guard !word.isEmpty else {
            completion(.failure(.emptyQuery))
            return
        }
        
        guard word.count > 2 else {
            completion(.failure(.tooShort(word)))
            return
        }

        let requestURL = URLImageBuilder(baseURL: ApiImage.baseUrl, word: word.lowercased()).requestURL
        
        guard let url = URL(string: requestURL) else {
            completion(.failure(.badURL))
            return
        }
        print("😌")
        print(url)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        
        print("Fetching image from: ", request.url?.absoluteString ?? "")
        session.dataTask(with: request) { data, response, error in
           print("😀")
            print(String(data: data!, encoding: .utf8)!)
            if let error = error {
                completion(.failure(.custom(error.localizedDescription)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            completion(.success(data))
            

        }.resume()
        
        
    }
    
}
