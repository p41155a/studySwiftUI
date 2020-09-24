//
//  QuantitySelector.swift
//  studySwiftUI
//
//  Created by Yoojin Park on 2020/09/24.
//

import SwiftUI

struct QuantitySelector: View {
  @Binding var quantity: Int
  var range: ClosedRange<Int> = 1...20 // 수량 선택 가능 범위
  
  // MARK: Body
  
  var body: some View {
    HStack {
      Button(action: { self.changeQuantity(-1) }) {
        Image(systemName: "minus.circle.fill")
          .imageScale(.large)
          .padding()
      }

      Text("\(quantity)")
        .bold()
        .font(Font.system(.title, design: .monospaced))
        .frame(minWidth: 40, maxWidth: 60)

      Button(action: { self.changeQuantity(1) }) {
        Image(systemName: "plus.circle.fill")
          .imageScale(.large)
          .padding()
      }
      .foregroundColor(Color.gray.opacity(0.5))
    }
  }
  
  // MARK: Action

  private func changeQuantity(_ num: Int) {
    if range ~= quantity + num {
      quantity += num
    }
  }
}

struct QuantitySelector_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      QuantitySelector(quantity: .constant(1))
      QuantitySelector(quantity: .constant(10))
      QuantitySelector(quantity: .constant(20))
    }
    .padding()
    .previewLayout(.sizeThatFits)
  }
}
