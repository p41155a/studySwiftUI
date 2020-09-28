//
//  AnyTransitionExtension.swift
//  FruitMart
//
//  Created by Giftbot on 2020/03/02.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import SwiftUI

// stripesClipModifier를 활용하여 AnyTransition 옵션을 만듬
extension AnyTransition {
  static func stripes() -> AnyTransition {
    func stripesModifier(
      stripes: Int = 30,
      insertion: Bool = true,
      ratio: CGFloat
    ) -> some ViewModifier {
      let shape = Stripes(stripes: stripes, insertion: insertion, ratio: ratio)
      return ShapeClipModifier(shape: shape)
    }

    // Stripes 뷰의 ratio 값이 0->1로 점차 증가하는 형태의 애니메이션이 적용
    let insertion = AnyTransition.modifier(
      active: stripesModifier(ratio: 0),
      identity: stripesModifier(ratio: 1)
    )
    // Stripes 뷰의 ratio 값이 1->0로 점차 감소
    let removal = AnyTransition.modifier(
      active: stripesModifier(insertion: false, ratio: 0),
      identity: stripesModifier(insertion: false, ratio: 1)
    )
    return AnyTransition.asymmetric(insertion: insertion, removal: removal)
  }
}
