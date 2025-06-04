//
//  ImageItem.swift
//  TestImageApp
//
//  Created by Ardak Tursunbayev on 03.06.2025.
//

import UIKit

struct ImageItem : Hashable {
    let name : String
    var image : UIImage?
    var isFace : Bool
    
    var imageData : Data? {
        if let img = image{
            return img.jpegData(compressionQuality: 0.5)
        }
        else {
            return nil
        }
    }
}
