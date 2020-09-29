//
//  ProductRow.swift
//  studySwiftUI
//
//  Created by Yoojin Park on 2020/09/21.
//

import SwiftUI

struct ProductRow: View {
    @EnvironmentObject var store: Store // 주문내역 저장
    @Binding var quickOrder: Product? // 팝업창에 상품 이름도 함께 출력해 주기 위한 상품 정보 저장
    @State private var willAppear: Bool = false
    
    let product: Product
    
    var body: some View {
        HStack {
            productImage
            productDescription
        }
        // 각 화면이 나타날 때마다 페이드 인/아웃
        .opacity(willAppear ? 1 : 0)
        .animation(.easeInOut(duration: 0.4))
        .onAppear { self.willAppear = true }
        .frame(height: 150)
        .background(Color.primary.colorInvert()) // 주석처리 하여 테스트
        .cornerRadius(6) // 주석처리 하여 테스트 해보면 좋음
        .shadow(color: Color.primaryShadow, radius: 1, x: 2, y: 2)
        .padding(.vertical, 8)
        .contextMenu { contextMenu }
    }
}

private extension ProductRow {
    var productImage: some View {
        ResizedImage(product.imageName)
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
            FavoriteButton(product: product)
            SystemImage("cart", color: .peach)
                .frame(width: 32, height: 32)
                .onTapGesture { self.orderProduct() }
        }
    }
    
    var contextMenu: some View {
        VStack {
            Button(action: { self.toggleFavorite() }) {
                Text("Toggle Favorite")
                SystemImage(self.product.isFavorite ? "heart.fill" : "heart")
            }
            Button(action: { self.orderProduct() }) {
                Text("Order Product")
                Symbol("cart")
            }
        }
    }
    
    func orderProduct() {
        quickOrder = product // 주문 상품 저장, 팝업창 출력 조건
        store.placeOrder(product: product, quantity: 1) // 상품 1개 주문
    }
    
    func toggleFavorite() {
        store.toggleFavorite(of: product)
    }
}

struct ProductRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach(productSamples) {
                ProductRow(quickOrder: .constant(nil), product: $0)
            }
            ProductRow(quickOrder: .constant(nil), product: productSamples[0])
                .preferredColorScheme(.dark)
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
