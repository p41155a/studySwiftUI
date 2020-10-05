//
//  Order.swift
//  FruitMart
//
//  Created by Giftbot on 2020/03/02.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import Foundation

struct Order: Identifiable { // 식별을 위한 Identifiable 프로토콜 채택
    static var orderSequence = sequence(first: lastOrderID + 1) { $0 &+ 1 }
    // 시퀀스의 시작이 마지막 주문 번호보다 1일 높은 상태에서 시작되게 설정
    static var lastOrderID: Int {
      get { UserDefaults.standard.integer(forKey: "LastOrderID") }
      set { UserDefaults.standard.set(newValue, forKey: "LastOrderID") }
    }
    
    let id: Int
    let product: Product
    let quantity: Int
    
    var price: Int {
        product.price * quantity
    }
    
}
extension Order: Codable {}
