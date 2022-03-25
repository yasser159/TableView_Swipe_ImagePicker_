//
//  VideoCell.swift
//  tableview advanced custom cell
//
//  Created by Yasser Hajlaoui on 2/22/22.
//

import UIKit
import SwipeCellKit

class VideoCell: SwipeTableViewCell {

    @IBOutlet weak var videoImageView: UIImageView!
    @IBOutlet weak var videoTitleLabel: UILabel!
    
    func setVideo(video: Video){
        videoImageView.image = video.image
        videoTitleLabel.text = video.title
        
    }
    
}
