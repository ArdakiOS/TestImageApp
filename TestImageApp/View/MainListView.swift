//
//  MainListView.swift
//  TestImageApp
//
//  Created by Ardak Tursunbayev on 03.06.2025.
//
import SwiftUI
import PhotosUI

struct MainListView : View {
    @ObservedObject var viewModel : MainViewModel
    @State private var photoPickerItem: PhotosPickerItem?
    var body: some View {
        VStack(spacing: 15){
            HStack{
                PhotosPicker(selection: $photoPickerItem, matching: .images, photoLibrary: .shared()){
                    Image(.addProjectImg)
                        .resizable()
                        .frame(width: 24, height: 24)
                }
                .onChange(of: photoPickerItem) { newItem in
                    Task {
                        if let data = try? await newItem?.loadTransferable(type: Data.self),
                           let uiImage = UIImage(data: data) {
                            withAnimation {
                                Task{
                                    await viewModel.startEditing(img: uiImage)
                                }
                                photoPickerItem = nil
                            }
                            
                            print("Image loaded: \(uiImage.size)")
                        }
                    }
                }
                
                
                Spacer()
                
                Text("Projects")
                    .foregroundStyle(.mainText)
                    .font(.system(size: 17, weight: .semibold))
                
                Spacer()
                
                Image(.addProjectImg)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .opacity(0)
                
            }
            
            HStack{
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(.secondaryText)
                TextField("", text: $viewModel.searchText, prompt: Text("Search").font(.system(size: 17, weight: .regular)).foregroundColor(.secondaryText))
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundStyle(.secondaryText)
                    .autocorrectionDisabled()
                    
            }
            .padding(8)
            .background(Color.searchBg)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            if viewModel.items.isEmpty {
                EmptyList(viewModel: viewModel)
            } else {
                ImageGridView(viewModel: viewModel)
                    .onTapGesture {
                        dismissKeyboard()
                    }
                
            }
        }
        .padding(8)
        .ignoresSafeArea(edges: [.bottom])
    }
}


func dismissKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                    to: nil, from: nil, for: nil)
}
