//
//  AppRoundedCornerNonIconButton.swift
//  MoneyBee
//
//  Created by PoKai Huang on 2022-03-14.
//

import SwiftUI


struct AppRoundedCornerNonIconButton: View {
    
    var label: String
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
                HStack{
                    Spacer()

                    AppText(text: label, fontSize: fontSize, fontColor: .white)
                    
                    Spacer()
                        
                }
                .frame(maxWidth: .infinity, minHeight: height)
                .background(backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: CornerRadius.medium))
                
                    
            }
            
        } else{
            // if handlePress is not provided, return a view that look like a button
            HStack{
                Spacer()
                
                AppText(text: label, fontSize: fontSize, fontColor: .white)
                
                Spacer()
                    
            }
            .frame(maxWidth: .infinity, minHeight: height)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: CornerRadius.medium))
        }

    }
}

struct AppRoundedCornerNonIconButton_Previews: PreviewProvider {
    static var previews: some View {
        AppRoundedCornerButton(label: "click me"){}
    }
}
