//
//  MeditationViewModel.swift
//  Hello World
//
//  Created by Carlos Limonggi on 20/12/23.
//

import SwiftUI

class MeditationViewModel: NSObject, ObservableObject {
    var time: Date = .now
    var timer: Timer?
    
    @Published var isOn: Bool = false
    @Published var volume: Float = 0
    
    @Published var isTimerPickerOn: Bool = false
    @Published var meditationLength: Double = 120.0
    @Published var numberOfAlerts: Int = 1
    
    func togglePicker() -> Void {
        self.isTimerPickerOn.toggle()
    }
    
    func togglePower() -> Void {
        self.isOn = !self.isOn
        
        
        
        timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(meditationLength), repeats: false) { timer in
            print("desde el callback")
            self.isOn = false
            self.volume = 0.9
//             timer.invalidate()
            print(timer)
        }
        
        
        
        
        
        if self.isOn {
            self.volume = 1.1
        } else {
            self.volume = 0.9
        }
    }
    
}
