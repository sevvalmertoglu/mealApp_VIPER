//
//  Widget.swift
//  MealApp
//
//  Created by Şevval Mertoğlu on 11.09.2023.
//

import Foundation

//Entity: modelimiz

// MARK: - Widget
struct HomeResponse: Decodable {
    let widgets: [Widget]?
    let href: String?
}

// MARK: - Widget
struct Widget: Decodable {
    let id: Int?
    let type: WidgetType?
    let displayType: WidgetDisplayType?
    let restaurants: [Restaurant]?
    let displayCount: Int?
    let displayOptions: DisplayOptions?
}

// MARK: - DisplayOptions
struct DisplayOptions: Decodable {
    let paddingTopBottom, paddingRightLeft: Int?
}

enum WidgetDisplayType: String, Decodable {
    case single = "SINGLE"
}

// MARK: - Restaurant
struct Restaurant: Decodable {
    let id: Int?
    let imageUrl: String?
    let logoUrl: String?
    let deeplink, name: String?
    let averageDeliveryInterval: String
    let minBasketPrice: Int?
    let kitchen: String
    let rating: Double?
    let ratingText, campaignText: String?
    let ratingBackgroundColor: String?
    let deliveryTypeImage: String?
    let workingHours: String
    let workingHoursInterval: [String]?
    let location: Location?
    let closed, isClosed: Bool?
}

// MARK: - Location
struct Location: Decodable {
    let neighborhoodName: String?
}

// MARK: - WidgetType
enum WidgetType: String, Decodable {
    case restaurant = "RESTAURANT"
}
