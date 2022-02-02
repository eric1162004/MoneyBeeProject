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
    
    // show add earning pop up
    @State var showPopUp = false
    @State private var showingPhotoPicker =  false

    var body: some View {
        
        // this zstack allow floating action to sit on top of the list
        ZStack(alignment: .bottomTrailing) {
            VStack{
                // Topbar
                WishItemScreenTopBar()
                
                // list of earning cards
                WishItemListSection()
            }
            
            // floating action button to add a new earning
            WishListFloatingButton(showPopUp: $showPopUp)
            
            // show add new earning pop up
            WishListPopup(
                showPopUp: $showPopUp,
                showingPhotoPicker: $showingPhotoPicker
            )
        }
        .sheet(isPresented: $showingPhotoPicker) {
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
    
    var body: some View {
        TopBar(
            title: "Wish List",
            leadingIcon: "chevron.left",
            backgroundColor: Color.appBlue,
            leadingIconHandler: {
                // back to home screen
                presentation.wrappedValue.dismiss()
            })
    }
}

private struct WishItemListSection: View {
    
    @ObservedObject var wishItemVM : WishItemViewModel = Resolver.resolve()
    
    var body: some View {
        List{
            ForEach(wishItemVM.wishItems){ wishItem in
                // an earning card
                AppWishItemCard(
                    wishItem: wishItem,
                    backgroundColor: Color.appLightBlue, buyButtonHandler: {
                        
                        // handle buy
                        print("buy pressed")
                        
                    }, swipeDeleteHandler: {
                        
                        // handle delete
                        wishItemVM.remove(wishItem)
                        
                    })
                // clear the default white list item background
                .listRowBackground(Color.clear)
            }
            
        }
        .listStyle(.plain)
    }
}

private struct WishListFloatingButton: View {
    
    @Binding var showPopUp: Bool
    
    var body: some View {
        AppFloatingButton(iconName: "plus", iconBackgroundColor: Color.appBlue) {
            // handle action button pressed
            showPopUp.toggle()
        }
        .padding(.horizontal, Dm.medium)
        .padding(.vertical, Dm.xlarge)
    }
    
}

private struct WishListPopup: View {
    
    @ObservedObject private var wishItemVM : WishItemViewModel = Resolver.resolve()
    
    @Binding var showPopUp: Bool
    @Binding var showingPhotoPicker: Bool
    
    @State private var newWishItemTitle: String = ""
    @State private var newWishItemCost: String = ""
    
    private func reset() {
        wishItemVM.selectedImage = nil
        newWishItemTitle = ""
        newWishItemCost = ""
    }
    
    var body: some View {
        
        if $showPopUp.wrappedValue {
            
            // all text field goes here
            let popupForm: AnyView = AnyView(
                VStack{
                    
                    AppImageView(uiImage: wishItemVM.selectedImage)
                        .frame(width: 140, height: 140)
                        .background()
                        .clipShape(RoundedRectangle(cornerRadius: CornerRadius.medium))
                        .onTapGesture {
                            showingPhotoPicker.toggle()
                        }
                    
                    AppTextField(text: $newWishItemTitle, placeholder: "Title")
                    
                    AppTextField(text: $newWishItemCost, placeholder: "Cost",keyboardType: .numberPad)
                }
            )
            
            ZStack(alignment: .center){
                AppPopupView(
                    title: "New Wish Item",
                    backgroundColor: Color.appLightBlue,
                    showPopUp: $showPopUp,
                    view: popupForm,
                    handleConfirm: {
                        
                        guard !newWishItemCost.isEmpty, !newWishItemTitle.isEmpty else {return}
                        
                        wishItemVM.add(WishItem(title: newWishItemTitle, cost: newWishItemCost.floatValue))
                        
                        reset()
                    },
                    handleCancel:{
                        reset()
                    }
                )}
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct WishListScreen_Previews: PreviewProvider {
    static var previews: some View {
        WishListScreen()
    }
}
