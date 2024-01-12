//
//  MeditationScreen.swift
//  Hello World
//
//  Created by Carlos Limonggi on 1/11/23.
//

import SwiftUI
import AVKit

struct MeditationScreen: View {
    //MARK: - Properties
    @ObservedObject var vm: MeditationViewModel = MeditationViewModel()
    //MARK: - Body
    var body: some View {
        ZStack {
            VideoPlayer(player: vm.player)
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
                .navigationBarBackButtonHidden()
            Color.black.opacity(vm.isActive ? 0.2 : 0.5)
                .ignoresSafeArea()
            ProgressCircleView(model: .init(color: .white,size: vm.isActive ? 200 : 270, percentage: vm.getPercentage(), time: vm.getUpdatedTime()))
                .padding(.bottom, vm.isActive ? 500 : 0)
                .animation(.smooth, value: vm.isActive)
            VStack {
                VStack {
                    HStack {
                        Spacer()
                        Button {
                            
                            withAnimation(.easeInOut(duration: 1.2)) {
                                //                                vm.togglePicker()
                            }
                        } label: {
                            Image(systemName: "stopwatch")
                                .frame(width: 30)
                                .padding(1)
                            //                            .foregroundColor( vm.isOn ? .yellow : .gray)
                                .fontWeight(.bold)
                        }
                        .clipShape(Circle())
                        .buttonStyle(.bordered)
                    }
                    .padding(.horizontal, 10)
                    Spacer()
                }
                VStack(alignment: .leading) {
                    Spacer()
                    Button(action: {
                        if vm.isActive {
                            vm.stopTimer()
                        } else {
                            vm.startTimer()
                        }
                    }, label: {
                        Label(vm.isActive ? "Stop" : "Start", systemImage: "timer")
//                            .frame(maxWidth: .infinity)
                    })
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .clipShape(Capsule())
                    .padding(.horizontal, 30)
                    Spacer()
                }
                
            }
        }
    }
}

#Preview {
    MeditationScreen()
}
