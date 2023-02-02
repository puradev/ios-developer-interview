//
//  NetworkErrors.swift
//  SampleApp
//
//  Created by MacBook on 27/01/23.
//

import Foundation
import UIKit
import SwiftyGif

class NetworkErrorView : UIView{
    
    var message = ""
    var titleAction = ""
   
    var grayBackground : UIView = {
        var view = UIView(frame: .zero)
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        return view
    }()
    
    var errorCard : UIView = {
       var view = UIView()
        view.backgroundColor = UIColor(displayP3Red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        view.layer.cornerRadius = 10
        return view
    }()
    
    var errorImage : UIImageView = {
        var image = UIImageView(frame: .zero)
        image.contentMode = .scaleAspectFit
        do {
            let gif = try UIImage(gifName: "offline.gif")
            image.setGifImage(gif, loopCount: -1)
        } catch {
            print(error)
        }
        return image
    }()
    
    var offLineLabel : UILabel = {
        var label = UILabel(frame: .zero)
        label.backgroundColor = .clear
        label.textColor = .black
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    var buttonConect : UIButton = {
        var button = UIButton(frame: .zero)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        return button
    }()
    
    init(message : String, titleAction : String){
        self.message = message
        self.titleAction = titleAction
        super.init(frame: .zero)
        initUINoNet()
    }
    
    func initUINoNet(){
        self.addSubview(grayBackground)
        grayBackground.addAnchorsWithMargin(0)
        
        grayBackground.addSubview(errorCard)
        errorCard.addAnchorsAndCenter(centerX: true, centerY: true, width: nil, height: height / 2, left: 10, top: nil, right: 10, bottom: nil)
        
        errorCard.addSubview(errorImage)
        errorImage.addAnchorsAndCenter(centerX: true, centerY: nil, width: nil, height: height / 3, left: 10, top: 10, right: 10, bottom: nil)
        
        offLineLabel.text = message
        errorCard.addSubview(offLineLabel)
        offLineLabel.addAnchorsAndSize(width: nil, height: 50, left: 2, top: 2, right: 2, bottom: nil)
        
        buttonConect.addTarget(self, action: #selector(openWifiSettings), for: .touchUpInside)
        buttonConect.setTitle(titleAction, for: .normal)
        errorCard.addSubview(buttonConect)
        buttonConect.addAnchorsAndCenter(centerX: true, centerY: nil, width: width / 2, height: 40, left: nil, top: nil, right: nil, bottom: 10)
    }
    
    @objc func openWifiSettings(){
        if let url = URL(string:"App-Prefs:root=WIFI") {
          if UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
              UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
              UIApplication.shared.openURL(url)
            }
          }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
