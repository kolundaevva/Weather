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
    func loadData() -> [Weather]
}

class DataManager: Manager {
    func saveWeatherData(_ weather: [Weather], city: String) {
        do {
            let realm = try Realm()
            try realm.write {
                let oldWeatherData = realm.objects(Weather.self).filter("city == %@", city)
                realm.delete(oldWeatherData)
                realm.add(weather)
            }
        } catch {
            print(error)
        }
    }
    
    func loadData() -> [Weather] {
        do {
            let realm = try Realm()
            let weathers = realm.objects(Weather.self).filter("city == %@", "Moscow")
            return Array(weathers)
        } catch {
            print(error)
            return []
        }
    }
}
