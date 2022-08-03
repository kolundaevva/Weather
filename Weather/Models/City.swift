//
//  City.swift
//  Weather
//
//  Created by Владислав Колундаев on 03.08.2022.
//

import Foundation
import RealmSwift

class City: Object {
    @objc dynamic var name = ""
    var weather = List<Weather>()
    
    override class func primaryKey() -> String? {
        return "name"
    }
}
