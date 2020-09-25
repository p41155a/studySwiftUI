//
//  FavoriteProductScrollView.swift
//  studySwiftUI
//
//  Created by Yoojin Park on 2020/09/25.
//

import SwiftUI

struct FavoriteProductScrollView: View {
    @EnvironmentObject private var store: Store
    @Binding var showingImage: Bool
    var body: some View {
        VStack(alignment: .leading) {
            title // 뷰의 목적을 표현하는 제목
            if showingImage {
                products
            }
        }
        .padding()
    }
    
    var title: some View {
        HStack(alignment: .top, spacing: 5) {
            Text("즐겨찾기 상품")
                .font(.headline).fontWeight(.medium)
            SystemImage("arrowtriangle.up.square")
                .padding(4)
                .rotationEffect(Angle(radians: showingImage ? .pi : 0))
            
            Spacer()
        }
        .padding(.bottom, 8)
        .onTapGesture { self.showingImage.toggle() }
    }
    
    var products: some View {
        // 즐겨찾기 상품 목록 읽어 오기
        let favoriteProducts = store.products.filter { $0.isFavorite }
        return ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(favoriteProducts) { product in
                    NavigationLink(
                        destination: ProductDetailView(product: product),
                        label: {
                            self.eachProduct(product)
                        })
                }
            }
        }
    }
    
    func eachProduct(_ product: Product) -> some View {
        GeometryReader {
        // 스크롤 뷰 내에서 위치 정보를 얻도록 GeometryReader를 사용
            ResizedImage(product.imageName, renderingMode: .original)
                .clipShape(Circle())
                .frame(width: 90, height: 90)
                .scaleEffect(self.scaleValue(from: $0))
                // 스크롤 위치에 따라 크기 조정
        }
        .frame(width: 105, height: 105)
    }
    
    func scaleValue(from geometry: GeometryProxy) -> CGFloat {
        let xOffset = geometry.frame(in: .global).minX - 16
        let minSize: CGFloat = 0.8
        let maxSize: CGFloat = 1.1
        let delta: CGFloat = maxSize - minSize // 변화폭
        let size = minSize + delta * (1 - xOffset / UIScreen.main.bounds.width)
        return max(min(size, maxSize), minSize)
    }
}
