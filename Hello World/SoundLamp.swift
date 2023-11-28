//
//  SoundLamp.swift
//  Hello World
//
//  Created by Carlos Limonggi on 1/11/23.
//

import SwiftUI


struct RainbowNoiceView: View {
    @State private var startTime = Date.now
    
    var body: some View {
        TimelineView(.animation) { timeline in
            let elapsedTime = startTime.distance(to: timeline.date)
            Rectangle()
                .colorEffect(
                    ShaderLibrary.labEffect(
                        .float(cos(elapsedTime))
                    )
                )
                .ignoresSafeArea()
        }
    }
}


struct SoundLamp: View  {
    @State private var startTime = Date.now

    var body: some View {
        TimelineView(.animation) { timeline in
            let elapsedTime = startTime.distance(to: timeline.date)
            
            Image(systemName: "circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: UIScreen.main.bounds.height * 2)
                .padding()
                .drawingGroup()
                .visualEffect { content, proxy in
                    content
                        .colorEffect(
                            ShaderLibrary.circleWave(
                                .float2(proxy.size),
                                .float(elapsedTime),
                                .float(0.5),
                                .float(1), // Wave timing
                                .float(2), // Brightness
                                .float(100), // Seed speed
                                .float2(0.5, 0.5),
                                .color(.orange)
                            )
                        )
                        //.offset(x: (proxy.size.width <= elapsedTime * 10 ) ? elapsedTime * 10 : elapsedTime * -10, y: 0)
                        .offset(x: ((cos(elapsedTime) <= 0 )) ? cos(elapsedTime) * 150 : cos(elapsedTime) * -150, y: (sin(elapsedTime) <= 0 ) ? sin(elapsedTime) * 170 : sin(elapsedTime) * -170)
                }
         
            
            
        }
    }
    
}


#Preview {
    RainbowNoiceView()
//    SoundLamp()
}
