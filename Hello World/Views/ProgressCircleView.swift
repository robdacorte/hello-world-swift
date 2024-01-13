//
//  ProgressCircleView.swift
//  Hello World
//
//  Created by Rob on 5/1/24.
//

import SwiftUI

struct ProgressCircleView: View {
    //MARK: - Properties
    var model: Model
    
    //MARK: - Body
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: model.percentage)
                .stroke(model.color, style: StrokeStyle(lineWidth: model.size / 15, lineCap: .round))
                .frame(width: model.size, height: model.size)
                .rotationEffect(.degrees(270))
            Circle()
                .trim(from: 0, to: 1)
                .stroke(model.color, style: StrokeStyle(lineWidth: model.size / 60, lineCap: .round))
                .frame(width: model.size, height: model.size)
                .rotationEffect(.degrees(270))
            Text(model.time)
                .shadow(color: .black.opacity(0.2), radius: 5, x: 10, y: 10)
                .font(.system(size: model.size / 4, weight: .heavy, design: .serif))
        }
    }
    
    struct Model {
        var color: Color = .red
        var size: CGFloat = 300
        var percentage: CGFloat = 0
        var time: String = "00:00"
    }
}

#Preview {
    ProgressCircleView(model: ProgressCircleView.Model())
}
