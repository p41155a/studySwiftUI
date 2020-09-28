//
//  RecipeView.swift
//  studySwiftUI
//
//  Created by Yoojin Park on 2020/09/28.
//

import SwiftUI

struct RecipeView: View {
    @State private var currentIndex = 0
    private let recipes = recipeSamples
    
    var body: some View {
        VStack(alignment: .leading) {
            title
            Spacer()
            recipePicker
            Spacer()
            recipeName
            recipeIndicator
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal)
        .padding(.bottom, 30)
        .padding(.top, 80)
        .background(backgroundGradient)
        .edgesIgnoringSafeArea(.top)
    }
}

private extension RecipeView {
    
    var title: some View {
        VStack {
            Text("과일을 활용한 \n 신나는 요리")
                .font(.system(size: 42)).fontWeight(.thin)
                .foregroundColor(.white)
                .padding(.vertical)
            
            Text("토마토와 함께하는 금주의 레시피")
                .font(.headline).fontWeight(.thin)
                .foregroundColor(.white)
        }
    }
    
    var recipePicker: some View {
        HStack {
            Button(action: { self.changeIndex(-1) }) {
                Text("<")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
            Spacer()
            ResizedImage(recipes[currentIndex].imageName, contentMode: .fit)
                .padding()
                .transition(.stripes())
                .id(currentIndex)
            Spacer()
            Button(action: { self.changeIndex(1) }) {
                Text(">")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
        }
    }
    
    // 현재 선택된 레시피가 어떤 것인지 나타내는 용도
    var recipeName: some View {
        Text(recipes[currentIndex].name)
            .font(.headline)
            .fontWeight(.medium)
            .foregroundColor(.white)
            .animation(nil)
    }
    
    // 레시피가 총 몇 개가 있을지 현재 몇 번쨰인지 알려주는 역할
    var recipeIndicator: some View {
        GeometryReader {
            Rectangle()
                .fill(Color.white.opacity(0.4))
                .frame(width: $0.size.width)
                // 첫 번째 레시피일 때 가장 왼쪽에 위치하게 정렬 위치를 leading으로 지정
                .overlay(self.currentIndicator(proxy: $0),
                         alignment: .leading)
        }
        .frame(height: 2)
        .padding(.top)
        .padding(.bottom, 32)
    }
    
    var backgroundGradient: some View {
        // Color -> Gradient -> LinearGradient
        let colors = [Color(hex: "#f56161"), Color(hex: "#fc9c79")]
        let gradient = Gradient(colors: colors)
        return LinearGradient(
            gradient: gradient,
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    func currentIndicator(proxy: GeometryProxy) -> some View {
        let pastelYellow = Color(hex: "#fffa77")
        // 전체 레시피 개수를 고려하여 인디케이터 너비를 지정
        let width = proxy.size.width / CGFloat(recipes.count)
        return pastelYellow
            .frame(width: width)
            // 현재 인덱스와 너비를 계산하여 위치 이동
            .offset(x: width * CGFloat(currentIndex), y: 0)
    }
    
    func changeIndex(_ num: Int) {
        // 새로운 인덱스(0 ~ 4)를 계산하여 반영하고, 관련 뷰에 애니메이션 적용
        withAnimation(.easeInOut(duration: 0.6)) {
            currentIndex = (currentIndex + recipes.count + num) % recipes.count
        }
    }
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView()
    }
}
