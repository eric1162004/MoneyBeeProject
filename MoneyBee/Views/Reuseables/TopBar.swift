//
//  TopBar.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-28.
//

import SwiftUI

struct TopBar: View {
    var title: String
    var leadingIcon: String?
    var trailingIcon: String?
    var BackgroundColor: Color = Color.primaryColor
    var leadingIconHandler: (() -> ())?
    var trailingIconHandler: (() -> ())?
    
    var body: some View {
        HStack{
            Image(systemName: leadingIcon ?? "")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .padding(.horizontal)
                .foregroundColor(.white)
                .onTapGesture {
                    leadingIconHandler?()
                }
            
            Spacer()
            
            AppText(text: title, fontSize: FontSize.large, fontColor: Color.white)
            
            Spacer()
            
            Image(systemName: trailingIcon ?? "")
                .resizable()
                .scaledToFit()
                .frame(width:40, height: 40)
                .padding(.horizontal)
                .foregroundColor(.white)
                .onTapGesture {
                    trailingIconHandler?()
                }
        }
        .frame(maxWidth: .infinity, minHeight: 80, alignment: .bottom)
        .padding(.vertical, Dm.medium)
        .background(BackgroundColor)
    }
}

struct TopBar_Previews: PreviewProvider {
    static var previews: some View {
        TopBar(title: "title", leadingIcon: "person", trailingIcon: "pencil")
    }
}
