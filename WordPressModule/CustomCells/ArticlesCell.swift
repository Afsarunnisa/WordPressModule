//
//  ArticlesCell.swift
//  Hariome
//
//  Created by Afsarunnisa on 11/9/16.
//  Copyright © 2016 Wavelabs. All rights reserved.
//

import Foundation
import UIKit

class ArticlesCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    
    
    
    public func bind(post : Post) -> Self {
        configure()
        
        titleLabel.text = post.title
        descLabel.text = post.excerpt
//        imgView.setURL(model.media?.link)
        
        return self
    }
    
    
    func configure() {
        // Optimize
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        
        // Style
////        imgView.layer.shadowColor = AppGlobal.userDefaults[.darkMode]
//            ? UIColor.white.cgColor : UIColor.gray.cgColor

        
        imgView.layer.shadowColor = UIColor.gray.cgColor

        imgView.layer.shadowOffset = .zero
        imgView.layer.shadowRadius = 1
        imgView.layer.shadowOpacity = 1
        imgView.layer.masksToBounds = false
        
//        itemTitle.textColor = UIColor(rgb: AppGlobal.userDefaults[.titleColor])
    }


}
