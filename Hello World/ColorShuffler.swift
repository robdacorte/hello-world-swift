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
    var colorPalette: Palettes = .shadesOfTeal
    @Published var lightColor: Color = Color.black
    
    func setColorPalette(palette: Palettes) -> Void {
        self.colorPalette = palette
        self.fetch(true)
    }
    
    func getColorPalette() -> Palettes {
        self.colorPalette
    }
    
    func fetch(_ isOn: Bool = false) -> Void {
        let lengthInSeconds: TimeInterval = 1
        
        // When set to true, this means the screen will never dim or go to sleep
        UIApplication.shared.isIdleTimerDisabled = isOn
        
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
