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
        Rectangle()
            .colorEffect(
                ShaderLibrary.testingEffect(
                    .float(cos(elapsedTime))
                )
            )
            .ignoresSafeArea()
    }
}
