//
//  MeditationScreen.swift
//  Hello World
//
//  Created by Carlos Limonggi on 1/11/23.
//

import SwiftUI

struct MeditationScreen: View {
    @ObservedObject var vm: MeditationViewModel = MeditationViewModel()
    
    var body: some View {
            ZStack {
                TimelineView(.animation) { timeline in
                    MeditationView(startTime: $vm.time, timeline: timeline)
                        .opacity(vm.isOn ? 1.0 : 0.0)
                }
                VStack {
                    HStack {
                        Button {
                            vm.togglePower()
                        } label: {
                            Image(systemName: vm.isOn ? "lightbulb.slash.fill" : "lightbulb.max.fill")
                                .frame(width: 30)
                            .padding(1)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                        }
                        .clipShape(Circle())
                        .buttonStyle(.bordered)
                        
                        Spacer()
                        Button {
                            
                            withAnimation(.easeInOut(duration: 1.2)) {
                                vm.togglePicker()
                            }
                        } label: {
                            Image(systemName: "stopwatch")
                            .frame(width: 30)
                            .padding(1)
                            .foregroundColor( vm.isOn ? .yellow : .gray)
                            .fontWeight(.bold)
                        }
                        .clipShape(Circle())
                        .buttonStyle(.bordered)
                    }
                    .padding(.horizontal, 10)
                    Spacer()
                    
                    if vm.isTimerPickerOn {
                            Picker("Choose the meditation length", selection: $vm.meditationLength) {
                                Text("2 seg").tag(Double(2))
                                Text("5 seg").tag(Double(5))
                                Text("10 seg").tag(Double(10))
                                ForEach(1..<10) { number in
                                    Text("\(number) min").tag(Double(number * 60))
                                }
                            }.pickerStyle(.wheel)
                        
                    }
                }
                
            
        }
    }
}

#Preview {
        MeditationScreen()
}
