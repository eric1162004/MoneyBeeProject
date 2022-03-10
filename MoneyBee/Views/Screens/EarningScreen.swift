//
//  EarningScreen.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-29.
//

import SwiftUI
import Resolver

struct EarningScreen: View {
        
    // show add earning pop up
    @State private var showPopUp = false
    
    var body: some View {
        
        ZStack {
            Color.backgroundColor
            
            // Screen without pop up
            VStack{
                
                // Topbar
                EarningTopBar(showPopUp: $showPopUp)
                
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
            EarningPopupField(showPopUp: $showPopUp)
        }
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

//private struct EarningFloatingButton: View {
//
//    @Binding var showPopUp: Bool
//
//    var body: some View {
//        AppFloatingButton(iconName: "plus", iconBackgroundColor: Color.appGreen) {
//            // handle action button pressed
//            showPopUp.toggle()
//        }
//        .padding(.horizontal, Dm.medium)
//        .padding(.vertical, Dm.xlarge)
//    }
//}

private struct EarningTopBar: View {
    
    // allow us to pop the current view off the navigation stack
    @Environment(\.presentationMode) var presentation
    
    @Binding var showPopUp: Bool
    
    var body: some View {
        TopBar(
            title: "Earnings",
            leadingIcon: "chevron.left",
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
            AppText(text: "Month Total: $\(earningVM.monthTotal.toStringWithDecimal(n: 2))", fontSize: FontSize.medium, fontColor: .white)
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
                // an earning card
                EarningCard(earning: earning, backgroundColor:((index % 2 == 0 ) ? Color.appGreen : Color.appLightGreen)) {
                    // handle swipt delete
                    earningVM.remove(earning)
                }
                // clear the default white list item background
                .listRowBackground(Color.backgroundColor)
            }
            
        }
        .listStyle(.plain)
    }
}

private struct EarningPopupField: View {
    
    @ObservedObject var earningVM : EarningViewModel = Resolver.resolve()
    
    @Binding var showPopUp: Bool
    
    // pop up states
    @State private var newEarningTitle: String = ""
    @State private var newEarningAmount: String = ""
    @State private var newEarningDate: Date = Date()
    
    @State private var errorMsg : String?
    
    private func resetFields() {
        newEarningTitle = ""
        newEarningAmount = ""
        newEarningDate = Date()
    }

    var body: some View {
        //grey out the background area on tap gesture
        if showPopUp{
            Color.black
                .opacity(0.6)
                .ignoresSafeArea()
                .onTapGesture {
                    showPopUp = true
                }
        }
        if $showPopUp.wrappedValue {
            
            // all text field inside the pop up goes here
            let popupForm: AnyView = AnyView(
                VStack{
                    
                    // new earning title
                    AppTextField(text: $newEarningTitle, placeholder: "Title")
                    
                    // new earning amount
                    AppTextField(text: $newEarningAmount, placeholder: "Amount", keyboardType: .decimalPad)
                    
                    // new earning date
                    AppDatePicker(selectedDate: $newEarningDate)
                    
                    // error message
                    if let errorMsg = errorMsg {
                        Text(errorMsg)
                            .bold()
                            .foregroundColor(.appRed)
                    }
                }
            )
            
            AppPopupView(
                title: "New Earning",
                backgroundColor: Color.appLightGreen,
                showPopUp: $showPopUp,
                view: popupForm,
                handleConfirm: {
                    
                    // ensure all fields are not empty and show error message
                    if (newEarningTitle.isEmpty){
                        errorMsg = "Title cannot be empty."
                        showPopUp.toggle()
                    }
                    else if (newEarningAmount.isEmpty) {
                        errorMsg = "Amount cannot be empty."
                        showPopUp.toggle()
                    }
                    else {
                        earningVM.add(Earning(
                            title: newEarningTitle, amount: newEarningAmount.floatValue, date: newEarningDate))
                        
                        resetFields()
                    }
                },
                handleCancel:{
                    errorMsg = nil
                    resetFields()
                }
            )
                .transition(.slide)
        }
    }
}

struct EarningScreen_Previews: PreviewProvider {
    static var previews: some View {
        EarningScreen()
            .previewInterfaceOrientation(.portrait)
           
    }
}
