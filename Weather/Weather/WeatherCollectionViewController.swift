//
//  WeatherCollectionViewController.swift
//  Weather
//
//  Created by Владислав Колундаев on 27.07.2022.
//

import UIKit

class WeatherCollectionViewController: UICollectionViewController {

    private let networkService = WeatherService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkService.loadData(city: "Moscow")
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Weather", for: indexPath) as! WeatherCollectionViewCell
        cell.weather.text = "30ºC"
        cell.time.text = "30.08.2017 18:00"
    
        return cell
    }
}
