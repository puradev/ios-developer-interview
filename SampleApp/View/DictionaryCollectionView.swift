//
//  DictionaryCollectionView.swift
//  SampleApp
//
//  Created by MacBook on 26/01/23.
//

import Foundation
import UIKit




class DictionaryCollectionView : UIView{
    
    var dataSource : TableViewDataSource?
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isPagingEnabled = false
     
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CustomCollectionCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    var imageDetail : UIImageView = {
        var image = UIImageView(frame: .zero)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    var labelDetail : UILabel = {
        var label = UILabel(frame: .zero)
        label.font = .boldSystemFont(ofSize: 25)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    
    init(){
        super.init(frame: .zero)
        dataSource = TableViewDataSource(state: .empty)
        initUI()
        showFirstImage(kind: .noError)
    }
    
    func initUI(){
        self.backgroundColor = .clear
        
        collectionView.delegate = self
        collectionView.dataSource = dataSource
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false

        self.addSubview(collectionView)
        collectionView.addAnchorsWithMargin(10)
    }
    
    func reloadData(state : State){
        dataSource = TableViewDataSource(state: state)
        collectionView.dataSource = dataSource
        collectionView.reloadData()
    }
    
    func showFirstImage(kind : APIError){
        DispatchQueue.main.async { [self] in
            self.addSubview(imageDetail)
            imageDetail.addAnchorsAndCenter(centerX: true, centerY: true, width: width / 2, height: width / 2, left: nil, top: nil, right: nil, bottom: nil)
            
            self.addSubview(labelDetail)
            labelDetail.addAnchorsAndSize(width: nil, height: 50, left: 10, top: 10, right: 10, bottom: nil,withAnchor: .top, relativeToView: imageDetail)
            
            switch kind{
            case .noError:
                imageDetail.image = UIImage(named: "dictionary")
            case .badURL, .custom(_), .noData, .emptyQuery:
                imageDetail.image = UIImage(named: "error")
                labelDetail.text = NSLocalizedString("searchError", comment: "")
            case .tooShort(_):
                imageDetail.image = UIImage(named: "short")
                labelDetail.text = NSLocalizedString("tooShort", comment: "")
            case .notFound:
                imageDetail.image = UIImage(named: "notfound")
                labelDetail.text = NSLocalizedString("notFound", comment: "")
            }
        }
    }
    
    func deleteFirstImage(){
        DispatchQueue.main.async { [self] in
            imageDetail.removeFromSuperview()
            labelDetail.removeFromSuperview()
        }
    }
    
    func addEndEditing(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeEditor))
        self.addGestureRecognizer(tap)
    }
    
    @objc func closeEditor(){
        self.endEditing(true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension DictionaryCollectionView : UICollectionViewDelegate{
    
    
}




extension DictionaryCollectionView : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0{
            return CGSize(width: width - 40, height: 100)
        }
        
        return CGSize(width: width / 2 - 40, height: height / 6)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        }
}
