//
//  MainTabView.swift
//  studySwiftUI
//
//  Created by Yoojin Park on 2020/09/25.
//

import SwiftUI

struct MainTabView: View {
    private enum Tabs {
        case home, recipe, gallery, myPage
    }
    
    @State private var selectedTab: Tabs = .home // 기본 탭
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Group {
                home
                recipe
                imageGallery
                myPage
            }
            .accentColor(.primary) // 실제 콘텐츠에서는 다시 primary로 변경
        }
        .accentColor(.peach) // 탭 뷰에 peach 적용
    }
}

private extension MainTabView {
    // MARK: View
    
    var home: some View {
        Home()
            .tag(Tabs.home)
            .tabItem(image: "house", text: "홈")
//            .onAppear { UITableView.appearance().separatorStyle = .none }
    }
    
    var recipe: some View {
        RecipeView()
            .tag(Tabs.recipe)
            .tabItem(image: "book", text: "레시피")
    }
    
    var imageGallery: some View {
        ImageGallery()
            .tag(Tabs.gallery)
            .tabItem(image: "photo.on.rectangle", text: "갤러리")
    }
    
    var myPage: some View {
        MyPage()
            .tag(Tabs.myPage)
            .tabItem(image: "person", text: "마이페이지")
//            .onAppear { UITableView.appearance().separatorStyle = .singleLine }
    }
}
    
fileprivate extension View {
    func tabItem(image: String, text: String) -> some View {
        self.tabItem {
            SystemImage(image, scale: .large)
                .font(Font.system(size: 17, weight: .light))
            Text(text)
        }
    }
}


struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
