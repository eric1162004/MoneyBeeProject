//
//  AppPopupView.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-29.
//

import SwiftUI

struct AppPopupView: View {
    
    var title: String = ""
    var backgroundColor: Color = Color.primaryColor
    @Binding var showPopUp: Bool
    var view: AnyView
    var handleConfirm: () -> ()
    var handleCancel: () -> ()
    
    
    var body: some View {
        ZStack {
            
            // background of the pop up
            backgroundColor
            
            // pop up content
            VStack {
                
                Spacer()
                
                AppText(text: title, fontSize: FontSize.medium, fontColor: .white)
                
                Spacer()
                
                view
                
                Spacer()
                
                // cancal and confirm buttons
                HStack(spacing: Dm.medium){
                    
                    AppCapsuleButton(label: "Cancel", backgroundColor: Color.appRed, fontSize: FontSize.tiny){
                        
                        handleCancel()
                        
                        $showPopUp.wrappedValue.toggle()
                    }
                    .frame(width: 100, height: 20)
                    
                    AppCapsuleButton(label: "Confirm", backgroundColor: Color.appGreen, fontSize: FontSize.tiny){
                        
                        handleConfirm()
                      
                        $showPopUp.wrappedValue.toggle()
                    }
                    .frame(width: 100, height: 20)
                }
                
                Spacer()
            }.padding()
        }
        .frame(maxWidth: 330, maxHeight: 520)
        .cornerRadius(20).shadow(radius: 20)
    }
    }


struct AppPopupView_Previews: PreviewProvider {

    static var previews: some View {
        AppPopupView(title: "New Earning", backgroundColor: Color.appLightGreen, showPopUp: .constant(false), view: AnyView(Text("hello")), handleConfirm: {}, handleCancel:{})
    }
}
