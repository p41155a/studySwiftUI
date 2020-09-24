//
//  SystemImage.swift
//  studySwiftUI
//
//  Created by Yoojin Park on 2020/09/24.
//

import SwiftUI

struct SystemImage: View {
    let systemName: String
    let imageScale: Image.Scale
    let color: Color?
    
    init(
        _ systemName: String,
        scale imageScale: Image.Scale = .medium,
        color: Color? = nil
    ) {
        self.systemName = systemName
        self.imageScale = imageScale
        self.color = color
    }
    
    var body: some View {
        Image(systemName: systemName)
            .imageScale(imageScale)
            .foregroundColor(color)
    }
}


// MARK: - Previews

struct Symbol_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            SystemImage("heart.fill")
            SystemImage("heart.fill", scale: .large)
            SystemImage("heart.fill", scale: .large, color: .red)
            SystemImage("heart", scale: .large, color: .red)
                .font(Font.system(size: 25, weight: .black))
        }
    }
}
