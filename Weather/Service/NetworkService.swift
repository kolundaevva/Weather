//
//  NetworkService.swift
//  Weather
//
//  Created by Владислав Колундаев on 29.07.2022.
//

import Foundation
import UIKit

protocol Network {
    func loadData(city: String)
}

class WeatherService: Network {
    private let baseUrl = "api.openweathermap.org"
    private let api = ApiKey.weather.rawValue
    
    private let configuration = URLSessionConfiguration.default
    private lazy var session = URLSession(configuration: configuration)
    private var urlConstructor = URLComponents()
    
    func loadData(city: String) {
        urlConstructor.scheme = "https"
        urlConstructor.host = baseUrl
        urlConstructor.path = "/data/2.5/forecast"
        print(api)
        urlConstructor.queryItems = [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "appid", value: api)
        ]
        
        guard let url = urlConstructor.url else { return }
        
        if UIApplication.shared.canOpenURL(url) {
            print(url)
            session.dataTask(with: url) { data, response, error in
                if let error = error {
                    print(error)
                    return
                }
                
                let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                print(json)
            }.resume()
        } else {
            print("Error")
        }
    }
}
