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
    var backgroundColor: Color = Color.primaryColor
    var leadingIconHandler: (() -> ())?
    var trailingIconHandler: (() -> ())?
    
    var body: some View {
        HStack{
            Image(systemName: leadingIcon ?? "")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
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
                .frame(width:30, height: 30)
                .padding(.horizontal)
                .foregroundColor(.white)
                .onTapGesture {
                    trailingIconHandler?()
                }
        }
        .frame(maxWidth: .infinity, minHeight: 60, alignment: .bottom)
        .padding(.vertical, Dm.medium)
        .background(backgroundColor)
    }
}

struct TopBar_Previews: PreviewProvider {
    static var previews: some View {
        TopBar(title: "title", leadingIcon: "person", trailingIcon: "pencil")
    }
}
