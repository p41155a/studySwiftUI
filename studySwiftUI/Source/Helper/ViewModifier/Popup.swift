//
//  Popup.swift
//  studySwiftUI
//
//  Created by Yoojin Park on 2020/09/25.
//

import SwiftUI

enum PopupStyle {
    case none
    case blur
    case dimmed
}

private struct Popup<Message: View>: ViewModifier {
    let size: CGSize?
    let style: PopupStyle
    let message: Message
    
    init (
        size: CGSize? = nil,
        style: PopupStyle = .none,
        message: Message
    ) {
        self.size = size
        self.style = style
        self.message = message
    }
    
    func body(content: Content) -> some View {
        content // 팝업창을 띄운 뷰
            .blur(radius: style == .blur ? 2 : 0)
            .overlay(Rectangle() // dimmed 스타일인 경우에만 적용
                        .fill(Color.black.opacity(style == .dimmed ? 0.4 : 0)))
            .overlay(popupContent) // 팝업창으로 표현될 뷰
    }
    
    private var popupContent: some View {
        GeometryReader {
            VStack { self.message }
                .frame(width: self.size?.width ?? $0.size.width * 0.6,
                       height: self.size?.height ?? $0.size.height * 0.25)
                // VStack을 감싼 view는 위의 frame이 적용
                .background(Color.primary.colorInvert())
                .cornerRadius(12)
                .shadow(color: .primaryShadow, radius: 15, x: 5, y: 5)
                .overlay(self.checkCircleMark, alignment: .top)
                .frame(width: $0.frame(in: .local).width, height: $0.frame(in: .local).height)
            // 그림자와 체크 이미지를 감싼 view는 frame이 적용
            // 따라서 원래 맨위 모서리에 있던 것이 전체 뷰 덮는 형태로 가운데에 오게됨
        }
    }
    
    private var checkCircleMark: some View {
        SystemImage("checkmark.circle.fill", color: .peach)
            .font(Font.system(size: 60).weight(.semibold))
            .background(Color.white.scaleEffect(0.6))
            .offset(x: 0, y: -20)
    }
}

fileprivate struct PopupToggle: ViewModifier {
    @Binding var isPresented: Bool
    func body(content: Content) -> some View {
        content
            .disabled(isPresented)
            // disable = isUserInteractionEnabled의 역할
            // true라면 해당 뷰에 대한 사용자의 터치와 같은 모든 상호 작용을 무시
            // -> content에 해당하는 dimm 처리 된 곳은 터치가 작용하지 않음
            .onTapGesture { self.isPresented.toggle() }
    }
}

fileprivate struct PopupItem<Item: Identifiable>: ViewModifier {
    @Binding var item: Item? //  nil이 아니면 팝업 표시
    func body(content: Content) -> some View {
        content
            .disabled(item != nil)
            .onTapGesture { self.item = nil }
    }
}

// MARK: - View Extension

extension View {
    func popup<Content: View>(
      isPresented: Binding<Bool>,
      size: CGSize? = nil,
      style: PopupStyle = .none,
      @ViewBuilder content: () -> Content
    ) -> some View {
      if isPresented.wrappedValue {
        let popup = Popup(size: size, style: style, message: content())
        let popupToggle = PopupToggle(isPresented: isPresented)
        let modifiedContent = self.modifier(popup).modifier(popupToggle)
        return AnyView(modifiedContent)
      } else {
        return AnyView(self)
      }
    }
    
    func popup<Content: View, Item: Identifiable>(
        item: Binding<Item?>,
        size: CGSize? = nil,
        style: PopupStyle = .none,
        @ViewBuilder content: (Item) -> Content
    ) -> some View {
        if let selectedItem = item.wrappedValue { // nil이 아닐 때만 팝업창 띄우기
            let content = content(selectedItem)
            let popup = Popup(size: size, style: style, message: content)
            let popupItem = PopupItem(item: item)
            let modifiedContent = self.modifier(popup).modifier(popupItem)
            return AnyView(modifiedContent)
        } else {
            return AnyView(self)
        }
    }
}
