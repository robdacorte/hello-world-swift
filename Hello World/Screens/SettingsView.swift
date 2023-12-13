//
//  SettingsView.swift
//  Hello World
//
//  Created by Carlos Limonggi on 1/11/23.
//

import SwiftUI

struct SettingsView: View {
    @State private var showingFirstView = true
    @State private var opacity = 1.0

    var body: some View {
        VStack {
            if showingFirstView {
                Image(systemName: "figure.walk.circle")
                    .font(.system(size: 300))
                    .foregroundStyle(.white)
                    .padding()
                    .background(.blue)
                    .opacity(opacity)
                    .transition(.swirl(radius: 0.5))
            } else {
                Image(systemName: "figure.run.circle")
                    .font(.system(size: 300))
                    .foregroundStyle(.white)
                    .padding()
                    .background(.indigo)
                    .opacity(opacity)
                    .transition(.swirl(radius: 0.5))
            }

            Button("Toggle Views") {
                withAnimation(.easeIn(duration: 1.5)) {
                    showingFirstView.toggle()
                }
            }
        }
    }
}

//
//
//    struct SettingsView: View {
//        @State private var showingFirstView = true
//
//        var body: some View {
//            VStack {
//                if showingFirstView {
//                    Image(systemName: "figure.walk.circle")
//                        .font(.system(size: 300))
//                        .foregroundStyle(.white)
//                        .padding()
//                        .background(.blue)
//                        .drawingGroup() .transition(.diamondWave(size: 20))
//
//                } else {
//                    Image(systemName: "figure.run.circle")
//                        .font(.system(size: 300))
//                        .foregroundStyle(.white)
//                        .padding()
//                        .background(.indigo)
//                        .drawingGroup()            .transition(.diamondWave(size: 20))
//
//                }
//
//                Button("Toggle Views") {
//                    withAnimation(.easeIn(duration: 1.5)) {
//                        showingFirstView.toggle()
//                    }
//                }
//            }
//        }
//    }


#Preview {
    SettingsView()
}
