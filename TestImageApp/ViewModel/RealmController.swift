//
//  RealmController.swift
//  TestImageApp
//
//  Created by Ardak Tursunbayev on 03.06.2025.
//

import RealmSwift
import Foundation

class RealmController {
    private let realm = try! Realm()

    func fetchItems() -> [RealmImageItem] {
        let results = realm.objects(RealmImageItem.self)
        return Array(results)
    }

    func addItem(_ item: ImageItem) {
        guard let data = item.imageData else { return }

        let realmItem = RealmImageItem()
        realmItem.name = item.name
        realmItem.imageData = data
        realmItem.isFace = item.isFace

        try! realm.write {
            realm.add(realmItem)
        }
    }

    func deleteItem(at offsets: IndexSet, from items: [RealmImageItem]) {
        let toDelete = offsets.map { items[$0] }
        try! realm.write {
            realm.delete(toDelete)
        }
    }
}

