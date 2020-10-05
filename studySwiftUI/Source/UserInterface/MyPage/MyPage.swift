//
//  MyPage.swift
//  studySwiftUI
//
//  Created by Yoojin Park on 2020/09/29.
//

import SwiftUI

struct MyPage: View {
    @EnvironmentObject var store: Store // 엡 설정에 접근하기 위하여
    @State private var pickedImage: Image = Image(systemName: "person.crop.circle") // 프로필 사진
    @State private var isPickerPresented: Bool = false
    @State private var nickname: String = ""
    
    private let pickerDataSource: [CGFloat] = [140, 150, 160] // 피커 선택지
    
    var body: some View {
        NavigationView {
            VStack {
              userInfo
            
                Form {
                    orderInfoSection
                    appSettingSection // 앱 설정 섹션
                }
            }
            .navigationBarTitle("마이 페이지")
        }
    }
}

private extension MyPage {
    var userInfo: some View {
    // 프로필 사진과 닉네임이 들어갈 컨테이너 역활
      VStack {
        profileImage
        nicknameTextField
      }
      .frame(maxWidth: .infinity, minHeight: 200)
      .background(Color.background)
    }
    
    // 프로필 사진
    var profileImage: some View {
      pickedImage
        .resizable().scaledToFill()
        .clipShape(Circle())
        .frame(width: 100, height: 100)
        .overlay(pickImageButton.offset(x: 8, y: 0), alignment: .bottomTrailing)
    }
    
    // 사진 변경 버튼
    var pickImageButton: some View {
      Button(action: {
        self.isPickerPresented = true
      }) {
        Circle()
          .fill(Color.white)
          .shadow(color: .primaryShadow, radius: 2, x: 2, y: 2)
          .overlay(Image("pencil").foregroundColor(.black))
          .frame(width: 32, height: 32)
      }
    }
    
    var nicknameTextField: some View {
      TextField("닉네임", text: $nickname)
        .font(.system(size: 25, weight: .medium))
        .textContentType(.nickname)
        .multilineTextAlignment(.center)
        .autocapitalization(.none) // 자동 대문자화 비활성화
    }
    
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
