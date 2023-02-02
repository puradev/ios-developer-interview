//
//  ExtensionTranslator.swift
//  SampleApp
//
//  Created by MacBook on 27/01/23.
//

import Foundation
import MLKit

class TranslatorT : NSObject {
    
    static let shared = TranslatorT()
    
    func translateText(_ sourceLanguaje: TranslateLanguage, _ targetLanguage: TranslateLanguage, text : String, _ completion: @escaping (Result<String, Error>) -> Void) {

        if targetLanguage != sourceLanguaje{
            let options = TranslatorOptions(sourceLanguage: sourceLanguaje, targetLanguage: targetLanguage)
            let languagesTranslator = Translator.translator(options: options)
            
            let conditions = ModelDownloadConditions(
                allowsCellularAccess: false,
                allowsBackgroundDownloading: true
            )
            
            languagesTranslator.downloadModelIfNeeded(with: conditions) { error in
                guard error == nil else { completion(.failure(error!))
                    return
                }
                
                languagesTranslator.translate(text) { translatedText, error in
                    guard error == nil, let translatedText = translatedText else { completion(.failure(error!))
                        return
                    }
                    completion(.success(translatedText))
                }
            }
            
        }else{
            completion(.success(text))
        }
    }
    
    func currentLanguaje() -> TranslateLanguage{
        if let current = Locale.current.languageCode{
            switch current{
            case "es" : return TranslateLanguage.spanish
            case "fr" : return TranslateLanguage.french
            case "nl" : return TranslateLanguage.dutch
            default: return TranslateLanguage.english
            }
        }
        return TranslateLanguage.english
    }
    
}
