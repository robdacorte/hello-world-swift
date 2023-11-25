//
//  SinusodalView.swift
//  Hello World
//
//  Created by Rob on 25/11/23.
//

import SwiftUI

struct SinusodalView: View {
    @Binding var start: Date
    var timeline: TimelineViewDefaultContext
    var body: some View {
        let time = start.distance(to: timeline.date)
        Rectangle().visualEffect { content, geometryProxy in
            content.colorEffect(
                ShaderLibrary.sinusoidal(
                    .float2(geometryProxy.size),
                    .float(time),
                    .float(50.0)
                )
            )
        }
    }
}
