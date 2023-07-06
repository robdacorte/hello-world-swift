//
//  ColorShuffler.swift
//  Hello World
//
//  Created by Carlos Limonggi on 4/7/23.
//

import Foundation
import SwiftUI

class ColorShuffler: NSObject {
    var timer: Timer?
    var currentIndex: Int = 0
    var lightColor: Color = Color.black
    
    let shadesOfTeal: [Color] = [
        Color(red:178, green:216, blue:216),
        Color(red:102, green:178, blue:178),
        Color(red:0, green:128, blue:128),
        Color(red:0, green:102, blue:102),
        Color(red:0, green:76, blue:76)
    ]
    
    func fetch() -> Void {
        let lengthInSeconds: TimeInterval = 1
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: lengthInSeconds, repeats: false) { (_) in
            
//            self.currentIndex = Int.random(in: 0..<self.shadesOfTeal.count)
            if self.currentIndex >= self.shadesOfTeal.count {
                self.currentIndex = 0
            } else {
                self.currentIndex += 1
            }
            self.lightColor = self.shadesOfTeal[self.currentIndex]
            self.fetch()
        }
    }
}
