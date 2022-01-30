//
//  WishListScreen.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-29.
//

import SwiftUI

struct WishListScreen: View {
    
    // show add earning pop up
    @State private var showPopUp = false
    
    // pop up states
    @State private var newWishItemTitle: String = ""
    @State private var newWishItemCost: Float = 0
    
    var body: some View {
        
        // this zstack allow floating action to sit on top of the list
        ZStack(alignment: .bottomTrailing) {
            VStack{
                // Topbar
                TopBar(
                    title: "Wish List",
                    leadingIcon: "chevron.left",
                    backgroundColor: Color.appBlue,
                    leadingIconHandler: {
                        print("pressed")
                    })

                    
                    // list of earning cards
                    List{
                        
                        ForEach(1...10, id: \.self){item in
                        // an earning card
                            AppWishItemCard(
                                title: "Soft Pandaa",
                                imageName: "honeyBeeLogo2",
                                amount: 20,
                                backgroundColor: item % 2 == 0 ? Color.appBlue: Color.appLightBlue
                                )
                        // clear the default white list item background
                        .listRowBackground(Color.clear)
                        }
                        
                    }
                    .listStyle(.plain)
            }
            
            // floating action button to add a new earning
            AppFloatingButton(iconName: "plus", iconBackgroundColor: Color.appBlue) {
                // handle action button pressed
                showPopUp.toggle()
            }
            .padding(.horizontal, Dm.medium)
            .padding(.vertical, Dm.xlarge)
            
            // show add new earning pop up
            if $showPopUp.wrappedValue {
                
                // all text field goes here
                let popupForm: AnyView = AnyView(
                    VStack{
                        
                        AppRoundedImageView()
                        
                        AppTextField(text: $newWishItemTitle, placeholder: "Title")
                        
                        AppTextField(text: $newWishItemTitle, placeholder: "Cost")
                    }
                )
                
                ZStack(alignment: .center){
                AppPopupView(
                    title: "New Wish Item",
                    backgroundColor: Color.appLightBlue,
                    showPopUp: $showPopUp, view: popupForm,
                    handleConfirm: { $showPopUp.wrappedValue.toggle() },
                    handleCancel:{ $showPopUp.wrappedValue.toggle()}
                )}
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .background(Color.backgroundColor)
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct WishListScreen_Previews: PreviewProvider {
    static var previews: some View {
        WishListScreen()
    }
}
