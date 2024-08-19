//
//  QuantityButtons.swift
//  CountLab
//
//  Created by Oliver Hnát on 19.08.2024.
//

import SwiftUI

struct QuantityButtons: View {
    var topLeft: Float = -1
    var bottomLeft: Float = -10
    var topRight: Float = 1
    var bottomRight: Float = 10
    @Binding var sum: Float

    var body: some View {
        HStack {
            VStack {
                fullButton(value: topLeft)
                fullButton(value: bottomLeft)
            }
            VStack {
                fullButton(value: topRight)
                fullButton(value: bottomRight)
            }
        }
    }
    
    func fullButton(value: Float) -> some View {
        Button(action: {
            withAnimation {
                self.sum += value
            }
        }, label: {
            let color: Color = value < 0 ? .red : .blue
            QuantityButtons.buttonView(value: Utils.formatFloat(value), color: color)
        })

    }
    
    static func buttonView(value: String, color: Color) -> some View {
            Text("\(value)")
                .padding()
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(color.opacity(0.5))
                .border(color, width: 5)
                .font(.system(size: 200))
                .minimumScaleFactor(0.01)
                .aspectRatio(3/2, contentMode: .fit)

    }
    
}

#Preview {
    
    return QuantityButtons(sum: Binding.constant(0))
}
