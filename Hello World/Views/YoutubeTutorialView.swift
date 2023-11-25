//
//  YoutubeTutorialView.swift
//  Hello World
//
//  Created by Rob on 25/11/23.
//

import SwiftUI

struct YoutubeTutorialView: View {
    @Binding var startTime: Date
    var timeline: TimelineViewDefaultContext
    var body: some View {
        let elapsedTime = startTime.distance(to: timeline.date)
        Rectangle()
            .visualEffect { content, geometryProxy in
                content.colorEffect(
                    ShaderLibrary.youtubeTutorial(
                        .float2(.init(x: 120, y: 120)),
                        .float2(geometryProxy.size),
                        .float(elapsedTime)
                    )
                )
            }
            .ignoresSafeArea()
    }
}
