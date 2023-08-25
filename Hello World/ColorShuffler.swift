//
//  ColorShuffler.swift
//  Hello World
//
//  Created by Carlos Limonggi on 4/7/23.
//

import Foundation
import SwiftUI
import Combine

class ColorShuffler: NSObject, ObservableObject {
    var timer: Timer?
    var currentIndex: Int = 0
    
    private var currentTime: Int = 0
    
    @Published var isOn: Bool = false
    @Published var firstColor: Color = .black
    @Published var secondColor: Color = .white
    @Published var switchColorAnimation: Bool = false
    @Published var colorPalette: Palettes = .shadesOfTeal
    @Published var transitionSpeed: Double = 1.0
    
    func setColorPalette(palette: Palettes) -> Void {
        self.colorPalette = palette
        self.isOn = false
        self.togglePower()
    }
    func getColorPalette() -> Palettes {
        self.colorPalette
    }

    
    func togglePower() -> Void {
        let lengthInSeconds: TimeInterval = TimeInterval(floatLiteral: transitionSpeed)
        self.isOn = !self.isOn
        
        // When set to true, this means the screen will never dim or go to sleep
        UIApplication.shared.isIdleTimerDisabled = self.isOn
        
        timer?.invalidate()
        if self.isOn {
            timer = Timer.scheduledTimer(withTimeInterval: lengthInSeconds, repeats: true) { timer in
                self.firstColor = self.colorPalette.colors[self.currentIndex]
                self.secondColor = self.colorPalette.colors[self.getSecondaryIndex(currentIndex: self.currentIndex)]

                self.switchColorAnimation = !self.switchColorAnimation
                
                if self.currentTime % 2 != 0 {
                    self.updateCurrentIndex()
                }
                
                self.currentTime += 1
            }
        } else {
            timer?.invalidate()
            timer = nil
            switchColorAnimation = self.isOn
            firstColor = .black
            secondColor = .black
        }
    }
    
    private func updateCurrentIndex() {
        if self.currentIndex == self.colorPalette.colors.count - 1 {
            self.currentIndex = 0
        } else {
            self.currentIndex += 1
        }
    }
    
    private func getSecondaryIndex(currentIndex: Int) -> Int {
        if (currentIndex + 1  > colorPalette.colors.count - 1) {
            return 0
        }
        return currentIndex + 1
    }
}
