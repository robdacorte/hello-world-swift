//
//  SoundLamp.swift
//  Hello World
//
//  Created by Carlos Limonggi on 1/11/23.
//

import SwiftUI


struct SoundLamp: View  {
    @ObservedObject private var audioAnalizer: AudioAnalizer = AudioAnalizer()
    
    @ObservedObject private var colorShuffler: ColorShuffler = ColorShuffler()
    
    @State private var buttonsArrayView: [ExpandableButtonItem] = Array()
    
    @State private var offsetY: CGFloat = 0
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Rectangle()
                    .fill(colorShuffler.switchColorAnimation ? colorShuffler.firstColor : colorShuffler.secondColor)
                    .edgesIgnoringSafeArea(.all)
                //                    .animation(.easeInOut(duration: colorShuffler.transitionSpeed), value: colorShuffler.switchColorAnimation)
                    .onTapGesture {
                        colorShuffler.togglePower()
                    }
                VStack{
                    Spacer()
                    Circle()
                        .fill(.blue)
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                        .offset(y:-(offsetY + CGFloat(audioAnalizer.currentPulseDb0 * 2)))
                        .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/, value: audioAnalizer.currentPulseDb0)
                    Text("\(audioAnalizer.currentPulseDb0)")
                        .font(.title)
                    Text("\(audioAnalizer.currentPulsePk0)")
                        .font(.title)
                    HStack{
                        Spacer()
                        ExpandableButtonPanelFixed(colorShuffler: colorShuffler)
                            .padding()
                        
                    }
                    
                    
                    Button {
                        audioAnalizer.outterStop()
                    } label: {
                        Label("Tap to stop", systemImage: "stop.fill")
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Button {
                        audioAnalizer.outterStart()
                    } label: {
                        Label("Tap to Record", systemImage: "mic.fill")
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Button {
                        colorShuffler.togglePower()
                    } label: {
                        Label( colorShuffler.isOn ? "Tap to Stop" : "Tap to Play", systemImage: colorShuffler.isOn ? "stop.fill" : "play.fill")
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Button {
                        colorShuffler.toggleShuffle()
                    } label: {
                        Label( colorShuffler.isOn ? "Stop Random Pulse" : "Play Random Pulse", systemImage: colorShuffler.isOn ? "stop.fill" : "play.fill")
                    }
                    .buttonStyle(.borderedProminent)
                    //                        Picker("Choose a color palette", selection: $colorShuffler.colorPalette) {
                    //                            ForEach(Palettes.allCases) { palette in
                    //                                Text("\(palette.name)").tag(palette)
                    //                            }
                    //                        }
                    Picker("Choose the transition speed", selection: $colorShuffler.transitionSpeed) {
                        Text(".1 s").tag(Double(0.1))
                        Text(".5 s").tag(Double(0.5))
                        ForEach(1..<10) { number in
                            Text("\(number.description) s").tag(Double(number))
                        }
                    }
                }
                .paddingBottom()
            }
            
        }
    }
}

#Preview {
    SoundLamp()
}
