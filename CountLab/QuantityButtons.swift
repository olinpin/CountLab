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
    @State var sum: Float = 0

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
            self.sum += value
        }, label: {
            let color: Color = value < 0 ? .red : .blue
            Text("\(formatFloat(value))")
                .padding()
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(color.opacity(0.5))
                .border(color, width: 5)
                .font(.system(size: 200))
                .minimumScaleFactor(0.01)
                .aspectRatio(3/2, contentMode: .fit)
        })

    }
    
    func formatFloat(_ number: Float) -> String {
        let formatter = Formatter.withSeparator
        return formatter.string(from: number as NSNumber) ?? "\(number)"
    }
}

#Preview {
    QuantityButtons()
}
