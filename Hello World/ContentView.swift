//
//  ContentView.swift
//  Hello World
//
//  Created by Rob on 21/6/23.
//

import SwiftUI

struct ContentView: View {
    init() {}
    var body: some View {
        daBulb()
    }
    
    struct daBulb: View  {
        @State private var isOn: Bool = false
        @State private var lightColor: Color = Color.black
        
        var body: some View {
                VStack(spacing: 0) {
                    ZStack {
//                        Rectangle()
//                            .fill(.gray)
//                            .edgesIgnoringSafeArea(.all)
                        Rectangle()
                            .fill(lightColor)
                            .edgesIgnoringSafeArea(.all)
//                            .padding(4)
                        
                    }
                    HStack {
                        Spacer()
                        Button {
                            powerSwitch()
                        } label: {
                            Image(systemName: isOn ? "lightswitch.off" : "lightswitch.on")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 60)
//                                .background(Color.gray)
                                .animation(.spring(),value:isOn)
//                                .shadow(color: Color.cyan, radius: 20)
                        }
                        .buttonStyle(.plain)
                            Spacer()
                    }
                    .background(.gray)
                    .frame(width: .infinity, height: 20)
                }
        }
        
        func powerSwitch() {
            isOn = !isOn
            
            if isOn {
                lightColor = Color.purple
            } else {
                lightColor = Color.black
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
