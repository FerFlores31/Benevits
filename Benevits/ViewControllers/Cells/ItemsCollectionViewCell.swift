//
//  ItemsCollectionViewCell.swift
//  Benevits
//
//  Created by Fer on 26/03/22.
//

import UIKit
import SkeletonView

class ItemsCollectionViewCell: UICollectionViewCell {

    
    lazy var ownContent : UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.layer .cornerRadius = 10
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 5
        return view
    }()
    
    lazy var imagesView : UIImageView = {
       let iview = UIImageView()
        iview.contentMode = .scaleAspectFit
        return iview
    }()
    
    lazy var textLabel : UILabel = {
       let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "Helvetica", size: 25)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
 

    override init(frame: CGRect) {
        super.init(frame: .zero)
       initUI()
        
        self.ownContent.isSkeletonable = true
        self.imagesView.isSkeletonable = true
        self.textLabel.isSkeletonable = true
        self.ownContent.showAnimatedGradientSkeleton()
        self.imagesView.showAnimatedGradientSkeleton()
        self.textLabel.showAnimatedGradientSkeleton()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10, execute: {
           
            self.ownContent.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
            self.imagesView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
            self.textLabel.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))

        }
        )
      
    }
    
  
    func initUI(){
 
        self.contentView.addSubview(ownContent)
        ownContent.addAnchors(left: 5, top: 10, right: 5, bottom: 0)
      
        ownContent.addSubview(imagesView)
        imagesView.addAnchors(left: 10, top: 0, right: 10, bottom: 150)
        
        ownContent.addSubview(textLabel)
        textLabel.addAnchors(left: 0, top: 5, right: 0, bottom: 5,withAnchor: .top,relativeToView: imagesView)
        
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
  
}

