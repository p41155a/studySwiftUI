//
//  Home.swift
//  studySwiftUI
//
//  Created by Yoojin Park on 2020/09/21.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject private var store: Store
    
    var body: some View {
        NavigationView {
            List(store.products, id: \.name) { product in
                NavigationLink(destination: ProductDetailView(product: product)) {
                    ProductRow(product: product)
                }
            }
            .navigationBarTitle("과일마트")
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Preview(source: Home())
            .environmentObject(Store())
    }
}
