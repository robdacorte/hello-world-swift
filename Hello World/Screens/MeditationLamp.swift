//
//  MeditationLamp.swift
//  Hello World
//
//  Created by Carlos Limonggi on 1/11/23.
//

import SwiftUI

struct MeditationLamp: View {
    @State private var start = Date.now
    var body: some View {
        TimelineView(.animation) { timeline in
            SinusodalView(start: $start, timeline: timeline)
        }.ignoresSafeArea()
    }
}

#Preview {
    MeditationLamp()
}
