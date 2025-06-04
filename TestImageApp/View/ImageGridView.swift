//
//  ImageGridView.swift
//  TestImageApp
//
//  Created by Ardak Tursunbayev on 03.06.2025.
//
import SwiftUI

struct ImageGridView: View {
    @ObservedObject var viewModel = MainViewModel()

    let columns = [
        GridItem(.flexible(), spacing: 20, alignment: .top),
        GridItem(.flexible(), spacing: 20, alignment: .top)
    ]
    
    private var filteredItems: [RealmImageItem] {
        if viewModel.searchText.isEmpty {
            return viewModel.items
        } else {
            return viewModel.items.filter { $0.name.contains(viewModel.searchText) }
        }
    }

    var body: some View {
        ScrollView {
            HStack(spacing: 12) {
                ForEach(0..<(filteredItems.count > 1 ? 2 : 1), id: \.self){col in
                    VStack(spacing: 12){
                        createGrid(col: col)
                        Spacer()
                    }
                    
                    
                }
            }
            
        }
        .animation(.easeInOut, value: viewModel.searchText)
    }
    @ViewBuilder
    func createGrid(col: Int) -> some View {
        ForEach(filteredItems.enumerated().filter { $0.offset % 2 == col }.map(\.element), id: \.self) { item in
            GridImageCell(item: item)
                .onTapGesture {
                    withAnimation {
                        viewModel.startPreview(item: item)
                    }
                }
        }
    }
    
}
