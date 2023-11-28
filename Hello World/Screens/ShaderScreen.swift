//
//  ShaderScreen.swift
//  Hello World
//
//  Created by Carlos Limonggi on 1/11/23.
//

import SwiftUI


struct ShaderScreen: View  {
    @ObservedObject var vm: ShaderViewModel = ShaderViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                TimelineView(.animation) { timeline in
                    switch vm.selectedShader {
                    case .circleWave:
                        CircleWavesView(startTime: $vm.time, timeline: timeline)
                    case .sinusoidal:
                        SinusodalView(start: $vm.time, timeline: timeline)
                    case .rainbowNoise:
                        RainbowNoiseView(startTime: $vm.time, timeline: timeline)
                    case .testingEffect:
                        TestingEffectView(startTime: $vm.time, timeline: timeline)
                    }
                }
                VStack(content: {
                    
                    Spacer()
                    HStack{
                        Spacer()
                        ButtonsPanelView(
                            primaryButton: vm.getPrimaryButton(),
                            secondaryButtons: vm.getSecondaryButtons()
                        )
                        .padding()
                        
                    }
                })
                .paddingBottom()
            }
        }
    }
    
}


#Preview {
    ShaderScreen()
}
