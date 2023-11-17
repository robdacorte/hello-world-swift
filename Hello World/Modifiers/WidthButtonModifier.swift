//
//  WidthButtonModifier.swift
//  Hello World
//
//  Created by Rob on 17/11/23.
//

import SwiftUI

struct WidthButtonModifier: ViewModifier {
    var widthButton: CGFloat {
        UIScreen.main.bounds.width * 0.20
    }
    func body(content: Content) -> some View {
            content
            .frame(width: widthButton)
            .padding(.vertical)
        }
}
