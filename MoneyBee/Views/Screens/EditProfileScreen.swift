//
//  EditProfileScreen.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-28.
//

import SwiftUI
import Resolver

struct EditProfileScreen: View {
    
    @ObservedObject var appUserViewModel: AppUserViewModel = Resolver.resolve()
    
    @State private var showingPhotoPicker =  false
    @State private var errorMsg: String?
    
    // allow us to pop the current view off the navigation stack
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
            VStack{
                // Topbar
                TopBar(title: "Edit Profile", leadingIcon: "chevron.left", topbarIcon: "editIcon",leadingIconHandler: {

                    // back to home screen
                    presentation.wrappedValue.dismiss()
                })
                
                // Screen Content
                VStack(spacing: Dm.small){
                    
                    // Image Edit
                    ZStack(alignment:.bottomTrailing){
                        // Image
                        
                        if(appUserViewModel.selectedImage != nil) {
                            Image(uiImage: appUserViewModel.selectedImage!)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150, height: 150, alignment: .center)
                                .background(.white)
                                .clipShape(Circle())
                                .padding(.bottom)
                            
                        }else {
                            AysncImageLoader(imageUrl: appUserViewModel.appUser.imageUrl)
                                .scaledToFit()
                                .frame(width: 150, height: 150, alignment: .center)
                                .background(.white)
                                .clipShape(Circle())
                                .padding(.bottom)
                        }
                    
                        Image(systemName: "photo.fill")
                        // image edit icon
                            .scaledToFit()
                            .frame(width: 20, height: 20, alignment: .center)
                            .padding()
                            .background(.gray)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .padding(.leading)
                            .offset(y: -Dm.medium)
                            .onTapGesture {
                                showingPhotoPicker.toggle()
                            }
                    }
                    
                    // Email
                    AppText(text: appUserViewModel.appUser.email, fontSize: FontSize.small)
                    
                    // name field
                    AppTextField(text: $appUserViewModel.appUser.name, placeholder: "name", leadingIcon: "person")
                    
                    // error message
                    if let errorMsg = errorMsg {
                        Text(errorMsg)
                            .bold()
                            .foregroundColor(.appRed)
                    }
                    
                    Spacer()
                    
                    // save button
                    AppCapsuleButton(label: "Save", backgroundColor: Color.appGreen){
                        
                        // Check empty input and show error message
                        if appUserViewModel.appUser.name.isEmpty {
                            errorMsg = "Name cannot be empty."
                        }
                        else {
                            appUserViewModel.update()
                            
                            // back to home screen
                            presentation.wrappedValue.dismiss()
                        }
                    }
                    .padding(.bottom, Dm.small)

                }
                .padding(Dm.medium)
        }
            .sheet(isPresented: $showingPhotoPicker) {
                PhotoPicker(image: $appUserViewModel.selectedImage)
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
