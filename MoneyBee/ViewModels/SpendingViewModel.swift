//
//  SpendingViewModel.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-02-01.
//

import Foundation
import SwiftUI
import Combine
import Resolver

class SpendingViewModel: ObservableObject {
    
    @Published var spendingRepo: FirestoreRepository<Spending> = Resolver.resolve()
    
    @Published var spendings: [Spending] = [Spending]()
    
    @Published var searchTerm: String = ""
    
    @Published var dateOptions = [DropdownOption]()
    
    @Published var selectedMonthYear: DropdownOption?
    
    @Published var monthTotal: Float = 0
    
    // spending total by type in order: Food, School, Play, Other
    @Published var spendingChartTotalAmounts: [Double]?
    
    var spendingTypes: [SpendingType] = [
        Food(), School(), Play(), Other()
    ]
    
    var spendingChartTypeColors: [Color] {
        spendingTypes.map {
            $0.color
        }
    }
    
    var spendingTypeOptions: [DropdownOption] {
        spendingTypes.map {
            DropdownOption(key: $0.name, value: $0.name)
        }
    }
    
    private var spendingsCopy: [Spending] = [Spending]()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        
        spendingRepo.$items
            .assign(to: \.spendings, on: self)
            .store(in: &cancellables)
        
        spendingRepo.$items
            .assign(to: \.spendingsCopy, on: self)
            .store(in: &cancellables)
        
        spendingRepo.$items
            .map{ spendings in
                spendings.map { spending -> Date in
                    let spendingDate = spending.date
                    return spendingDate
                }.removingDuplicates()
            }
            .map { dates -> [Date] in
                let sortedDates = dates.sorted(by: { $0.compare($1) == .orderedDescending })
                return sortedDates
            }
            .map { sortedDates in
                sortedDates.map { date in
                    DropdownOption(key: date.dateToMonthYearString(), value: date.dateToMonthYearString())
                }
            }
            .map { dropdownOptions in
                return dropdownOptions.removingDuplicates()
            }
            .removeDuplicates()
            .assign(to: \.dateOptions, on: self)
            .store(in: &cancellables)
        
        $selectedMonthYear
            .compactMap{ $0 }
            .sink { (_) in
                //
            } receiveValue: { [weak self] selectedDateOption in
                
                self?.filterByMonthYear(selectedDateOption)
                
                // populate the piechart
                self?.populatePieChart()
                
            }.store(in: &cancellables)
        
        $searchTerm
            .debounce(for: .milliseconds(800), scheduler: RunLoop.main) // debounces the string publisher, such that it delays the process of sending request to remote server.
            .removeDuplicates()
            .map({ [weak self] (string) -> String? in
                self?.reload()
                
                if string.count < 1 {
                    return nil
                }
                
                // populate the piechart
                self?.populatePieChart()
                
                return string
            }) // prevents sending numerous requests and sends nil if the count of the characters is less than 1.
            .compactMap{ $0 } // removes the nil values so the search string does not get passed down to the publisher chain
            .sink { (_) in
                //

            } receiveValue: { [weak self] string in
                self?.filterBySearchTerm(string)
                
            }.store(in: &cancellables)

    }
    
    func filterBySearchTerm(_ searchTerm: String){
        // case insenstive search against each spending's title
        spendings = spendingsCopy.filter{ $0.title.lowercased().contains(searchTerm.lowercased()) }
    }
    
    func filterByMonthYear(_ monthYear: DropdownOption){
        spendings = spendingsCopy.filter { $0.date.isInMonthYear(monthYearString: monthYear.value) }
        
        // caluclate month total
        monthTotal = spendings.map({ $0.amount }).reduce(0, +)
    }
    
    func populatePieChart() {
        self.spendingChartTotalAmounts = [Double](repeating: 0.0, count: spendingTypes.count)
        
        // extract whatever in (filtered) spendings and map it to spendingChartTotalAmounts
        spendings.forEach { [weak self] spending in
            let index = getSpendingTypeIndex(spending)
            if index != -1 {
                self?.spendingChartTotalAmounts![index] += Double(spending.amount)
            }
        }
    }
    
    func getSpendingTypeIndex(_ spendingType: SpendingType) -> Int {
        return spendingTypes.firstIndex(where: {$0.name == spendingType.name}) ?? -1
    }
    
    func getSpendingTypeIndex(_ spending: Spending) -> Int {
        var index = 0
        for spendingType in self.spendingTypes{
            if spendingType.name == spending.type{
                return index
            }
            index+=1
        }
        return -1
    }
    
    func reload(){
        spendings = spendingsCopy
        selectedMonthYear = nil
        monthTotal = 0
    }
    
    func remove(_ spending: Spending){
        spendingRepo.remove(spending)
    }
    
    func add(_ spending: Spending){
        spendingRepo.add(spending)
    }
    
}

