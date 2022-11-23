//
//  WeatherResponse.swift
//  Clima
//
//  Created by Alibek Kozhambekov on 24.11.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct WeatherResponse: Decodable {
    let name: String
    let weather: [Weather]
    let main: Main
}

struct Main: Decodable {
    let temp: Double
    
    var tempCel: Double {
        return temp - 273
    }
}

struct Weather: Decodable {
    let id: Int
}

