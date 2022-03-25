//
//  ImageHandling.swift
//  ImagePicker_Camera_VS_Library
//
//  Created by Yasser Hajlaoui on 3/9/22.
//

import Foundation
import UIKit



func saveJpg(_ image: UIImage) -> URL {
    
    let name = genImageName()
    var myPath = URL(string: "")
    if let jpgData = image.jpegData(compressionQuality: 0.5),
        let path = documentDirectoryPath()?.appendingPathComponent(name) {
        try? jpgData.write(to: path)
        //path
        myPath = path
    }
    return myPath!
}


func documentDirectoryPath() -> URL? {
    let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return path.first
}

// Generate Image Name from Current date
func genImageName() -> String {
    let date :NSDate = NSDate()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HHmmssddMMyyyy"//"dd-MM-yyyy'_'HH_mm_ss"
    dateFormatter.timeZone = NSTimeZone(name: "PT") as TimeZone?
    let imageName = "/\(dateFormatter.string(from: date as Date)).jpg"
    //print("imageName: ", imageName)
    return imageName
}



