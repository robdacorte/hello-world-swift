//
//  PaddingBottomModifier.swift
//  Hello World
//
//  Created by Rob on 17/11/23.
//

import SwiftUI

struct PaddingBottom: ViewModifier {
    func body(content: Content) -> some View {
            content
            .padding(.bottom, 60)
        }
}
