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


struct ContentView: View {
    var body: some View {
        daBulb()
    }
    
    struct daBulb: View  {
        @ObservedObject private var colorShuffler: ColorShuffler = ColorShuffler()
        
        @State private var buttonsArrayView: [ExpandableButtonItem] = Array()
        
        var body: some View {
            VStack(spacing: 0) {
                ZStack {
                    Rectangle()
                        .fill(colorShuffler.switchColorAnimation ? colorShuffler.firstColor : colorShuffler.secondColor)
                        .edgesIgnoringSafeArea(.all)
                        .animation(.easeInOut(duration: colorShuffler.transitionSpeed), value: colorShuffler.switchColorAnimation)
                        .onTapGesture {
                            colorShuffler.togglePower()
                        }
                    VStack{
                        Spacer()
                        HStack{
                            Spacer()
                            ExpandableButtonPanelFixed(colorShuffler: colorShuffler)
                            .padding()
                            
                        }
                        
                        Button {
                            colorShuffler.togglePower()
                        } label: {
                            Label( colorShuffler.isOn ? "Tap to Stop" : "Tap to Play", systemImage: colorShuffler.isOn ? "stop.fill" : "play.fill")
                        }
                        .buttonStyle(.borderedProminent)
//                        Picker("Choose a color palette", selection: $colorShuffler.colorPalette) {
//                            ForEach(Palettes.allCases) { palette in
//                                Text("\(palette.name)").tag(palette)
//                            }
//                        }
                        Picker("Choose the transition speed", selection: $colorShuffler.transitionSpeed) {
                            ForEach(1..<10) { number in
                                Text("\(number.description) s").tag(Double(number))
                            }
                        }
                    }
                }
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
