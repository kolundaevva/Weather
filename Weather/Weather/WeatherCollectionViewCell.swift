//
//  WeatherCollectionViewCell.swift
//  Weather
//
//  Created by Владислав Колундаев on 27.07.2022.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    private static let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yyyy HH.mm"
        return df
    }()
    
    func configure(with weather: Weather) {
        weatherLabel.text = "\(weather.temp) ºC"
        let date = Date(timeIntervalSince1970: weather.date)
        time.text = WeatherCollectionViewCell.dateFormatter.string(from: date)
    }
}
