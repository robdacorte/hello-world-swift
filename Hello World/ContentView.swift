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
                        .fill(colorShuffler.switchColorAnimation ? colorShuffler.firstColor : colorShuffler.secondColor)
                        .edgesIgnoringSafeArea(.all)
                        .animation(.easeInOut(duration: colorShuffler.transitionSpeed), value: colorShuffler.switchColorAnimation)
                    VStack {
//                        Text("\(currentDate)")
//                            .onReceive(timer) { input in
//                                currentDate = input
//                            }
//                        Text(colorShuffler.lightColor.description)
//                            .foregroundColor(Color.white)
//                            .font(Font.largeTitle)
//                            .glow(color: .red, radius: 90)
                        Spacer()
                        Button {
                            powerSwitch()
                        } label: {
                            Label( isOn ? "Tap to Stop" : "Tap to Play", systemImage: isOn ? "stop.fill" : "play.fill")
                        }
                        .buttonStyle(.borderedProminent)
                        Picker("Choose a color palette", selection: $colorShuffler.colorPalette) {
                            ForEach(Palettes.allCases) { palette in
                                Text("\(palette.name)").tag(palette)
                            }
                        }
                        Picker("Choose the transition speed", selection: $colorShuffler.transitionSpeed) {
                            ForEach(1..<10) { number in
                                Text("\(number.description) s").tag(Double(number))
                            }
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
