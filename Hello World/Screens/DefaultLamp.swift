//
//  DefaultLamp.swift
//  Hello World
//
//  Created by Carlos Limonggi on 1/11/23.
//

import SwiftUI

struct DefaultLamp: View  {
    
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
                    HStack {
                        Button {
                            colorShuffler.togglePower()
                        } label: {
                            Image(systemName: colorShuffler.isOn ? "lightbulb.slash.fill" : "lightbulb.max.fill")
                            .padding(1)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                        }
                        .clipShape(Circle())
                        .buttonStyle(.bordered)
                        
                        Spacer()
                        
                        if colorShuffler.isOn {
                            Button {
                                
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    colorShuffler.toggleSpeedPicker()
                                }
                            } label: {
                                Image(systemName: "stopwatch")
                                .padding(1)
                                .foregroundColor( colorShuffler.isSpeedPickerOn ? .yellow : .gray)
                                .fontWeight(.bold)
                            }
                            .clipShape(Circle())
                            .buttonStyle(.bordered)
                            
                            Button {
                                colorShuffler.toggleShuffle()
                            } label: {
                                Image(systemName: "shuffle")
                                .padding(1)
                                .foregroundColor( colorShuffler.isShuffleOn ? .yellow : .gray)
                                .fontWeight(.bold)
                            }
                            .clipShape(Circle())
                            .buttonStyle(.bordered)
                        }
                    }
                    .padding(.horizontal, 10)
                    Spacer()
                    HStack{
                        Spacer()
                        ExpandableButtonPanelFixed(colorShuffler: colorShuffler)
                            .padding()
                        
                    }
                    if colorShuffler.isSpeedPickerOn {
                            Picker("Choose the transition speed", selection: $colorShuffler.transitionSpeed) {
                                Text(".1 s").tag(Double(0.1))
                                Text(".5 s").tag(Double(0.5))
                                ForEach(1..<10) { number in
                                    Text("\(number.description) s").tag(Double(number))
                                }
                            }.pickerStyle(.wheel)
                        
                    }
                }
                .paddingBottom()
            }
        }
    }
}

#Preview {
    DefaultLamp()
}
