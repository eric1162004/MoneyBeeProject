//
//  SpendingScreen.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-29.
//

import SwiftUI

struct SpendingScreen: View {
    
    @State private var showChartSheet = false
    
    var body: some View {
        
        VStack {
            // Topbar
            TopBar(
                title: "Spendings",
                leadingIcon: "chevron.left",
                trailingIcon: "chart.pie.fill",
                backgroundColor: Color.appRed,
                leadingIconHandler: {
                    print("pressed")
                    
                },
                trailingIconHandler: {
                    print("pressed piechart")
                    showChartSheet.toggle()
                })
            
            // Screen Content
            SpendingScreenContent()
        }
        .sheet(isPresented: $showChartSheet) {
            SpendingChartView()
        }
        .background(Color.backgroundColor)
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct SpendingScreenContent: View {
    
    // list of dropdown options
    // a dropdown option must have a string index and label text
    @State var options: [DropdownOption] = [
        DropdownOption(key: "0", value: "Jan 2020"),
        DropdownOption(key: "1", value: "Feb 2020"),
        DropdownOption(key: "2", value: "Mar 2020"),
        DropdownOption(key: "3", value: "Mar 2020"),
        DropdownOption(key: "4", value: "Mar 2020"),
        DropdownOption(key: "5", value: "Mar 2020"),
    ]
    
    @State var spendingTypeOptions: [DropdownOption] = [
        DropdownOption(key: "0", value: SpendingType.FOOD),
        DropdownOption(key: "1", value: SpendingType.SCHOOL),
        DropdownOption(key: "2", value: SpendingType.PLAY),
        DropdownOption(key: "3", value: SpendingType.OTHER),
    ]
    
    @State var selectedMonthYear: String = ""
    @State private var searchString: String = ""
    
    // show add earning pop up
    @State private var showPopUp = false
    
    // pop up states
    @State var newSpendingType: String = ""
    @State var newSpendingTitle: String = ""
    @State var newSpendingAmount: Float = 0
    @State var newSpendingDate: Date = Date()
    
    var body: some View {
        ZStack {
            Color.backgroundColor
            
            // Screen without pop up
            VStack{
                
                // Month Selector and Month Total
                VStack{
                    // select a month of which earnings are made
                    DropdownSelector(
                        placeholder: "Pick a month",
                        options: options,
                        onOptionSelected: { option in
                            selectedMonthYear = option.value
                        })
                        .zIndex(1)
                    
                    // display the total amount of earnings made in the month
                    AppText(text: "Month Total: $200", fontSize: FontSize.medium, fontColor: .white)
                }
                .padding(Dm.medium)
                .background(Color.appLightRed)
                .offset(y: -Dm.tiny)
                .zIndex(1)
                
                // this zstack allow floating action to sit on top of the list
                ZStack(alignment: .bottomTrailing){
                    
                    // list of earning cards
                    List{
                        
                        // search bar - search by earning title
                        AppTextField(text:$searchString, placeholder: "search", trailingIcon: "magnifyingglass", trailingIconHandler: {
                            
                            // handler search icon pressed
                            print("search..")
                        })
                            .listRowBackground(Color.backgroundColor)
                            .shadow(color: .gray, radius: 5, x: 0, y: 2)
                        
                        ForEach(1...10, id: \.self){item in
                        // an earning card
                            AppEarningsOrSpendingCard(title: "Making my own bed", subtitle: "Dec 16, 2021", amount: 2, backgroundColor: item%2 == 0 ? Color.appRed : Color.appLightRed) {
                            // handle swipt delete
                            
                        }
                        // clear the default white list item background
                            .listRowBackground(Color.backgroundColor)
                        }
                        
                    }
                    .listStyle(.plain)
                    
                    
                    // floating action button to add a new earning
                    AppFloatingButton(iconName: "plus", iconBackgroundColor: Color.appRed) {
                        
                        // handle action button pressed
                        showPopUp.toggle()
                    }
                    .padding(.horizontal, Dm.medium)
                    .padding(.vertical, Dm.xlarge)
                }
                
            }
            
            // show add new earning pop up
            if $showPopUp.wrappedValue {
                
                // all text field inside the pop up goes here
                let popupForm: AnyView = AnyView(
                    VStack{
                        DropdownSelector(
                            placeholder: "Spending Type",
                            options: spendingTypeOptions,
                            onOptionSelected: { option in
                                newSpendingType = option.value
                            })
                            .zIndex(3)
                        
                        AppTextField(text: $newSpendingTitle, placeholder: "Title")
                        
                        AppTextField(text: $newSpendingTitle, placeholder: "Amount")
                        
                        AppDatePicker(selectedDate: $newSpendingDate)
                    }
                )
                
                AppPopupView(
                    title: "New Earning",
                    backgroundColor: Color.appLightRed,
                    showPopUp: $showPopUp, view: popupForm,
                    handleConfirm: { $showPopUp.wrappedValue.toggle() },
                    handleCancel:{ $showPopUp.wrappedValue.toggle()}
                )
            }
            
        }
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
    
}

struct SpendingChartView: View {
    
    // used to dismiss the sheetview: dismiss()
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(){
            
            AppText(text: "Dec 2020", fontSize: FontSize.medium)
            
            // Spending Pie Chart
            PieChartView(values: [200.0, 180.0, 180.0, 100.0], colors: [Color.appGreen, Color.appBlue, Color.primaryColor, Color.appRed], backgroundColor: Color.clear)
            
            Spacer()
            
            SpendingTable()
                .frame(maxHeight: 280)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(Dm.medium)
        .background(Color.backgroundColor)
    }
}

struct SpendingTable: View {
    
    var body: some View {
        
        GeometryReader{ geometry in
            VStack{
                
                ForEach(1...4, id:\.self) { _ in
                    HStack{
                        Circle()
                            .fill(Color.appGreen)
                            .frame(width: geometry.size.width * 0.1)
                        
                        AppText(text: "Food", fontSize: FontSize.small)
                            .frame(width: geometry.size.width * 0.3)
                        
                        
                        AppText(text: "$100.00", fontSize: FontSize.small)
                            .frame(width: geometry.size.width * 0.4)
                    }
                    
                }
                
            }
            .padding(Dm.medium)
            .background(.white)
            .opacity(0.95)
            .clipShape(RoundedRectangle(cornerRadius: CornerRadius.large))
        }
        
    }
}

struct SpendingScreen_Previews: PreviewProvider {
    static var previews: some View {
        SpendingScreen()
            
    }
}
