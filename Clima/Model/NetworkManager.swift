//
//  NetworkManager.swift
//  Clima
//
//  Created by Alibek Kozhambekov on 24.11.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

protocol NetworkManagerDelegate {
    func updateWeather(with weather: WeatherResponse, weatherModel: WeatherModel)
}

struct NetworkManager{
    
    var delegate: NetworkManagerDelegate?
    
    func getWeather(with name: String) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(name)&appid=04b08e29966fd160e5a727b9c5477bdf"
        guard let url = URL(string: urlString) else {return}
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error in getting request \(error.localizedDescription)")
            } else {
                guard let safeData = data else {return}
                decoder(with: safeData)
            }
        }
        task.resume()
    }
    
    private func decoder(with data: Data) {
        let decoder = JSONDecoder()
        do {
            let weatherResponse = try decoder.decode(WeatherResponse.self, from: data)
            
            let conditionID = weatherResponse.weather[0].id
            let temperature = weatherResponse.main.tempCel
            let cityName = weatherResponse.name
            
            let weatherModel = WeatherModel(conditionID: conditionID, temperature: temperature, cityName: cityName)
            
            DispatchQueue.main.async {
                delegate?.updateWeather(with: weatherResponse, weatherModel: weatherModel)
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}

