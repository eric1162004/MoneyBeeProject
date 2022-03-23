//
//  WishListScreen.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-29.
//

import SwiftUI
import Resolver

struct WishListScreen: View {
    
    @ObservedObject private var wishItemVM : WishItemViewModel = Resolver.resolve()

    var body: some View {
        
        // this zstack allow floating action to sit on top of the list
        ZStack(alignment: .bottomTrailing) {
            VStack{
                // Topbar
                WishItemScreenTopBar()
                
                // list of earning cards
                WishItemListSection()
            }
            
            // show add new earning pop up
            WishListPopup()
        }
        .sheet(isPresented: $wishItemVM.showingPhotoPicker) {
            // user select a picture from gallery
            PhotoPicker(image: $wishItemVM.selectedImage)
        }
        .background(Color.backgroundColor)
        .ignoresSafeArea()
        .navigationBarHidden(true)
                
    }
}

private struct WishItemScreenTopBar: View {
    
    // allow us to pop the current view off the navigation stack
    @Environment(\.presentationMode) var presentation
    
    @ObservedObject var wishItemVM : WishItemViewModel = Resolver.resolve()
    
    var body: some View {
        TopBar(
            title: "Wish List",
            leadingIcon: "chevron.left",
            topbarIcon: "wishlist",
            trailingIcon: "plus",
            backgroundColor: Color.appBlue,
            leadingIconHandler: {
                // back to home screen
                presentation.wrappedValue.dismiss()
            },
            trailingIconHandler: {
                // Add new wish item
                withAnimation{wishItemVM.showPopUp.toggle()}
            }
        )
    }
}

private struct WishItemListSection: View {
    
    @ObservedObject var wishItemVM : WishItemViewModel = Resolver.resolve()
    
    var body: some View {
        List{
            ForEach(Array($wishItemVM.wishItems.enumerated()), id: \.element.id){ index, wishItem in
                // an earning card
                AppWishItemCard(
                    wishItem: wishItem,

                    backgroundColor: ((index % 2 == 0) ? Color.appBlue : Color.appLightBlue), buyButtonHandler: {
                        
                        // handle buy
                        wishItemVM.buyItem(wishItem.wrappedValue)
                        
                    }, swipeDeleteHandler: {
                        
                        // handle delete
                        wishItemVM.remove(wishItem.wrappedValue)
                        
                    })
                // clear the default white list item background
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
        .listRowSeparator(.hidden)
        .alert(isPresented: $wishItemVM.showingAlert) {
            Alert(
                title: Text("Oops..."),
                message: Text(wishItemVM.notEnoughMoneyError)
            )
        }
    }
}

private struct WishListPopup: View {
    
    @ObservedObject private var wishItemVM : WishItemViewModel = Resolver.resolve()
    
    var body: some View {
        if $wishItemVM.showPopUp.wrappedValue {

            // all text field goes here
            let popupForm: AnyView = AnyView(
                VStack{
                    
                    // User gallery image selector
                    AppImageView(uiImage: wishItemVM.selectedImage)
                        .frame(width: 120, height: 120)
                        .background()
                        .clipShape(RoundedRectangle(cornerRadius: CornerRadius.medium))
                        .onTapGesture {
                            wishItemVM.showingPhotoPicker.toggle()
                        }
                        .padding(.bottom, Dm.tiny)
                    
                    //new wish item title
                    AppTextField(text: $wishItemVM.newWishItemTitle, placeholder: "Title")
                    
                    //new wish item cost
                    AppTextField(text: $wishItemVM.newWishItemCost, placeholder: "Cost",keyboardType: .decimalPad)
                    
                    // error message
                    if let errorMsg = wishItemVM.errorMsg {
                        Text(errorMsg)
                            .bold()
                            .foregroundColor(.appRed)
                    }
                }
            )
            
            ZStack(alignment: .center){
                
                //grey out the background area on tap gesture
                PopupOpaqueBlackground()
                
                AppPopupView(
                    title: "New Wish Item",
                    backgroundColor: Color.appLightBlue,
                    showPopUp: $wishItemVM.showPopUp,
                    view: popupForm,
                    handleConfirm: {
                        
                        wishItemVM.add(WishItem(
                            title: wishItemVM.newWishItemTitle,
                            cost: wishItemVM.newWishItemCost.floatValue))
                        
                    },
                    handleCancel:{
                        wishItemVM.errorMsg = nil
                        wishItemVM.resetFields()
                    }
                )
                   
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .transition(.slide)
            .onTapGesture {
                hideKeyboard()
            }

        }
    }
}

struct WishListScreen_Previews: PreviewProvider {
    static var previews: some View {
        WishListScreen()
    }
}
