//
//  EditingView.swift
//  TestImageApp
//
//  Created by Ardak Tursunbayev on 03.06.2025.
//

import SwiftUI

struct EditingView : View {
    @ObservedObject var viewModel : MainViewModel
    @State private var shareURL: URL?
    @State private var showShareSheet = false
    var body: some View {
        ZStack{
            Color.mainBg.opacity(0.15).ignoresSafeArea()
                .onTapGesture {
                    withAnimation {
                        viewModel.stopEditing()
                    }
                }
            VStack(spacing: 10){
                Spacer()
                if viewModel.isSearchingFace{
                    Rectangle()
                        .fill(Color.imagePlaceholder)
                        .frame(width: 249, height: 374)
                } else {
                    if let uiImg = viewModel.selectedItem?.image{
                        Image(uiImage: uiImg)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 249, height: 374)
                            .clipped()
                            
                    }
                    else {
                        Rectangle()
                            .fill(Color.imagePlaceholder)
                            .frame(width: 249, height: 374)
                    }
                }
                HStack(spacing: 10){
                    Text(viewModel.selectedItem?.name ?? "Image_1")
                    
                    if viewModel.isSearchingFace{
                        ProgressView()
                            .tint(.white)
                    } else {
                        if let item = viewModel.selectedItem{
                            if item.isFace {
                                Image(systemName: "faceid")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundStyle(.accent)
                            } else {
                                Image(.gallery)
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                
                            }
                        }
                    }
                }
                .foregroundStyle(.white)
                
                Spacer()
                
                if !viewModel.isSearchingFace{
                    Button{
                        guard let item = viewModel.selectedItem else {return}
                        guard let img = item.image else {return}
                        
                        if let url = saveImageToDocuments(img, name: item.name) {
                            print(url)
                            shareURL = url
                            
                        }
                        
                    } label: {
                        Text("Export")
                            .font(.system(size: 13, weight: .regular))
                            .foregroundStyle(Color.mainBg)
                            .frame(maxWidth: .infinity)
                            .frame(height: 46)
                            .background(Color.accent)
                            .clipShape(RoundedRectangle(cornerRadius: 26))
                            .padding(.horizontal, 24)
                    }
                }
            }
            .onChange(of: shareURL, perform: { oldValue in
                showShareSheet.toggle()
            })
            .padding(.vertical, 8)
            .sheet(isPresented: $showShareSheet) {
                if let shareURL = shareURL {
                    ShareSheet(activityItems: [shareURL])
                }
            }
        }
        .task {
            if let img = viewModel.selectedItem?.image{
                if !viewModel.isOpenForPreview{
                    await viewModel.checkForFaces(in: img)
                }
                
            }
        }
    }
    
    private func saveImageToDocuments(_ image: UIImage, name: String) -> URL? {
        guard let data = image.jpegData(compressionQuality: 0.9) else { return nil }

        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("\(name).jpg")

        do {
            try data.write(to: fileURL)
            return fileURL
        } catch {
            print("Failed to save image:", error)
            return nil
        }
    }
}
