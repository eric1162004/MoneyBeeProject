//
//  EarningScreen.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-29.
//

import SwiftUI

struct EarningScreen: View {
    
    @State private var selectedDate: String = ""
    @State private var searchString: String = ""
    
    // show add earning pop up
    @State private var showPopUp = false
    
    // pop up states
    @State private var newEarningTitle: String = ""
    @State private var newEarningAmount: Float = 0
    @State private var newEarningDatePicker: Date = Date()
    
    // list of dropdown options
    // a dropdown option must have a string index and label text
    let options: [DropdownOption] = [
        DropdownOption(key: "0", value: "Sunday"),
        DropdownOption(key: "1", value: "Monday"),
        DropdownOption(key: "2", value: "Tuesday"),
        DropdownOption(key: "3", value: "Wednesday"),
        DropdownOption(key: "4", value: "Thursday"),
        DropdownOption(key: "5", value: "Friday"),
        DropdownOption(key: "6", value: "Saturday")
    ]
    
    var body: some View {
        
        ZStack {
            
            // Screen without pop up
            VStack{
                
                // Topbar
                TopBar(
                    title: "Earnings",
                    leadingIcon: "chevron.left",
                    backgroundColor: Color.appGreen,
                    leadingIconHandler: { print("pressed")}
                )
                
                // Month Selector and Month Total
                VStack{
                    // select a month of which earnings are made
                    DropdownSelector(
                        placeholder: "Pick a month",
                        options: options,
                        onOptionSelected: { option in
                            print(option)
                        })
                        .padding(.horizontal)
                        .zIndex(1)
                    
                    // display the total amount of earnings made in the month
                    AppText(text: "Month Total: $200", fontSize: FontSize.medium, fontColor: .white)
                }
                .padding(Dm.medium)
                .background(Color.appLightGreen)
                .offset(y: -Dm.tiny)
                .zIndex(1)
                
                // search bar - search by earning title
                AppTextField(text:$searchString, placeholder: "search", trailingIcon: "magnifyingglass", trailingIconHandler: {
                    
                    // handler search icon pressed
                    print("search..")
                })
                    .shadow(color: .gray, radius: 5, x: 0, y: 2)
                    .padding(.horizontal, Dm.medium)
                
                
                // this zstack allow floating action to sit on top of the list
                ZStack(alignment: .bottomTrailing){
                    Color.backgroundColor
                    
                    // list of earning cards
                    List{
                        
                        ForEach(1...10, id: \.self){item in
                        // an earning card
                            AppEarningsOrSpendingCard(title: "Making my own bed", subtitle: "Dec 16, 2021", amount: 2, backgroundColor: item%2 == 0 ? Color.appGreen : Color.appLightGreen) {
                            // handle swipt delete
                            
                        }
                        // clear the default white list item background
                        .listRowBackground(Color.clear)
                        }
                        
                    }
                    .listStyle(.plain)
                    
                    // floating action button to add a new earning
                    AppFloatingButton(iconName: "plus", iconBackgroundColor: Color.appGreen) {
                        
                        // handle action button pressed
                        showPopUp.toggle()
                    }
                    
                }
            }
            .background(Color.backgroundColor)
            .navigationBarHidden(true)
            .ignoresSafeArea()
            
            
            // show add new earning pop up
            if $showPopUp.wrappedValue {
                
                // all text field goes here
                let popupForm: AnyView = AnyView(
                    VStack{
                        AppTextField(text: $newEarningTitle, placeholder: "Title")
                        
                        AppTextField(text: $newEarningTitle, placeholder: "Amount")
                        
                        AppTextField(text: $newEarningTitle, placeholder: "Date")
                    }
                )
                
                AppPopupView(
                    title: "New Earning",
                    backgroundColor: Color.appLightGreen,
                    showPopUp: $showPopUp, view: popupForm,
                    handleConfirm: { $showPopUp.wrappedValue.toggle() },
                    handleCancel:{ $showPopUp.wrappedValue.toggle()}
                )
            }
        }
    }
}

struct EarningScreen_Previews: PreviewProvider {
    static var previews: some View {
        EarningScreen()
    }
}
