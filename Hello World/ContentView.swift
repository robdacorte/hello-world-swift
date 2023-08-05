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
    @State var audioAnalizer: AudioAnalizer
    
    init() {
        self.audioAnalizer = AudioAnalizer()
//        self.audioAnalizer?.setupAudio()
    }
    var body: some View {
        daBulb(audioAnalizer: self.$audioAnalizer)
    }
    
    struct daBulb: View  {
        @Binding var audioAnalizer: AudioAnalizer
        @State private var isOn: Bool = false
        @State private var lightColor: Color = Color.black
        
        @ObservedObject private var colorShuffler: ColorShuffler = ColorShuffler()
        
        
        @State var currentDate = Date.now
//        let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

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
                    VStack {
//                        Text("\(currentDate)")
//                            .onReceive(timer) { input in
//                                currentDate = input
//                            }
//                        Text(colorShuffler.lightColor.description)
//                            .foregroundColor(Color.white)
//                            .font(Font.largeTitle)
//                            .glow(color: .red, radius: 90)
                        Button {
                            self.audioAnalizer.keepRolling()
                        } label: {
                            Label("Tap To Action", image: "pencil")
                        }
                    }
                    
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
