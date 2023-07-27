//
//  PaletteModel.swift
//  Hello World
//
//  Created by Carlos Limonggi on 27/7/23.
//

import Foundation
import SwiftUI

enum Palettes {
    case shadesOfTeal
    case beach
    case neonColors
    
    var colors: [Color] {
        switch self {
        case .shadesOfTeal:
            return [
                Color(red:178/255, green:216/255, blue:216/255),
                Color(red:102/255, green:178/255, blue:178/255),
                Color(red:0, green:128/255, blue:128/255),
                Color(red:0, green:102/255, blue:102/255),
                Color(red:0, green:76/255, blue:76/255)
            ]
        case .beach:
            return [
                Color(red:150/255, green:206/255, blue:180/255),
                Color(red:255/255, green:238/255, blue:173/255),
                Color(red:255/255, green:111/255, blue:105/255),
                Color(red:255/255, green:204/255, blue:92/255),
                Color(red:136/255, green:216/255, blue:176/255)
            ]
        case .neonColors:
            return [
                Color(red:77/255, green:238/255, blue:234/255),
                Color(red:116/255, green:238/255, blue:21/255),
                Color(red:255/255, green:231/255, blue:0),
                Color(red:240/255, green:0, blue:255/255),
                Color(red:0, green:30/255, blue:255/255)
            ]
        }
    }
}
