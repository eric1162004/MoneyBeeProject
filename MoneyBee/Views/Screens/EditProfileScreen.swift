//
//  EditProfileScreen.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-28.
//

import SwiftUI

struct EditProfileScreen: View {
    
    @State var name: String = ""
    
    // allow us to pop the current view off the navigation stack
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
            VStack{
                // Topbar
                TopBar(title: "Edit Profile", leadingIcon: "chevron.left", leadingIconHandler: { 

                    // back to home screen
                    presentation.wrappedValue.dismiss()
                })
                
                // Screen Content
                VStack(spacing: Dm.small){
                    
                    // Image Edit
                    ZStack(alignment:.bottomTrailing){
                        // Image
                        AppCircularProfileImage(imageName: "honeyBeeLogo")
                    
                        // image edit icon
                        Image(systemName: "pencil")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20, alignment: .center)
                            .padding()
                            .background(.gray)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .padding(.leading)
                            .offset(y: -Dm.medium)
                    }
                    
                    // name field
                    AppTextField(text: $name, placeholder: "name", leadingIcon: "person")
                    
                    Spacer()
                    
                    // save button
                    AppCapsuleButton(label: "Save", backgroundColor: Color.appGreen){
                        
                        // back to home screen
                        presentation.wrappedValue.dismiss()
                        
                    }
                    .padding(.bottom, Dm.small)

                }
                .padding(Dm.medium)
        }
        .background(Color.backgroundColor)
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct EditProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileScreen()
    }
}
