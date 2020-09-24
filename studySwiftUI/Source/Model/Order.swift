//
//  Order.swift
//  FruitMart
//
//  Created by Giftbot on 2020/03/02.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import Foundation

struct Order: Identifiable { // 식별을 위한 Identifiable 프로토콜 채택
  static var orderSequence = sequence(first: 1) { $0 + 1 }
  
  let id: Int
  let product: Product
  let quantity: Int
  
  var price: Int {
    product.price * quantity
  }
}
