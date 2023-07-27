//
//  ContentView.swift
//  Hello World
//
//  Created by Rob on 21/6/23.
//

import SwiftUI
import AVFoundation

extension View {
    func glow(color: Color = .blue, radius: CGFloat = 20) -> some View {
        self
            .overlay(self.blur(radius: radius / 6))
            .shadow(color: color, radius: radius / 3)
            .shadow(color: color, radius: radius / 3)
            .shadow(color: color, radius: radius / 3)
    }
}

//func getMyAudioSession() -> String {
//
//    // Retrieve the shared audio session.
//    let audioSession = AVFoundation.AVAudioSession.sharedInstance()
//
//    return "Audio Session outputLatency: \(audioSession.outputLatency)"
//}

struct ContentView: View {
    init() {}
    var body: some View {
        daBulb()
    }
    
    struct daBulb: View  {
        @State private var isOn: Bool = false
        @State private var lightColor: Color = Color.black
        
        @ObservedObject private var colorShuffler: ColorShuffler = ColorShuffler()
                
//        @State private var audioText: String = getMyAudioSession()
        
        var body: some View {
            
            
            VStack(spacing: 0) {
                ZStack {
                    Rectangle()
                        .fill(colorShuffler.lightColor)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            powerSwitch()
                        }
                    Text(colorShuffler.lightColor.description)
                        .foregroundColor(Color.white)
                        .font(Font.largeTitle)
                        .glow(color: .red, radius: 90)
                    
                }
            }
        }
        
        func powerSwitch() {
            isOn = !isOn
            
            colorShuffler.fetch(isOn)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
