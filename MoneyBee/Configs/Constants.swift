//
//  Constants.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-28.
//
//  Constant Values used in the application

import Foundation
import SwiftUI

struct Fonts {
    static let bubbleGum = "BubblegumSans-Regular"
}

extension Color {
    static let primaryColor = Color("appPrimaryColor")
    static let backgroundColor = Color("appBackgroundColor")
    static let appRed = Color("appRed")
    static let appLightRed = Color("appLightRed")
    static let appGreen = Color("appGreen")
    static let appLightGreen = Color("appLightGreen")
    static let appBlue = Color("appBlue")
    static let appLightBlue = Color("appLightBlue")
    static let appLightGray = Color("appLightGray")
}

// FontSize
struct FontSize {
    static let tiny: CGFloat = 20
    static let small: CGFloat = 25
    static let medium: CGFloat = 30
    static let large: CGFloat = 35
    static let xlarge: CGFloat = 45
    static let xxlarge: CGFloat = 60
}

// Dimensions for margin
struct Dm {
    static let tiny: CGFloat = 10
    static let small: CGFloat = 15
    static let medium: CGFloat = 25
    static let large: CGFloat = 35
    static let xlarge: CGFloat = 45
}

// Corner Radius
struct CornerRadius {
    static let small: CGFloat = 10
    static let medium: CGFloat = 20
    static let large: CGFloat = 30
    static let xlarge: CGFloat = 50
}

// Icon size
struct IconSize {
    static let small: CGFloat = 35
    static let medium: CGFloat = 40
    static let large: CGFloat = 45
    static let xlarge: CGFloat = 50
}
