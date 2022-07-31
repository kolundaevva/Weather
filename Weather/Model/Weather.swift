//
//  Weather.swift
//  Weather
//
//  Created by Владислав Колундаев on 31.07.2022.
//

import Foundation
import SwiftyJSON

class Weather {
    var date = 0.0
    var temp = 0.0
    var pressure = 0.0
    var humidity = 0
    var weatherName = ""
    var weatherIcon = ""
    var windSpeed = 0.0
    var windDegrees = 0.0
    
    init(json: JSON) {
        self.date = json["dt"].doubleValue
        self.temp = json["main"]["temp"].doubleValue
        self.pressure = json["main"]["pressure"].doubleValue
        self.humidity = json["main"]["humidity"].intValue
        self.weatherName = json["weather"][0]["main"].stringValue
        self.weatherIcon = json["weather"][0]["icon"].stringValue
        self.windSpeed = json["wind"]["speed"].doubleValue
        self.windDegrees = json["wind"]["deg"].doubleValue
        
    }
}
