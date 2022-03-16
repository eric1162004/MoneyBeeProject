//
//  EarningScreen.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-29.
//

import SwiftUI
import Resolver

struct EarningScreen: View {
    
    @ObservedObject var earningVM : EarningViewModel = Resolver.resolve()
    
    var body: some View {
        
        ZStack {
            Color.backgroundColor
            
            // Screen without pop up
            VStack{
                
                // Topbar
                EarningTopBar(showPopUp: $earningVM.showPopUp)
                
                // Month Selector and Month Total
                MonthSection()
                
                // this zstack allow floating action to sit on top of the list
                ZStack(alignment: .bottomTrailing){
                    
                    // list of earning cards
                    EarningListSection()
                    
                    // floating action button to add a new earning
                    //EarningFloatingButton(showPopUp: $showPopUp)
                }
            }
            
            // show add new earning pop up
            EarningPopupField()
        }
        .navigationBarHidden(true)
        .ignoresSafeArea()
        .onTapGesture {
            hideKeyboard()
        }
    }    
}

private struct EarningTopBar: View {
    
    // allow us to pop the current view off the navigation stack
    @Environment(\.presentationMode) var presentation
    
    @Binding var showPopUp: Bool
    
    var body: some View {
        TopBar(
            title: "Earnings",
            leadingIcon: "chevron.left",
            topbarIcon: "earningbee",
            trailingIcon: "plus",
            backgroundColor: Color.appGreen,
            leadingIconHandler: {
                // back to home screen
                presentation.wrappedValue.dismiss()
            },
            trailingIconHandler: {
                // handle action button pressed
                withAnimation{self.showPopUp.toggle()}
            }
        )
    }
}

private struct MonthSection: View {
    
    @ObservedObject var earningVM : EarningViewModel = Resolver.resolve()
    
    var body: some View {
        VStack{
            // select a month of which earnings are made
            DropdownSelector(
                selectedOption: $earningVM.selectedMonthYear,
                placeholder: "Pick a month",
                options: earningVM.dateOptions,
                onOptionSelected: { option in
                    earningVM.selectedMonthYear = option
                })
                .zIndex(1)
            
            // display the total amount of earnings made in the month
            AppText(
                text: "Month Total: $\(earningVM.monthTotal.toStringWithDecimal(n: 2))",
                fontSize: FontSize.medium,
                fontColor: .white
            )
        }
        .padding(Dm.medium)
        .background(Color.appLightGreen)
        .offset(y: -Dm.tiny)
        .zIndex(1)
        .transition(.asymmetric(insertion: .opacity, removal: .scale))
    }
}

private struct EarningListSection: View {
    
    @ObservedObject var earningVM : EarningViewModel = Resolver.resolve()
    
    var body: some View {
        List{
            // search bar - search by earning title
            AppTextField(text:$earningVM.searchTerm, placeholder: "search", trailingIcon: "magnifyingglass")
                .listRowBackground(Color.backgroundColor)
                .shadow(color: .gray, radius: 5, x: 0, y: 2)
            
            
            // display all earnings
            ForEach(Array(earningVM.earnings.enumerated()), id: \.element.id){ index, earning in
                // display an earning card with alternate color
                EarningCard(earning: earning, backgroundColor:((index % 2 == 0 ) ? Color.appGreen : Color.appLightGreen)) {
                    // handle swipt delete
                    earningVM.remove(earning)
                }
                // clear the default white list item background
                .listRowBackground(Color.backgroundColor)
                .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
        .listRowSeparator(.hidden)
    }
}

private struct EarningPopupField: View {
    
    @ObservedObject var earningVM : EarningViewModel = Resolver.resolve()
    
    var body: some View {
        if $earningVM.showPopUp.wrappedValue {
            // all text field inside the pop up goes here
            let popupForm: AnyView = AnyView(
                VStack{
                    // new earning title
                    AppTextField(text: $earningVM.newEarningTitle, placeholder: "Title")
                    
                    // new earning amount
                    AppTextField(text: $earningVM.newEarningAmount, placeholder: "Amount", keyboardType: .decimalPad)
                    
                    // new earning date
                    AppDatePicker(selectedDate: $earningVM.newEarningDate)
                    
                    // error message
                    if let errorMsg = earningVM.errorMsg {
                        Text(errorMsg)
                            .bold()
                            .foregroundColor(.appRed)
                    }
                }
            )
            
            //grey out the background area on tap gesture
            PopupOpaqueBlackground()
            
            AppPopupView(
                title: "New Earning",
                backgroundColor: Color.appLightGreen,
                showPopUp: $earningVM.showPopUp,
                view: popupForm,
                handleConfirm: {
                    
                    // validate and add earning to repo
                    earningVM.add(Earning(
                        title: earningVM.newEarningTitle,
                        amount: earningVM.newEarningAmount.floatValue,
                        date: earningVM.newEarningDate))
                    

                },
                handleCancel:{
                    earningVM.errorMsg = nil
                    earningVM.resetFields()
                }
            ).transition(.slide)
        }
    }
}

struct EarningScreen_Previews: PreviewProvider {
    static var previews: some View {
        EarningScreen()
            .previewInterfaceOrientation(.portrait)
           
    }
}
