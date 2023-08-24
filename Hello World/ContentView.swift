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
        @State private var isOn: Bool = false
        @ObservedObject private var colorShuffler: ColorShuffler = ColorShuffler()
        
        @State private var buttonsArrayView: [ExpandableButtonItem] = Array()
        
        
        var body: some View {
            
            
            VStack(spacing: 0) {
                ZStack {
                    Rectangle()
                        .fill(colorShuffler.lightColor)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture(count: 2) {
                            resetColorShuffler()
                        }
                        .onTapGesture {
                            powerSwitch()
                        }
                    VStack{
                        Spacer()
                        HStack{
                            Spacer()
                            ExpandableButtonPanel(primaryButton: ExpandableButtonItem(label: Image(systemName: "ellipsis")
                                                                                     ), secondaryButtons: [
                                                                                        ExpandableButtonItem(label: Image(systemName: "ellipsis"), palette: .shadesOfTeal, action: {
                                                                                            colorShuffler.setColorPalette(palette: .shadesOfTeal)
                                                                                        }),
                                                                                        ExpandableButtonItem(label: Image(systemName: "photo"), palette: .neonColors, action: {
                                                                                            colorShuffler.setColorPalette(palette: .neonColors)
                                                                                        }),
                                                                                        ExpandableButtonItem(label: Image(systemName: "camera"), palette: .beach, action: {
                                                                                            colorShuffler.setColorPalette(palette: .beach)
                                                                                        })
                                                                                     ])
                            .padding()
                        }
                    }
                }
            }
        }
        
//        func fillButtons() {
//            ForEach(Palettes.allCases, id: \.self) { Palette in
//                var current: ExpandableButtonItem = ExpandableButtonItem( label: Image(systemName: "ellipsis"), palette: Palette, action: {
//                    colorShuffler.setColorPalette(palette: Palette)
//                })
//                    buttonsArrayView.append(current)
//
//            }
//        }
        
        func resetColorShuffler() {
            isOn = false
            colorShuffler.fetch(isOn)
            colorShuffler.lightColor = .black
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
