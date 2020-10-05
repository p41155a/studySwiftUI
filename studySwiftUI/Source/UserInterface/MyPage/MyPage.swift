//
//  MyPage.swift
//  studySwiftUI
//
//  Created by Yoojin Park on 2020/09/29.
//

import SwiftUI

struct MyPage: View {
    @EnvironmentObject var store: Store // 엡 설정에 접근하기 위하여
    private let pickerDataSource: [CGFloat] = [140, 150, 160] // 피커 선택지
    
    var body: some View {
        NavigationView {
            Form {
                orderInfoSection
                appSettingSection // 앱 설정 섹션
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
    
    var appSettingSection: some View {
        Section(header: Text("앱 설정").fontWeight(.medium)) {
            Toggle("즐겨찾는 상품 표시", isOn: $store.appSetting.showFavoriteList).frame(height: 44)
            productHeightPicker
        }
    }
    
    var productHeightPicker: some View {
        // 피커에서 선택한 값을 appSetting의 productRowHeight와 연동
        
        VStack(alignment: .leading) {
            Text("상품 이미지 높이 조절")
            Picker("", selection: $store.appSetting.productRowHeight) {
                ForEach(pickerDataSource, id: \.self) {
                    Text(String(format: "%.0f", $0)).tag($0) // 소수점 제거
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
        .frame(height: 72)
    }
}

struct MyPage_Previews: PreviewProvider {
    static var previews: some View {
        MyPage()
    }
}
