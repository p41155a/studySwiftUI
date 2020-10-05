//
//  Store.swift
//  studySwiftUI
//
//  Created by Yoojin Park on 2020/09/23.
//

import SwiftUI

final class Store: ObservableObject {
    @Published var products: [Product]
    @Published var orders: [Order] = [] {
        didSet { saveData(at: ordersFilePath, data: orders) }
    }
    
    init(filename: String = "ProductData.json") {
        self.products = Bundle.main.decode(filename: filename, as: [Product].self)
        self.orders = loadData(at: ordersFilePath, type: [Order].self) // 앱 생성시 파일 읽어옴
    }
    
    func placeOrder(product: Product, quantity: Int) {
        let nextID = Order.orderSequence.next()!
        let order = Order(id: nextID, product: product, quantity: quantity)
        orders.append(order)
        Order.lastOrderID = nextID
        print(order)
    }
    
    // 파일 경로 구성
    var ordersFilePath: URL {
        // library 디렉터리에 있는 ApplicationSupport 디렉터리 URL
        let manager = FileManager.default
        let appSupportDir = manager.urls(for: .applicationSupportDirectory,
                                         in: .userDomainMask).first!
        
        // 번들 ID를 서브 디렉터리로 추가
        let bundleID = Bundle.main.bundleIdentifier ?? "studySwiftUI"
        let appDir = appSupportDir
            .appendingPathComponent(bundleID, isDirectory: true)
        
        // 디렉터리가 없으면 생성
        if !manager.fileExists(atPath: appDir.path) {
            try? manager.createDirectory(at: appDir,
                                         withIntermediateDirectories: true)
        }
        
        // 지정한 경로에 파일명 추가 - Orders.json
        return appDir
            .appendingPathComponent("Orders")
            .appendingPathExtension("json")
    }
    
    // 경로와 저장할 데이터를 전달 받아 저장하는 코드
    func saveData<T>(at path: URL, data: T) where T: Encodable {
        do {
            let data = try JSONEncoder().encode(data) // 부호화
            try data.write(to: path) // 파일로 저장
        } catch {
            print(error)
        }
    }
    
    func loadData<T>(at path: URL, type: [T].Type) -> [T] where T: Decodable {
        do {
            let data = try Data(contentsOf: path)
            let decodedData = try JSONDecoder().decode(type, from: data)
            return decodedData
        } catch {
            return []
        }
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
