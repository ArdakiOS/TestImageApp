//
//  RealmImageItem.swift
//  TestImageApp
//
//  Created by Ardak Tursunbayev on 03.06.2025.
//

import RealmSwift
import UIKit

class RealmImageItem: Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var imageData: Data
    @Persisted var isFace: Bool

    var uiImage: UIImage? {
        UIImage(data: imageData)
    }
}

