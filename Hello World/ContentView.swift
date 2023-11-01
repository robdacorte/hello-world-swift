//
//  ContentView.swift
//  Hello World
//
//  Created by Rob on 21/6/23.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    
    @State private var selectedView: Int = 1
    
    var body: some View {
        TabView {
            DefaultLamp().tag(1).tabItem { Label("Default", systemImage: "house") }
            SoundLamp().tag(2).tabItem { Label("Wave", systemImage: "waveform.path") }
            
            // todo
            MeditationLamp().tag(3).tabItem { Label("Meditation", systemImage: "figure.mind.and.body") }
            SettingsView().tag(4).tabItem { Label("Settings and Help", systemImage: "gear") }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
