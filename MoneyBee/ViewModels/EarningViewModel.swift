//
//  EarningViewModal.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-31.
//

import Foundation
import Combine
import Resolver

class EarningViewModel: ObservableObject {
    
    // Retrieve the FirestoreRepository Singleton from Resolver
    @Published var earningRepo: FirestoreRepository<Earning> = Resolver.resolve()
    
    // Store all earnings that should display to the users
    @Published var earnings: [Earning] = [Earning]()
    
    // Store the search term that the user has typed in
    @Published var searchTerm: String = ""
    
    // Store the dropdown options
    @Published var dateOptions = [DropdownOption]()
    
    // Store the dropdown option that the user has pick
    @Published var selectedMonthYear: DropdownOption?
    
    // Calculated month total
    @Published var monthTotal: Float = 0
     
    // pop up states
    @Published var showPopUp: Bool = false
    @Published var newEarningTitle: String = ""
    @Published var newEarningAmount: String = ""
    @Published var newEarningDate: Date = Date()
    
    @Published var errorMsg : String?
    
    // Hold a copy of all the earnings to replace the filtered earnings
    private var earningsCopy: [Earning] = [Earning]()
    
    // Store canacllables
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        
        // subscribe to earnings change from firebase
        // and set them to the earnings property
        earningRepo.$items
            .assign(to: \.earnings, on: self)
            .store(in: &cancellables)
        
        // keep a copy in the earnings
        earningRepo.$items
            .assign(to: \.earningsCopy, on: self)
            .store(in: &cancellables)
        
        // Filter earnings by month year
        earningRepo.$items
            .map{ earnings in
                // select the earning date and remove duplicate
                earnings.map { earning -> Date in
                    let earningDate = earning.date
                    return earningDate
                }.removingDuplicates()
            }
            .map { dates -> [Date] in
                // sort the dates in descending order
                let sortedDates = dates.sorted(by: { $0.compare($1) == .orderedDescending })
                return sortedDates
            }
            .map { sortedDates in
                // transform the date object in dropdownoption object
                sortedDates.map { date in
                    DropdownOption(key: date.dateToMonthYearString(), value: date.dateToMonthYearString())
                }
            }
            .map { dropdownOptions in
                // removing all duplicates
                dropdownOptions.removingDuplicates()
            }
            .removeDuplicates()
            .assign(to: \.dateOptions, on: self)
            .store(in: &cancellables)
        
        // store the month year option selected by the user
        $selectedMonthYear
            .compactMap{ $0 }
            .sink { (_) in
                //
            } receiveValue: { [weak self] selectedDateOption in
                self?.filterByMonthYear(selectedDateOption)
                
            }.store(in: &cancellables)
        
        // filter earnings by title
        $searchTerm
            .debounce(for: .milliseconds(800), scheduler: RunLoop.main) // debounces the string publisher, such that it delays the process of sending request to remote server.
            .removeDuplicates()
            .map({ [weak self] (string) -> String? in
                self?.reload()
                
                if string.count < 1 {
                    return nil
                }
                
                return string
            }) // prevents sending numerous requests and sends nil if the count of the characters is less than 1.
            .compactMap{ $0 } // removes the nil values so the search string does not get passed down to the publisher chain
            .sink { (_) in
                //
            } receiveValue: { [weak self] string in
                self?.filterBySearchTerm(string)
                
            }.store(in: &cancellables)
    }
    
    // helper function to filter earnings by search term
    private func filterBySearchTerm(_ searchTerm: String){
        // case insenstive search against each spending's title
        earnings = earningsCopy.filter{ $0.title.lowercased().contains(searchTerm.lowercased()) }
    }
    
    // helper function to filter earning by month year
    private func filterByMonthYear(_ monthYear: DropdownOption){
        earnings = earningsCopy.filter { $0.date.isInMonthYear(monthYearString: monthYear.value) }
        
        // caluclate month total
        monthTotal = earnings.map({ $0.amount }).reduce(0, +)
    }
    
    // helper function to replace the filtered earnings back to orignal
    private func reload(){
        earnings = earningsCopy
        selectedMonthYear = nil
        monthTotal = 0
    }
    
    // ask repo to delete an earning
    func remove(_ earning: Earning){
        earningRepo.remove(earning)
    }
    
    // ask repo to create an earning
    func add(_ earning: Earning){
        
        guard !newEarningTitle.isEmpty && !newEarningAmount.isEmpty else {
            showPopUp.toggle()
            errorMsg = "Fields cannot be empty"
            
            return
        }
        earningRepo.add(earning)
        resetFields()

    }
    
    func resetFields() {
        newEarningTitle = ""
        newEarningAmount = ""
        newEarningDate = Date()
    }
    
}
