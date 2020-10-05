//
//  MyPage.swift
//  studySwiftUI
//
//  Created by Yoojin Park on 2020/09/29.
//

import SwiftUI

struct MyPage: View {
    var body: some View {
        NavigationView {
            Form {
                orderInfoSection
            }
            .navigationBarTitle("마이 페이지")
        }
    }
}

private extension MyPage {
    var orderInfoSection: some View {
        Section(header: Text("주문 정보").fontWeight(.medium)) {
            NavigationLink(destination: OrderListView()) {
                Text("주문 목록")
            }
            .frame(height: 44)
        }
    }
}

struct MyPage_Previews: PreviewProvider {
    static var previews: some View {
        MyPage()
    }
}
