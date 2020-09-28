//
//  ShapeClipModifier.swift
//  FruitMart
//
//  Created by Giftbot on 2020/03/02.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import SwiftUI

// Stripes를 만든 효과는 AnyTransition의 modifier 메서드를 사용해야하는데
// transition 수식어 메서드 제네릭 매개 변수 타입이 ViewModifier를 받고 있기 때문
struct ShapeClipModifier<S: Shape>: ViewModifier {
  let shape: S
  
  func body(content: Content) -> some View {
    content
      .clipShape(shape)
    // clipShape = 원본 뷰를 지정한 뷰의 모습에 맞춰 잘라내는 기능
  }
}


// MARK: - Previews

struct ShapeClipModifier_Previews : PreviewProvider {
  static var previews: some View {
    let ratio: [CGFloat] = [0.1, 0.3, 0.5, 0.7, 0.9]
    let insertion = ratio.map { Stripes(ratio: $0) }
    let removal = ratio.map {
      Stripes(insertion: false, ratio: 1 - $0)
    }
    
    let image = ResizedImage(recipeSamples[0].imageName,
                             contentMode: .fit)
    return HStack {
      ForEach([insertion, removal], id: \.self) { type in
        VStack {
          ForEach(type, id: \.self) {
            image.modifier(ShapeClipModifier(shape: $0))
          }
        }
      }
    }
  }
}
