//
//  CircleWavesView.swift
//  Hello World
//
//  Created by Rob on 25/11/23.
//

import SwiftUI

struct CircleWavesView: View {
    @Binding var startTime: Date
    var timeline: TimelineViewDefaultContext
    var body: some View {
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
                            .float(0.2),
                            .float(0.3), // Wave timing
                            .float(2), // Brightness
                            .float(100), // Seed speed
                            .float2(0.5, 0.5),
                            .color(.orange)
                        )
                    )
                    //.offset(x: (proxy.size.width <= elapsedTime * 10 ) ? elapsedTime * 10 : elapsedTime * -10, y: 0)
                    .offset(x: ((cos(elapsedTime) <= 0 )) ? cos(elapsedTime) * 50 : cos(elapsedTime) * -50, y: (sin(elapsedTime) <= 0 ) ? sin(elapsedTime) * 70 : sin(elapsedTime) * -70)
            }
    }
}
