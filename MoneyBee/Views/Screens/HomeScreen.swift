//
//  HomeScreen.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-28.
//

import SwiftUI
import Resolver

struct HomeScreen: View {
    
    @State var showMenu = false
    
    var body: some View {
        
        // Drag gesture that allow side menu to close from right to left
        let drag = DragGesture()
            .onEnded {
                
                // check whether the user has exceeded a certain threshold value with his swiping gesture, if this is the case, we close the menu
                if $0.translation.width < -100 {
                    withAnimation {
                        self.showMenu = false
                    }
                }
            }
    
        return GeometryReader { geometry in
            ZStack(alignment: .leading) {
                
                VStack{
                    // Topbar
                    TopBar(title: "Money Bee", leadingIcon: "line.3.horizontal", leadingIconHandler: { print("pressed")
                        showMenu.toggle()
                    })
                    
                    // Screen Content
                    ScrollView{
                        // User Avatar image and Greeting
                        HStack(alignment: .center){
                            Image("honeyBeeLogo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60, alignment: .center)
                                .clipShape(Circle())
                            
                            AppText(text: "Hello, Justin!", fontSize: FontSize.large)
                                .padding(.vertical, Dm.small)
                            
                            // push everything to the left
                            Spacer()
                        }
                        
                        // Display Saving Amount
                        VStack{
                            AppText(text: "Your Total Saving:", fontSize: FontSize.large, fontColor: .white)
                            AppText(text: "$100", fontSize: FontSize.large, fontColor: .white)
                        }
                        .frame(maxWidth: .infinity, minHeight: 200)
                        .background(Color.primaryColor)
                        .clipShape(RoundedRectangle(cornerRadius: CornerRadius.medium))
                        .shadow(radius: Dm.tiny)
                        .padding(.bottom, Dm.small)
                        
                        
                        // Buttons
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
                
                if showMenu{
                    AppSideMenu()
                        .frame(width: geometry.size.width / 2, height: geometry.size.height)
                        .background(Color.backgroundColor)
                        .transition(.move(edge: .leading))
                }
            }
            // attach the swipe-to-close side menu gesture
            .gesture(drag)
            .navigationBarHidden(true)
            .onAppear {
                showMenu = false
            }
        }
    }
    
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
