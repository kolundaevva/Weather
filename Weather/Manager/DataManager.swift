//
//  DataManager.swift
//  Weather
//
//  Created by Владислав Колундаев on 01.08.2022.
//

import Foundation
import RealmSwift

protocol Manager {
    func saveWeatherData(_ weather: [Weather])
}

class DataManager: Manager {
    func saveWeatherData(_ weather: [Weather]) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(weather)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
}
