//
//  ContentViewModel.swift
//  Hello World
//
//  Created by Carlos Limonggi on 13/1/24.
//

import Foundation

class ContentViewModel: NSObject, ObservableObject {
    func getHapticsOn() -> Bool {
        return UserDefaults.standard.bool(forKey: "HapticsOn")
    }
}
