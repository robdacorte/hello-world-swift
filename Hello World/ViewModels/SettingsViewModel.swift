//
//  SettingsModel.swift
//  Hello World
//
//  Created by Carlos Limonggi on 11/1/24.
//

import Foundation

class SettingsViewModel: NSObject, ObservableObject {
    @Published var hapticsOn: Bool {
        didSet {
            UserDefaults.standard.set(hapticsOn, forKey: "HapticsOn")
        }
    }
    
    override init() {
        self.hapticsOn = UserDefaults.standard.bool(forKey: "HapticsOn")
    }
    
}
