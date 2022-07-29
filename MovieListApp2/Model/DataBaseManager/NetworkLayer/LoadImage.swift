//
//  LoadImage.swift
//  MovieListApp2
//
//  Created by adham ragap on 11/08/2021.
//

import Foundation
import UIKit
import Kingfisher
extension UIImageView {
    func loadProfileCover(_ url : URL?) {
        
        self.kf.setImage(
            with: url,
            placeholder: UIImage(named: "background"),
            options: [
                
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        
        self.kf.indicatorType = .activity
        
    }}
