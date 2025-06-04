//
//  GridImageCell.swift
//  TestImageApp
//
//  Created by Ardak Tursunbayev on 03.06.2025.
//
import SwiftUI

struct GridImageCell: View {
    let item: RealmImageItem

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            if let image = item.uiImage{
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.searchBg, lineWidth: 1))
                    .clipped()
            }
            HStack {
                Text(item.name)
                    .foregroundColor(.mainText)
                    .font(.system(size: 15, weight: .regular))

                Spacer()
                if item.isFace {
                    Image(systemName: "faceid")
                        .resizable()
                        .frame(width: 18, height: 18)
                        .foregroundStyle(.accent)
                }
                else {
                    Image(.gallery)
                        .resizable()
                        .frame(width: 18, height: 18)
                }
                
            }
            .padding(8)
            .frame(maxWidth: .infinity)
            .background(.ultraThinMaterial)
            .clipShape(.rect(topLeadingRadius: 0, bottomLeadingRadius: 16, bottomTrailingRadius: 16, topTrailingRadius: 0))
        }
    }
}
