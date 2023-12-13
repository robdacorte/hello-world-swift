//
//  TestingEffectView.swift
//  Hello World
//
//  Created by Rob on 25/11/23.
//

import SwiftUI

struct TestingEffectView: View {
    @Binding var startTime: Date
    var timeline: TimelineViewDefaultContext
    var body: some View {
        let elapsedTime = startTime.distance(to: timeline.date)
        VStack {
            Rectangle()
                .visualEffect { content, proxy in
                    content
                        .colorEffect(
                            ShaderLibrary.circleWave(
//                                .float2(CGSize(width: proxy.size.width / 2, height: proxy.size.height / 2)),
                                .float2(proxy.size),
                                .float(elapsedTime),
                                .float(0.2),
                                .float(0.5), // Wave timing
                                .float(2), // Brightness
                                .float(150), // Seed speed
                                .float2(0.5, 0.5),
                                .color(.orange)
                            )
                        )
                }
        }
        .ignoresSafeArea()
    }
}

//#Preview {
//    @Binding var startTime: Date
//    TimelineView(.animation) { timeline in
//        TestingEffectView(startTime: $startTime, timeline: timeline)
//    }
//}
