//
//  EarningScreen.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-29.
//

import SwiftUI
import Resolver

struct EarningScreen: View {
    
    @ObservedObject var earningVM = EarningViewModel()
    
    // show add earning pop up
    @State private var showPopUp = false
    
    // allow us to pop the current view off the navigation stack
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        
        ZStack {
            Color.backgroundColor
            
            // Screen without pop up
            VStack{
                
                // Topbar
                TopBar(
                    title: "Earnings",
                    leadingIcon: "chevron.left",
                    backgroundColor: Color.appGreen,
                    leadingIconHandler: {
                        // back to home screen
                        presentation.wrappedValue.dismiss()
                    }
                )
                
                // Month Selector and Month Total
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
                    AppText(text: "Month Total: $\(earningVM.monthTotal)", fontSize: FontSize.medium, fontColor: .white)
                }
                .padding(Dm.medium)
                .background(Color.appLightGreen)
                .offset(y: -Dm.tiny)
                .zIndex(1)
                
                // this zstack allow floating action to sit on top of the list
                ZStack(alignment: .bottomTrailing){
                    
                    // list of earning cards
                    List{
                        
                        // search bar - search by earning title
                        AppTextField(text:$earningVM.searchTerm, placeholder: "search", trailingIcon: "magnifyingglass")
                            .listRowBackground(Color.backgroundColor)
                            .shadow(color: .gray, radius: 5, x: 0, y: 2)
                        
                        
                        // display all earnings
                        ForEach(earningVM.earnings){ earning in
                            // an earning card
                            EarningCard(earning: earning, backgroundColor: Color.appLightGreen) {
                                // handle swipt delete
                                earningVM.remove(earning)
                            }
                            // clear the default white list item background
                            .listRowBackground(Color.backgroundColor)
                        }
                        
                    }
                    .listStyle(.plain)
                    
                    
                    // floating action button to add a new earning
                    AppFloatingButton(iconName: "plus", iconBackgroundColor: Color.appGreen) {
                        // handle action button pressed
                        showPopUp.toggle()
                    }
                    .padding(.horizontal, Dm.medium)
                    .padding(.vertical, Dm.xlarge)
                    
                }
            }
            
            // show add new earning pop up
            EarningPopupField(showPopUp: $showPopUp)
        }
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

private struct EarningPopupField: View {
    
    @ObservedObject var earningVM = EarningViewModel()
    
    @Binding var showPopUp: Bool
    
    // pop up states
    @State private var newEarningTitle: String = ""
    @State private var newEarningAmount: String = ""
    @State private var newEarningDate: Date = Date()
    
    private func resetFields() {
        newEarningTitle = ""
        newEarningAmount = ""
        newEarningDate = Date()
    }

    var body: some View {
        if $showPopUp.wrappedValue {
            
            // all text field inside the pop up goes here
            let popupForm: AnyView = AnyView(
                VStack{
                    
                    // new earning title
                    AppTextField(text: $newEarningTitle, placeholder: "Title")
                    
                    // new earning amount
                    AppTextField(text: $newEarningAmount, placeholder: "Amount", keyboardType: .numberPad)
                    
                    // new earning date
                    AppDatePicker(selectedDate: $newEarningDate)
                }
            )
            
            AppPopupView(
                title: "New Earning",
                backgroundColor: Color.appLightGreen,
                showPopUp: $showPopUp,
                view: popupForm,
                handleConfirm: {
                    
                    earningVM.add(Earning(
                        title: newEarningTitle, amount: newEarningAmount.floatValue, date: newEarningDate))
                    
                    resetFields()
                    
                },
                handleCancel:{
                    resetFields()
                }
            )
        }
    }
}

struct EarningScreen_Previews: PreviewProvider {
    static var previews: some View {
        EarningScreen()
            .previewInterfaceOrientation(.portrait)
    }
}
