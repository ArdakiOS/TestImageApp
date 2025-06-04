//
//  EmptyList.swift
//  TestImageApp
//
//  Created by Ardak Tursunbayev on 03.06.2025.
//
import SwiftUI
import PhotosUI

struct EmptyList : View {
    @ObservedObject var viewModel : MainViewModel
    @State private var photoPickerItem: PhotosPickerItem?
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 10){
                Spacer()
                Image(.gallery)
                    .resizable()
                    .frame(width: 54, height: 54)
                
                Text("No projects yet")
                    .foregroundStyle(.mainText)
                    .font(.system(size: 19, weight: .medium))
                
                Text("Start editing your photos now")
                    .foregroundStyle(.secondaryText)
                    .font(.system(size: 13, weight: .regular))
                
                PhotosPicker(selection: $photoPickerItem, matching: .images, photoLibrary: .shared()){
                    Text("Start editing")
                        .foregroundStyle(.mainBg)
                        .font(.system(size: 13, weight: .regular))
                        .frame(width: 224, height: 46)
                        .background(Color.accentColor)
                        .clipShape(RoundedRectangle(cornerRadius: 26))
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
                .padding(.top)
                
            }
            .frame(width: geo.size.width, height: geo.size.height / 2)
        }
        
    }
}
