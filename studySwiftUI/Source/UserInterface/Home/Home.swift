//
//  Home.swift
//  studySwiftUI
//
//  Created by Yoojin Park on 2020/09/21.
//

import SwiftUI

struct Home: View {
    let store: Store
    
    var body: some View {
        List(store.products, id: \.name) { product in
            ProductRow(product: product)
        }
        
//        VStack {
//            ProductRow(product: productSamples[0])
//            ProductRow(product: productSamples[1])
//            ProductRow(product: productSamples[2])
//        }.padding([.leading, .trailing], 12)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(store: Store())
    }
}
