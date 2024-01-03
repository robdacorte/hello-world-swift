//
//  PaletteViewModel.swift
//  Hello World
//
//  Created by Carlos Limonggi on 4/7/23.
//

import SwiftUI

class PaletteViewModel: NSObject, ObservableObject {
    let palettes: [Palettes] = Palettes.allCases
    
    var timer: Timer?
    var currentIndex: Int = 0
    
    private var currentTime: Int = 0
    
    @Published var isOn: Bool = false
    @Published var firstColor: Color = .gray
    @Published var secondColor: Color = .black
    @Published var switchColorAnimation: Bool = false
    @Published var selectedPalette: Palettes = .shadesOfTeal
    @Published var transitionSpeed: Double = 1.0
    @Published var isShuffleOn: Bool = false
    @Published var isSpeedPickerOn: Bool = false
    
    var randomInt: Int = 0

    func getRandomInt() -> Int {
        return Int.random(in: 1..<5)
    }
    
    func setColorPalette(palette: Palettes) -> Void {
        self.selectedPalette = palette
        self.isOn = false
        self.togglePower()
    }
    func getColorPalette() -> Palettes {
        self.selectedPalette
    }
    func toggleShuffle() -> Void {
        self.isShuffleOn.toggle()
    }
    func toggleSpeedPicker() -> Void {
        self.isSpeedPickerOn.toggle()
    }
    func togglePower() -> Void {
        let lengthInSeconds: TimeInterval = TimeInterval(floatLiteral: transitionSpeed)
        self.isOn = !self.isOn
        
        // When set to true, this means the screen will never dim or go to sleep
        UIApplication.shared.isIdleTimerDisabled = self.isOn
        
        timer?.invalidate()
        if self.isOn {
            timer = Timer.scheduledTimer(withTimeInterval: lengthInSeconds, repeats: true) { timer in
                self.randomInt = self.getRandomInt()
                self.firstColor = self.selectedPalette.colors[self.isShuffleOn ? self.randomInt : self.currentIndex]
                self.secondColor = self.selectedPalette.colors[self.getSecondaryIndex(currentIndex: self.isShuffleOn ? self.randomInt : self.currentIndex)]

                self.switchColorAnimation = !self.switchColorAnimation
                
                if !self.isShuffleOn && self.currentTime % 2 != 0 {
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
        
        if self.currentIndex == self.selectedPalette.colors.count - 1 {
            self.currentIndex = 0
        } else {
            self.currentIndex += 1
        }
    }
    private func getSecondaryIndex(currentIndex: Int) -> Int {
        if (currentIndex + 1  > selectedPalette.colors.count - 1) {
            return 0
        }
        return currentIndex + 1
    }
    
    func getPrimaryButton() -> ButtonsPanelView.ButtonItem {
        .init(systemImageString: "poweroff", action: {
            print("primary button pressed from Palettes")
        })
    }
    
    func getSecondaryButtons() -> [ButtonsPanelView.ButtonItem] {
        var secondaryButtonsArray: [ButtonsPanelView.ButtonItem] = []
        for palette in palettes {
            secondaryButtonsArray.append(.init(systemImageString: palette.image, action: {
                self.selectedPalette = palette
                print("aquí vamos Everytime")
                if !self.isOn {
                    self.togglePower()
                    print("aquí vamos inside del if")
                }
            }))
        }
        
        return secondaryButtonsArray
    }
    
    enum Palettes: Identifiable, CaseIterable {
        case off
        case shadesOfTeal
        case beach
        case neonColors
        case aetherpunk
        
        var id: Self { self }
        
        var name: String {
            switch self {
            case .off: return "OFF"
            case .shadesOfTeal: return "Shade of Teal"
            case .beach: return "Beach"
            case .neonColors: return "Neon Colors"
            case .aetherpunk: return "Aether Punk"
            }
        }
        
        var colors: [Color] {
            switch self {
            case .off:
                return [
                    .black,
                    .black,
                    .black,
                    .black,
                    .black
                ]
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
            case .aetherpunk:
                return [
                    Color(red:233/255, green:214/255, blue:107/255),
                    Color(red:240/255, green:220/255, blue:130/255),
                    Color(red:204/255, green:153/255, blue:0),
                    Color(red:46/255, green:45/255, blue:136/255),
                    Color(red:194/255, green:59/255, blue:34/255)
                ]
            }
        }
        
        var image: String {
            switch self {
            case .off: "1.lane"
            case .shadesOfTeal: "2.lane"
            case .beach: "3.lane"
            case .neonColors: "4.lane"
            case .aetherpunk: "5.lane"
            }
        }
    }
    
}
