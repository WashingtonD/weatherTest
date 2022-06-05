//
//  weatherTestApp.swift
//  weatherTest
//
//  Created by Denys Shevchuk on 05/06/2022.
//

import SwiftUI

@main
struct weatherTestApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}


struct Query: Decodable{
    
    let type: String?
    let query: String?
    let unit: String?
    let lang: String?
}

struct Place: Decodable{
    
    let country: String?
    let region: String?
    let name: String?
    let latitude: String?
    let longitude: String?
    let timezone_id: String?
    let time: String?
    let time_epoch: Int?
    let utc_offset: String?
}

struct Statte: Decodable{
    
    let temp: Int?
    let time_of_observation: Int?
    let weather_icons: [String?]
    let weather_code: Int?
    let descriptions: [String?]
    let wind_speed: Int?
    let wind_degree: Int?
    let wind_direction: String?
    let humidity: Int?
    let pressure: Int?
    let precip: Double?
    let uv_index: Int?
    let visibility: Int?
    let feeling: Int?
    let cloudCover: Int?
}


struct Forecast: Decodable{
    
    let query: Query?
    let place: Place?
    let state: Statte?
}



