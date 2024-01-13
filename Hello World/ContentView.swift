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
    @ObservedObject var vm: ContentViewModel = ContentViewModel()
    
    private let marginBottom: CGFloat = 60
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedView) {
                PaletteScreen().tag(1)
                ShaderScreen().tag(2)
                MeditationScreen().tag(3)
                SettingsScreen().tag(4)
            }
            .sensoryFeedback(trigger: selectedView) { oldValue, newValue in
                if (vm.getHapticsOn() && (oldValue != newValue)) {
                    return .success
                } else {
                    return nil
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))

            VStack {
                Spacer()
                HStack(spacing: 0) {
                    TabViewLink($selectedView: $selectedView, selectedViewId: 1, image: "house.fill", title: "Default")
                    TabViewLink($selectedView: $selectedView, selectedViewId: 2,image: "waveform.path", title: "Wave")
                    TabViewLink($selectedView: $selectedView, selectedViewId: 3 , image: "figure.mind.and.body", title: "Meditation")
                    TabViewLink($selectedView: $selectedView, selectedViewId: 4 , image: "gear", title: "Settings")
                }
                .padding(.bottom, 40)
            }
            .frame(maxWidth: .infinity)
        }
        .ignoresSafeArea()
    }
    
    @ViewBuilder
    func TabViewLink(@Binding selectedView: Int, selectedViewId:Int, image:String, title: String) -> some View {
        Button {
            selectedView = selectedViewId
        } label: {
            VStack {
                Image(systemName: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 20)
                Text(title)
                    .font(.footnote)
                    .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
            }
            .foregroundColor(.white)
            .opacity(selectedView == selectedViewId ? 0.4 : 0.8)
        }.tabButtonWidth()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
