//
//  ShaderViewModel.swift
//  Hello World
//
//  Created by Rob on 25/11/23.
//

import Foundation
import SwiftUI

class ShaderViewModel: ObservableObject {
    var time: Date = .now
    var selectedShader: Shaders = .rainbowNoise
    enum Shaders: Identifiable, CaseIterable {
        var id: Self { self }
        
        case circleWave
        case sinusoidal
        case rainbowNoise
        case testingEffect
        
        
        var image: Image {
            switch self {
            case .circleWave:
                Image(systemName: "circle.circle")
            case .sinusoidal:
                Image(systemName: "water.waves")
            case .rainbowNoise:
                Image(systemName: "circle.bottomrighthalf.checkered")
            case .testingEffect:
                Image(systemName: "testtube.2")
            }
        }
    }
    
    
    func getPrimaryButton() -> ButtonsPanelView.ButtonItem {
        .init(label: Image(systemName: "poweroff")) {
            print("primary button pressed from Shaders")
        }
    }
    
    
    func getSecondaryButtons() -> [ButtonsPanelView.ButtonItem] {
        var secondaryButtonsArray: [ButtonsPanelView.ButtonItem] = []
        for shader in Shaders.allCases {
            secondaryButtonsArray.append(.init(label: shader.image, action: {
                self.selectedShader = shader.self
            }))
        }
        
        return secondaryButtonsArray
    }
}

