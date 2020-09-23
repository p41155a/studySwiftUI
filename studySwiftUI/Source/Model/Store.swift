//
//  Store.swift
//  studySwiftUI
//
//  Created by Yoojin Park on 2020/09/23.
//

import SwiftUI

final class Store {
    var products: [Product]
    
    init(filename: String = "ProductData.json") {
        self.products = Bundle.main.decode(filename: filename, as: [Product].self)
    }
}
