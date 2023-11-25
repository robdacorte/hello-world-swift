//
//  SoundLamp.swift
//  Hello World
//
//  Created by Carlos Limonggi on 1/11/23.
//

import SwiftUI


struct SoundLamp: View  {
    @ObservedObject var vm: ShaderViewModel = ShaderViewModel()
    var body: some View {
        ZStack {
            TimelineView(.animation) { timeline in
                switch vm.selectedShader {
                case .circleWave:
                    CircleWavesView(startTime: $vm.time, timeline: timeline)
                case .sinusoidal:
                    SinusodalView(start: $vm.time, timeline: timeline)
                case .rainbowNoise:
                    RainbowNoise(startTime: $vm.time, timeline: timeline)
                case .youtubeTutorial:
                    YoutubeTutorialView(startTime: $vm.time, timeline: timeline)
                }
            }
        }.ignoresSafeArea()
    }
    
}


#Preview {
    SoundLamp()
}
