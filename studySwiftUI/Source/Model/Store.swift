//
//  Store.swift
//  studySwiftUI
//
//  Created by Yoojin Park on 2020/09/23.
//

import SwiftUI

final class Store: ObservableObject {
  @Published var products: [Product]
  @Published var orders: [Order] = []
  
  init(filename: String = "ProductData.json") {
    self.products = Bundle.main.decode(filename: filename, as: [Product].self)
  }
  func placeOrder(product: Product, quantity: Int) {
    let nextID = Order.orderSequence.next()!
    let order = Order(id: nextID, product: product, quantity: quantity)
    orders.append(order)
    print(order)
  }
}

extension Store {
  func toggleFavorite(of product: Product) {
    guard let index = products.firstIndex(of: product) else {
      return
    }
    products[index].isFavorite.toggle()
  }
}
