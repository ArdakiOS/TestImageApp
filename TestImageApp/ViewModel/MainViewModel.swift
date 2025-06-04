//
//  MainViewModel.swift
//  TestImageApp
//
//  Created by Ardak Tursunbayev on 03.06.2025.
//

import UIKit

@MainActor
class MainViewModel : ObservableObject {
    
    private let faceDetectionService = FaceDetection()
    private let realmController = RealmController()
    
    @Published var items: [RealmImageItem] = []
    
    @Published var isSearchingFace = false
    
    @Published var isEditing = false
    
    @Published var searchText = ""
    
    @Published var selectedItem : ImageItem?
    
    @Published var blur : CGFloat = 0

    init() {
        loadItems()
        
    }
    
    func loadItems() {
        items = realmController.fetchItems()
    }
    
    func addItem(_ item: ImageItem) {
        realmController.addItem(item)
        loadItems() // Refresh after add
    }
    
    func deleteItems(at offsets: IndexSet) {
        realmController.deleteItem(at: offsets, from: items)
        loadItems() // Refresh after delete
    }
    
    func checkForFaces(in image: UIImage) async {
        isSearchingFace = true
        let result = await faceDetectionService.isFaces(in: image)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            self.selectedItem?.isFace = result
            self.isSearchingFace = false
        }
        
    }
    
    
    func generateName() -> String {
        let opts = ["Sunset", "Mountain", "Beach", "Forest", "Cityscape", "Portrait", "Pet", "Food", "Flower", "Building", "Lake", "Art", "Landscape", "Tree", "Cloud","River", "Snow", "Sand", "Road", "Horizon"]
        
        return "\(opts.randomElement() ?? "Image")_\(Int.random(in: 1...9))"
    }
    
    func startEditing(img : UIImage) {
        isEditing = true
        selectedItem = ImageItem(name: generateName(), image: img, isFace: false)
        blur = 9
    }
    
    func stopEditing() {
        isEditing = false
        addItem(selectedItem!)
        selectedItem = nil
        blur = 0
    }
}
