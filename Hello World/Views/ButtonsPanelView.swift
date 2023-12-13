//
//  ButtonsPanelView.swift
//  Hello World
//
//  Created by Carlos Limonggi on 28/11/23.
//

import SwiftUI

struct ButtonsPanelView: View {
    struct ButtonItem: Identifiable {
        let id = UUID()
        let systemImageString: String
        var action: (() -> Void)
    }
    
    var primaryButton: ButtonItem
    var secondaryButtons: [ButtonItem]
    
    private let size: CGFloat = 45
    private var cornerRadius: CGFloat {
        get {
            size * 0.5
        }
    }
    
    @State private var isExpanded = false
    
    var body: some View {
        VStack {
            if isExpanded {
                ForEach(secondaryButtons) { button in
                    if (button.id != primaryButton.id) {
                        
                        Button(action: {
                            withAnimation {
                                self.isExpanded.toggle()
                            }
                            button.action()
                        }, label: {
                            Image(systemName: button.systemImageString)
                                .frame(width: self.size, height: self.size)
                                .cornerRadius(self.cornerRadius)
                            
                        })
                        .frame(width: self.size, height: self.size)
                    }
                }
            }
            
            Button(action: {
                withAnimation {
                    self.isExpanded.toggle()
                }
                self.primaryButton.action()
            }, label: {
                Image(systemName: primaryButton.systemImageString)
            })
            .frame(width: self.size, height: self.size)
        }
        .background(.black)
        .opacity(0.6)
        .cornerRadius(self.cornerRadius)
        .shadow(radius: 5)
        
    }
}




struct ButtonsPanelView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonsPanelView(primaryButton: ButtonsPanelView.ButtonItem(systemImageString: "poweroff" , action: {
            print("button off")
        }), secondaryButtons: [
            ButtonsPanelView.ButtonItem(systemImageString: "photo", action: {
                print("button photo")
            }),
            ButtonsPanelView.ButtonItem(systemImageString: "camera", action: {
                print("button camera")
            })
        ])
    }
}
