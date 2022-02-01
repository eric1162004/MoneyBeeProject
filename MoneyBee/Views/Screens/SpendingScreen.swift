//
//  SpendingScreen.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-29.
//

import SwiftUI
import Resolver

struct SpendingScreen: View {
    
    @State var showChartSheet = false
    
    // show add earning pop up
    @State var showPopUp = false
    
    var body: some View {
        ZStack(alignment: .center){
            VStack {
                // Topbar
                SpendingScreenTopBar(showChartSheet: $showChartSheet)
                
                // Screen Content
                SpendingScreenContent(showPopUp: $showPopUp)
            }
            // show add new earning pop up
            SpendingPopupField(showPopUp: $showPopUp)
        }
        .sheet(isPresented: $showChartSheet) {
            SpendingChartView()
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct SpendingScreenTopBar: View {
    
    @Binding var showChartSheet: Bool
    
    // allow us to pop the current view off the navigation stack
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        TopBar(
            title: "Spendings",
            leadingIcon: "chevron.left",
            trailingIcon: "chart.pie.fill",
            backgroundColor: Color.appRed,
            leadingIconHandler: {
                // back to home screen
                presentation.wrappedValue.dismiss()
            },
            trailingIconHandler: {
                // show pie chart sheet
                showChartSheet.toggle()
            })
    }
}

struct SpendingScreenContent: View {
    
    @ObservedObject var spendingVM : SpendingViewModel = Resolver.resolve()
    
    // show add earning pop up
    @Binding var showPopUp : Bool
    
    var body: some View {
        ZStack {
            Color.backgroundColor
            
            // Screen without pop up
            VStack{
                // Month Selector and Month Total
                VStack{
                    // select a month of which earnings are made
                    MonthSection()
                    
                    // this zstack allow floating action to sit on top of the list
                    ZStack(alignment: .bottomTrailing){
                        
                        // list of earning cards
                        EarningListSection()
                        
                        // floating action button to add a new earning
                        SpendingScreenFloadButton(showPopUp: $showPopUp)
                    }
                }
            }
            
        }
    }
}

private struct MonthSection: View {
    
    @ObservedObject var spendingVM : SpendingViewModel = Resolver.resolve()
    
    var body: some View {
        VStack{
            // select a month of which earnings are made
            DropdownSelector(
                selectedOption: $spendingVM.selectedMonthYear,
                placeholder: "Pick a month",
                options: spendingVM.dateOptions,
                onOptionSelected: { option in
                    spendingVM.selectedMonthYear = option
                })
                .zIndex(1)
            
            // display the total amount of earnings made in the month
            AppText(text: "Month Total: $\(spendingVM.monthTotal.toStringWithDecimal(n: 2))", fontSize: FontSize.medium, fontColor: .white)
        }
        .padding(Dm.medium)
        .background(Color.appLightRed)
        .offset(y: -Dm.tiny)
        .zIndex(1)
    }
}

private struct EarningListSection: View {
    
    @ObservedObject var spendingVM : SpendingViewModel = Resolver.resolve()
    
    var body: some View {
        List{
            // search bar - search by spending title
            AppTextField(text:$spendingVM.searchTerm, placeholder: "search", trailingIcon: "magnifyingglass")
                .listRowBackground(Color.backgroundColor)
                .shadow(color: .gray, radius: 5, x: 0, y: 2)
            
            // an earning card
            ForEach(spendingVM.spendings){ spending in
                // an earning card
                SpendingCard(spending: spending, backgroundColor: Color.appLightRed) {
                    // handle swipt delete
                    spendingVM.remove(spending)
                }
                // clear the default white list item background
                .listRowBackground(Color.backgroundColor)
            }
        }
        .listStyle(.plain)
    }
}

private struct SpendingScreenFloadButton: View {
    
    @Binding var showPopUp: Bool
    
    var body: some View {
        AppFloatingButton(iconName: "plus", iconBackgroundColor: Color.appRed) {
            // handle action button pressed
            showPopUp.toggle()
        }
        .padding(.horizontal, Dm.medium)
        .padding(.vertical, Dm.xlarge)
    }
    
}

private struct SpendingPopupField: View {
    
    @ObservedObject var spendingVM : SpendingViewModel = Resolver.resolve()
    
    @Binding var showPopUp: Bool

    // pop up states
    @State var newSpendingType: DropdownOption?
    @State var newSpendingTitle: String = ""
    @State var newSpendingAmount: String = ""
    @State var newSpendingDate: Date = Date()
    
    private func resetFields() {
        newSpendingTitle = ""
        newSpendingAmount = ""
        newSpendingType = nil
        newSpendingDate = Date()
    }
    
    var body: some View {
        if $showPopUp.wrappedValue {
            
            // all text field inside the pop up goes here
            let popupForm: AnyView = AnyView(
                VStack{
                    
                    // new spending type
                    DropdownSelector(
                        selectedOption: $newSpendingType,
                        placeholder: "Spending Type",
                        options: spendingVM.spendingTypeOptions,
                        onOptionSelected: { option in
                            newSpendingType = option
                        })
                        .zIndex(3)
                    
                    // new spending title
                    AppTextField(text: $newSpendingTitle, placeholder: "Title")
                    
                    // new spending amount
                    AppTextField(text: $newSpendingAmount, placeholder: "Amount", keyboardType: .numberPad)
                    
                    // new spending date
                    AppDatePicker(selectedDate: $newSpendingDate)
                }
            )
            
            AppPopupView(
                title: "New Spending",
                backgroundColor: Color.appLightRed,
                showPopUp: $showPopUp,
                view: popupForm,
                handleConfirm: {
                    
                    if let newSpendingType = newSpendingType, !newSpendingTitle.isEmpty {
                        spendingVM.add(Spending(
                            title: newSpendingTitle, amount: newSpendingAmount.floatValue, date: newSpendingDate, type: newSpendingType.value))
                    }
                    
                    resetFields()
                    
                },
                handleCancel:{
                    resetFields()
                }
            )
        }
    }
}

struct SpendingScreen_Previews: PreviewProvider {
    static var previews: some View {
        SpendingScreen()
    }
}
