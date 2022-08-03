//
//  DataManager.swift
//  Weather
//
//  Created by Владислав Колундаев on 01.08.2022.
//

import Foundation
import RealmSwift

protocol Manager {
    func saveWeatherData(_ weather: [Weather], city: String)
}

class DataManager: Manager {
    func saveWeatherData(_ weather: [Weather], city: String) {
        do {
            let realm = try Realm()
            guard let city = realm.object(ofType: City.self, forPrimaryKey: city) else { return }
            let oldWeather = city.weather
            try realm.write {
                realm.delete(oldWeather)
                city.weather.append(objectsIn: weather)
            }
        } catch {
            print(error)
        }
    }
}
