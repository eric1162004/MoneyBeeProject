//
//  StrokeText.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-28.
//

import SwiftUI

struct StrokeText: View {
    let text: String
    let width: CGFloat
    let color: Color

    var body: some View {
        ZStack{
            ZStack{
                Text(text).offset(x:  width, y:  width)
                Text(text).offset(x: -width, y: -width)
                Text(text).offset(x: -width, y:  width)
                Text(text).offset(x:  width, y: -width)
            }
            .foregroundColor(color)
            Text(text)
        }
    }
}


struct StrokeText_Previews: PreviewProvider {
    static var previews: some View {
        StrokeText(text: "Money Bee", width: 0.5, color: .black)
            .foregroundColor(Color.primaryColor)
            .font(.system(size: FontSize.xlarge, weight: .bold))
    }
}
