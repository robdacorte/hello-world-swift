//
//  ExpandableButtonPanel.swift
//  Hello World
//
//  Created by Carlos Limonggi on 16/8/23.
//

import SwiftUI




struct ExpandableButtonItem: Identifiable {
    let id = UUID()
    let label: Image?
    var palette: Palettes? = nil
    var action: (() -> Void)? = nil
}


struct ExpandableButtonPanelFixed: View {
    let colorShuffler: ColorShuffler
    let primaryButton: ExpandableButtonItem = ExpandableButtonItem(label: Image(systemName: "rainbow").renderingMode(.original))
    let secondaryButtons: [ExpandableButtonItem] = []
    
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
                ForEach(Palettes.allCases) { palette in
                    if (colorShuffler.colorPalette != palette) || !colorShuffler.isOn {
                        
                        Button(action: {
                            withAnimation {
                                self.isExpanded.toggle()
                            }
                            colorShuffler.setColorPalette(palette: palette)
                        }, label: {
                                VStack(spacing: 0.0){
                                    ForEach(palette.colors, id: \.self) { color in
                                        color
                                    }
                                }
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
                self.primaryButton.action?()
            }, label: {
                if colorShuffler.isOn {
                    VStack(spacing: 0.0){
                        ForEach(colorShuffler.colorPalette.colors, id: \.self) { color in
                            color
                        }
                    }
                    .frame(width: self.size, height: self.size)
                    .cornerRadius(self.cornerRadius)
                } else {
                    self.primaryButton.label
                        .frame(width: self.size, height: self.size)
                        .cornerRadius(self.cornerRadius)
                }
            })
            .frame(width: self.size, height: self.size)
        }
        .cornerRadius(self.cornerRadius)
        .shadow(radius: 5)
        
    }
}




struct ExpandableButtonPanel_Previews: PreviewProvider {
    static var previews: some View {
        ExpandableButtonPanelFixed(colorShuffler: ColorShuffler()).previewLayout(.sizeThatFits)
        
        // Example without palettes
        //        ExpandableButtonPanel(primaryButton: ExpandableButtonItem(label: Image(systemName: "ellipsis")), secondaryButtons: [
        //            ExpandableButtonItem(label: Image(systemName: "photo")),
        //            ExpandableButtonItem(label: Image(systemName: "camera"))
        //        ])
    }
}
