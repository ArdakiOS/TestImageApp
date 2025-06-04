//
//  ContentView.swift
//  TestImageApp
//
//  Created by Ardak Tursunbayev on 03.06.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = MainViewModel()
    var body: some View {
        ZStack {
            Color.mainBg.ignoresSafeArea()
            MainListView(viewModel: viewModel)
                .blur(radius: viewModel.blur)
            
            if viewModel.isEditing {
                EditingView(viewModel: viewModel)
            }
        }
    }
}


#Preview {
    ContentView()
}


