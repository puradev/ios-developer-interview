//
//  CustomCollectionCell.swift
//  SampleApp
//
//  Created by MacBook on 26/01/23.
//

import Foundation
import UIKit
import SwiftyGif
import MLKit


class CustomCollectionCell: UICollectionViewCell {
    var descriptionTextView : UITextView = {
        var textView = UITextView(frame: .zero)
        textView.textAlignment = .justified
        textView.font = .systemFont(ofSize: 12)
        return textView
    }()
    
    var wordLabel : UILabel = {
        var label = UILabel(frame: .zero)
        label.font = .boldSystemFont(ofSize: 30)
        return label
    }()
    
    var cellContentView : UIView = {
        var view = UIView(frame: .zero)
        return view
    }()
    
    var wordImageView : UIImageView = {
        var image = UIImageView(frame: .zero)
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .clear
    }
    
    func definitionInitUI(){
        descriptionTextView.layer.borderColor = UIColor.black.cgColor
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.dropShadow()
        descriptionTextView.layer.cornerRadius = 5
        self.addSubview(descriptionTextView)
        descriptionTextView.addAnchorsWithMargin(5)
    }
    
    func setText(_ text : String){
        TranslatorT.shared.translateText(.english, TranslatorT.shared.currentLanguaje(), text: text.capitalizedSentence) { response in
            switch response {
            case .success(let text):
                DispatchQueue.main.async {
                    self.descriptionTextView.text = text
                    self.descriptionTextView.clipsToBounds = true
                }
            case .failure(let error):
                print("Error translating: \(error)")
            }
            
        }
    }
    
    func wordInitUI(){
        self.addSubview(cellContentView)
        descriptionTextView.removeFromSuperview()
        cellContentView.backgroundColor = UIColor(displayP3Red: 255/255, green: 179/255, blue: 64/255, alpha: 1)
        cellContentView.addAnchorsWithMargin(5)
        cellContentView.layer.cornerRadius = 5
        cellContentView.dropShadow()
        cellContentView.layer.borderColor = UIColor.black.cgColor
        cellContentView.layer.borderWidth = 1
        
        wordLabel.textAlignment = .center
        cellContentView.addSubview(wordLabel)
        wordLabel.addAnchorsAndCenter(centerX: nil, centerY: true, width: width / 3, height: 50, left: 15, top: nil, right: nil, bottom: nil)
        
        wordImageView.contentMode = .scaleAspectFit
        wordImageView.backgroundColor = .clear
        cellContentView.addSubview(wordImageView)
        wordImageView.addAnchorsAndCenter(centerX: nil, centerY: true, width: width / 3, height: nil, left: nil, top: 5, right: 5, bottom: 5)
        setImage()
    }
    
    func setWordText(_ text : String){
        TranslatorT.shared.translateText(.english, TranslatorT.shared.currentLanguaje(), text: text.capitalizedSentence) { response in
            switch response {
            case .success(let text):
                DispatchQueue.main.async {
                    self.wordLabel.text = text
                }
            case .failure(let error):
                print("Error translating: \(error)")
            }
            
        }
        wordLabel.adjustsFontSizeToFitWidth = true
    }
    
    func setImage(){
        guard let urlImage = UserDefaults.standard.string(forKey: "urlGift") else{
            return
        }
            
        if let url = URL(string: urlImage){
            let loader = UIActivityIndicatorView(style: .medium)
            wordImageView.setGifFromURL(url, customLoader: loader)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



