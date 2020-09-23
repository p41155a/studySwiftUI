//
//  ProductDetailView.swift
//  studySwiftUI
//
//  Created by Yoojin Park on 2020/09/23.
//

import SwiftUI

struct ProductDetailView: View {
  let product: Product // 상품 정보를 전달받기 위한 프로퍼티 선언
  var body: some View {
    VStack(spacing: 0) {
      productImage
      orderView
    }
    .edgesIgnoringSafeArea(.top)
  }
}
private extension ProductDetailView {
  // MARK: View
  
  var productImage: some View {
    GeometryReader { _ in
      Image(self.product.imageName)
        .resizable()
        .scaledToFill()
    }
  }
  
  var orderView: some View {
    GeometryReader {
      VStack(alignment: .leading) {
        self.productDescription // 상품명과 즐겨찾기 버튼 이미지
        Spacer()
        self.priceInfo
        self.placeOrderButton
      }
      .padding(32)
      .frame(height: $0.size.height + 10)
      .background(Color.white)
      .cornerRadius(16)
      .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: -5)
    }
  }
  
  var productDescription: some View {
    VStack(alignment: .leading, spacing: 16) {
      HStack {
        Text(product.name) // 상품명
          .font(.largeTitle).fontWeight(.medium)
          .foregroundColor(.black)
        Spacer()
        Image(systemName: "heart") // 즐겨찾기 버튼
          .imageScale(.large)
          .foregroundColor(Color.peach)
          .frame(width: 32, height: 32)
      }
      Text(splitText(product.description)) // 상품 설명
        .foregroundColor(.secondaryText)
        .fixedSize() // 뷰 크기가 작아져도 텍스트 생략하지 않음
    }
  }
  
  var priceInfo: some View {
    HStack {
      (Text("₩")
        + Text("\(product.price)").font(.title)
      ).fontWeight(.medium)
      Spacer()
    }
    .foregroundColor(.black)
  }
  
  var placeOrderButton: some View {
    Button(action: {}) {
      Capsule()
        .fill(Color.peach)
        .frame(maxWidth: .infinity, minHeight: 30, maxHeight: 55)
        .overlay(Text("주문하기")
          .font(.system(size: 20)).fontWeight(.medium)
          .foregroundColor(Color.white))
        .padding(.vertical, 8)
    }
  }
  
  func splitText(_ text: String) -> String {
    guard !text.isEmpty else { return text }
    let centerIdx = text.index(text.startIndex, offsetBy: text.count / 2)
    let centerSpaceIdx = text[..<centerIdx].lastIndex(of: " ")
      ?? text[centerIdx...].firstIndex(of: " ")
      ?? text.index(before: text.endIndex)
    let afterSpaceIdx = text.index(after: centerSpaceIdx)
    let lhsString = text[..<afterSpaceIdx].trimmingCharacters(in: .whitespaces)
    let rhsString = text[afterSpaceIdx...].trimmingCharacters(in: .whitespaces)
    return String(lhsString + "\n" + rhsString)
  }
}

struct ProductDetailView_Previews: PreviewProvider {
  static var previews: some View {
    let source1 = ProductDetailView(product: productSamples[0])
    let source2 = ProductDetailView(product: productSamples[1])
    return Group {
      Preview(source: source1) // 변수 따로 설정하지 않으면 4가지 환경에서의 프리뷰 출력 (기기3개, 다크모드)
      Preview(source: source2, devices: [.iPhone11Pro], displayDarkMode: false)
    }
  }
}
