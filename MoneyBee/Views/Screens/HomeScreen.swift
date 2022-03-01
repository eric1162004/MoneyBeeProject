//
//  HomeScreen.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-28.
//

import SwiftUI
import Resolver

struct HomeScreen: View {
    
    // contains information about the current user
    @ObservedObject var appUserViewModel: AppUserViewModel = Resolver.resolve()
    
    // contain user's total amount of earning, spending and wishlist
    @ObservedObject var homeViewModel: HomeViewModel = Resolver.resolve()
    
    // display side menu or not
    @State var showSideMenu = false
    
    var body: some View {
        
        // dynanmically calculate the total saving amount
        let totalSavingAmount = homeViewModel.totalEarning - homeViewModel.totalSpending - homeViewModel.totalBoughtWishItem
        
        // drag gesture that allows side menu to close from right to left
        let drag = DragGesture()
            .onEnded {
                
                // check whether the user has exceeded a certain threshold value with his swiping gesture, if this is the case, we close the menu
                if $0.translation.width < -100 {
                    withAnimation {
                        self.showSideMenu = false
                    }
                }
            }
    
        return GeometryReader { geometry in
            ZStack(alignment: .leading) {
                
                VStack{
                    // Topbar
                    TopBar(title: "Money Bee", leadingIcon: "line.3.horizontal", leadingIconHandler: { print("pressed")
                        showSideMenu.toggle()
                    })
                    
                    // Screen Content
                    ScrollView{
                        
                        // User Avatar image and Greeting
                        HStack(alignment: .center){
                            
                            // if user has provided a profile image, use that image, else just display a default honey bee logo
                            if !appUserViewModel.appUser.imageUrl.isEmpty{
                                
                                AsyncImage(url: URL(string: appUserViewModel.appUser.imageUrl)) { image in
                                    image.resizable()
                                } placeholder: {
                                    Image(systemName: "photo.fill")
                                        .resizable()
                                        .foregroundColor(.white)
                                }
                                .scaledToFit()
                                .frame(width: 60, height: 60, alignment: .center)
                                .background(.white)
                                .clipShape(Circle())
                                .padding(.bottom)
                                
                            } else {
                                Image("honeyBeeLogo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60, height: 60, alignment: .center)
                                    .clipShape(Circle())
                            }
                            
                            // Greeting text
                            AppText(text: "Hello, \(appUserViewModel.appUser.name)!", fontSize: FontSize.large)
                                .padding(.vertical, Dm.small)
                            
                            // push everything to the left
                            Spacer()
                        }
                        
                        // Display Saving Amount
                        VStack(spacing: 10){
                            
                            Spacer()
                            
                            AppText(
                                text: "Your Total Saving:",
                                fontSize: FontSize.large,
                                fontColor: .white)
                            
                            // Displaying Saving amount
                            Image("honeyJar")
                                .resizable()
                                .frame(width: 220, height: 170, alignment: .center)
                                .overlay(
                                    AppText(
                                    text: "$\(totalSavingAmount.toStringWithDecimal(n: 2))",
                                    fontSize: FontSize.large,
                                    fontColor: .white)
                                        .padding(.top, 45.0))
                            
                            Spacer()
                        }
                        .frame(maxWidth: .infinity, minHeight: 200)
                        .background(Color.primaryColor)
                        .clipShape(RoundedRectangle(cornerRadius: CornerRadius.medium))
                        .shadow(radius: Dm.tiny)
                        .padding(.bottom, Dm.small)
                        
                        // Earings, Spendings, WishList Buttons
                        VStack(spacing: Dm.small){
                            
                            NavigationLink(destination: EarningScreen()){
                                AppRoundedCornerButton(label: "Earnings", backgroundColor: Color.appGreen, height: 100, fontSize: FontSize.large)
                            }
                            
                            NavigationLink(destination: SpendingScreen()){
                                AppRoundedCornerButton(label: "Spendings", backgroundColor: Color.appRed, height: 100, fontSize: FontSize.large)
                            }
                            
                            NavigationLink(destination: WishListScreen()){
                                AppRoundedCornerButton(label: "Wish List", backgroundColor: Color.appBlue, height: 100, fontSize: FontSize.large)
                            }
                        }
                        
                    }
                    .padding(.horizontal, Dm.medium)
                    
                    Spacer()
                }
                .background(Color.backgroundColor)
                .ignoresSafeArea()
                
                if showSideMenu{
                    // use geometry width to determine the width of sidemenu
                    SideMenu()
                        .frame(width: geometry.size.width / 2, height: geometry.size.height)
                        .background(Color.backgroundColor)
                        .transition(.move(edge: .leading))
                }
            }
            // attach the swipe-to-close side menu gesture
            .gesture(drag)
            .navigationBarHidden(true)
            .onAppear {
                
                // make sure the side menu is close when displaying the screen
                showSideMenu = false
            }
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
