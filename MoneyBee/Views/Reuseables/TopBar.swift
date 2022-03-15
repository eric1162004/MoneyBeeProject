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
    var topbarIcon: String?
    var trailingIcon: String?
    var backgroundColor: Color = Color.primaryColor
    var leadingIconHandler: (() -> ())?
    var trailingIconHandler: (() -> ())?
    
    var body: some View {
        HStack{
            
            // leading icon
            Image(systemName: leadingIcon ?? "")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .padding(.horizontal)
                .padding(.top, 2)
                .foregroundColor(.white)
                .onTapGesture {
                    leadingIconHandler?()
                }
            
            Spacer()
        
            // Title Text
            AppText(text: title, fontSize: FontSize.large, fontColor: Color.white)
                .padding(.top, 3)
            
            // Title Icon
            Image(topbarIcon ?? "")
                .resizable()
                .scaledToFill()
                .frame(width: IconSize.small, height: IconSize.small)
             
            Spacer()
            
            // trailing icon
            Image(systemName: trailingIcon ?? "")
                .resizable()
                .scaledToFit()
                .frame(width:30, height: 30)
                .padding(.horizontal)
                .padding(.top, 5)
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
        TopBar(title: "title", leadingIcon: "person", topbarIcon: "topbarIcon", trailingIcon: "pencil")
    }
}
