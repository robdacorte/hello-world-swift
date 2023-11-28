//
//  PaletteScreen.swift
//  Hello World
//
//  Created by Carlos Limonggi on 1/11/23.
//

import SwiftUI

struct PaletteScreen: View  {
    @ObservedObject var vm: PaletteViewModel = PaletteViewModel()
    
    @State private var paletteButtons: [ButtonsPanelView.ButtonItem] = []
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Rectangle()
                    .fill(vm.switchColorAnimation ? vm.firstColor : vm.secondColor)
                    .edgesIgnoringSafeArea(.all)
                    .animation(.easeInOut(duration: vm.transitionSpeed), value: vm.switchColorAnimation)
                    .onTapGesture {
                        vm.togglePower()
                    }
                VStack{
                    HStack {
                        Button {
                            vm.togglePower()
                        } label: {
                            Image(systemName: vm.isOn ? "lightbulb.slash.fill" : "lightbulb.max.fill")
                            .padding(1)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                        }
                        .clipShape(Circle())
                        .buttonStyle(.bordered)
                        
                        Spacer()
                        
                        if vm.isOn {
                            Button {
                                
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    vm.toggleSpeedPicker()
                                }
                            } label: {
                                Image(systemName: "stopwatch")
                                .padding(1)
                                .foregroundColor( vm.isSpeedPickerOn ? .yellow : .gray)
                                .fontWeight(.bold)
                            }
                            .clipShape(Circle())
                            .buttonStyle(.bordered)
                            
                            Button {
                                vm.toggleShuffle()
                            } label: {
                                Image(systemName: "shuffle")
                                .padding(1)
                                .foregroundColor( vm.isShuffleOn ? .yellow : .gray)
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
                        ButtonsPanelView(
                            primaryButton: vm.getPrimaryButton(),
                            secondaryButtons: vm.getSecondaryButtons()
                        )
                            .padding()
                        
                    }
                    if vm.isSpeedPickerOn {
                            Picker("Choose the transition speed", selection: $vm.transitionSpeed) {
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
    PaletteScreen()
}
