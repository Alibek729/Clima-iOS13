//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    var cityName: String?

    var networkManager = NetworkManager()

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.delegate = self
    }
    
    @IBAction func cityTextFieldDidChange(_ sender: UITextField) {
        cityName = sender.text ?? ""
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        networkManager.getWeather(with: cityName!)
        searchTextField.text = ""
        cityName = ""
    }
}

extension WeatherViewController: NetworkManagerDelegate {
    
    func updateWeather(with weather: WeatherResponse, weatherModel: WeatherModel) {
        conditionImageView.image = UIImage(systemName: weatherModel.conditionName)
        temperatureLabel.text = String(format: "%.1f", weatherModel.temperature)
        cityLabel.text = weatherModel.cityName
    }
}

extension WeatherViewController: UISearchTextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.text = cityName
    }
}

