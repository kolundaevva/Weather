//
//  WeatherCollectionViewController.swift
//  Weather
//
//  Created by Владислав Колундаев on 27.07.2022.
//

import UIKit
import RealmSwift

class WeatherCollectionViewController: UICollectionViewController {

    private let networkService: Network = WeatherService()
    private let dataManger: Manager = DataManager()
    
    private var weathers: [Weather] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkService.loadData(city: "Moscow") { [weak self] in
            DispatchQueue.main.async {
                self?.weathers = self?.dataManger.loadData() ?? []
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
