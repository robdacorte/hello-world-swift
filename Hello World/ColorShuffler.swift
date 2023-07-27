//
//  ColorShuffler.swift
//  Hello World
//
//  Created by Carlos Limonggi on 4/7/23.
//

import Foundation
import SwiftUI

class ColorShuffler: NSObject, ObservableObject {
    var timer: Timer?
    var currentIndex: Int = 0
    @Published var lightColor: Color = Color.black
    
    let colorPalette: Palettes = .shadesOfTeal
//    let colorPalette: Palettes = .beach
//    let colorPalette: Palettes = .neonColors
    
    func fetch(_ isOn: Bool = false) -> Void {
        let lengthInSeconds: TimeInterval = 1
        
        timer?.invalidate()
        if isOn {
            timer = Timer.scheduledTimer(withTimeInterval: lengthInSeconds, repeats: false) { (_) in
                
                self.lightColor = self.colorPalette.colors[self.currentIndex]
                if self.currentIndex == self.colorPalette.colors.count - 1 {
                    self.currentIndex = 0
                } else {
                    self.currentIndex += 1
                }
                self.fetch(true)
            }
        }
    }
}
