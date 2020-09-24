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
    
    private let softFeedback = UIImpactFeedbackGenerator(style: .soft) // 부드러운 느낌의 진동
    private let rigidFeedback = UIImpactFeedbackGenerator(style: .rigid) // 딱딱한 느낌의 진동
    
    // MARK: Body
    
    var body: some View {
        HStack {
            Button(action: { self.changeQuantity(-1) }) {
                SystemImage("minus.circle.fill", scale: .large)
                    .padding()
            }
            
            Text("\(quantity)")
                .bold()
                .font(Font.system(.title, design: .monospaced))
                .frame(minWidth: 40, maxWidth: 60)
            
            Button(action: { self.changeQuantity(1) }) {
                SystemImage("plus.circle.fill", scale: .large)
                    .padding()
            }
            .foregroundColor(Color.gray.opacity(0.5))
        }
    }
    
    // MARK: Action
    
    private func changeQuantity(_ num: Int) {
        if range ~= quantity + num {
            quantity += num
            softFeedback.prepare() // 진동 지연 시간을 줄일 수 있도록 미리 준비 시키는 메소드
            softFeedback.impactOccurred(intensity: 0.8) // 진동 세기
        } else {
            rigidFeedback.prepare()
            rigidFeedback.impactOccurred()
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
