//
//  WeatherCollectionViewCell.swift
//  Weather
//
//  Created by Владислав Колундаев on 27.07.2022.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var weatherLabel: UILabel! {
        didSet {
            weatherLabel.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    @IBOutlet weak var time: UILabel! {
        didSet {
            time.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    @IBOutlet weak var icon: UIImageView! {
        didSet {
            icon.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private let insets: CGFloat = 10
    
    func setWeather(weather: String) {
        self.weatherLabel.text = weather
        weatherFrame()
    }
    
    func setTime(time: String) {
        self.time.text = time
        timeFrame()
    }
    
    func configure(temp: Double, time: String) {
        weatherLabel.text = "\(temp) ºC"
        self.time.text = time
        
        weatherFrame()
        timeFrame()
        iconFrame()
    }
    
    private func getLabelFrame(text: String, font: UIFont) -> CGSize {
        let maxWidth = bounds.width
        let textBlock = CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)
        
        let rect = text.boundingRect(with: textBlock, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : font], context: nil)
        let width = rect.size.width
        let height = rect.size.height + insets * 2
        
        return CGSize(width: ceil(width), height: ceil(height))
    }
    
    private func weatherFrame() {
        guard let text = weatherLabel.text else { return }
        let labelSize = getLabelFrame(text: text, font: weatherLabel.font)
        let weatherLabelX = (bounds.width - labelSize.width) / 2
        let weatherOrigin = CGPoint(x: weatherLabelX, y: insets)
        weatherLabel.frame = CGRect(origin: weatherOrigin, size: labelSize)
    }
    
    private func timeFrame() {
        guard let text = time.text else { return }
        let labelSize = getLabelFrame(text: text, font: time.font)
        let timeLabelX = (bounds.width - labelSize.width) / 2
        let timeLabelY = bounds.height - labelSize.height - insets
        let timeOrigin = CGPoint(x: timeLabelX, y: timeLabelY)
        time.frame = CGRect(origin: timeOrigin, size: labelSize)
    }
    
    private func iconFrame() {
        let iconSideLinght: CGFloat = 50
        let iconSize = CGSize(width: iconSideLinght, height: iconSideLinght)
        let iconOrigin = CGPoint(x: bounds.midX - iconSideLinght / 2, y: bounds.midY - iconSideLinght / 2)
        icon.frame = CGRect(origin: iconOrigin, size: iconSize)
    }
}
