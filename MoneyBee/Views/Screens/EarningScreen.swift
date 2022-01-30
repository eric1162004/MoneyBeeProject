//
//  EarningScreen.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-29.
//

import SwiftUI

struct EarningScreen: View {
    
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
    
    @State var selectedMonthYear: String = ""
    @State private var searchString: String = ""
    
    // show add earning pop up
    @State private var showPopUp = false
    
    // pop up states
    @State var newEarningTitle: String = ""
    @State var newEarningAmount: Float = 0
    @State var newEarningDate: Date = Date()

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
                    leadingIconHandler: { print("pressed")}
                )
                
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
                .background(Color.appLightGreen)
                .offset(y: -Dm.tiny)
                .zIndex(1)
                
                // this zstack allow floating action to sit on top of the list
                ZStack(alignment: .bottomTrailing){
//                    Color.backgroundColor
                    
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
                                AppEarningsOrSpendingCard(title: "Making my own bed", subtitle: "Dec 16, 2021", amount: 2, backgroundColor: item%2 == 0 ? Color.appGreen : Color.appLightGreen) {
                                // handle swipt delete
                                
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
            if $showPopUp.wrappedValue {
                
                // all text field goes here
                let popupForm: AnyView = AnyView(
                    VStack{
                        AppTextField(text: $newEarningTitle, placeholder: "Title")
                        
                        AppTextField(text: $newEarningTitle, placeholder: "Amount")
                        
                        AppDatePicker(selectedDate: $newEarningDate)
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
        .navigationBarHidden(true)
        .ignoresSafeArea()

    }
}

struct EarningScreen_Previews: PreviewProvider {
    static var previews: some View {
        EarningScreen()
.previewInterfaceOrientation(.portrait)
    }
}
