//
//  ShaderViewModel.swift
//  Hello World
//
//  Created by Rob on 25/11/23.
//

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
        
        
        var image: String {
            switch self {
            case .circleWave:"circle.circle"
            case .sinusoidal:"water.waves"
            case .rainbowNoise: "circle.bottomrighthalf.checkered"
            case .testingEffect:"testtube.2"
            }
        }
    }
    
    
    func getPrimaryButton() -> ButtonsPanelView.ButtonItem {
        .init(systemImageString: "poweroff") {
            print("primary button pressed from Shaders")
        }
    }
    
    
    func getSecondaryButtons() -> [ButtonsPanelView.ButtonItem] {
        var secondaryButtonsArray: [ButtonsPanelView.ButtonItem] = []
        for shader in Shaders.allCases {
            secondaryButtonsArray.append(.init(systemImageString: shader.image, action: {
                self.selectedShader = shader.self
            }))
        }
        
        return secondaryButtonsArray
    }
}

