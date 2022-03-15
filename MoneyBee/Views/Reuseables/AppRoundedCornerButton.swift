//
//  AppRoundedCornerButton.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-28.
//

import SwiftUI

struct AppRoundedCornerButton: View {
    
    var label: String
    var buttonIcons: String?
    var backgroundColor: Color = Color.primaryColor
    var height: CGFloat = Dm.xlarge
    var fontSize: CGFloat = FontSize.small
    var handlePress: (() -> ())?
    
    var body: some View {
        
        // if handlePress is provided, return a button view
        if let handlePress = handlePress {
            Button {
               handlePress()
            } label: {
                HStack(){
                    
                    // button icon
                    Image(buttonIcons ?? "")
                        .resizable()
                        .scaledToFill()
                        .frame(width: IconSize.large, height: IconSize.large)
                        .padding(.leading, Dm.large)
                    
                    Spacer()
                    
                    // icon text
                    AppText(text: label, fontSize: fontSize, fontColor: .white)
                    
                    Spacer()
                    
                    // placeholder to balance the right side
                    Image("")
                        .resizable()
                        .scaledToFill()
                        .frame(width: IconSize.large, height: IconSize.large)
                        .padding()
                }
                .frame(maxWidth: .infinity, minHeight: height)
                .background(backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: CornerRadius.medium))
            }
            
        } else{
            // if handlePress is not provided, return a view that look like a button
            HStack{
                
                // button icon
                Image(buttonIcons ?? "")
                    .resizable()
                    .scaledToFill()
                    .frame(width: IconSize.large, height: IconSize.large)
                    .padding(.leading, Dm.large)
                
                Spacer()
                
                // icon text
                AppText(text: label, fontSize: fontSize, fontColor: .white)
                
                Spacer()
                
                // placeholder to balance the right side
                Image("")
                    .resizable()
                    .scaledToFill()
                    .frame(width: IconSize.large, height: IconSize.large)
                    .padding()
                    
            }
            .frame(maxWidth: .infinity, minHeight: height)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: CornerRadius.medium))
        }

    }
}

struct AppRoundedCornerButton_Previews: PreviewProvider {
    static var previews: some View {
        AppRoundedCornerButton(label: "click me", buttonIcons: "test1"){}
    }
}
