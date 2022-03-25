//
//  Video.swift
//  tableview advanced custom cell
//
//  Created by Yasser Hajlaoui on 2/22/22.
//

import Foundation
import UIKit

class Video {
    
    var image:UIImage
    var title:String
    var isThumbsUp:Bool

    init(image: UIImage, title: String, isThumbsUp: Bool) {
        self.image = image
        self.title = title
        self.isThumbsUp = isThumbsUp
    }
    
}
