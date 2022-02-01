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
    
    @Published var earningRepo: FirestoreRepository<Earning> = Resolver.resolve()
    
    @Published var earnings: [Earning] = [Earning]()
    
    @Published var searchTerm: String = ""
    
    @Published var dateOptions = [DropdownOption]()
    
    @Published var selectedMonthYear: DropdownOption?
    
    @Published var monthTotal: Float = 0
    
    private var earningsCopy: [Earning] = [Earning]()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        
        earningRepo.$items
            .assign(to: \.earnings, on: self)
            .store(in: &cancellables)
        
        earningRepo.$items
            .assign(to: \.earningsCopy, on: self)
            .store(in: &cancellables)
        
        earningRepo.$items
            .map{ earnings in
                earnings.map { earning -> Date in
                    let earningDate = earning.date
                    return earningDate
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
                dropdownOptions.removingDuplicates()
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
                
            }.store(in: &cancellables)
        
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
    
    func filterBySearchTerm(_ searchTerm: String){
        // case insenstive search against each spending's title
        earnings = earningsCopy.filter{ $0.title.lowercased().contains(searchTerm.lowercased()) }
    }
    
    func filterByMonthYear(_ monthYear: DropdownOption){
        earnings = earningsCopy.filter { $0.date.isInMonthYear(monthYearString: monthYear.value) }
        
        // caluclate month total
        monthTotal = earnings.map({ $0.amount }).reduce(0, +)
    }
    
    func reload(){
        earnings = earningsCopy
        selectedMonthYear = nil
        monthTotal = 0
    }
    
    func remove(_ earning: Earning){
        earningRepo.remove(earning)
    }
    
    func add(_ earning: Earning){
        earningRepo.add(earning)
    }
    
}
