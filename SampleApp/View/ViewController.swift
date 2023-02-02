//
//  ViewController.swift
//  SampleApp
//
//  Created by natehancock on 6/28/22.
//

import UIKit

class ViewController: UIViewController {

    var networkFlag = true
    
    var dataSource = TableViewDataSource(state: .empty)
    
    @IBOutlet weak var textField: UITextField!

    var collectionView : DictionaryCollectionView = {
        let  collection = DictionaryCollectionView()
        return collection
    }()
    
    
    
    @IBAction func didTapButton() {
        guard let text = textField.text else {
            return
        }
        
        TranslatorT.shared.translateText(TranslatorT.shared.currentLanguaje(), .english, text: text) { response in
            switch response {
            case .success(let text):
                self.fetchWord(text: text)

            case .failure(let error):
                print("Error translating: \(error)")
            }
        }
        

    }
    
    func fetchWord(text : String){
        print(text)
        API.shared.fetchWord(query: text) { response in
            switch response {
            case .success(let data):
                guard let r = WordResponse.parseData(data) else {
                    return
                }
                
                self.dataSource.updateState(.word(r.word)) {
                    self.collectionView.reloadData(state: .word(r.word))
                    self.collectionView.deleteFirstImage()
                }
                
                self.setImage(text: text)
                
            case .failure(let error):

                self.dataSource.updateState(.empty) {
                    self.collectionView.reloadData(state: .empty)
                }
                
                self.collectionView.showFirstImage(kind: error)
                print("NETWORK ERROR: ", error.localizedDescription)
            }
        }
        
        textField.text = ""
        view.endEditing(true)
    }
    
    
    func setImage(text : String){
        ApiImage.shared.getImage(word: text) { response in
            print("Response : \(response)")
            switch response {
            case .success(let data):
                guard let r = Welcome.parseData(data) else {
                    return
                }
                
                guard let results = r.results else{
                    return
                }
                
                guard let firtsImage = results.first else{
                    return
                }
                
                guard let media = firtsImage.media else{
                    return
                }
                
                guard let firstMedia = media.first else{
                    return
                }
                
                guard let getGift = firstMedia["gif"] else {
                    return
                }
                
                guard let urlGift = getGift.url else{
                    return
                }
                UserDefaults.standard.set(urlGift, forKey: "urlGift")
                
                let urlDataDict:[String: String] = ["url": urlGift]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationImage"), object: nil, userInfo: urlDataDict)
               
            case .failure(let error):
                print("NETWORK ERROR: ", error.localizedDescription)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        initUI()
    }
    
    func initUI(){
        textField.placeholder = NSLocalizedString("search", comment: "")
        view.backgroundColor = .systemTeal
        view.addSubview(collectionView)
        collectionView.addAnchors(left: 10, top: 27, right: 10, bottom: 10,withAnchor: .top, relativeToView: textField)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(updateUserInterface), name: .flagsChanged, object: nil)
        updateUserInterface()
    }
    
    @objc func updateUserInterface() {

        switch NetworkR.reachability.status {
        case .unreachable:
            networkFlag = false
            let errorNetworking = NetworkErrorView(message: NSLocalizedString("offLine",comment: ""), titleAction: NSLocalizedString("connectButton", comment: ""))
            view.addSubview(errorNetworking)
            errorNetworking.addAnchorsWithMargin(0)
        case .wwan:
            if !networkFlag{
                deleteError()
            }
        case .wifi:
            if !networkFlag{
                deleteError()
            }
        }
    }
    
    func deleteError(){
        if let errorView = view.subviews.last{
            errorView.removeFromSuperview()
        }
    }


}




