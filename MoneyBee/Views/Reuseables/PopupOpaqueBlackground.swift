//
//  PopupOpaqueBlackground.swift
//  MoneyBee
//
//  Created by eric on 2022-03-15.
//

import SwiftUI

struct PopupOpaqueBlackground: View {
    var body: some View {
        Color.black
            .opacity(0.6)
            .ignoresSafeArea()
    }
}

struct PopupOpaqueBlackground_Previews: PreviewProvider {
    static var previews: some View {
        PopupOpaqueBlackground()
    }
}
