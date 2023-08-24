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
    private var currentIndex: Int = 0
    private var currentTime: Int = 0
    @Published var firstColor: Color = .black
    @Published var secondColor: Color = .white
    @Published var switchColorAnimation: Bool = false
    @Published var colorPalette: Palettes = .shadesOfTeal
    @Published var transitionSpeed: Double = 1.0
    private var cancellable = Set<AnyCancellable>()
//    let colorPalette: Palettes = .beach
//    let colorPalette: Palettes = .neonColors

    
    func fetch(_ isOn: Bool = false) -> Void {
        let lengthInSeconds: TimeInterval = TimeInterval(floatLiteral: transitionSpeed)
        
        timer?.invalidate()
        if isOn {
            timer = Timer.scheduledTimer(withTimeInterval: lengthInSeconds, repeats: false) { timer in
                self.firstColor = self.colorPalette.colors[self.currentIndex]
                self.secondColor = self.colorPalette.colors[self.getSecondaryIndex(currentIndex: self.currentIndex)]

                self.switchColorAnimation = !self.switchColorAnimation
                
                if self.currentTime % 2 != 0 {
                    self.updateCurrentIndex()
                }
                
                self.fetch(true)
                self.currentTime += 1
            }
        } else {
            timer?.invalidate()
            timer = nil
            switchColorAnimation = false
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
        print(currentIndex + 1)
        return currentIndex + 1
    }
}
