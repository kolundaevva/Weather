//
//  NetworkService.swift
//  Weather
//
//  Created by Владислав Колундаев on 29.07.2022.
//

import Foundation
import UIKit
import SwiftyJSON

protocol Network {
    func loadData(city: String)
}

class WeatherService: Network {
    private let baseUrl = "api.openweathermap.org"
    private let api = ApiKey.weather.rawValue
    
    private let configuration = URLSessionConfiguration.default
    private lazy var session = URLSession(configuration: configuration)
    private var urlConstructor = URLComponents()
    private let dataManager: Manager = DataManager()
    
    func loadData(city: String) {
        urlConstructor.scheme = "https"
        urlConstructor.host = baseUrl
        urlConstructor.path = "/data/2.5/forecast"
        urlConstructor.queryItems = [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "appid", value: api)
        ]
        
        guard let url = urlConstructor.url else { return }
        
        if UIApplication.shared.canOpenURL(url) {
            DispatchQueue.main.async { [weak self] in
                self?.session.dataTask(with: url) { data, response, error in
                    if let error = error {
                        print(error)
                        return
                    }
                    
                    guard let data = data, let json = try? JSON(data: data) else { return }
                    let weather = json["list"].compactMap { Weather(json: $0.1, city: city) }
                    self?.dataManager.saveWeatherData(weather, city: city)
                }.resume()
            }
        } else {
            print("Error")
        }
    }
}
