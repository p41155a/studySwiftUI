//
//  ProductRow.swift
//  studySwiftUI
//
//  Created by Yoojin Park on 2020/09/21.
//

import SwiftUI

struct ProductRow: View {
    let product: Product
    
    var body: some View {
        HStack {
            productImage
            productDescription
        }
        .frame(height: 150)
        .background(Color.primary.colorInvert()) // 주석처리 하여 테스트
        .cornerRadius(6) // 주석처리 하여 테스트 해보면 좋음
        .shadow(color: Color.primaryShadow, radius: 1, x: 2, y: 2)
        .padding(.vertical, 8)
    }
}

private extension ProductRow {
    var productImage: some View {
        Image(product.imageName)
            .resizable()
            .scaledToFill()
            .frame(width: 140)
            .clipped()
    }
    
    var productDescription: some View {
        VStack(alignment: .leading) {
            Text(product.name)
                .font(.headline)
                .fontWeight(.medium)
                .padding(.bottom, 6)
            Text(product.description)
                .font(.footnote)
                .foregroundColor(.secondaryText)
            Spacer()
            footerView
        }
        .padding([.leading, .bottom], 12)
        .padding([.top, .trailing])
    }
    
    var footerView: some View {
        HStack(spacing: 0) {
            Text("￦").font(.footnote) + Text("\(product.price)").font(.headline)
            Spacer()
            Image(systemName: "heart")
                .imageScale(.large)
                .foregroundColor(Color.peach)
                .frame(width: 32, height: 32)
            Image(systemName: "cart")
                .foregroundColor(Color("peach"))
                .frame(width: 32, height: 32)
            
        }
    }
}

struct ProductRow_Previews: PreviewProvider {
    static var previews: some View {
        ProductRow(product: productSamples[0])
    }
}
