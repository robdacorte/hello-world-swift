//
//  SettingsScreen.swift
//  Hello World
//
//  Created by Carlos Limonggi on 1/11/23.
//

import SwiftUI

struct SettingsScreen: View {
    @ObservedObject var vm: SettingsViewModel = SettingsViewModel()
    
    var body: some View {
        Form {
            Section {
                Toggle(isOn: $vm.hapticsOn) {
                    Text("Vibrate on tab change")
                }
            }
        }.formStyle(.grouped)
    }
}

#Preview {
    SettingsScreen(vm: SettingsViewModel())
}
