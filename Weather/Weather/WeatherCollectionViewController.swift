//
//  WeatherCollectionViewController.swift
//  Weather
//
//  Created by Владислав Колундаев on 27.07.2022.
//

import UIKit

class WeatherCollectionViewController: UICollectionViewController {

    private let networkService = WeatherService()
    
    var weathers: [Weather] = []
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkService.loadData(city: "Moscow") { [weak self] wth in
            self?.weathers = wth
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weathers.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Weather", for: indexPath) as! WeatherCollectionViewCell
        let weather = weathers[indexPath.row]
        cell.configure(with: weather)
        return cell
    }
}
