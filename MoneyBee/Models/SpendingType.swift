//
//  SpendingType.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-29.
//

import Foundation
import SwiftUI

// All SpendingType should have name and color as properties
protocol SpendingType{
    var name : String {get}
    var color : Color {get}
}

struct Food : SpendingType {
    var name: String = "Food"
    var color: Color = Color.appGreen
}

struct School : SpendingType{
    var name: String = "School"
    var color: Color = Color.appBlue
}

struct Play: SpendingType{
    var name: String = "Play"
    var color: Color = Color.primaryColor
}

struct Other : SpendingType{
    var name: String = "Other"
    var color: Color = Color.appRed
}


