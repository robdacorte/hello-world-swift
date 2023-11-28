//
//  RainbowNoiseView.swift
//  Hello World
//
//  Created by Rob on 25/11/23.
//

import SwiftUI

struct RainbowNoiseView: View {
    @Binding var startTime: Date
    var timeline: TimelineViewDefaultContext
    var body: some View {
        let elapsedTime = startTime.distance(to: timeline.date)
        Rectangle()
            .colorEffect(
                ShaderLibrary.rainbowNoise(
                    .float(cos(elapsedTime))
                )
            )
            .ignoresSafeArea()
    }
}

