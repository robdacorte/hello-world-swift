//
//  ShaderViewModel.swift
//  Hello World
//
//  Created by Rob on 25/11/23.
//

import Foundation

class ShaderViewModel: ObservableObject {
    var time: Date = .now
    var selectedShader: Shaders = .rainbowNoise
    enum Shaders {
        case circleWave
        case sinusoidal
        case rainbowNoise
        case youtubeTutorial
    }
    
}

